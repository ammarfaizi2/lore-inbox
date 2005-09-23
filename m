Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750865AbVIWJui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbVIWJui (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 05:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750866AbVIWJui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 05:50:38 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:16864 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750864AbVIWJuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 05:50:37 -0400
Date: Fri, 23 Sep 2005 11:50:02 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Greg KH <gregkh@suse.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] s390: export ipl device parameters
Message-ID: <20050923095002.GA20928@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this is the new "export ipl device parameters" patch with the
changes integrated as proposed by Greg KH. Now this interface
resides in /sys/firmware/ipl and all files contain only a single
value.

This patch is aimed for 2.6.15 and should replace
s390-ipl-device.patch in the -mm tree.

Thanks,
Heiko

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Sysfs interface to export ipl device parameters.
Dependent on the ipl type the interface will look like this:

- ccw ipl:

/sys/firmware/ipl/device
		 /ipl_type

- fcp ipl:

/sys/firmware/ipl/binary_parameter
		 /bootprog
		 /br_lba
		 /device
		 /ipl_type
		 /lun
		 /scp_data
		 /wwpn

- otherwise (unknown that is):

/sys/firmware/ipl/ipl_type

Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>

diffstat:
 arch/s390/kernel/head.S   |   72 ++++++++++++++++-
 arch/s390/kernel/head64.S |   66 +++++++++++++++
 arch/s390/kernel/setup.c  |  192 ++++++++++++++++++++++++++++++++++++++++++++++
 include/asm-s390/setup.h  |   50 +++++++++++
 4 files changed, 373 insertions(+), 7 deletions(-)

diff --git a/arch/s390/kernel/head.S b/arch/s390/kernel/head.S
--- a/arch/s390/kernel/head.S
+++ b/arch/s390/kernel/head.S
@@ -485,7 +485,9 @@ start:
 #
         .org  0x10000
 startup:basr  %r13,0                     # get base
-.LPG1:  lctl  %c0,%c15,.Lctl-.LPG1(%r13) # load control registers
+.LPG1:	l     %r1, .Lget_ipl_device_addr-.LPG1(%r13)
+	basr  %r14, %r1
+	lctl  %c0,%c15,.Lctl-.LPG1(%r13) # load control registers
 	la    %r12,_pstart-.LPG1(%r13)   # pointer to parameter area
 					 # move IPL device to lowcore
         mvc   __LC_IPLDEV(4),IPL_DEVICE-PARMAREA(%r12)
@@ -560,6 +562,9 @@ startup:basr  %r13,0                    
 	mr    %r2,%r1			# mem size in bytes in %r3
 	b     .Lfchunk-.LPG1(%r13)
 
+	.align 4
+.Lget_ipl_device_addr:
+	.long .Lget_ipl_device
 .Lpmask:
 	.byte 0
 .align 8
@@ -755,6 +760,63 @@ _pstart:	
 	.global _pend
 _pend:	
 
+.Lget_ipl_device:
+	basr  %r12,0
+.LPG2:	l     %r1,0xb8			# get sid
+	sll   %r1,15			# test if subchannel is enabled
+	srl   %r1,31
+	ltr   %r1,%r1
+	bz    0(%r14)			# subchannel disabled
+	l     %r1,0xb8
+	la    %r5,.Lipl_schib-.LPG2(%r12)
+	stsch 0(%r5)		        # get schib of subchannel
+	bnz   0(%r14)			# schib not available
+	tm    5(%r5),0x01		# devno valid?
+	bno   0(%r14)
+	la    %r6,ipl_parameter_flags-.LPG2(%r12)
+	oi    3(%r6),0x01		# set flag
+	la    %r2,ipl_devno-.LPG2(%r12)
+	mvc   0(2,%r2),6(%r5)		# store devno
+	tm    4(%r5),0x80		# qdio capable device?
+	bno   0(%r14)
+	oi    3(%r6),0x02		# set flag
+
+	# copy ipl parameters
+
+	lhi   %r0,4096
+	l     %r2,20(%r0)		# get address of parameter list
+	lhi   %r3,IPL_PARMBLOCK_ORIGIN
+	st    %r3,20(%r0)
+	lhi   %r4,1
+	cr    %r2,%r3			# start parameters < destination ?
+	jl    0f
+	lhi   %r1,1			# copy direction is upwards
+	j     1f
+0:	lhi   %r1,-1			# copy direction is downwards
+	ar    %r2,%r0
+	ar    %r3,%r0
+	ar    %r2,%r1
+	ar    %r3,%r1
+1:	mvc   0(1,%r3),0(%r2)		# finally copy ipl parameters
+	ar    %r3,%r1
+	ar    %r2,%r1
+	sr    %r0,%r4
+	jne   1b
+	b     0(%r14)
+
+	.align 4
+.Lipl_schib:
+	.rept 13
+	.long 0
+	.endr
+
+	.globl ipl_parameter_flags
+ipl_parameter_flags:
+	.long 0
+	.globl ipl_devno
+ipl_devno:
+	.word 0
+
 #ifdef CONFIG_SHARED_KERNEL
 	.org   0x100000
 #endif
@@ -764,11 +826,11 @@ _pend:	
 #
         .globl _stext
 _stext:	basr  %r13,0                    # get base
-.LPG2:
+.LPG3:
 #
 # Setup stack
 #
-        l     %r15,.Linittu-.LPG2(%r13)
+        l     %r15,.Linittu-.LPG3(%r13)
 	mvc   __LC_CURRENT(4),__TI_task(%r15)
         ahi   %r15,1<<(PAGE_SHIFT+THREAD_ORDER) # init_task_union + THREAD_SIZE
         st    %r15,__LC_KERNEL_STACK    # set end of kernel stack
@@ -782,8 +844,8 @@ _stext:	basr  %r13,0                    
         lctl   %c0,%c15,0(%r15)
 
 #
-        lam    0,15,.Laregs-.LPG2(%r13) # load access regs needed by uaccess
-        l      %r14,.Lstart-.LPG2(%r13)
+        lam    0,15,.Laregs-.LPG3(%r13) # load access regs needed by uaccess
+        l      %r14,.Lstart-.LPG3(%r13)
         basr   %r14,%r14                # call start_kernel
 #
 # We returned from start_kernel ?!? PANIK
diff --git a/arch/s390/kernel/head64.S b/arch/s390/kernel/head64.S
--- a/arch/s390/kernel/head64.S
+++ b/arch/s390/kernel/head64.S
@@ -484,6 +484,8 @@ start:
 startup:basr  %r13,0                     # get base
 .LPG1:  sll   %r13,1                     # remove high order bit
         srl   %r13,1
+	l     %r1,.Lget_ipl_device_addr-.LPG1(%r13)
+	basr  %r14,%r1
         lhi   %r1,1                      # mode 1 = esame
         slr   %r0,%r0                    # set cpuid to zero
         sigp  %r1,%r0,0x12               # switch to esame mode
@@ -556,6 +558,9 @@ startup:basr  %r13,0                    
 	mlgr  %r2,%r1			# mem size in bytes in %r3
 	b     .Lfchunk-.LPG1(%r13)
 
+	.align 4
+.Lget_ipl_device_addr:
+	.long .Lget_ipl_device
 .Lpmask:
 	.byte 0
 	.align 8
@@ -746,6 +751,63 @@ _pstart:
 	.global _pend
 _pend:	
 
+.Lget_ipl_device:
+	basr  %r12,0
+.LPG2:	l     %r1,0xb8			# get sid
+	sll   %r1,15			# test if subchannel is enabled
+	srl   %r1,31
+	ltr   %r1,%r1
+	bz    0(%r14)			# subchannel disabled
+	l     %r1,0xb8
+	la    %r5,.Lipl_schib-.LPG2(%r12)
+	stsch 0(%r5)		        # get schib of subchannel
+	bnz   0(%r14)			# schib not available
+	tm    5(%r5),0x01		# devno valid?
+	bno   0(%r14)
+	la    %r6,ipl_parameter_flags-.LPG2(%r12)
+	oi    3(%r6),0x01		# set flag
+	la    %r2,ipl_devno-.LPG2(%r12)
+	mvc   0(2,%r2),6(%r5)		# store devno
+	tm    4(%r5),0x80		# qdio capable device?
+	bno   0(%r14)
+	oi    3(%r6),0x02		# set flag
+
+	# copy ipl parameters
+
+	lhi   %r0,4096
+	l     %r2,20(%r0)		# get address of parameter list
+	lhi   %r3,IPL_PARMBLOCK_ORIGIN
+	st    %r3,20(%r0)
+	lhi   %r4,1
+	cr    %r2,%r3			# start parameters < destination ?
+	jl    0f
+	lhi   %r1,1			# copy direction is upwards
+	j     1f
+0:	lhi   %r1,-1			# copy direction is downwards
+	ar    %r2,%r0
+	ar    %r3,%r0
+	ar    %r2,%r1
+	ar    %r3,%r1
+1:	mvc   0(1,%r3),0(%r2)		# finally copy ipl parameters
+	ar    %r3,%r1
+	ar    %r2,%r1
+	sr    %r0,%r4
+	jne   1b
+	b     0(%r14)
+
+	.align 4
+.Lipl_schib:
+	.rept 13
+	.long 0
+	.endr
+
+	.globl ipl_parameter_flags
+ipl_parameter_flags:
+	.long 0
+	.globl ipl_devno
+ipl_devno:
+	.word 0
+
 #ifdef CONFIG_SHARED_KERNEL
 	.org   0x100000
 #endif
@@ -755,7 +817,7 @@ _pend:	
 #
         .globl _stext
 _stext:	basr  %r13,0                    # get base
-.LPG2:
+.LPG3:
 #
 # Setup stack
 #
@@ -774,7 +836,7 @@ _stext:	basr  %r13,0                    
         lctlg  %c0,%c15,0(%r15)
 
 #
-        lam    0,15,.Laregs-.LPG2(%r13) # load access regs needed by uaccess
+        lam    0,15,.Laregs-.LPG3(%r13) # load access regs needed by uaccess
         brasl  %r14,start_kernel        # go to C code
 #
 # We returned from start_kernel ?!? PANIK
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -36,6 +36,7 @@
 #include <linux/console.h>
 #include <linux/seq_file.h>
 #include <linux/kernel_stat.h>
+#include <linux/device.h>
 
 #include <asm/uaccess.h>
 #include <asm/system.h>
@@ -685,3 +686,194 @@ struct seq_operations cpuinfo_op = {
 	.show	= show_cpuinfo,
 };
 
+#ifdef CONFIG_SYSFS
+
+#define DEFINE_IPL_ATTR(_name, _format, _value)			\
+static ssize_t ipl_##_name##_show(struct subsystem *subsys,	\
+		char *page)					\
+{								\
+	return sprintf(page, _format, _value);			\
+}								\
+static struct subsys_attribute ipl_##_name##_attr =		\
+	__ATTR(_name, S_IRUGO, ipl_##_name##_show, NULL);
+
+DEFINE_IPL_ATTR(wwpn, "0x%016llx\n", (unsigned long long)
+		IPL_PARMBLOCK_START->fcp.wwpn);
+DEFINE_IPL_ATTR(lun, "0x%016llx\n", (unsigned long long)
+		IPL_PARMBLOCK_START->fcp.lun);
+DEFINE_IPL_ATTR(bootprog, "%lld\n", (unsigned long long)
+		IPL_PARMBLOCK_START->fcp.bootprog);
+DEFINE_IPL_ATTR(br_lba, "%lld\n", (unsigned long long)
+		IPL_PARMBLOCK_START->fcp.br_lba);
+
+enum ipl_type_type {
+	ipl_type_unknown,
+	ipl_type_ccw,
+	ipl_type_fcp,
+};
+
+static enum ipl_type_type
+get_ipl_type(void)
+{
+	struct ipl_parameter_block *ipl = IPL_PARMBLOCK_START;
+
+	if (!IPL_DEVNO_VALID)
+		return ipl_type_unknown;
+	if (!IPL_PARMBLOCK_VALID)
+		return ipl_type_ccw;
+	if (ipl->hdr.header.version > IPL_MAX_SUPPORTED_VERSION)
+		return ipl_type_unknown;
+	if (ipl->fcp.pbt != IPL_TYPE_FCP)
+		return ipl_type_unknown;
+	return ipl_type_fcp;
+}
+
+static ssize_t
+ipl_type_show(struct subsystem *subsys, char *page)
+{
+	switch (get_ipl_type()) {
+	case ipl_type_ccw:
+		return sprintf(page, "ccw\n");
+	case ipl_type_fcp:
+		return sprintf(page, "fcp\n");
+	default:
+		return sprintf(page, "unknown\n");
+	}
+}
+
+static struct subsys_attribute ipl_type_attr = __ATTR_RO(ipl_type);
+
+static ssize_t
+ipl_device_show(struct subsystem *subsys, char *page)
+{
+	struct ipl_parameter_block *ipl = IPL_PARMBLOCK_START;
+
+	switch (get_ipl_type()) {
+	case ipl_type_ccw:
+		return sprintf(page, "0.0.%04x\n", ipl_devno);
+	case ipl_type_fcp:
+		return sprintf(page, "0.0.%04x\n", ipl->fcp.devno);
+	default:
+		return 0;
+	}
+}
+
+static struct subsys_attribute ipl_device_attr =
+	__ATTR(device, S_IRUGO, ipl_device_show, NULL);
+
+static struct attribute *ipl_fcp_attrs[] = {
+	&ipl_type_attr.attr,
+	&ipl_device_attr.attr,
+	&ipl_wwpn_attr.attr,
+	&ipl_lun_attr.attr,
+	&ipl_bootprog_attr.attr,
+	&ipl_br_lba_attr.attr,
+	NULL,
+};
+
+static struct attribute_group ipl_fcp_attr_group = {
+	.attrs = ipl_fcp_attrs,
+};
+
+static struct attribute *ipl_ccw_attrs[] = {
+	&ipl_type_attr.attr,
+	&ipl_device_attr.attr,
+	NULL,
+};
+
+static struct attribute_group ipl_ccw_attr_group = {
+	.attrs = ipl_ccw_attrs,
+};
+
+static struct attribute *ipl_unknown_attrs[] = {
+	&ipl_type_attr.attr,
+	NULL,
+};
+
+static struct attribute_group ipl_unknown_attr_group = {
+	.attrs = ipl_unknown_attrs,
+};
+
+static ssize_t
+ipl_parameter_read(struct kobject *kobj, char *buf, loff_t off, size_t count)
+{
+	unsigned int size = IPL_PARMBLOCK_SIZE;
+
+	if (off > size)
+		return 0;
+	if (off + count > size)
+		count = size - off;
+
+	memcpy(buf, (void *) IPL_PARMBLOCK_START + off, count);
+	return count;
+}
+
+static struct bin_attribute ipl_parameter_attr = {
+	.attr = {
+		.name = "binary_parameter",
+		.mode = S_IRUGO,
+		.owner = THIS_MODULE,
+	},
+	.size = PAGE_SIZE,
+	.read = &ipl_parameter_read,
+};
+
+static ssize_t
+ipl_scp_data_read(struct kobject *kobj, char *buf, loff_t off, size_t count)
+{
+	unsigned int size =  IPL_PARMBLOCK_START->fcp.scp_data_len;
+	void *scp_data = &IPL_PARMBLOCK_START->fcp.scp_data;
+
+	if (off > size)
+		return 0;
+	if (off + count > size)
+		count = size - off;
+
+	memcpy(buf, scp_data + off, count);
+	return count;
+}
+
+static struct bin_attribute ipl_scp_data_attr = {
+	.attr = {
+		.name = "scp_data",
+		.mode = S_IRUGO,
+		.owner = THIS_MODULE,
+	},
+	.size = PAGE_SIZE,
+	.read = &ipl_scp_data_read,
+};
+
+static decl_subsys(ipl, NULL, NULL);
+
+static int __init
+ipl_device_sysfs_register(void) {
+	struct attribute_group *attr_group;
+	int rc;
+
+	rc = firmware_register(&ipl_subsys);
+	if (rc)
+		return rc;
+
+	switch (get_ipl_type()) {
+	case ipl_type_ccw:
+		sysfs_create_group(&ipl_subsys.kset.kobj, &ipl_ccw_attr_group);
+		break;
+	case ipl_type_fcp:
+		sysfs_create_group(&ipl_subsys.kset.kobj, &ipl_fcp_attr_group);
+		sysfs_create_bin_file(&ipl_subsys.kset.kobj,
+				      &ipl_parameter_attr);
+		sysfs_create_bin_file(&ipl_subsys.kset.kobj,
+				      &ipl_scp_data_attr);
+		break;
+	default:
+		sysfs_create_group(&ipl_subsys.kset.kobj,
+				   &ipl_unknown_attr_group);
+		attr_group = &ipl_unknown_attr_group;
+		break;
+	}
+	return 0;
+}
+
+__initcall(ipl_device_sysfs_register);
+
+#endif /* CONFIG_SYSFS */
diff --git a/include/asm-s390/setup.h b/include/asm-s390/setup.h
--- a/include/asm-s390/setup.h
+++ b/include/asm-s390/setup.h
@@ -8,11 +8,14 @@
 #ifndef _ASM_S390_SETUP_H
 #define _ASM_S390_SETUP_H
 
+#include <asm/types.h>
+
 #define PARMAREA		0x10400
 #define COMMAND_LINE_SIZE 	896
 #define RAMDISK_ORIGIN		0x800000
 #define RAMDISK_SIZE		0x800000
 #define MEMORY_CHUNKS		16	/* max 0x7fff */
+#define IPL_PARMBLOCK_ORIGIN	0x2000
 
 #ifndef __ASSEMBLY__
 
@@ -64,6 +67,53 @@ extern unsigned int console_irq;
 #define SET_CONSOLE_3215	do { console_mode = 2; } while (0)
 #define SET_CONSOLE_3270	do { console_mode = 3; } while (0)
 
+struct ipl_list_header {
+	u32 length;
+	u8  reserved[3];
+	u8  version;
+} __attribute__((packed));
+
+struct ipl_block_fcp {
+	u32 length;
+	u8  pbt;
+	u8  reserved1[322-1];
+	u16 devno;
+	u8  reserved2[4];
+	u64 wwpn;
+	u64 lun;
+	u32 bootprog;
+	u8  reserved3[12];
+	u64 br_lba;
+	u32 scp_data_len;
+	u8  reserved4[260];
+	u8  scp_data[];
+} __attribute__((packed));
+
+struct ipl_parameter_block {
+	union {
+		u32 length;
+		struct ipl_list_header header;
+	} hdr;
+	struct ipl_block_fcp fcp;
+} __attribute__((packed));
+
+#define IPL_MAX_SUPPORTED_VERSION (0)
+
+#define IPL_TYPE_FCP (0)
+
+/*
+ * IPL validity flags and parameters as detected in head.S
+ */
+extern u32 ipl_parameter_flags;
+extern u16 ipl_devno;
+
+#define IPL_DEVNO_VALID		(ipl_parameter_flags & 1)
+#define IPL_PARMBLOCK_VALID	(ipl_parameter_flags & 2)
+
+#define IPL_PARMBLOCK_START	((struct ipl_parameter_block *) \
+				 IPL_PARMBLOCK_ORIGIN)
+#define IPL_PARMBLOCK_SIZE	(IPL_PARMBLOCK_START->hdr.length)
+
 #else 
 
 #ifndef __s390x__
