Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030333AbWD1JWY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030333AbWD1JWY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 05:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030337AbWD1JWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 05:22:23 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:27479 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030333AbWD1JWW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 05:22:22 -0400
Date: Fri, 28 Apr 2006 11:22:25 +0200
From: Michael Holzheu <holzheu@de.ibm.com>
To: akpm@osdl.org
Cc: schwidefsky@de.ibm.com, penberg@cs.helsinki.fi, ioe-lkml@rameria.de,
       joern@wohnheim.fh-wedel.de, linux-kernel@vger.kernel.org
Subject: [PATCH] s390: Hypervisor File System
Message-Id: <20060428112225.418cadd9.holzheu@de.ibm.com>
Organization: IBM
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On zSeries machines there exists an interface which allows the operating
system  to retrieve LPAR hypervisor accounting data. For example, it is
possible to get usage data for physical and virtual cpus. In order to
provide this information to user space programs, I implemented a new
virtual Linux file system named 'hypfs' using the Linux 2.6 libfs
framework. The name 'hypfs' stands for 'Hypervisor Filesystem'. All the
accounting information is put into different virtual files which can be
accessed from user space. All data is represented as ASCII strings.

When the file system is mounted the accounting information is retrieved
and a file system tree is created with the attribute files containing
the cpu information. The content of the files remains unchanged until a
new update is made. An update can be triggered from user space through
writing 'something' into a special purpose update file.

We create the following directory structure:

<mount-point>/
        update
        cpus/
                <cpu-id>
                        type
                        mgmtime
                <cpu-id>
                        ...
        hyp/
                type
        systems/
                <lpar-name>
                        cpus/
                                <cpu-id>
                                        type
                                        mgmtime
                                        cputime
                                        onlinetime
                                <cpu-id>
                                        ...
                <lpar-name>
                        cpus/
                                ...

- update: File to trigger update
- cpus/: Directory for all physical cpus
- cpus/<cpu-id>/: Directory for one physical cpu.
- cpus/<cpu-id>/type: Type name of physical zSeries cpu.
- cpus/<cpu-id>/mgmtime: Physical-LPAR-management time in microseconds.
- hyp/: Directory for hypervisor information
- hyp/type: Typ of hypervisor (currently only 'LPAR Hypervisor')
- systems/: Directory for all LPARs
- systems/<lpar-name>/: Directory for one LPAR.
- systems/<lpar-name>/cpus/<cpu-id>/: Directory for the virtual cpus
- systems/<lpar-name>/cpus/<cpu-id>/type: Typ of cpu.
- systems/<lpar-name>/cpus/<cpu-id>/mgmtime:
Accumulated number of microseconds during which a physical
CPU was assigned to the logical cpu and the cpu time was 
consumed by the hypervisor and was not provided to
the LPAR (LPAR overhead).

- systems/<lpar-name>/cpus/<cpu-id>/cputime:
Accumulated number of microseconds during which a physical CPU
was assigned to the logical cpu and the cpu time was consumed
by the LPAR.

- systems/<lpar-name>/cpus/<cpu-id>/onlinetime:
Accumulated number of microseconds during which the logical CPU
has been online.

As mount point for the filesystem /sys/hypervisor is created.

The update process is triggered when writing 'something' into the
'update' file at the top level hypfs directory. You can do this e.g.
with 'echo 1 > update'. During the update the whole directory structure
is deleted and built up again.

Cc: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Ingo Oeser <ioe-lkml@rameria.de>
Cc: Jörn Engel <joern@wohnheim.fh-wedel.de>

Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Michael Holzheu <holzheu@de.ibm.com>

---

 arch/s390/Kconfig            |    7
 arch/s390/Makefile           |    2
 arch/s390/hypfs/Makefile     |    7
 arch/s390/hypfs/hypfs.h      |   30 ++
 arch/s390/hypfs/hypfs_diag.c |  628 +++++++++++++++++++++++++++++++++++++++++++
 arch/s390/hypfs/hypfs_diag.h |   16 +
 arch/s390/hypfs/inode.c      |  462 +++++++++++++++++++++++++++++++
 7 files changed, 1151 insertions(+), 1 deletion(-)

diff -urpN linux-2.6.16/arch/s390/Kconfig linux-2.6.16-hypfs/arch/s390/Kconfig
--- linux-2.6.16/arch/s390/Kconfig	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6.16-hypfs/arch/s390/Kconfig	2006-04-28 08:58:46.000000000 +0200
@@ -442,6 +442,13 @@ config NO_IDLE_HZ_INIT
 	  The HZ timer is switched off in idle by default. That means the
 	  HZ timer is already disabled at boot time.
 
+config HYPFS_FS
+	bool "s390 hypervisor file system support"
+	default y
+	help
+	  This is a virtual file system intended to provide accounting
+	  information in a s390 hypervisor environment.
+
 config KEXEC
 	bool "kexec system call (EXPERIMENTAL)"
 	depends on EXPERIMENTAL
diff -urpN linux-2.6.16/arch/s390/Makefile linux-2.6.16-hypfs/arch/s390/Makefile
--- linux-2.6.16/arch/s390/Makefile	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6.16-hypfs/arch/s390/Makefile	2006-04-28 08:59:10.000000000 +0200
@@ -77,7 +77,7 @@ LDFLAGS_vmlinux := -e start
 head-y		:= arch/$(ARCH)/kernel/head.o arch/$(ARCH)/kernel/init_task.o
 
 core-y		+= arch/$(ARCH)/mm/ arch/$(ARCH)/kernel/ arch/$(ARCH)/crypto/ \
-		   arch/$(ARCH)/appldata/
+		   arch/$(ARCH)/appldata/ arch/$(ARCH)/hypfs/
 libs-y		+= arch/$(ARCH)/lib/
 drivers-y	+= drivers/s390/
 drivers-$(CONFIG_MATHEMU) += arch/$(ARCH)/math-emu/
diff -urpN linux-2.6.16/arch/s390/hypfs/Makefile linux-2.6.16-hypfs/arch/s390/hypfs/Makefile
--- linux-2.6.16/arch/s390/hypfs/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.16-hypfs/arch/s390/hypfs/Makefile	2006-04-28 08:59:36.000000000 +0200
@@ -0,0 +1,7 @@
+#
+# Makefile for the linux hypfs filesystem routines.
+#
+
+obj-$(CONFIG_HYPFS_FS) += hypfs.o
+
+hypfs-objs := inode.o hypfs_diag.o
diff -urpN linux-2.6.16/arch/s390/hypfs/hypfs.h linux-2.6.16-hypfs/arch/s390/hypfs/hypfs.h
--- linux-2.6.16/arch/s390/hypfs/hypfs.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.16-hypfs/arch/s390/hypfs/hypfs.h	2006-04-28 08:59:36.000000000 +0200
@@ -0,0 +1,30 @@
+/*
+ *  fs/hypfs/hypfs.h
+ *    Hypervisor filesystem for Linux on s390.
+ *
+ *    Copyright (C) IBM Corp. 2006
+ *    Author(s): Michael Holzheu <holzheu@de.ibm.com>
+ */
+
+#ifndef _HYPFS_H_
+#define _HYPFS_H_
+
+#include <linux/fs.h>
+#include <linux/types.h>
+
+#define REG_FILE_MODE    0440
+#define UPDATE_FILE_MODE 0220
+#define DIR_MODE         0550
+
+extern struct dentry *hypfs_mkdir(struct super_block *sb, struct dentry *parent,
+				  const char *name);
+
+extern struct dentry *hypfs_create_u64(struct super_block *sb,
+				       struct dentry *dir, const char *name,
+				       __u64 value);
+
+extern struct dentry *hypfs_create_str(struct super_block *sb,
+				       struct dentry *dir, const char *name,
+				       char *string);
+
+#endif /* _HYPFS_H_ */
diff -urpN linux-2.6.16/arch/s390/hypfs/hypfs_diag.c linux-2.6.16-hypfs/arch/s390/hypfs/hypfs_diag.c
--- linux-2.6.16/arch/s390/hypfs/hypfs_diag.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.16-hypfs/arch/s390/hypfs/hypfs_diag.c	2006-04-28 08:59:36.000000000 +0200
@@ -0,0 +1,628 @@
+/*
+ *  fs/hypfs/hypfs_diag.c
+ *    Hypervisor filesystem for Linux on s390. Diag 204 and 224
+ *    implementation.
+ *
+ *    Copyright (C) IBM Corp. 2006
+ *    Author(s): Michael Holzheu <holzheu@de.ibm.com>
+ */
+
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <asm/ebcdic.h>
+#include "hypfs.h"
+
+#define LPAR_NAME_LEN 8		/* lpar name len in diag 204 data */
+#define TMP_SIZE 64		/* size of temporary buffers */
+
+/* diag 204 subcodes */
+enum diag204_sc {
+	SUBC_STIB4 = 4,
+	SUBC_RSI = 5,
+	SUBC_STIB6 = 6,
+	SUBC_STIB7 = 7
+};
+
+/* The two available diag 204 data formats */
+enum diag204_format {
+	INFO_SIMPLE = 0,
+	INFO_EXT = 0x00010000
+};
+
+/* bit is set in flags, when physical cpu info is included in diag 204 data */
+#define LPAR_PHYS_FLG  0x80
+
+static char *diag224_cpu_names;			/* diag 224 name table */
+static enum diag204_sc diag204_store_sc;	/* used subcode for store */
+static enum diag204_format diag204_info_type;	/* used diag 204 data format */
+
+/*
+ * DIAG 204 data structures and member access functions.
+ *
+ * Since we have two different diag 204 data formats for old and new s390 
+ * machines, we do not access the structs directly, but use getter functions for 
+ * each struct member instead. This should make the code more readable.
+ */
+
+/* Time information block */
+
+struct info_blk_hdr {
+	__u8  npar;
+	__u8  flags;
+	__u16 tslice;
+	__u16 phys_cpus;
+	__u16 this_part;
+	__u64 curtod;
+} __attribute__ ((packed));
+
+struct x_info_blk_hdr {
+	__u8  npar;
+	__u8  flags;
+	__u16 tslice;
+	__u16 phys_cpus;
+	__u16 this_part;
+	__u64 curtod1;
+	__u64 curtod2;
+	char reserved[40];
+} __attribute__ ((packed));
+
+static inline int info_blk_hdr__size(enum diag204_format type)
+{
+	if (type == INFO_SIMPLE)
+		return sizeof(struct info_blk_hdr);
+	else /* INFO_EXT */
+		return sizeof(struct x_info_blk_hdr);
+}
+
+static inline __u8 info_blk_hdr__npar(enum diag204_format type, void *hdr)
+{
+	if (type == INFO_SIMPLE)
+		return ((struct info_blk_hdr *)hdr)->npar;
+	else /* INFO_EXT */
+		return ((struct x_info_blk_hdr *)hdr)->npar;
+}
+
+static inline __u8 info_blk_hdr__flags(enum diag204_format type, void *hdr)
+{
+	if (type == INFO_SIMPLE)
+		return ((struct info_blk_hdr *)hdr)->flags;
+	else /* INFO_EXT */
+		return ((struct x_info_blk_hdr *)hdr)->flags;
+}
+
+static inline __u16 info_blk_hdr__pcpus(enum diag204_format type, void *hdr)
+{
+	if (type == INFO_SIMPLE)
+		return ((struct info_blk_hdr *)hdr)->phys_cpus;
+	else /* INFO_EXT */
+		return ((struct x_info_blk_hdr *)hdr)->phys_cpus;
+}
+
+/* Partition header */
+
+struct part_hdr {
+	__u8 pn;
+	__u8 cpus;
+	char reserved[6];
+	char part_name[LPAR_NAME_LEN];
+} __attribute__ ((packed));
+
+struct x_part_hdr {
+	__u8  pn;
+	__u8  cpus;
+	__u8  rcpus;
+	__u8  pflag;
+	__u32 mlu;
+	char  part_name[LPAR_NAME_LEN];
+	char  lpc_name[8];
+	char  os_name[8];
+	__u64 online_cs;
+	__u64 online_es;
+	__u8  upid;
+	char  reserved1[3];
+	__u32 group_mlu;
+	char  group_name[8];
+	char  reserved2[32];
+} __attribute__ ((packed));
+
+static inline int part_hdr__size(enum diag204_format type)
+{
+	if (type == INFO_SIMPLE)
+		return sizeof(struct part_hdr);
+	else /* INFO_EXT */
+		return sizeof(struct x_part_hdr);
+}
+
+static inline __u8 part_hdr__cpus(enum diag204_format type, void *hdr)
+{
+	if (type == INFO_SIMPLE)
+		return ((struct part_hdr *)hdr)->cpus;
+	else /* INFO_EXT */
+		return ((struct x_part_hdr *)hdr)->cpus;
+}
+
+static inline void part_hdr__part_name(enum diag204_format type, void *hdr,
+				       char *name)
+{
+	if (type == INFO_SIMPLE)
+		memcpy(name, ((struct part_hdr *)hdr)->part_name,
+		       LPAR_NAME_LEN);
+	else /* INFO_EXT */
+		memcpy(name, ((struct x_part_hdr *)hdr)->part_name,
+		       LPAR_NAME_LEN);
+	EBCASC(name, LPAR_NAME_LEN);
+	name[LPAR_NAME_LEN] = 0;
+	strstrip(name);
+}
+
+struct cpu_info {
+	__u16 cpu_addr;
+	char  reserved1[2];
+	__u8  ctidx;
+	__u8  cflag;
+	__u16 weight;
+	__u64 acc_time;
+	__u64 lp_time;
+} __attribute__ ((packed));
+
+struct x_cpu_info {
+	__u16 cpu_addr;
+	char  reserved1[2];
+	__u8  ctidx;
+	__u8  cflag;
+	__u16 weight;
+	__u64 acc_time;
+	__u64 lp_time;
+	__u16 min_weight;
+	__u16 cur_weight;
+	__u16 max_weight;
+	char  reseved2[2];
+	__u64 online_time;
+	__u64 wait_time;
+	__u32 pma_weight;
+	__u32 polar_weight;
+	char  reserved3[40];
+} __attribute__ ((packed));
+
+/* CPU info block */
+
+static inline int cpu_info__size(enum diag204_format type)
+{
+	if (type == INFO_SIMPLE)
+		return sizeof(struct cpu_info);
+	else /* INFO_EXT */
+		return sizeof(struct x_cpu_info);
+}
+
+static inline __u8 cpu_info__ctidx(enum diag204_format type, void *hdr)
+{
+	if (type == INFO_SIMPLE)
+		return ((struct cpu_info *)hdr)->ctidx;
+	else /* INFO_EXT */
+		return ((struct x_cpu_info *)hdr)->ctidx;
+}
+
+static inline __u16 cpu_info__cpu_addr(enum diag204_format type, void *hdr)
+{
+	if (type == INFO_SIMPLE)
+		return ((struct cpu_info *)hdr)->cpu_addr;
+	else /* INFO_EXT */
+		return ((struct x_cpu_info *)hdr)->cpu_addr;
+}
+
+static inline __u64 cpu_info__acc_time(enum diag204_format type, void *hdr)
+{
+	if (type == INFO_SIMPLE)
+		return ((struct cpu_info *)hdr)->acc_time;
+	else /* INFO_EXT */
+		return ((struct x_cpu_info *)hdr)->acc_time;
+}
+
+static inline __u64 cpu_info__lp_time(enum diag204_format type, void *hdr)
+{
+	if (type == INFO_SIMPLE)
+		return ((struct cpu_info *)hdr)->lp_time;
+	else /* INFO_EXT */
+		return ((struct x_cpu_info *)hdr)->lp_time;
+}
+
+static inline __u64 cpu_info__online_time(enum diag204_format type, void *hdr)
+{
+	if (type == INFO_SIMPLE)
+		return 0;	/* online_time not available in simple info */
+	else /* INFO_EXT */
+		return ((struct x_cpu_info *)hdr)->online_time;
+}
+
+/* Physical header */
+
+struct phys_hdr {
+	char reserved1[1];
+	__u8 cpus;
+	char reserved2[6];
+	char mgm_name[8];
+} __attribute__ ((packed));
+
+struct x_phys_hdr {
+	char reserved1[1];
+	__u8 cpus;
+	char reserved2[6];
+	char mgm_name[8];
+	char reserved3[80];
+} __attribute__ ((packed));
+
+static inline int phys_hdr__size(enum diag204_format type)
+{
+	if (type == INFO_SIMPLE)
+		return sizeof(struct phys_hdr);
+	else /* INFO_EXT */
+		return sizeof(struct x_phys_hdr);
+}
+
+static inline __u8 phys_hdr__cpus(enum diag204_format type, void *hdr)
+{
+	if (type == INFO_SIMPLE)
+		return ((struct phys_hdr *)hdr)->cpus;
+	else /* INFO_EXT */
+		return ((struct x_phys_hdr *)hdr)->cpus;
+}
+
+/* Physical CPU info block */
+
+struct phys_cpu {
+	__u16 cpu_addr;
+	char  reserved1[2];
+	__u8  ctidx;
+	char  reserved2[3];
+	__u64 mgm_time;
+	char  reserved3[8];
+} __attribute__ ((packed));
+
+struct x_phys_cpu {
+	__u16 cpu_addr;
+	char  reserved1[2];
+	__u8  ctidx;
+	char  reserved2[3];
+	__u64 mgm_time;
+	char  reserved3[80];
+} __attribute__ ((packed));
+
+static inline int phys_cpu__size(enum diag204_format type)
+{
+	if (type == INFO_SIMPLE)
+		return sizeof(struct phys_cpu);
+	else /* INFO_EXT */
+		return sizeof(struct x_phys_cpu);
+}
+
+static inline __u16 phys_cpu__cpu_addr(enum diag204_format type, void *hdr)
+{
+	if (type == INFO_SIMPLE)
+		return ((struct phys_cpu *)hdr)->cpu_addr;
+	else /* INFO_EXT */
+		return ((struct x_phys_cpu *)hdr)->cpu_addr;
+}
+
+static inline __u64 phys_cpu__mgm_time(enum diag204_format type, void *hdr)
+{
+	if (type == INFO_SIMPLE)
+		return ((struct phys_cpu *)hdr)->mgm_time;
+	else /* INFO_EXT */
+		return ((struct x_phys_cpu *)hdr)->mgm_time;
+}
+
+static inline __u64 phys_cpu__ctidx(enum diag204_format type, void *hdr)
+{
+	if (type == INFO_SIMPLE)
+		return ((struct phys_cpu *)hdr)->ctidx;
+	else /* INFO_EXT */
+		return ((struct x_phys_cpu *)hdr)->ctidx;
+}
+
+/* Diagnose 204 functions */
+
+static inline int diag204(unsigned long subcode, unsigned long size, void *addr)
+{
+	register unsigned long _subcode asm("0") = subcode;
+	register unsigned long _size asm("1") = size;
+
+	asm volatile ("   diag    %2,%0,0x204\n"
+		      "0: \n" ".section __ex_table,\"a\"\n"
+#ifndef __s390x__
+		      "    .align 4\n"
+		      "    .long  0b,0b\n"
+#else
+		      "    .align 8\n"
+		      "    .quad  0b,0b\n"
+#endif
+		      ".previous":"+d" (_subcode), "+d"(_size)
+		      :"d"(addr)
+		      :"memory");
+	if (_subcode)
+		return -1;
+	else
+		return _size;
+}
+
+/* 
+ * diag204_probe() has to find out, which type of diagnose 204 implementation
+ * we have on our machine. Currently there are three possible scanarios:
+ *   - subcode 4   + simple data format (only one page)
+ *   - subcode 4-6 + extended data format
+ *   - subcode 4-7 + extended data format
+ *
+ * Subcode 5 is used to retrieve the size of the data, provided by subcodes
+ * 6 and 7. Subcode 7 basically has the same function as subcode 6. In addition
+ * to subcode 6 it provides also information about secondary cpus.
+ * In order to get as much information as possible, we first try
+ * subcode 7, then 6 and if both fail, we use subcode 4.
+ */
+
+static int diag204_probe(void)
+{
+	void *buf;
+	int pages, rc;
+
+	pages = diag204(SUBC_RSI | INFO_EXT, 0, 0);
+	if (pages > 0) {
+		buf = kmalloc(pages * PAGE_SIZE, GFP_KERNEL);
+		if (!buf) {
+			rc = -ENOMEM;
+			goto err_out;
+		}
+		if (diag204(SUBC_STIB7 | INFO_EXT, pages, buf) >= 0) {
+			diag204_store_sc = SUBC_STIB7;
+			diag204_info_type = INFO_EXT;
+			goto out;
+		}
+		if (diag204(SUBC_STIB6 | INFO_EXT, pages, buf) >= 0) {
+			diag204_store_sc = SUBC_STIB7;
+			diag204_info_type = INFO_EXT;
+			goto out;
+		}
+		kfree(buf);
+	}
+	buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!buf) {
+		rc = -ENOMEM;
+		goto err_out;
+	}
+	if (diag204(SUBC_STIB4 | INFO_SIMPLE, pages, buf) >= 0) {
+		diag204_store_sc = SUBC_STIB4;
+		diag204_info_type = INFO_SIMPLE;
+		goto out;
+	} else {
+		rc = -ENOSYS;
+		goto err_out;
+	}
+      out:
+	rc = 0;
+      err_out:
+	kfree(buf);
+	return rc;
+}
+
+static void *diag204_store(void)
+{
+	void *buf;
+	int pages;
+
+	if (diag204_store_sc == SUBC_STIB4)
+		pages = 1;
+	else
+		pages = diag204(SUBC_RSI | diag204_info_type, 0, 0);
+
+	if (pages < 0)
+		return ERR_PTR(-ENOSYS);
+
+	buf = kmalloc(pages * PAGE_SIZE, GFP_KERNEL);
+	if (!buf)
+		return ERR_PTR(-ENOMEM);
+
+	if (diag204(diag204_store_sc | diag204_info_type, pages, buf) < 0) {
+		kfree(buf);
+		return ERR_PTR(-ENOSYS);
+	}
+	return buf;
+}
+
+/* Diagnose 224 functions */
+
+static inline void diag224(void *ptr)
+{
+	asm volatile("   diag    %0,%1,0x224\n"
+		     : :"d" (0), "d"(ptr) : "memory");
+}
+
+static inline int diag224_get_name_table(void)
+{
+	/* memory must be below 2GB */
+	diag224_cpu_names = kmalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);
+	if (!diag224_cpu_names)
+		return -ENOMEM;
+	diag224(diag224_cpu_names);
+	EBCASC(diag224_cpu_names + 16, (*diag224_cpu_names + 1) * 16);
+	return 0;
+}
+
+static inline void diag224_delete_name_table(void)
+{
+	kfree(diag224_cpu_names);
+}
+
+static int diag224_idx2name(int index, char *name)
+{
+	memcpy(name, diag224_cpu_names + ((index + 1) * 16), 16);
+	name[16] = 0;
+	strstrip(name);
+	return 0;
+}
+
+int diag_init(void)
+{
+	int rc;
+
+	if (diag204_probe()) {
+		printk(KERN_ERR "hypfs: diag 204 not working.");
+		return -ENODATA;
+	}
+	rc = diag224_get_name_table();
+	if (rc) {
+		diag224_delete_name_table();
+		printk(KERN_ERR "hypfs: could not get name table.\n");
+	}
+	return rc;
+}
+
+void diag_exit(void)
+{
+	diag224_delete_name_table();
+}
+
+/*
+ * Functions to create the directory structure
+ * *******************************************
+ */
+
+static int hypfs_create_cpu_files(struct super_block *sb,
+				  struct dentry *cpus_dir, void *cpu_info)
+{
+	struct dentry *cpu_dir;
+	char buffer[TMP_SIZE];
+	void *rc;
+
+	snprintf(buffer, TMP_SIZE, "%d", cpu_info__cpu_addr(diag204_info_type,
+							    cpu_info));
+	cpu_dir = hypfs_mkdir(sb, cpus_dir, buffer);
+	rc = hypfs_create_u64(sb, cpu_dir, "mgmtime",
+			      cpu_info__acc_time(diag204_info_type, cpu_info) -
+			      cpu_info__lp_time(diag204_info_type, cpu_info));
+	if (IS_ERR(rc))
+		return PTR_ERR(rc);
+	rc = hypfs_create_u64(sb, cpu_dir, "cputime",
+			      cpu_info__lp_time(diag204_info_type, cpu_info));
+	if (IS_ERR(rc))
+		return PTR_ERR(rc);
+	if (diag204_info_type == INFO_EXT) {
+		rc = hypfs_create_u64(sb, cpu_dir, "onlinetime",
+				      cpu_info__online_time(diag204_info_type,
+							    cpu_info));
+		if (IS_ERR(rc))
+			return PTR_ERR(rc);
+	}
+	diag224_idx2name(cpu_info__ctidx(diag204_info_type, cpu_info), buffer);
+	rc = hypfs_create_str(sb, cpu_dir, "type", buffer);
+	if (IS_ERR(rc))
+		return PTR_ERR(rc);
+	return 0;
+}
+
+static void *hypfs_create_lpar_files(struct super_block *sb,
+				     struct dentry *systems_dir, void *part_hdr)
+{
+	struct dentry *cpus_dir;
+	struct dentry *lpar_dir;
+	char lpar_name[LPAR_NAME_LEN + 1];
+	void *cpu_info;
+	int i;
+
+	part_hdr__part_name(diag204_info_type, part_hdr, lpar_name);
+	lpar_name[LPAR_NAME_LEN] = 0;
+	lpar_dir = hypfs_mkdir(sb, systems_dir, lpar_name);
+	if (IS_ERR(lpar_dir))
+		return lpar_dir;
+	cpus_dir = hypfs_mkdir(sb, lpar_dir, "cpus");
+	if (IS_ERR(cpus_dir))
+		return cpus_dir;
+	cpu_info = part_hdr + part_hdr__size(diag204_info_type);
+	for (i = 0; i < part_hdr__cpus(diag204_info_type, part_hdr); i++) {
+		int rc;
+		rc = hypfs_create_cpu_files(sb, cpus_dir, cpu_info);
+		if (rc)
+			return ERR_PTR(rc);
+		cpu_info += cpu_info__size(diag204_info_type);
+	}
+	return cpu_info;
+}
+
+static int hypfs_create_phys_cpu_files(struct super_block *sb,
+				       struct dentry *cpus_dir, void *cpu_info)
+{
+	struct dentry *cpu_dir;
+	char buffer[TMP_SIZE];
+	void *rc;
+
+	snprintf(buffer, TMP_SIZE, "%i", phys_cpu__cpu_addr(diag204_info_type,
+							    cpu_info));
+	cpu_dir = hypfs_mkdir(sb, cpus_dir, buffer);
+	if (IS_ERR(cpu_dir))
+		return PTR_ERR(cpu_dir);
+	rc = hypfs_create_u64(sb, cpu_dir, "mgmtime",
+			      phys_cpu__mgm_time(diag204_info_type, cpu_info));
+	if (IS_ERR(rc))
+		return PTR_ERR(rc);
+	diag224_idx2name(phys_cpu__ctidx(diag204_info_type, cpu_info), buffer);
+	rc = hypfs_create_str(sb, cpu_dir, "type", buffer);
+	if (IS_ERR(rc))
+		return PTR_ERR(rc);
+	return 0;
+}
+
+static void *hypfs_create_phys_files(struct super_block *sb,
+				     struct dentry *parent_dir, void *phys_hdr)
+{
+	int i;
+	void *cpu_info;
+	struct dentry *cpus_dir;
+
+	cpus_dir = hypfs_mkdir(sb, parent_dir, "cpus");
+	if (IS_ERR(cpus_dir))
+		return cpus_dir;
+	cpu_info = phys_hdr + phys_hdr__size(diag204_info_type);
+	for (i = 0; i < phys_hdr__cpus(diag204_info_type, phys_hdr); i++) {
+		int rc;
+		rc = hypfs_create_phys_cpu_files(sb, cpus_dir, cpu_info);
+		if (rc)
+			return ERR_PTR(rc);
+		cpu_info += phys_cpu__size(diag204_info_type);
+	}
+	return cpu_info;
+}
+
+int diag_create_files(struct super_block *sb, struct dentry *root)
+{
+	struct dentry *systems_dir, *hyp_dir;
+	void *time_hdr, *part_hdr;
+	int i;
+	void *buffer, *rc;
+
+	buffer = diag204_store();
+	if (IS_ERR(buffer))
+		return PTR_ERR(buffer);
+
+	systems_dir = hypfs_mkdir(sb, root, "systems");
+	if (IS_ERR(systems_dir))
+		return PTR_ERR(systems_dir);
+	time_hdr = (struct x_info_blk_hdr *)buffer;
+	part_hdr = time_hdr + info_blk_hdr__size(diag204_info_type);
+	for (i = 0; i < info_blk_hdr__npar(diag204_info_type, time_hdr); i++) {
+		part_hdr = hypfs_create_lpar_files(sb, systems_dir, part_hdr);
+		if (IS_ERR(part_hdr))
+			return PTR_ERR(part_hdr);
+	}
+	if (info_blk_hdr__flags(diag204_info_type, time_hdr) & LPAR_PHYS_FLG) {
+		void *rc;
+		rc = hypfs_create_phys_files(sb, root, part_hdr);
+		if (IS_ERR(rc))
+			return PTR_ERR(rc);
+	}
+	hyp_dir = hypfs_mkdir(sb, root, "hyp");
+	if (IS_ERR(hyp_dir))
+		return PTR_ERR(hyp_dir);
+	rc = hypfs_create_str(sb, hyp_dir, "type", "LPAR Hypervisor");
+	if (IS_ERR(rc))
+		return PTR_ERR(rc);
+	kfree(buffer);
+	return 0;
+}
diff -urpN linux-2.6.16/arch/s390/hypfs/hypfs_diag.h linux-2.6.16-hypfs/arch/s390/hypfs/hypfs_diag.h
--- linux-2.6.16/arch/s390/hypfs/hypfs_diag.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.16-hypfs/arch/s390/hypfs/hypfs_diag.h	2006-04-28 08:59:36.000000000 +0200
@@ -0,0 +1,16 @@
+/*
+ *  fs/hypfs/hypfs_diag.h
+ *    Hypervisor filesystem for Linux on s390.
+ *
+ *    Copyright (C) IBM Corp. 2006
+ *    Author(s): Michael Holzheu <holzheu@de.ibm.com>
+ */
+
+#ifndef _HYPFS_DIAG_H_
+#define _HYPFS_DIAG_H_
+
+extern int diag_init(void);
+extern void diag_exit(void);
+extern int diag_create_files(struct super_block *sb, struct dentry *root);
+
+#endif /* _HYPFS_DIAG_H_ */
diff -urpN linux-2.6.16/arch/s390/hypfs/inode.c linux-2.6.16-hypfs/arch/s390/hypfs/inode.c
--- linux-2.6.16/arch/s390/hypfs/inode.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.16-hypfs/arch/s390/hypfs/inode.c	2006-04-28 08:59:36.000000000 +0200
@@ -0,0 +1,462 @@
+/*
+ *  fs/hypfs/inode.c
+ *    Hypervisor filesystem for Linux on s390.
+ *
+ *    Copyright (C) IBM Corp. 2006
+ *    Author(s): Michael Holzheu <holzheu@de.ibm.com>
+ */
+
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/namei.h>
+#include <linux/vfs.h>
+#include <linux/pagemap.h>
+#include <linux/gfp.h>
+#include <linux/time.h>
+#include <linux/parser.h>
+#include <linux/sysfs.h>
+#include <linux/module.h>
+#include <asm/ebcdic.h>
+#include "hypfs.h"
+#include "hypfs_diag.h"
+
+#define HYPFS_MAGIC 0x687970	/* ASCII 'hyp' */
+#define TMP_SIZE 64		/* size of temporary buffers */
+
+static struct dentry *hypfs_create_update_file(struct super_block *sb,
+					       struct dentry *dir);
+
+struct hypfs_sb_info {
+	int uid;		/* uid used for files and dirs */
+	int gid;		/* gid used for files and dirs */
+};
+
+static struct dentry *update_file_dentry;
+static struct file_operations hypfs_file_ops;
+static struct file_system_type hypfs_type;
+static struct super_operations hypfs_s_ops;
+static time_t last_update_time = 0;	/* update time in seconds since 1970 */
+static DEFINE_MUTEX(hypfs_lock);
+
+/* start of list of all dentries, which have to be deleted on update */
+static struct dentry *hypfs_last_dentry;
+
+static void hypfs_update_update(void)
+{
+	struct inode* inode = update_file_dentry->d_inode;
+	
+	last_update_time = get_seconds();
+	inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+}
+
+/* directory tree removal functions */
+
+static void hypfs_add_dentry(struct dentry *dentry)
+{
+	dentry->d_fsdata = hypfs_last_dentry;
+	hypfs_last_dentry = dentry;
+}
+
+static void hypfs_delete_tree(struct dentry *root)
+{
+	while (hypfs_last_dentry) {
+		struct dentry *parent, *next_dentry;
+
+		parent = hypfs_last_dentry->d_parent;
+		if (S_ISDIR(hypfs_last_dentry->d_inode->i_mode))
+			simple_rmdir(parent->d_inode, hypfs_last_dentry);
+		else
+			simple_unlink(parent->d_inode, hypfs_last_dentry);
+		d_delete(hypfs_last_dentry);
+		next_dentry = hypfs_last_dentry->d_fsdata;
+		dput(hypfs_last_dentry);
+		hypfs_last_dentry = next_dentry;
+	}
+}
+
+static struct inode *hypfs_make_inode(struct super_block *sb, int mode)
+{
+	struct inode *ret = new_inode(sb);
+
+	if (ret) {
+		struct hypfs_sb_info *hypfs_info = sb->s_fs_info;
+		ret->i_mode = mode;
+		ret->i_uid = hypfs_info->uid;
+		ret->i_gid = hypfs_info->gid;
+		ret->i_blksize = PAGE_CACHE_SIZE;
+		ret->i_blocks = 0;
+		ret->i_atime = ret->i_mtime = ret->i_ctime = CURRENT_TIME;
+		if (mode & S_IFDIR)
+			ret->i_nlink = 2;
+		else
+			ret->i_nlink = 1;
+	}
+	return ret;
+}
+
+static void hypfs_drop_inode(struct inode *inode)
+{
+	kfree(inode->u.generic_ip);
+	generic_delete_inode(inode);
+}
+
+static int hypfs_open(struct inode *inode, struct file *filp)
+{
+	char *data = (char *)filp->f_dentry->d_inode->u.generic_ip;
+
+	if (filp->f_mode & FMODE_WRITE) {
+		if (!(inode->i_mode & S_IWUGO))
+			return -EACCES;
+	}
+	if (filp->f_mode & FMODE_READ) {
+		if (!(inode->i_mode & S_IRUGO))
+			return -EACCES;
+	}
+	mutex_lock(&hypfs_lock);
+	filp->private_data = kmalloc(strlen(data) + 1, GFP_KERNEL);
+	if (!filp->private_data) {
+		mutex_unlock(&hypfs_lock);
+		return -ENOMEM;
+	}
+	strcpy(filp->private_data, data);
+	mutex_unlock(&hypfs_lock);
+	return 0;
+}
+
+static ssize_t hypfs_aio_read(struct kiocb *iocb, __user char *buf,
+			      size_t count, loff_t offset)
+{
+	char *data;
+	size_t len;
+	struct file *filp = iocb->ki_filp;
+
+	data = (char *)filp->private_data;
+	len = strlen(data);
+	if (offset > len) {
+		count = 0;
+		goto out;
+	}
+	if (count > len - offset)
+		count = len - offset;
+	if (copy_to_user(buf, data + offset, count)) {
+		count = -EFAULT;
+		goto out;
+	}
+	iocb->ki_pos += count;
+	file_accessed(filp);
+      out:
+	return count;
+}
+static ssize_t hypfs_aio_write(struct kiocb *iocb, const char __user *buf,
+			       size_t count, loff_t pos)
+{
+	int rc;
+	struct super_block *sb;
+
+	mutex_lock(&hypfs_lock);
+	sb = iocb->ki_filp->f_dentry->d_inode->i_sb;
+	if (last_update_time == get_seconds()) {
+		rc = -EBUSY;
+		goto out;
+	}
+	hypfs_delete_tree(sb->s_root);
+	rc = diag_create_files(sb, sb->s_root);
+	if (rc) {
+		printk(KERN_ERR "hypfs: Update failed\n");
+		hypfs_delete_tree(sb->s_root);
+		goto out;
+	}
+	hypfs_update_update();
+	rc = count;
+      out:
+	mutex_unlock(&hypfs_lock);
+	return rc;
+}
+
+static int hypfs_release(struct inode *inode, struct file *filp)
+{
+	kfree(filp->private_data);
+	return 0;
+}
+
+enum { opt_uid, opt_gid, opt_err };
+
+static match_table_t hypfs_tokens = {
+	{opt_uid, "uid=%u"},
+	{opt_gid, "gid=%u"},
+	{opt_err, NULL}
+};
+
+static int hypfs_parse_options(char *options, struct super_block *sb)
+{
+	char *str;
+	substring_t args[MAX_OPT_ARGS];
+
+	if (!options)
+		return 0;
+	while ((str = strsep(&options, ",")) != NULL) {
+		int token, option;
+		struct hypfs_sb_info *hypfs_info = sb->s_fs_info;
+
+		if (!*str)
+			continue;
+		token = match_token(str, hypfs_tokens, args);
+		switch (token) {
+		case opt_uid:
+			if (match_int(&args[0], &option))
+				return -EINVAL;
+			hypfs_info->uid = option;
+			break;
+		case opt_gid:
+			if (match_int(&args[0], &option))
+				return -EINVAL;
+			hypfs_info->gid = option;
+			break;
+		case opt_err:
+		default:
+			printk(KERN_ERR "hypfs: Unrecognized mount option "
+			       "\"%s\" or missing value\n", str);
+			return -EINVAL;
+		}
+	}
+	return 0;
+}
+
+static int hypfs_fill_super(struct super_block *sb, void *data, int silent)
+{
+	struct inode *root_inode;
+	int rc = 0;
+	struct hypfs_sb_info *sbi;
+
+	sbi = kmalloc(sizeof(struct hypfs_sb_info), GFP_KERNEL);
+	if (!sbi)
+		return -ENOMEM;
+	sbi->uid = current->uid;
+	sbi->gid = current->gid;
+	sb->s_fs_info = sbi;
+	sb->s_blocksize = PAGE_CACHE_SIZE;
+	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
+	sb->s_magic = HYPFS_MAGIC;
+	sb->s_op = &hypfs_s_ops;
+	if (hypfs_parse_options(data, sb)) {
+		rc = -EINVAL;
+		goto err_alloc;
+	}
+	root_inode = hypfs_make_inode(sb, S_IFDIR | 0755);
+	if (!root_inode) {
+		rc = -ENOMEM;
+		goto err_alloc;
+	}
+	root_inode->i_op = &simple_dir_inode_operations;
+	root_inode->i_fop = &simple_dir_operations;
+	sb->s_root = d_alloc_root(root_inode);
+	if (!sb->s_root) {
+		rc = -ENOMEM;
+		goto err_inode;
+	}
+	rc = diag_create_files(sb, sb->s_root);
+	if (rc)
+		goto err_tree;
+	update_file_dentry = hypfs_create_update_file(sb, sb->s_root);
+	if (IS_ERR(update_file_dentry)) {
+		rc = PTR_ERR(update_file_dentry);
+		goto err_tree;
+	}
+	hypfs_update_update();
+	return 0;
+
+      err_tree:
+	hypfs_delete_tree(sb->s_root);
+	dput(sb->s_root);
+      err_inode:
+	iput(root_inode);
+      err_alloc:
+	kfree(sbi);
+	return rc;
+}
+
+static void hypfs_put_super(struct super_block *sb)
+{
+	kfree(sb->s_fs_info);
+}
+
+static struct super_block *hypfs_get_super(struct file_system_type *fst,
+					   int flags, const char *devname,
+					   void *data)
+{
+	return get_sb_single(fst, flags, data, hypfs_fill_super);
+}
+
+static struct dentry *hypfs_create_file(struct super_block *sb,
+					struct dentry *parent, const char *name,
+					char *data, mode_t mode)
+{
+	struct dentry *dentry;
+	struct inode *inode;
+	struct qstr qname;
+
+	qname.name = name;
+	qname.len = strlen(name);
+	qname.hash = full_name_hash(name, qname.len);
+	dentry = lookup_one_len(name, parent, strlen(name));
+	if (IS_ERR(dentry))
+		return ERR_PTR(-ENOMEM);
+	inode = hypfs_make_inode(sb, mode);
+	if (!inode) {
+		dput(dentry);
+		return ERR_PTR(-ENOMEM);
+	}
+	if (mode & S_IFREG) {
+		inode->i_fop = &hypfs_file_ops;
+		if(data)
+			inode->i_size = strlen(data);
+		else
+			inode->i_size = 0;
+	} else if (mode & S_IFDIR) {
+		inode->i_op = &simple_dir_inode_operations;
+		inode->i_fop = &simple_dir_operations;
+		parent->d_inode->i_nlink++;
+	} else
+		BUG();
+	inode->u.generic_ip = data;
+	d_instantiate(dentry, inode);
+	return dentry;
+}
+
+struct dentry *hypfs_mkdir(struct super_block *sb, struct dentry *parent,
+			   const char *name)
+{
+	struct dentry *dentry;
+
+	dentry = hypfs_create_file(sb, parent, name, NULL, S_IFDIR | DIR_MODE);
+	if (IS_ERR(dentry))
+		return dentry;
+	hypfs_add_dentry(dentry);
+	parent->d_inode->i_nlink++;
+	return dentry;
+}
+
+static struct dentry *hypfs_create_update_file(struct super_block *sb,
+					       struct dentry *dir)
+{
+	struct dentry *dentry;
+
+	dentry = hypfs_create_file(sb, dir, "update", NULL,
+				   S_IFREG | UPDATE_FILE_MODE);
+	if (!dentry)
+		return ERR_PTR(-ENOMEM);
+	/*
+	 * We do not put the update file on the 'delete' list with
+	 * hypfs_add_dentry(), since it should not be removed when the tree
+	 * is updated.
+	 */
+	return dentry;
+}
+
+struct dentry *hypfs_create_u64(struct super_block *sb, struct dentry *dir,
+				const char *name, __u64 value)
+{
+	char *buffer;
+	char tmp[TMP_SIZE];
+	struct dentry *dentry;
+
+	snprintf(tmp, TMP_SIZE, "%lld\n", (unsigned long long int)value);
+	buffer = kmalloc(strlen(tmp) + 1, GFP_KERNEL);
+	if (!buffer)
+		return ERR_PTR(-ENOMEM);
+	strcpy(buffer, tmp);
+	dentry =
+	    hypfs_create_file(sb, dir, name, buffer, S_IFREG | REG_FILE_MODE);
+	if (!dentry) {
+		kfree(buffer);
+		return ERR_PTR(-ENOMEM);
+	}
+	hypfs_add_dentry(dentry);
+	return dentry;
+}
+
+struct dentry *hypfs_create_str(struct super_block *sb, struct dentry *dir,
+				const char *name, char *string)
+{
+	char *buffer;
+	struct dentry *dentry;
+
+	buffer = kmalloc(strlen(string) + 2, GFP_KERNEL);
+	if (!buffer)
+		return ERR_PTR(-ENOMEM);
+	sprintf(buffer, "%s\n", string);
+	dentry =
+	    hypfs_create_file(sb, dir, name, buffer, S_IFREG | REG_FILE_MODE);
+	if (!dentry) {
+		kfree(buffer);
+		return ERR_PTR(-ENOMEM);
+	}
+	hypfs_add_dentry(dentry);
+	return dentry;
+}
+
+static struct file_operations hypfs_file_ops = {
+	.open		= hypfs_open,
+	.release	= hypfs_release,
+	.read		= do_sync_read,
+	.write		= do_sync_write,
+	.aio_read	= hypfs_aio_read,
+	.aio_write	= hypfs_aio_write,
+};
+
+static struct file_system_type hypfs_type = {
+	.owner		= THIS_MODULE,
+	.name		= "hypfs",
+	.get_sb		= hypfs_get_super,
+	.kill_sb	= kill_litter_super
+};
+
+static struct super_operations hypfs_s_ops = {
+	.statfs		= simple_statfs,
+	.drop_inode	= hypfs_drop_inode,
+	.put_super	= hypfs_put_super
+};
+
+static decl_subsys(hypervisor, NULL, NULL);
+
+static int __init hypfs_init(void)
+{
+	int rc;
+
+	if (MACHINE_IS_VM)
+		return -ENODATA;
+	if (diag_init()) {
+		rc = -ENODATA;
+		goto err_msg;
+	}
+	rc = subsystem_register(&hypervisor_subsys);
+	if (rc)
+		goto err_diag;
+	rc = register_filesystem(&hypfs_type);
+	if (rc)
+		goto err_sysfs;
+	return 0;
+
+      err_sysfs:
+	subsystem_unregister(&hypervisor_subsys);
+      err_diag:
+	diag_exit();
+      err_msg:
+	printk(KERN_ERR "hypfs: Initialization failed with rc = %i.\n", rc);
+	return rc;
+}
+
+static void __exit hypfs_exit(void)
+{
+	diag_exit();
+	unregister_filesystem(&hypfs_type);
+	subsystem_unregister(&hypervisor_subsys);
+}
+
+module_init(hypfs_init)
+module_exit(hypfs_exit)
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Michael Holzheu <holzheu@de.ibm.com>");
+MODULE_DESCRIPTION("s390 Hypervisor Filesystem");
