Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263283AbSJWJdt>; Wed, 23 Oct 2002 05:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263316AbSJWJdt>; Wed, 23 Oct 2002 05:33:49 -0400
Received: from w032.z064001165.sjc-ca.dsl.cnc.net ([64.1.165.32]:5444 "EHLO
	nakedeye.aparity.com") by vger.kernel.org with ESMTP
	id <S263283AbSJWJar>; Wed, 23 Oct 2002 05:30:47 -0400
Date: Wed, 23 Oct 2002 02:45:07 -0700 (PDT)
From: "Matt D. Robinson" <yakker@aparity.com>
To: linux-kernel@vger.kernel.org
cc: lkcd-devel@lists.sourceforge.net
Subject: [PATCH] LKCD for 2.5.44 (8/8): dump driver and build files
In-Reply-To: <Pine.LNX.4.44.0210230241050.27315-100000@nakedeye.aparity.com>
Message-ID: <Pine.LNX.4.44.0210230244560.27315-100000@nakedeye.aparity.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the complete set of dump drivers for creating crash dumps
during panic/exception situations in the Linux kernel.  It can be
built as a module or as a built-in with the kernel.  The compression
modules, base dump driver, block device driver, and associated
header files are included here.

This is the largest patch set, and with the exception of the
standard Makefiles and one line in major.h, all of the code here
is in new files, completing the feature set.

 drivers/Makefile             |    1 
 drivers/dump/Makefile        |   26 
 drivers/dump/dump_base.c     | 1641 +++++++++++++++++++++++++++++++++++++++++++
 drivers/dump/dump_blockdev.c |  361 +++++++++
 drivers/dump/dump_gzip.c     |  119 +++
 drivers/dump/dump_i386.c     |  322 ++++++++
 drivers/dump/dump_rle.c      |  176 ++++
 include/asm-i386/dump.h      |  101 ++
 include/linux/dump.h         |  349 +++++++++
 include/linux/major.h        |    2 
 10 files changed, 3098 insertions(+)

diff -Naur linux-2.5.44.orig/drivers/Makefile linux-2.5.44.lkcd/drivers/Makefile
--- linux-2.5.44.orig/drivers/Makefile	Fri Oct 18 21:02:28 2002
+++ linux-2.5.44.lkcd/drivers/Makefile	Wed Oct 23 02:09:07 2002
@@ -41,5 +41,6 @@
 obj-$(CONFIG_BT)		+= bluetooth/
 obj-$(CONFIG_HOTPLUG_PCI)	+= hotplug/
 obj-$(CONFIG_ISDN_BOOL)		+= isdn/
+obj-$(CONFIG_CRASH_DUMP)	+= dump/
 
 include $(TOPDIR)/Rules.make
diff -Naur linux-2.5.44.orig/drivers/dump/Makefile linux-2.5.44.lkcd/drivers/dump/Makefile
--- linux-2.5.44.orig/drivers/dump/Makefile	Wed Dec 31 16:00:00 1969
+++ linux-2.5.44.lkcd/drivers/dump/Makefile	Wed Oct 23 02:09:07 2002
@@ -0,0 +1,26 @@
+#
+# Makefile for the dump device drivers.
+#
+export-objs				:= dump_base.o
+
+obj-$(CONFIG_CRASH_DUMP)		+= dump.o
+
+dump-y					:= dump_base.o
+obj-$(CONFIG_CRASH_DUMP_BLOCKDEV)	+= dump_blockdev.o
+obj-$(CONFIG_CRASH_DUMP_COMPRESS_RLE)	+= dump_rle.o
+obj-$(CONFIG_CRASH_DUMP_COMPRESS_GZIP)	+= dump_gzip.o
+dump-objs				+= $(dump-y)
+
+ifeq ($(ARCH),i386)
+dump-objs				+= dump_i386.o
+endif
+
+ifeq ($(ARCH),alpha)
+dump-objs				+= dump_alpha.o
+endif
+
+ifeq ($(ARCH),ia64)
+dump-objs				+= dump_ia64.o
+endif
+
+include $(TOPDIR)/Rules.make
diff -Naur linux-2.5.44.orig/drivers/dump/dump_base.c linux-2.5.44.lkcd/drivers/dump/dump_base.c
--- linux-2.5.44.orig/drivers/dump/dump_base.c	Wed Dec 31 16:00:00 1969
+++ linux-2.5.44.lkcd/drivers/dump/dump_base.c	Wed Oct 23 02:09:29 2002
@@ -0,0 +1,1641 @@
+/*
+ * Standard kernel functions for Linux crash dumps.
+ *
+ * Created by: Matt Robinson (yakker@sourceforge.net)
+ * Contributions from SGI, IBM, HP, MCL, and others.
+ *
+ * Copyright (C) 1999 - 2002 Silicon Graphics, Inc. All rights reserved.
+ * Copyright (C) 2000 - 2002 TurboLinux, Inc.  All rights reserved.
+ * Copyright (C) 2001 - 2002 Matt D. Robinson.  All rights reserved.
+ * Copyright (C) 2002 Free Software Foundation, Inc. All rights reserved.
+ *
+ * This code is released under version 2 of the GNU GPL.
+ */
+
+/*
+ * -----------------------------------------------------------------------
+ *
+ * DUMP HISTORY
+ *
+ * This dump code goes back to SGI's first attempts at dumping system
+ * memory on SGI systems running IRIX.  A few developers at SGI needed
+ * a way to take this system dump and analyze it, and created 'icrash',
+ * or IRIX Crash.  The mechanism (the dumps and 'icrash') were used
+ * by support people to generate crash reports when a system failure
+ * occurred.  This was vital for large system configurations that
+ * couldn't apply patch after patch after fix just to hope that the
+ * problems would go away.  So the system memory, along with the crash
+ * dump analyzer, allowed support people to quickly figure out what the
+ * problem was on the system with the crash dump.
+ *
+ * In comes Linux.  SGI started moving towards the open source community,
+ * and upon doing so, SGI wanted to take its support utilities into Linux
+ * with the hopes that they would end up the in kernel and user space to
+ * be used by SGI's customers buying SGI Linux systems.  One of the first
+ * few products to be open sourced by SGI was LKCD, or Linux Kernel Crash
+ * Dumps.  LKCD comprises of a patch to the kernel to enable system
+ * dumping, along with 'lcrash', or Linux Crash, to analyze the system
+ * memory dump.  A few additional system scripts and kernel modifications
+ * are also included to make the dump mechanism and dump data easier to
+ * process and use.
+ *
+ * As soon as LKCD was released into the open source community, a number
+ * of larger companies started to take advantage of it.  Today, there are
+ * many community members that contribute to LKCD, and it continues to
+ * flourish and grow as an open source project.
+ *
+ * -----------------------------------------------------------------------
+ *
+ * SYSTEM DUMP LAYOUT
+ * 
+ * System dumps are currently the combination of a dump header and a set
+ * of data pages which contain the system memory.  The layout of the dump
+ * (for full dumps) is as follows:
+ *
+ *             +-----------------------------+
+ *             |     generic dump header     |
+ *             +-----------------------------+
+ *             |   architecture dump header  |
+ *             +-----------------------------+
+ *             |         page header         |
+ *             +-----------------------------+
+ *             |          page data          |
+ *             +-----------------------------+
+ *             |         page header         |
+ *             +-----------------------------+
+ *             |          page data          |
+ *             +-----------------------------+
+ *             |              |              |
+ *             |              |              |
+ *             |              |              |
+ *             |              |              |
+ *             |              V              |
+ *             +-----------------------------+
+ *             |        PAGE_END header      |
+ *             +-----------------------------+
+ *
+ * There are two dump headers, the first which is architecture
+ * independent, and the other which is architecture dependent.  This
+ * allows different architectures to dump different data structures
+ * which are specific to their chipset, CPU, etc.
+ *
+ * After the dump headers come a succession of dump page headers along
+ * with dump pages.  The page header contains information about the page
+ * size, any flags associated with the page (whether it's compressed or
+ * not), and the address of the page.  After the page header is the page
+ * data, which is either compressed (or not).  Each page of data is
+ * dumped in succession, until the final dump header (PAGE_END) is
+ * placed at the end of the dump, assuming the dump device isn't out
+ * of space.
+ *
+ * This mechanism allows for multiple compression types, different
+ * types of data structures, different page ordering, etc., etc., etc.
+ * It's a very straightforward mechanism for dumping system memory.
+ * -----------------------------------------------------------------------
+ *
+ * DUMP IMPLEMENTATION
+ *
+ * Dumps are implemented using a "start at the top and work your way
+ * to the bottom" method.  The starting location of kernel memory is
+ * determined, and each successive page is passed through to the
+ * dump_add_page() function, which determines whether to compress the
+ * page, throw it out, add the page header, etc.  This mechanism is
+ * going to change over time as non-disruptive dumps are created, so
+ * it is best to read through the code (it is commented pretty well),
+ * and let the developers know if it isn't clear enough.  We believe
+ * in well-documented, well-commented code.
+ *
+ * -----------------------------------------------------------------------
+ *
+ * DUMP TUNABLES
+ *
+ * This is the list of system tunables (via /proc) that are available
+ * for Linux systems.  All the read, write, etc., functions are listed
+ * here.  Currently, there are a few different tunables for dumps:
+ *
+ * dump_device (used to be dumpdev):
+ *     The device for dumping the memory pages out to.  This is almost
+ *     always the primary swap partition for disruptive dumps.
+ *
+ * dump_compress (used to be dump_compress_pages):
+ *     This is the flag which indicates which compression mechanism
+ *     to use.  This is a BITMASK, not an index (0,1,2,4,8,16,etc.).
+ *     This is the current set of values:
+ *
+ *     0: DUMP_COMPRESS_NONE -- Don't compress any pages.
+ *     1: DUMP_COMPRESS_RLE  -- This uses RLE compression.
+ *     2: DUMP_COMPRESS_GZIP -- This uses GZIP compression.
+ *
+ * dump_level:
+ *     The amount of effort the dump module should make to save
+ *     information for post crash analysis.  This value is now
+ *     a BITMASK value, not an index:
+ *
+ *     0:   Do nothing, no dumping. (DUMP_LEVEL_NONE)
+ *
+ *     1:   Print out the dump information to the dump header, and
+ *          write it out to the dump_device. (DUMP_LEVEL_HEADER)
+ *
+ *     2:   Write out the dump header and all kernel memory pages.
+ *          (DUMP_LEVEL_KERN)
+ *
+ *     4:   Write out the dump header and all kernel and user
+ *          memory pages.  (DUMP_LEVEL_USED)
+ *
+ *     8:   Write out the dump header and all conventional/cached 
+ *	    memory (RAM) pages in the system (kernel, user, free).  
+ *	    (DUMP_LEVEL_ALL_RAM)
+ *
+ *    16:   Write out everything, including non-conventional memory
+ *	    like firmware, proms, I/O registers, uncached memory.
+ *	    (DUMP_LEVEL_ALL)
+ *
+ *     The dump_level will default to 1.
+ *
+ * dump_flags:
+ *     These are the flags to use when talking about dumps.  There
+ *     are lots of possibilities.  This is a BITMASK value, not an index.
+ * 
+ *     1:  Try to keep the system running _after_ we are done
+ *         dumping -- for non-disruptive dumps.  (DUMP_FLAGS_NONDISRUPT)
+ *
+ * -----------------------------------------------------------------------
+ */
+
+/*
+ * -----------------------------------------------------------------------
+ *                      H E A D E R   F I L E S
+ * -----------------------------------------------------------------------
+ */
+
+/* header files */
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/reboot.h>
+#include <linux/fs.h>
+#include <linux/dump.h>
+#include <linux/proc_fs.h>
+#include <linux/module.h>
+#include <linux/utsname.h>
+#include <linux/highmem.h>
+#include <linux/major.h>
+#include <asm/hardirq.h>
+#include <asm/uaccess.h>
+
+/*
+ * -----------------------------------------------------------------------
+ *                         V A R I A B L E S
+ * -----------------------------------------------------------------------
+ */
+
+/* Dump tunables */
+static kdev_t dump_device;         /* the actual kdev_t device number      */
+static int dump_level;             /* the current dump level               */
+static int dump_compress;          /* whether to try to compress each page */
+static int dump_flags;             /* whether to try to compress each page */
+
+/* Dump Notifier Tunables */
+static long dump_scheduler_enabled = 0;  /* Default:scheduler is disabled   */
+static long dump_interrupts_enabled = 1; /* Default:interrupts stay enabled */
+static long dump_nondisruptive_enabled = 1;/* Default:non-disruptive enabled*/
+
+/* Other global fields */
+static void *dump_page_buf;        /* dump page buffer for memcpy()!       */
+static void *dump_page_buf_0;      /* dump page buffer returned by kmalloc */
+struct __dump_header dump_header;  /* the primary dump header              */
+struct __dump_header_asm dump_header_asm; /* the arch-specific dump header */
+static loff_t dump_fpos;           /* the offset in the output device      */
+int dump_mbanks;                   /* number of  physical memory banks     */
+struct __dump_mbank dump_mbank[MAXCHUNKS]; /* layout of physical memory    */
+long dump_unreserved_mem = 0;      /* Save Pages even if it isn't reserved */
+long dump_unreferenced_mem = 0;    /* Save Pages even if page_count == 0   */
+long dump_nonconventional_mem = 0; /* Save non-conventional mem (firmware) */
+volatile int dump_started = 0;     /* Indicated we are about to dump  */
+static struct dump_operations *dump_device_ops = 0;
+
+static u16 dump_compress_none(char *old, u16 oldsize, char *new, u16 newsize);
+
+static struct __dump_compress dump_none_compression = {
+	.compress_type	=	DUMP_COMPRESS_NONE,
+	.compress_func	=	dump_compress_none,
+};
+
+/* our device operations and functions */
+static int dump_release(struct inode *i, struct file *f);
+static int dump_ioctl(struct inode *i, struct file *f,
+	unsigned int cmd, unsigned long arg);
+
+static struct file_operations dump_fops = {
+	.release	=	dump_release,
+	.ioctl		=	dump_ioctl,
+};
+
+/* function pointers and prototypes */
+u16 (*dump_compress_func)(char *old, u16 oldsize, char *new, u16 newsize);
+
+/* proc entries */
+static struct proc_dir_entry *dump_root;    /* /proc/sys/dump root dir     */
+static struct proc_dir_entry *dump_dd;      /* dump_device tunable         */
+static struct proc_dir_entry *dump_cp;      /* dump_compress tunable       */
+static struct proc_dir_entry *dump_l;       /* dump_level tunable          */
+static struct proc_dir_entry *dump_f;       /* dump_flags tunable          */
+
+/* static variables                                                        */
+static int dump_okay = 0;      	   /* can we dump out to disk?     */
+static char dpcpage[DUMP_DPC_PAGE_SIZE];  /* buffer used for compression   */
+static unsigned long dump_save_flags;     /* save_flags()/restore_flags()  */
+
+/* used for dump compressors */
+static struct list_head dump_compress_list = LIST_HEAD_INIT(dump_compress_list);
+
+/* external variables                                                      */
+extern int panic_timeout;          /* time before reboot                   */
+
+/* lkcd info structure -- this is used by lcrash for basic system data     */
+struct __lkcdinfo lkcdinfo = {
+	0,
+	(sizeof(void *) * 8),
+#if defined(__LITTLE_ENDIAN) 
+	__LITTLE_ENDIAN,
+#else
+	__BIG_ENDIAN,
+#endif
+	0,
+	PAGE_SHIFT,
+	PAGE_SIZE,
+	PAGE_MASK,
+	PAGE_OFFSET,
+	0
+};
+
+/*
+ * -----------------------------------------------------------------------
+ *            / P R O C   T U N A B L E   F U N C T I O N S
+ * -----------------------------------------------------------------------
+ */
+
+/*
+ * Name: dump_read_proc()
+ * Func: Read the proc data for dump tunables.
+ */
+static int
+dump_read_proc(char *page, char **start, off_t off,
+	int count, int *eof, void *data)
+{
+	int len;
+	char *out = page;
+	struct proc_dir_entry *p = (struct proc_dir_entry *)data;
+
+
+	if (0 == strcmp(p->name, DUMP_LEVEL_NAME)) {
+		out += sprintf(out, "%d\n", dump_level);
+		len = out - page;
+	} else if (0 == strcmp(p->name, DUMP_FLAGS_NAME)) {
+		out += sprintf(out, "%d\n", dump_flags);
+		len = out - page;
+	} else if (0 == strcmp(p->name, DUMP_COMPRESS_NAME)) {
+		out += sprintf(out, "%d\n", dump_compress);
+		len = out - page;
+	} else if (0 == strcmp(p->name, DUMP_DEVICE_NAME)) {
+		out += sprintf(out, "0x%x\n", kdev_val(dump_device));
+		len = out - page;
+	} else {
+		return 0;
+	}
+	len -= off;
+	if (len < count) {
+		*eof = 1;
+		if (len <= 0) return 0;
+	} else {
+		len = count;
+	}
+	*start = page + off;
+	return len;
+}
+
+/*
+ * -----------------------------------------------------------------------
+ *              C O M P R E S S I O N   F U N C T I O N S
+ * -----------------------------------------------------------------------
+ */
+
+/*
+ * Name: dump_compress_none()
+ * Func: Don't do any compression, period.
+ */
+static u16
+dump_compress_none(char *old, u16 oldsize, char *new, u16 newsize)
+{
+	/* just return the old size */
+	return oldsize;
+}
+
+/*
+ * -----------------------------------------------------------------------
+ *                  U T I L I T Y   F U N C T I O N S
+ * -----------------------------------------------------------------------
+ */
+
+/*
+ * Dump Notifier Callbacks:
+ *    Used by disk drivers during the dump notification
+ *    to tune the dump driver. Names and functions are obvious.
+ */
+void dump_scheduler_enable(void)
+{
+	printk("setting dump_scheduler_enabled = 1\n");
+	dump_scheduler_enabled = 1;
+}
+
+void dump_interrupts_disable(void)
+{
+	printk("setting dump_interrupts_enabled = 0\n");
+	dump_interrupts_enabled = 0;
+}
+
+void dump_nondisruptive_disable(void)
+{
+	printk("setting dump_nondisruptive_enabled = 0\n");
+	dump_nondisruptive_enabled = 0;
+}
+
+/*
+ * Name: dump_kernel_write()
+ *
+ * Func: Write out kernel information, check the device limitations,
+ *       block sizes, etc. 
+ * 	 Writes DUMP_BUFFER_SIZE bytes in page buffer
+ *
+ * Returns: number of bytes written or -ERRNO. 
+ *	    At EOF it returns 0.
+ */
+static ssize_t
+dump_kernel_write(int *eof)
+{
+	int err = 0, err1 = 0;
+	loff_t offset=0;
+	
+	if (dump_device_ops == 0)
+		return -EINVAL;
+
+	if (eof)
+		offset = (loff_t) (*eof);
+
+	/* wait till the dump device is ready to accept IO */
+	err1 = dump_device_ops->dump_ready(0);
+	if (err1 < 0) {
+		printk("dump_kernel_write(): dump device not ready for IO\n");
+		return err1;
+	}
+
+	err = dump_device_ops->dump_seek(dump_fpos, 0);
+	if (err < 0) {
+		printk("dump_kernel_write(): seek to dump device failed, "
+				"err %d\n", err);
+		return -EFAULT;
+	}
+
+	/* write to the dump device */ 
+	err = dump_device_ops->dump_write(dump_page_buf, DUMP_BUFFER_SIZE,
+			&offset);
+	if (eof)
+		*eof = (int) offset;
+	if (err < 0) {
+		printk("dump_kernel_write(): write to dump device failed, "
+				"err %d\n", err);
+		return err;
+	}
+
+	/* wait till the dump device is ready to accept next IO */
+	err1 = dump_device_ops->dump_ready(0);
+	if (err1 < 0) {
+		printk("dump_kernel_write(): dump device not ready for IO\n");
+		return err1;
+	}
+
+	/* err is the transferred bytes -- return those */
+	dump_fpos += err;
+	return err;
+}
+
+/*
+ * Name: dump_add_end_marker()
+ * Func: add last dump page marker to the end of the dump buffer.
+ */
+static void
+dump_add_end_marker(unsigned long *toffset, int flags)
+{
+	struct __dump_page dp;
+
+	/* set the end marker */
+	dp.dp_address = dp.dp_size = 0x0;
+	dp.dp_flags = flags;
+
+	/* clear the buffer and copy the page header */
+	memcpy((void *)(dump_page_buf + *toffset),
+		(const void *)&dp, sizeof(struct __dump_page));
+	*toffset += sizeof(struct __dump_page);
+
+	dump_header.dh_num_dump_pages++;
+
+	return;
+}
+
+static inline int
+kernel_page(struct page *p)
+{
+	if (PageReserved(p) || (!PageLRU(p) && PageInuse(p)))
+		return 1;
+	else
+		return 0;
+}
+
+static inline int
+referenced_page(struct page *p)
+{
+	if (PageInuse(p)) {
+		if (!PageReserved(p) && PageLRU(p))
+			return 1;
+		else
+			return 0;
+	} else
+		return 0;
+}
+
+static inline int
+unreferenced_page(struct page *p)
+{
+	if (!PageInuse(p)) {
+		if (!PageReserved(p))
+			return 1;
+		else
+			return 0;
+	} else
+		return 0;
+}
+
+/*
+ * Name: dump_add_page()
+ * Func: Add a hardware page to the dump buffer.
+ *
+ * NB: page is a DUMP_PAGE_SIZE page, 
+ *     not a system page (PAGE_SIZE).
+ */
+static int
+dump_add_page(unsigned long page_index, unsigned long *toffset, int pass)
+{
+	u16 size;
+	struct __dump_page dp;
+	void *vaddr;
+	u64 paddr = (((u64)page_index) << DUMP_PAGE_SHIFT);
+	struct page *p;
+
+	if (!dump_page_valid(page_index))
+		return 1;
+
+	p = pfn_to_page(page_index);
+
+	dp.dp_address = paddr;
+	dp.dp_flags = DUMP_DH_RAW;
+
+	/*
+ 	 * Selective dump:
+	 *  	Some systems, have huge memories, NUMA for example, where
+	 *	a dump of all of memory isn't likely to fit on a swap partition.
+	 *	This is a simple 1st attempt at ordering the dump so the most 
+	 *	important pages are dumped first.
+	 *
+	 *	pass1: Kernel Pages
+	 *	pass2: Remaining referenced pages
+	 *	pass3: the rest of conventional memory
+	 *	pass4: non-conventional memory,
+	 */
+	switch (pass) {
+	case 1:
+		if (kernel_page(p))
+			break;
+		else
+			return 1;
+	case 2: 
+		if (referenced_page(p))
+			break;
+		else
+			return 1;
+	case 3:
+		if (unreferenced_page(p))
+			break;
+		else
+			return 1;
+	case 4:
+		break;
+
+	}
+
+	/*
+	 * Since this can be executed from IRQ context,
+	 * reentrance on the same CPU must be avoided:
+	 */
+	vaddr = kmap_atomic(p, KM_USER0);
+
+	/*
+	 * Don't compress the page if any part of it overlaps
+	 * with the current stack.
+	 */
+	if ((((unsigned long)vaddr < (unsigned long)current->thread_info + 
+		THREAD_SIZE)  && ((unsigned long)vaddr + DUMP_PAGE_SIZE >
+		(unsigned long)current->thread_info))) {
+			size = DUMP_PAGE_SIZE;
+	}
+	else {
+		size = dump_compress_func((char *)vaddr, DUMP_PAGE_SIZE,
+			(char *)dpcpage, DUMP_DPC_PAGE_SIZE);
+		if (!size) {
+			/* dump compression failed -- default to raw mode */
+			size = DUMP_PAGE_SIZE;
+		}
+		/* set the compressed flag if the page did compress */
+		if (size < DUMP_PAGE_SIZE)
+			dp.dp_flags = DUMP_DH_COMPRESSED;
+	}
+
+	/* set the universal size */
+	dp.dp_size = size;
+
+	/* copy the page header */
+	memcpy((void *)(dump_page_buf + *toffset), (const void *)&dp,
+		sizeof(struct __dump_page));
+
+	*toffset += sizeof(struct __dump_page);
+
+	if (dp.dp_flags & DUMP_DH_COMPRESSED) {
+		/* copy the compressed page */
+		memcpy((void *)(dump_page_buf + *toffset),
+			(const void *)dpcpage, size);
+	} else {
+		/* copy directly from memory */
+		DUMP_memcpy((void *)(dump_page_buf + *toffset),
+			(const void *)vaddr, size);
+	}
+
+	kunmap_atomic(vaddr, KM_USER0);
+
+	*toffset += size;
+
+	dump_header.dh_num_dump_pages++;
+
+	return 0;
+}
+
+/*
+ * Name: dump_silence_system()
+ * Func: Silence the system, or make CPUs spin, etc.  The intention
+ *       here is to get things to a "quiet" state, so we can dump.
+ */
+void
+dump_silence_system(void)
+{
+	unsigned int stage = 0;
+	int cpu = smp_processor_id();
+
+	if (in_interrupt()) {
+		printk(KERN_ALERT "Dumping from interrupt handler !\n");
+		printk(KERN_ALERT "Uncertain scenario - but will try my best\n");
+		/* 
+		 * Must be an unrelated interrupt, not in the middle of io ! 
+		 * If we've panic'ed in the middle of io we should take 
+		 * another approach 
+		 */
+	}
+	/* see if there's something to do before we re-enable interrupts */
+	(void)__dump_silence_system(stage);
+
+	/* we set this to FALSE so we don't ever re-enter this code! */
+	dump_okay = 0;
+	dumping_cpu = cpu;
+
+	local_irq_save(dump_save_flags);
+	local_irq_enable(); /* enable interrupts just in case ... */
+
+	/* now increment the stage and do stuff after interrupts are enabled */
+	stage++;
+	(void)__dump_silence_system(stage);
+
+	/* time to leave */
+	return;
+}
+
+/*
+ * Name: dump_resume_system()
+ * Func: Resume the system state.
+ */
+void
+dump_resume_system(void)
+{
+	unsigned int stage = 0;
+
+	/* let the architectures return their proper system state */
+	(void)__dump_resume_system(stage);
+
+	local_irq_restore(dump_save_flags);
+	dump_in_progress = 0;
+	dump_okay = 1;
+
+	return;
+}
+
+static void
+dump_speedo(void)
+{
+	static int i = 0;
+
+	switch (++i%4) {
+	case 0:
+		printk("|\b");
+		break;
+	case 1:
+		printk("\\\b");
+		break;
+	case 2:
+		printk("-\b");
+		break;
+	case 3:
+		printk("/\b");
+		break;
+	}
+}
+
+/*
+ * -----------------------------------------------------------------------
+ *                     H E A D E R   F U N C T I O N S
+ * -----------------------------------------------------------------------
+ */
+
+/*
+ * Name: dump_configure_header()
+ * Func: Update the header with the appropriate information.
+ */
+static int
+dump_configure_header(char *panic_str, struct pt_regs *regs)
+{
+	struct timeval dh_time;
+	/* make sure the dump header isn't TOO big */
+	if ((sizeof(struct __dump_header) +
+		sizeof(struct __dump_header_asm)) > DUMP_BUFFER_SIZE) {
+			printk("dump_configure_header(): combined "
+				"headers larger than DUMP_BUFFER_SIZE!\n");
+			return 0;
+	}
+
+	/* configure dump header values */
+	dump_header.dh_magic_number = DUMP_MAGIC_NUMBER;
+	dump_header.dh_version = DUMP_VERSION_NUMBER;
+	dump_header.dh_memory_start = PAGE_OFFSET;
+	dump_header.dh_memory_end = DUMP_MAGIC_NUMBER;
+	dump_header.dh_header_size = sizeof(struct __dump_header);
+	dump_header.dh_page_size = PAGE_SIZE;
+	dump_header.dh_dump_level = dump_level;
+	dump_header.dh_current_task = (unsigned long) current;
+	dump_header.dh_dump_compress = dump_compress;
+	dump_header.dh_dump_flags = dump_flags;
+	dump_header.dh_dump_device = kdev_val(dump_device);
+	dump_header.dh_num_dump_pages = 0;
+	do_gettimeofday(&dh_time);
+	dump_header.dh_time.tv_sec = dh_time.tv_sec;
+	dump_header.dh_time.tv_usec = dh_time.tv_usec;
+
+#ifndef UTSNAME_ENTRY_SZ
+#define UTSNAME_ENTRY_SZ 65
+#endif
+	memcpy((void *)&(dump_header.dh_utsname_sysname), 
+		(const void *)&(system_utsname.sysname), UTSNAME_ENTRY_SZ);
+	memcpy((void *)&(dump_header.dh_utsname_nodename), 
+		(const void *)&(system_utsname.nodename), UTSNAME_ENTRY_SZ);
+	memcpy((void *)&(dump_header.dh_utsname_release), 
+		(const void *)&(system_utsname.release), UTSNAME_ENTRY_SZ);
+	memcpy((void *)&(dump_header.dh_utsname_version), 
+		(const void *)&(system_utsname.version), UTSNAME_ENTRY_SZ);
+	memcpy((void *)&(dump_header.dh_utsname_machine), 
+		(const void *)&(system_utsname.machine), UTSNAME_ENTRY_SZ);
+	memcpy((void *)&(dump_header.dh_utsname_domainname), 
+		(const void *)&(system_utsname.domainname), UTSNAME_ENTRY_SZ);
+
+	if (panic_str) {
+		memcpy((void *)&(dump_header.dh_panic_string),
+			(const void *)panic_str, DUMP_PANIC_LEN);
+	}
+
+        dump_header_asm.dha_magic_number = DUMP_ASM_MAGIC_NUMBER;
+        dump_header_asm.dha_version = DUMP_ASM_VERSION_NUMBER;
+        dump_header_asm.dha_header_size = sizeof(struct __dump_header_asm);
+
+	/* copy the registers if they are valid */
+	if (regs) {
+		memcpy((void *)&(dump_header_asm.dha_regs),
+			(const void *)regs, sizeof(struct pt_regs));
+	}
+
+	/* configure architecture-specific dump header values */
+	if (!__dump_configure_header(regs))
+		return 0;
+
+	return 1;
+}
+
+/*
+ * Name: dump_write_header()
+ * Func: Write out the dump header.
+ *
+ * Returns:
+ *	-1: failed
+ *	 0: wrote o bytes (truncated)
+ *	+1: wrote header
+ */
+static int
+dump_write_header(void)
+{
+	int state;
+	loff_t toffset;
+
+	/* clear the dump page buffer */
+	memset(dump_page_buf, 0, DUMP_BUFFER_SIZE);
+
+	/* copy the dump header directly into the dump page buffer */
+	memcpy(dump_page_buf, (const void *)&dump_header,
+		sizeof(struct __dump_header));
+
+	memcpy((void *)(dump_page_buf + sizeof(struct __dump_header)),
+		(const void *)&dump_header_asm, sizeof(struct __dump_header_asm));
+
+	/* save our file pointer */
+	toffset = dump_fpos;
+
+	/* 
+	 * ALWAYS write out the dump header at DUMP_HEADER_OFFSET, 
+	 * this is after the longest swap header possibly written by mkswap;
+	 * likely the largest PAGE_SIZE supported by the architecture.
+	 */
+	dump_fpos = DUMP_HEADER_OFFSET;
+
+	/* do the real write here */
+	state = dump_kernel_write(NULL);
+	dump_fpos = toffset;
+	if (state < 0) {
+		printk("dump_kernel_write() failed!\n");
+		return -1;
+	} else if (!state) {
+		/* wrote zero bytes - failed */
+		return 0;
+	}
+	/* Wrote the header - success */
+	return 1;
+}
+
+/*
+ * -----------------------------------------------------------------------
+ *                  E X E C U T E   F U N C T I O N S
+ * -----------------------------------------------------------------------
+ */
+
+static int
+dump_write_mbank(int *dump_truncated, int pass, u64 mbank_start,
+		u64 mbank_end, unsigned long *buf_loc)
+{
+	int counter = 0, n_bytes = 0;
+	u64 mem_loc;
+
+	for (mem_loc = mbank_start; mem_loc < mbank_end;
+			mem_loc += DUMP_PAGE_SIZE) {
+  
+		/* add the page (if it's real RAM) */
+		if (dump_add_page((mem_loc >> DUMP_PAGE_SHIFT), 
+			buf_loc, pass)) {
+			/* didn't add a page to buffer */
+			continue;
+		}
+
+		/* see if we've filled the buffer */
+		if (*buf_loc >= DUMP_BUFFER_SIZE) {
+			int near_eof = 0;
+
+			/* write out the dump page buffer */
+			n_bytes = dump_kernel_write(&near_eof);
+			if (n_bytes < 0) {
+				printk("Write of dump pages failed!\n");
+				return -1;
+			} else if (n_bytes == 0) {
+				printk("EOF on Write of dump pages; "
+						"dump terminated\n!");
+				return 0;
+			}
+			if (near_eof) {
+				printk("Near EOF on Write of dump pages; "
+						"truncating dump,\n");
+				*dump_truncated = 1;
+			}
+
+			/* bump the counter for writing out the header */
+			counter++;
+
+			/*
+			 * Update the header every once in a while -- this
+			 * _must_ be done before we write the overflow end of
+			 * the dump_page_buf into the top of dump_page_buf,
+			 * as dump_write_header() uses dump_page_buf to
+			 * write the default/asm dump headers.  After we are
+			 * done updating the header, _then_ we can move the
+			 * leftover dump data into the top of dump_page_buf.
+			 *
+			 * NOTE: a period is printed to indicate that the header
+			 *	 was updated. Speedo shows page outactivity.
+			 */
+			if ((counter & 0x3f) == 0) {
+				n_bytes = dump_write_header();
+				if (n_bytes < 0) {
+					printk("Dump header update "
+							"failed!\n");
+					return -1;
+				} else if (n_bytes == 0) {
+					printk("Dump header update "
+							"failed; bizarre\n");
+					return 0;
+				}
+				printk(".");
+			} else {
+				if ((counter & 0x07) == 0)
+					dump_speedo();
+			}
+
+			/* clear the dump page buffer */
+			memset(dump_page_buf, 0, DUMP_BUFFER_SIZE);
+
+			/* adjust leftover data back to the top of the page */
+			if (*buf_loc > DUMP_BUFFER_SIZE) {
+				/* copy the dump page buffer remnants */
+				memcpy((void *)dump_page_buf,
+					(const void *)(dump_page_buf +
+						DUMP_BUFFER_SIZE),
+					*buf_loc - DUMP_BUFFER_SIZE);
+
+				/* set the new buffer location */
+				*buf_loc -= DUMP_BUFFER_SIZE;
+			} else {
+				/* reset the buffer location counter */
+				*buf_loc = 0;
+			}
+		}
+		if (*dump_truncated) {
+			break;
+		}
+	}
+	printk(" ");	
+	return 1;
+}
+
+/*
+ * Name: dump_execute_memdump()
+ * Func: Perform the actual memory dump.  This walks through the
+ *       memory pages and dumps the data to disk (using other functions).
+ *
+ * Returns:
+ *	-1: failed
+ *	 0: dump truncated	
+ *	 1: success
+ */
+static int
+dump_execute_memdump(void)
+{
+	int n_bytes = 0, i, retval = 1;
+	unsigned long buf_loc;
+	int dump_truncated = 0;
+	int pass = 0;
+
+	printk("Compression value is 0x%x, Writing dump header \n",
+			dump_compress);
+
+	/* update the header to disk the first time */
+	n_bytes = dump_write_header();
+	printk("\n");
+
+	if (n_bytes < 0) {
+		printk("Initial dump header update failed!\n");
+		return -1;
+	} else if (n_bytes == 0) {
+		return 0;
+	}
+
+	/* if we only want the header, return */
+	if (dump_level & DUMP_LEVEL_HEADER)
+		return 1;
+
+	/* set beginning offset to keep compats right with swap devices */
+	dump_fpos = DUMP_HEADER_OFFSET + DUMP_BUFFER_SIZE;
+
+	/* clear the dump page buffer */
+	memset(dump_page_buf, 0, DUMP_BUFFER_SIZE);
+
+	/* set the buffer location */
+	buf_loc = 0;
+
+	for (pass = 1; pass <= 4; pass++) {
+		if ((pass == 2) && dump_unreserved_mem == 0)
+			 continue;
+		if ((pass == 3) && dump_unreferenced_mem == 0)
+			 continue;
+		if (pass == 4) { 
+			if (dump_nonconventional_mem == 0) break;
+			/* Contiguous Mem Sys have 1 mbank */
+			if (dump_mbanks == 1) break;
+		} 
+		/* Algorithm suggested by Jack Steiner <steiner@sgi.com */
+		switch(pass) {
+			case 1:	printk("\nPass 1: Saving Kernel Pages: \n");
+				break;
+			case 2:	printk("\nPass 2: Saving Remaining "
+						"Referenced Pages: \n");
+				break;
+			case 3:	printk("\nPass 3: Saving Remaining "
+						"Unreferenced Pages: \n");
+				break;
+			case 4:	printk("\nPass 4: Saving Unconventional "
+						"Memory: \n");
+				break;
+		}
+		for (i = 0; i < dump_mbanks; i++) {
+			u64 mem_bank_start = dump_mbank[i].start;
+			u64 mem_bank_end = dump_mbank[i].end;
+			int type = dump_mbank[i].type;
+
+			if ((type != DUMP_MBANK_TYPE_CONVENTIONAL_MEMORY) &&
+				  (pass != 4)) continue;
+			if ((type == DUMP_MBANK_TYPE_CONVENTIONAL_MEMORY) &&
+				  (pass == 4)) continue;
+	
+			printk("Memory Bank[%d]: %llx ... %llx: "
+					,i, mem_bank_start, mem_bank_end);
+
+			if ((retval = dump_write_mbank(&dump_truncated, pass,
+				mem_bank_start, mem_bank_end, &buf_loc)) <= 0)
+				return retval;
+			if (dump_truncated)
+				break;
+		}
+		if (dump_truncated)
+			break;
+		printk("\n");
+	}
+
+	/* 
+	 * we have written out most of the dump pages, a few may still be in the
+	 * page buffer and it's possible we had to truncate the dump because we
+	 * got very close to the end of the dump partition. Now we add a EOF
+	 * marker to the page out buffer and flush out the remaining pages.
+	 *
+	 * We need to write the DUMP_DH_END even for truncated data because
+	 * the reader won't get an EOF if he reads the data in smaller chunks
+	 * than the DUMP_BUFFER_SIZE it's written in.
+	 */
+	if (dump_truncated)
+		dump_add_end_marker(&buf_loc, (DUMP_DH_END | DUMP_DH_TRUNCATED));
+	else
+		dump_add_end_marker(&buf_loc, DUMP_DH_END);
+
+	n_bytes = dump_kernel_write(NULL);
+
+	if (n_bytes < 0) {
+                printk("Final write of last of page buffer and "
+				"DUMP_DH_END failed!\n");
+                return -1;
+        } else if (n_bytes == 0) {
+		printk("Hit EOF writing DUMP_DH_END; bad luck\n");
+                return 0;
+        }
+
+	/*
+	 * Writing out DUMP_DH_END may have pushed us past the end of the first
+	 * part of the page buffer, if it did we have to write out one last 
+	 * DUMP_BUFFER with the spill over page.
+	 */
+	if (buf_loc > DUMP_BUFFER_SIZE) {
+		/* clear the first part of the buffer */
+		memset(dump_page_buf, 0, DUMP_BUFFER_SIZE);
+
+		/*
+		 * Copy the dump page buffer remnants in the second 
+		 * part of the buffer to the first part.
+		 */
+		memcpy((void *)dump_page_buf,
+			(const void *)(dump_page_buf + DUMP_BUFFER_SIZE),
+			buf_loc - DUMP_BUFFER_SIZE);
+
+		n_bytes = dump_kernel_write(NULL);
+		if (n_bytes < 0) {
+			printk("Final write of spillover page failed!\n");
+			return -1;
+		} else if (n_bytes == 0) {
+			printk("Hit EOF writing spill over page with "
+					"DUMP_DH_END; very bad luck!\n");
+			return 0;
+		}
+	}
+	if (dump_truncated)
+		return 0;
+
+	/* success */
+	return 1;
+}
+
+/*
+ * Name: dump_execute()
+ * Func: Execute the dumping process.  This makes sure all the appropriate
+ *       fields are updated correctly, and calls dump_execute_memdump(),
+ *       which does the real work.
+ * 
+ * if( dump_flags & DUMP_FLAGS_NONDISRUPT ) {
+ *    Returns:
+ *      -1: failed
+ *       0: dump truncated
+ *       1: success
+ * }
+ */
+int
+dump_execute(char *panic_str, struct pt_regs *regs)
+{
+	int state = 1;
+	int scheduler_disabled = 1;
+
+	dump_started = 1;
+
+	/* make sure we can dump */
+	if (!dump_okay)
+		return -1;
+
+	/* 
+	 * we can delay this till arch-specific header configuration
+	 * where we use NMI ipi to mark the current process
+	 * for rescheduling and schedular is disabled based on this value
+	 * However setting this early here only...
+	 */
+	dump_in_progress = 1;
+
+	if(!dump_configure_header(panic_str, regs)) {
+		printk("dump header could not be configured!\n");
+		dump_in_progress = 0;
+		return -1;
+	}
+
+	/* silence the system */
+	dump_silence_system();
+
+	/* tell interested parties that a dump is about to start */
+	if (dump_flags & DUMP_FLAGS_NONDISRUPT) {
+		notifier_call_chain(&dump_notifier_list, DUMP_BEGIN_NONDISRUPT,
+				&dump_device);
+	} else {
+		notifier_call_chain(&dump_notifier_list, DUMP_BEGIN,
+				&dump_device);
+	}
+
+	/*
+	 * if dump device notifier indicated the scheduler needs to be 
+	 * enabled then we need to turn it back on.
+	 */
+	if (dump_scheduler_enabled) {
+		dump_resume_system();
+		scheduler_disabled = 0;
+	}
+
+        /*
+	 * Make sure dump device notifier indicated that Non-Disruptive
+	 * Dumps are Supported.
+	 */
+	if (!dump_nondisruptive_enabled && (dump_flags &
+				DUMP_FLAGS_NONDISRUPT) ) {
+		printk("Non-Disruptive Dumps are not Supported by "
+			"Dump Device 0x%x\n", kdev_val(dump_device));
+		state = -1;	/* Dump Aborted */
+	} else {
+		/* bail out if we're not going to do any dumping. */
+		if (dump_level != DUMP_LEVEL_NONE) {
+			/* inform users of what we are about to do */
+			printk("Dumping to device 0x%x on CPU %d ...\n",
+				kdev_val(dump_device), smp_processor_id());
+	
+			dump_device_ops->dump_start(0);
+
+			/* start walking through the page tables */
+			state = dump_execute_memdump();
+	
+			printk("\n");
+	
+			/* update header to disk for the last time */
+			if (dump_write_header() < 0) {
+				printk("Final dump header update "
+						"failed!\n");
+			}
+			
+			dump_device_ops->dump_end(0);
+
+			if (state < 0) {
+				printk("Dump Failed!\n");
+			} else if (state == 0) {
+				printk("Dump Truncated (likely out of "
+						"space).\n");
+			} else {
+				printk("Dump Complete; %d dump pages "
+						"saved.\n", 
+					dump_header.dh_num_dump_pages);
+			}
+		}
+	}
+
+	/* tell interested parties that a dump has completed */
+	notifier_call_chain(&dump_notifier_list, DUMP_END, &dump_device);
+
+	/* put the system state back */
+	if (scheduler_disabled)
+		dump_resume_system();
+
+	/* 
+	 * Reboot the system if this is a disrupted dump.
+	 * Non-disruptive dumps have to be set up special 
+	 * swap partition that isn't being used and can be
+	 * used for testing.
+	 */
+	if (!(dump_flags & DUMP_FLAGS_NONDISRUPT)) {
+		int timeout = (panic_timeout > 0) ? panic_timeout : 10;
+
+		printk("Dump: Rebooting in %d seconds ...\n", timeout);
+		mdelay(timeout * 1000);
+		machine_restart(NULL);
+	}
+	dump_started = 0;
+	return state;
+}
+
+/*
+ * Name: dump_register_compression()
+ * Func: Register a dump compression mechanism.
+ */
+void
+dump_register_compression(struct __dump_compress *item)
+{
+	/* let's make sure our list is valid */
+	if (!item)
+		return;
+
+	/* add our item */
+	list_add(&(item->list), &dump_compress_list);
+
+	/* print information to callers */
+	printk("\n \nRegistering dump compression type 0x%x\n",
+			item->compress_type);
+}
+
+/*
+ * Name: dump_unregister_compression()
+ * Func: Remove a dump compression mechanism, and re-assign the dump
+ *       compression pointer if necessary.
+ */
+void
+dump_unregister_compression(int compression_type)
+{
+	struct list_head *tmp;
+	struct __dump_compress *dc;
+
+	/* let's make sure our list is valid */
+	if (compression_type == DUMP_COMPRESS_NONE) {
+		printk("Compression list is invalid!\n");
+		return;
+	}
+
+	/* try to remove the compression item */
+	list_for_each(tmp, &dump_compress_list) {
+		dc = list_entry(tmp, struct __dump_compress, list);
+		if (dc->compress_type == compression_type) {
+			list_del(&(dc->list));
+			printk("De-registering dump compression type "
+					"0x%x\n", compression_type);
+			return;
+		}
+	}
+}
+
+/*
+ * Name: dump_compress_init()
+ * Func: Initialize (or re-initialize) compression scheme.
+ */
+static int
+dump_compress_init(int compression_type)
+{
+	struct list_head *tmp;
+	struct __dump_compress *dc;
+
+	/* try to remove the compression item */
+	list_for_each(tmp, &dump_compress_list) {
+		dc = list_entry(tmp, struct __dump_compress, list);
+		if (dc->compress_type == compression_type) {
+			dump_compress_func = dc->compress_func;
+			dump_compress = compression_type;
+
+			printk("dump_compress = %d\n", dump_compress);
+			return 0;
+		}
+	}
+
+	/* 
+	 * nothing on the list -- return ENODATA to indicate an error 
+	 *
+	 * NB: 
+	 *	EAGAIN: reports "Resource temporarily unavailable" which
+	 *		isn't very enlightening.
+	 */
+	printk("compression_type:%d not found\n", compression_type);
+
+	return -ENODATA;
+}
+
+/*
+ * Name: dump_open_kdev()
+ * Func: Try to open the kdev_t argument as the real dump device.
+ *       This is where all the work is done for setting up the dump
+ *       device.  It's assumed at this point that by passing in the
+ *       dump device's major/minor number, we can open it up, check
+ *       it out, and use it for whatever purposes.
+ */
+static int
+dump_open_kdev(kdev_t tmp_dump_device)
+{
+	unsigned long dump_page_addr;
+	int err;
+
+	if (dump_device_ops == 0) {
+		printk("dump device driver is not loaded\n");
+		return -EINVAL;
+	}
+
+	/* if this is the second call to this function, clean up ... */
+	if (dump_okay && !dump_page_buf_0)
+		kfree((const void *)dump_page_buf_0);
+
+	/* 
+	 * Allocate buffer to be used for copying pages (only once ...) 
+	 *
+	 * An extra:
+	 * 2 * DUMP_PAGE_SIZE:
+	 * is needed for the page overflow of last page, it's page header
+	 * and the EOF page header.
+	 *
+	 * and an  extra:
+	 * 1 * PAGE_SIZE:
+	 * is needed for rounding up the start of the dump_page_buf to
+	 * a system page (PAGE_SIZE) boundry.
+	 * 
+	 */
+	dump_page_buf = dump_page_buf_0 = (void *)kmalloc(DUMP_BUFFER_SIZE + 
+			2 * DUMP_PAGE_SIZE + PAGE_SIZE, GFP_KERNEL);
+
+	if (dump_page_buf_0 == (void *)0) {
+		printk("Cannot kmalloc() dump page buffer!\n");
+		dump_okay = 0;
+		return -ENOMEM;
+	}
+
+	/* align the dump page addresses */
+	dump_page_addr = (unsigned long) dump_page_buf;
+	if (dump_page_addr % PAGE_SIZE)
+		dump_page_buf = (void *) PAGE_ALIGN(dump_page_addr);
+
+	/* assign the new dump file structure */
+	dump_device = tmp_dump_device;
+
+	err = dump_device_ops->dump_open(kdev_val(dump_device));
+	if (err < 0) {
+		dump_okay = 0;
+		return -EINVAL;
+	}
+	dump_okay = 1;
+
+	/* after opening the block device, return */
+	return 0;
+}
+
+/*
+ * Name: dump_release()
+ * Func: Release the dump device -- it's never necessary to call
+ *       this function, but it's here regardless.
+ */
+static int
+dump_release(struct inode *i, struct file *f)
+{
+	return 0;
+}
+
+/*
+ * Name: dump_ioctl()
+ * Func: Allow all dump tunables through a standard ioctl() mechanism.
+ *       This is far better than before, where we'd go through /proc,
+ *       because now this will work for multiple OS and architectures.
+ */
+static int
+dump_ioctl(struct inode *i, struct file *f, unsigned int cmd, unsigned long arg)
+{
+	/* check capabilities */
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	/*
+	 * This is the main mechanism for controlling get/set data
+	 * for various dump device parameters.  The real trick here
+	 * is setting the dump device (DIOSDUMPDEV).  That's what
+	 * triggers everything else.
+	 */
+	switch (cmd) {
+		/* set dump_device */
+		case DIOSDUMPDEV:
+			/* check flags */
+			if (!(f->f_flags & O_RDWR))
+				return -EPERM;
+
+			__dump_open();
+			return (dump_open_kdev(to_kdev_t((dev_t)arg)));
+
+		/* get dump_device */
+		case DIOGDUMPDEV:
+			return (put_user((long)kdev_val(dump_device), (long *)arg));
+
+		/* set dump_level */
+		case DIOSDUMPLEVEL:
+			/* check flags */
+			if (!(f->f_flags & O_RDWR))
+				return -EPERM;
+
+			/* make sure we have a positive value */
+			if (arg < 0)
+				return -EINVAL;
+			dump_level = (int)arg;
+
+			if (dump_level > DUMP_LEVEL_KERN)
+				dump_unreserved_mem = 1;
+			else
+				dump_unreserved_mem = 0;
+
+			if (dump_level > DUMP_LEVEL_USED)
+				dump_unreferenced_mem = 1;
+			else
+				dump_unreferenced_mem = 0;
+
+			if (dump_level > DUMP_LEVEL_ALL_RAM)
+				dump_nonconventional_mem = 1;
+			else
+				dump_nonconventional_mem = 0;
+			break;
+
+		/* get dump_level */
+		case DIOGDUMPLEVEL:
+			return (put_user((long)dump_level, (long *)arg));
+
+		/* set dump_flags */
+		case DIOSDUMPFLAGS:
+			/* check flags */
+			if (!(f->f_flags & O_RDWR))
+				return -EPERM;
+
+			/* make sure we have a positive value */
+			if (arg < 0)
+				return -EINVAL;
+
+			dump_flags = (int)arg;
+			break;
+
+		/* get dump_flags */
+		case DIOGDUMPFLAGS:
+			return (put_user((long)dump_flags, (long *)arg));
+
+		/* set the dump_compress status */
+		case DIOSDUMPCOMPRESS:
+			/* check flags */
+			if (!(f->f_flags & O_RDWR))
+				return -EPERM;
+
+			return (dump_compress_init((int)arg));
+
+		/* get the dump_compress status */
+		case DIOGDUMPCOMPRESS:
+			return (put_user((long)dump_compress, (long *)arg));
+
+	}
+	return 0;
+}
+
+/*
+ * -----------------------------------------------------------------------
+ *                     I N I T   F U N C T I O N S
+ * -----------------------------------------------------------------------
+ */
+
+/*
+ * Name: dump_init_proc_entry()
+ * Func: Create a dump proc entry based on the /proc dump root.
+ *       Returns 1 on failure, 0 on success.
+ */
+int
+dump_init_proc_entry(char *name, struct proc_dir_entry *dirent)
+{
+	if (!(dirent = create_proc_entry(name,
+		S_IFREG|S_IRUGO|S_IWUSR, dump_root))) {
+			printk("unable to initialize "
+				"/proc/%s/%s!\n", DUMP_ROOT_NAME, name);
+		return 1;
+	}
+	dirent->data = (void *)dirent;
+	dirent->read_proc = &dump_read_proc;
+	dirent->write_proc = NULL;
+	dirent->size = 16;
+	return 0;
+}
+
+/*
+ * Name: dump_proc_init()
+ * Func: Initialize the /proc interfaces for dumping.
+ * 
+ * Typically:
+ *	/proc/sys/dump/
+ *		dump_compress  dump_device  dump_flags  dump_level
+ */
+int
+dump_proc_init(void)
+{
+	/* create the proc entries for the various tunables */
+	dump_root = create_proc_entry(DUMP_ROOT_NAME, S_IFDIR, 0);
+	if (dump_root) {
+		dump_root->owner = THIS_MODULE;
+	} else {
+		printk("unable to initialize /proc/%s!\n", DUMP_ROOT_NAME);
+		return -EBUSY;
+	}
+
+	if (dump_init_proc_entry(DUMP_DEVICE_NAME, dump_dd)) {
+		remove_proc_entry(DUMP_ROOT_NAME, 0);
+		return -EBUSY;
+	}
+	if (dump_init_proc_entry(DUMP_LEVEL_NAME, dump_l)) {
+		remove_proc_entry(DUMP_ROOT_NAME, 0);
+		remove_proc_entry(DUMP_DEVICE_NAME, dump_root);
+		return -EBUSY;
+	}
+	if (dump_init_proc_entry(DUMP_FLAGS_NAME, dump_f)) {
+		remove_proc_entry(DUMP_ROOT_NAME, 0);
+		remove_proc_entry(DUMP_DEVICE_NAME, dump_root);
+		remove_proc_entry(DUMP_LEVEL_NAME, dump_root);
+		return -EBUSY;
+	}
+	if (dump_init_proc_entry(DUMP_COMPRESS_NAME, dump_cp)) {
+		remove_proc_entry(DUMP_ROOT_NAME, 0);
+		remove_proc_entry(DUMP_DEVICE_NAME, dump_root);
+		remove_proc_entry(DUMP_LEVEL_NAME, dump_root);
+		remove_proc_entry(DUMP_FLAGS_NAME, dump_root);
+		return -EBUSY;
+	}
+	return 0;
+}
+
+/*
+ * Name: dump_proc_cleanup()
+ * Func: Cleanup the /proc interfaces for dumping.
+ */
+void
+dump_proc_cleanup(void)
+{
+	/* remove the proc entries */
+	remove_proc_entry(DUMP_DEVICE_NAME, dump_root);
+	remove_proc_entry(DUMP_LEVEL_NAME, dump_root);
+	remove_proc_entry(DUMP_FLAGS_NAME, dump_root);
+	remove_proc_entry(DUMP_COMPRESS_NAME, dump_root);
+	remove_proc_entry(DUMP_ROOT_NAME, 0);
+	return;
+}
+
+/*
+ * These register and unregister routines are exported for modules
+ * to register their dump drivers (like block, net etc)
+ */
+int
+dump_register_device(struct dump_operations *dump_ops)
+{
+	if (dump_device_ops)
+		return -1;
+	dump_device_ops = dump_ops;
+	return 0;
+}
+
+void
+dump_unregister_device(void)
+{
+	dump_device_ops = 0;
+}
+
+/*
+ * Name: dump_init()
+ * Func: Initialize the dump process.  This will set up any architecture
+ *       dependent code.  The big key is we need the memory offsets before
+ *       the page table is initialized, because the base memory offset
+ *       is changed after paging_init() is called.
+ */
+static int __init
+dump_init(void)
+{
+	struct sysinfo info;
+	int i; 
+
+	/* try to initialize /proc interfaces */
+	if (dump_proc_init() < 0) {
+		printk("dump_proc_init failed!; dump not initialized\n");
+		return -EBUSY;
+	}
+
+	/* try to create our dump device */
+	if (register_chrdev(CRASH_DUMP_MAJOR, "dump", &dump_fops)) {
+		printk("cannot register dump character device!\n");
+		return -EBUSY;
+	}
+
+	/* initialize the dump headers to zero */
+	memset(&dump_header, 0, sizeof(dump_header));
+	memset(&dump_header_asm, 0, sizeof(dump_header_asm));
+
+	__dump_init((u64)PAGE_OFFSET);
+
+	/* initialize the dump page buffer */
+	dump_page_buf = (void *)0;
+
+	/* set the dump function pointer for dump execution */
+	dump_function_ptr = dump_execute;
+
+	/* set the dump_compression_list structure up */
+	dump_compress = DUMP_COMPRESS_NONE;
+	dump_compress_func = dump_compress_none;
+	dump_register_compression(&dump_none_compression);
+
+	/* initialize the dump flags, dump level and dump_compress fields */
+	dump_flags = DUMP_FLAGS_NONE;
+	dump_level = DUMP_LEVEL_ALL;
+
+	/* grab the total memory size now (not if/when we crash) */
+	si_meminfo(&info);
+
+	/* set the memory size */
+	dump_header.dh_memory_size = (u64)info.totalram;
+
+	for (i = 0; i < dump_mbanks; i++) {
+		printk("mbank[%d]: type:%d, phys_addr %llx ... " 
+			"%llx \n" ,i, dump_mbank[i].type, dump_mbank[i].start,
+			dump_mbank[i].end);
+		if (dump_mbank[i].start % DUMP_PAGE_SIZE)
+			printk("oops, start is not DUMP_PAGE_SIZE:%x "
+				"aligned!\n", (int) DUMP_PAGE_SIZE);
+
+		if ((dump_mbank[i].end + 1) % DUMP_PAGE_SIZE)
+			printk("oops, end is not DUMP_PAGE_SIZE:%x "
+				"aligned!\n", (int) DUMP_PAGE_SIZE);
+	}
+	printk("Crash dump driver initialized.\n");
+	return 0;
+}
+
+static void __exit
+dump_cleanup(void)
+{
+	/* get rid of the allocated dump page buffer */
+	if (dump_page_buf_0)
+		kfree((const void *)dump_page_buf_0);
+
+	/* arch-specific cleanup routine */
+	__dump_cleanup();
+
+	/* remove the proc entries */
+	dump_proc_cleanup();
+
+	/* try to create our dump device */
+	if (unregister_chrdev(CRASH_DUMP_MAJOR, "dump"))
+		printk("cannot unregister dump character device!\n");
+
+	/* reset the dump function pointer */
+	dump_function_ptr = NULL;
+
+	return;
+}
+
+EXPORT_SYMBOL(dump_register_compression);
+EXPORT_SYMBOL(dump_unregister_compression);
+EXPORT_SYMBOL(dump_register_device);
+EXPORT_SYMBOL(dump_unregister_device);
+EXPORT_SYMBOL(dump_page_buf);
+
+#ifdef MODULE
+MODULE_AUTHOR("Matt D. Robinson <yakker@sourceforge.net>");
+MODULE_DESCRIPTION("Linux Kernel Crash Dump (LKCD) driver");
+MODULE_LICENSE("GPL");
+#endif /* MODULE */
+
+module_init(dump_init);
+module_exit(dump_cleanup);
diff -Naur linux-2.5.44.orig/drivers/dump/dump_blockdev.c linux-2.5.44.lkcd/drivers/dump/dump_blockdev.c
--- linux-2.5.44.orig/drivers/dump/dump_blockdev.c	Wed Dec 31 16:00:00 1969
+++ linux-2.5.44.lkcd/drivers/dump/dump_blockdev.c	Wed Oct 23 02:09:29 2002
@@ -0,0 +1,361 @@
+/*
+ * Block device driver for LKCD
+ * This code is released under version 2 of the GNU GPL.
+ */
+#include <linux/types.h>
+#include <linux/dump.h>
+#include <linux/module.h>
+#include <linux/proc_fs.h>
+#include <linux/init.h>
+#include <linux/blkdev.h>
+#include <linux/bio.h>
+
+extern void *dump_page_buf;	/* dump page buffer for memcpy()!       */
+
+kdev_t dump_dev;		/* the actual kdev_t device number      */
+int dump_blk_size;		/* sector size for dump_device          */
+int dump_blk_shift;		/* shift need to convert to sector size */
+struct bio *dump_bio;		/* bio structure for io request         */
+loff_t dump_offset;		/* the offset in the output device      */
+unsigned long dumpdev_limit;	/* the size limit of the block device   */
+int dump_io_abort = 0;		/* set by end_io func during io error   */
+
+/* dump block device */
+struct block_device *dump_bdev = NULL;
+
+/* indicates completion of each bio request */
+volatile int bio_complete = 1;
+
+static void
+dump_free_bio(void)
+{
+	if (dump_bio && dump_bio->bi_io_vec)
+		kfree(dump_bio->bi_io_vec);
+	if (dump_bio)
+		kfree(dump_bio);
+}
+
+int
+dump_bio_end_io(struct bio *bio, unsigned int bytes_done, int error)
+{
+	/* No wakeup needed since we've stopped scheduling */
+	/* TODO: take care of the case when scheduler is enabled */
+
+	/* 
+	 * IO is not fully complete, return without setting bio_complete
+	 * so that caller continues to wait for completion.
+	 */
+	if (bio->bi_size)
+		return 1;
+
+	if (error) {
+		printk("dump_bio_end_io(): IO error while writing "
+			"the dump, aborting\n");
+		dump_io_abort = 1;
+	}
+	bio_complete = 1;
+	clear_bit(BIO_UPTODATE, &dump_bio->bi_flags);
+
+	return 0;
+}
+
+/*
+ * Name: dump_open_device()
+ * Func: Try to open the kdev_t argument as the real dump device.
+ *       This is where all the work is done for setting up the dump
+ *       device.  It's assumed at this point that by passing in the
+ *       dump device's major/minor number, we can open it up, check
+ *       it out, and use it for whatever purposes.
+ */
+static int
+dump_open_device(kdev_t tmp_dump_device)
+{
+	int i, retval = 0;
+	unsigned long a;
+	struct bio_vec *bvec;
+
+	/* make sure this is a valid block device */
+	if (!kdev_val(tmp_dump_device)) {
+		retval = -EINVAL;
+		goto err;
+	}
+
+	/* release earlier dump_bdev if present */
+	if (dump_bdev) {
+		blkdev_put(dump_bdev, BDEV_RAW);
+		dump_bdev = NULL;
+	}
+
+	dump_bdev = bdget(kdev_t_to_nr(tmp_dump_device));
+	if (!dump_bdev) {
+		retval = -ENODEV;
+		goto err;
+	}
+
+	if (blkdev_get(dump_bdev, O_RDWR | O_LARGEFILE, 0, BDEV_RAW)) {
+		retval = -ENODEV;
+		goto err1;
+	}
+	
+	if (!dump_page_buf) {
+		retval = -EINVAL;
+		goto err2;
+	}
+
+	if (dump_bio)
+		dump_free_bio();
+
+	if ((dump_bio = kmalloc(sizeof(struct bio), GFP_KERNEL)) == NULL) {
+		printk("dump_open_device(): Cannot allocate bio\n");
+		retval = -ENOMEM;
+		goto err2;
+	}
+
+	bio_init(dump_bio);
+
+	if ((bvec = kmalloc(sizeof(struct bio_vec) * 
+		(DUMP_BUFFER_SIZE >> PAGE_SHIFT), GFP_KERNEL)) == NULL) {
+		retval = -ENOMEM;
+		goto err3;
+	}
+
+	/* setup bio structure */
+	dump_bio->bi_io_vec = bvec;
+
+	a = (unsigned long) dump_page_buf;
+	for (i = 0; i < (DUMP_BUFFER_SIZE >> PAGE_SHIFT); i++, bvec++,
+			a += PAGE_SIZE) {
+		dump_bio->bi_vcnt++;
+		bvec->bv_page = (struct page *)virt_to_page(a);
+		bvec->bv_len = PAGE_SIZE;
+		bvec->bv_offset = 0;
+	}
+	dump_bio->bi_size = DUMP_BUFFER_SIZE;
+	dump_bio->bi_end_io = dump_bio_end_io;
+	dump_bio->bi_bdev = dump_bdev;
+
+	/* assign the new dump file structure */
+	dump_dev = tmp_dump_device;
+
+	/* note the max size of the dump device */
+	dumpdev_limit = dump_bdev->bd_inode->i_size;
+
+	printk("dump device 0x%x opened; Ready to take a "
+			"core dump\n", kdev_val(dump_dev));
+
+	/* after opening the block device, return */
+	return 0;
+
+err3:	dump_free_bio();
+err2:	if (dump_bdev) {
+		blkdev_put(dump_bdev, BDEV_RAW);
+		dump_bdev = NULL;
+	}
+err1:	if (dump_bdev) {
+		bdput(dump_bdev);
+		dump_bdev = NULL;
+	}
+err:	return retval;
+}
+
+/*
+ * Name: dev_dump_release()
+ * Func: Release the dump device -- it's never necessary to call
+ *       this function, but it's here regardless.
+ */
+static int
+dev_dump_release(void)
+{
+	return 0;
+}
+
+/*
+ * Name: dev_dump_end()
+ * Func: end the dump device -- it's never necessary to call
+ *       this function, but it's here regardless.
+ */
+static int
+dev_dump_end(unsigned long arg)
+{
+	return 0;
+}
+
+/*
+ * Name: dev_dump_ioctl()
+ * Func: Allow all dump tunables through a standard ioctl() mechanism.
+ *       This is far better than before, where we'd go through /proc,
+ *       because now this will work for multiple OS and architectures.
+ */
+static int
+dev_dump_ioctl(unsigned int cmd, unsigned long arg)
+{
+	return 0;
+}
+
+/*
+ * Name: dev_dump_seek()
+ * Func: seek to the dump device for use when the system crashes.
+ */
+static loff_t
+dev_dump_seek(loff_t off, int tmp)
+{
+	if (off & (PAGE_SIZE - 1)) {
+		printk("dev_dump_seek(): non-aligned page\n");
+		return -EINVAL;
+	}
+	
+	if (off & (bdev_hardsect_size(dump_bio->bi_bdev) - 1)) {
+		printk("dev_dump_seek(): sector not aligned\n");
+		return -EINVAL;
+	}
+
+	if (off > dumpdev_limit) {
+		printk("dev_dump_seek(): not enough space left on device!\n");
+		return -ENOSPC;
+	}
+	dump_offset = off;
+	return 0;
+}
+
+/*
+ * Name: dev_dump_write()
+ *
+ * Func: Write out kernel information, check the device limitations etc
+ * 	 Writes DUMP_BUFFER_SIZE bytes in page buffer
+ *
+ * Returns: number of bytes written or -ERRNO. 
+ *	    At EOF it returns 0.
+ */
+static ssize_t
+dev_dump_write(const char *buff, size_t len, loff_t *offset)
+{
+	/* this condition will not be true for now */
+	if (len > DUMP_BUFFER_SIZE) {
+		printk("dev_dump_write(): max dump buffer size exceeded");
+		return -EINVAL;
+	}
+	
+	if (dump_offset >= dumpdev_limit) {
+		printk("dev_dump_write(): no space left on device!");
+		return -ENOSPC;
+	}
+
+	/* 
+	 * If near the end of the dump device we set *eof (if ptr provided) to
+	 * let the caller know that it's near the EOF on the dump device.
+	 */
+	if ((dump_offset + (4 * DUMP_BUFFER_SIZE)) > dumpdev_limit)
+		if (offset != NULL) *offset = 1;
+
+	if (dump_offset + len > dumpdev_limit)
+		len = dumpdev_limit - dump_offset;
+
+	/* make sure we have space to write! */
+	if (!len) {
+		printk("dev_dump_write(): no space left on dump device!");
+		return 0;
+	}
+
+	/* re-initialize the fields of bio structure */
+	dump_bio->bi_sector = dump_offset >> 9;
+	dump_bio->bi_bdev = dump_bdev;
+	dump_bio->bi_vcnt = len >> PAGE_SHIFT;
+	dump_bio->bi_idx = 0;
+	dump_bio->bi_size = len;
+
+	/*
+	 * write out the data to disk.
+	 * here we submit a bio request for size = 64k(DUMP_BUFFER_SIZE)
+	 * and wait for io completion. In future, we can think of increasing
+	 * the dump buffer size and issuing multiple bios parallelly.
+	 */
+	bio_complete = 0;
+	submit_bio(WRITE, dump_bio);
+
+	return len;
+}
+
+/*
+ * Name: dev_dump_open()
+ * Func: Open the dump device for use when the system crashes.
+ */
+static int
+dev_dump_open(unsigned long arg)
+{
+	return dump_open_device(to_kdev_t((dev_t)arg));
+}
+
+/*
+ * Name: dev_dump_start()
+ * Func: start the dump device for use when the system crashes.
+ */
+static int
+dev_dump_start(unsigned long arg)
+{
+	return 0;
+}
+
+/*
+ * Name: dev_dump_ready()
+ * Func: check the dump device for use when the system crashes.
+ */
+static int
+dev_dump_ready(unsigned long arg)
+{
+	request_queue_t *q = bdev_get_queue(dump_bio->bi_bdev);
+
+	/* wait for io completion */
+	while (bio_complete == 0)
+		q->unplug_fn(q);
+
+	if (dump_io_abort)
+		return -EIO;
+	return 1;
+}
+
+static struct dump_operations dump_blockdev_ops = {
+	.dump_open	= dev_dump_open,
+	.dump_release	= dev_dump_release,
+	.dump_ioctl	= dev_dump_ioctl,
+        .dump_write	= dev_dump_write,
+	.dump_seek	= dev_dump_seek,
+	.dump_start	= dev_dump_start,
+	.dump_end	= dev_dump_end,
+	.dump_ready	= dev_dump_ready,
+};
+
+static int __init
+dump_blockdev_init(void)
+{        
+	dump_offset = 0;
+
+	if (dump_register_device(&dump_blockdev_ops) < 0) {
+		printk("block device driver registration failed\n");
+		return -1;
+	}
+		
+	printk("block device driver for LKCD unregistered\n");
+	return 0;
+}
+
+static void __exit
+dump_blockdev_cleanup(void)
+{
+	dump_unregister_device();
+	printk("block device driver for LKCD unregistered\n");
+	if (dump_bdev) {
+		blkdev_put(dump_bdev, BDEV_RAW);
+		dump_bdev = NULL;
+	}
+	if (dump_bio)
+		dump_free_bio();
+}
+
+#ifdef MODULE
+MODULE_AUTHOR("Mohamed. Abbas");
+MODULE_DESCRIPTION("Block Device Driver for Linux Kernel Crash Dump (LKCD)");
+MODULE_LICENSE("GPL");
+#endif /* MODULE */
+
+module_init(dump_blockdev_init);
+module_exit(dump_blockdev_cleanup);
diff -Naur linux-2.5.44.orig/drivers/dump/dump_gzip.c linux-2.5.44.lkcd/drivers/dump/dump_gzip.c
--- linux-2.5.44.orig/drivers/dump/dump_gzip.c	Wed Dec 31 16:00:00 1969
+++ linux-2.5.44.lkcd/drivers/dump/dump_gzip.c	Wed Oct 23 02:09:07 2002
@@ -0,0 +1,119 @@
+/*
+ * GZIP Compression functions for kernel crash dumps.
+ *
+ * Created by: Matt Robinson (yakker@sourceforge.net)
+ * Copyright 2001 Matt D. Robinson.  All rights reserved.
+ *
+ * This code is released under version 2 of the GNU GPL.
+ */
+
+/* header files */
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/fs.h>
+#include <linux/file.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/dump.h>
+#include <linux/zlib.h>
+#include <linux/vmalloc.h>
+
+static void *deflate_workspace;
+
+/*
+ * Name: dump_compress_gzip()
+ * Func: Compress a DUMP_PAGE_SIZE page using gzip-style algorithms (the.
+ *       deflate functions similar to what's used in PPP).
+ */
+static u16
+dump_compress_gzip(char *old, u16 oldsize, char *new, u16 newsize)
+{
+	/* error code and dump stream */
+	int err;
+	z_stream dump_stream;
+	
+	dump_stream.workspace = deflate_workspace;
+	
+	if ((err = zlib_deflateInit(&dump_stream, Z_BEST_COMPRESSION)) != Z_OK) {
+		/* fall back to RLE compression */
+		printk("dump_compress_gzip(): zlib_deflateInit() "
+			"failed (%d)!\n", err);
+		return 0;
+	}
+
+	/* use old (page of memory) and size (DUMP_PAGE_SIZE) as in-streams */
+	dump_stream.next_in = old;
+	dump_stream.avail_in = oldsize;
+
+	/* out streams are new (dpcpage) and new size (DUMP_DPC_PAGE_SIZE) */
+	dump_stream.next_out = new;
+	dump_stream.avail_out = newsize;
+
+	/* deflate the page -- check for error */
+	err = zlib_deflate(&dump_stream, Z_FINISH);
+	if (err != Z_STREAM_END) {
+		/* zero is return code here */
+		(void)zlib_deflateEnd(&dump_stream);
+		printk("dump_compress_gzip(): zlib_deflate() failed (%d)!\n",
+			err);
+		return 0;
+	}
+
+	/* let's end the deflated compression stream */
+	if ((err = zlib_deflateEnd(&dump_stream)) != Z_OK) {
+		printk("dump_compress_gzip(): zlib_deflateEnd() "
+			"failed (%d)!\n", err);
+	}
+
+	/* return the compressed byte total (if it's smaller) */
+	if (dump_stream.total_out >= oldsize) {
+		return oldsize;
+	}
+	return dump_stream.total_out;
+}
+
+/* setup the gzip compression functionality */
+static struct __dump_compress dump_gzip_compression = {
+	.compress_type = DUMP_COMPRESS_GZIP,
+	.compress_func = dump_compress_gzip,
+};
+
+/*
+ * Name: dump_compress_gzip_init()
+ * Func: Initialize gzip as a compression mechanism.
+ */
+static int __init
+dump_compress_gzip_init(void)
+{
+	deflate_workspace = vmalloc(zlib_deflate_workspacesize());
+	if (!deflate_workspace) {
+		printk("dump_compress_gzip_init(): Failed to "
+			"alloc %d bytes for deflate workspace\n",
+			zlib_deflate_workspacesize());
+		return -ENOMEM;
+	}
+	dump_register_compression(&dump_gzip_compression);
+	return 0;
+}
+
+/*
+ * Name: dump_compress_gzip_cleanup()
+ * Func: Remove gzip as a compression mechanism.
+ */
+static void __exit
+dump_compress_gzip_cleanup(void)
+{
+	vfree(deflate_workspace);
+	dump_unregister_compression(DUMP_COMPRESS_GZIP);
+}
+
+/* module initialization */
+module_init(dump_compress_gzip_init);
+module_exit(dump_compress_gzip_cleanup);
+
+#ifdef MODULE
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("LKCD Development Team <lkcd-devel@lists.sourceforge.net>");
+MODULE_DESCRIPTION("Gzip compression module for crash dump driver");
+#endif /* MODULE */
diff -Naur linux-2.5.44.orig/drivers/dump/dump_i386.c linux-2.5.44.lkcd/drivers/dump/dump_i386.c
--- linux-2.5.44.orig/drivers/dump/dump_i386.c	Wed Dec 31 16:00:00 1969
+++ linux-2.5.44.lkcd/drivers/dump/dump_i386.c	Wed Oct 23 02:09:29 2002
@@ -0,0 +1,322 @@
+/*
+ * Architecture specific (i386) functions for Linux crash dumps.
+ *
+ * Created by: Matt Robinson (yakker@sgi.com)
+ *
+ * Copyright 1999 Silicon Graphics, Inc. All rights reserved.
+ *
+ * 2.3 kernel modifications by: Matt D. Robinson (yakker@turbolinux.com)
+ * Copyright 2000 TurboLinux, Inc.  All rights reserved.
+ * 
+ * This code is released under version 2 of the GNU GPL.
+ */
+
+/*
+ * The hooks for dumping the kernel virtual memory to disk are in this
+ * file.  Any time a modification is made to the virtual memory mechanism,
+ * these routines must be changed to use the new mechanisms.
+ */
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/smp.h>
+#include <linux/fs.h>
+#include <linux/vmalloc.h>
+#include <linux/dump.h>
+#include <linux/mm.h>
+#include <linux/irq.h>
+
+#include <asm/processor.h>
+#include <asm/hardirq.h>
+
+static int
+alloc_dha_stack(void)
+{
+	int i;
+	void *ptr;
+	
+	if (dump_header_asm.dha_stack[0])
+		return 0;
+
+       	ptr = vmalloc(THREAD_SIZE * num_online_cpus());
+	if (!ptr) {
+		printk("vmalloc for dha_stacks failed\n");
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < num_online_cpus(); i++) {
+		dump_header_asm.dha_stack[i] = (u32)((unsigned long)ptr +
+				(i * THREAD_SIZE));
+	}
+	return 0;
+}
+
+static int
+free_dha_stack(void) 
+{
+	if (dump_header_asm.dha_stack[0])
+		vfree((void *)dump_header_asm.dha_stack[0]);	
+	return 0;
+}
+
+/* In case of panic dumps, we collects regs on entry to panic.
+ * so, we shouldn't 'fix' ssesp here again. But it is hard to
+ * tell just looking at regs whether ssesp need fixing. We make
+ * this decision by looking at xss in regs. If we have better
+ * means to determine that ssesp are valid (by some flag which
+ * tells that we are here due to panic dump), then we can use
+ * that instead of this kludge.
+ */
+static inline void 
+fix_ssesp(struct pt_regs *regs, int cpu)
+{
+	if (!user_mode(regs)) {
+		if ((cpu == dump_header_asm.dha_dumping_cpu) &&
+			(0xffff & regs->xss) == __KERNEL_DS) 
+			return;
+		dump_header_asm.dha_smp_regs[cpu].esp = 
+				(unsigned long)&(regs->esp);
+		__asm__ __volatile__ ("movw %%ss, %%ax;"
+			:"=a"(dump_header_asm.dha_smp_regs[cpu].xss));
+	}
+}
+
+static void
+save_this_cpu_state(int cpu, struct pt_regs *regs, struct task_struct *tsk)
+{
+	dump_header_asm.dha_smp_regs[cpu] = *regs;
+	dump_header_asm.dha_smp_current_task[cpu] = (u32)tsk;
+	fix_ssesp(regs, cpu);
+
+	if (dump_header_asm.dha_stack[cpu]) {
+		memcpy((void *)dump_header_asm.dha_stack[cpu],
+				tsk->thread_info, THREAD_SIZE);
+	}
+	dump_header_asm.dha_stack_ptr[cpu] = (u32)(tsk->thread_info);
+	return;
+}
+
+#ifdef CONFIG_SMP
+extern unsigned long irq_affinity[];
+extern irq_desc_t irq_desc[];
+extern void dump_send_ipi(void);
+static int dump_expect_ipi[NR_CPUS];
+static atomic_t waiting_for_dump_ipi;
+static int wait_for_dump_ipi = 1; /* always wait for ipi to to be handled */
+static unsigned long saved_affinity[NR_IRQS];
+__s32 saved_irq_count, saved_bh_count;
+
+static int
+dump_ipi_handler(struct pt_regs *regs) 
+{
+	int cpu = smp_processor_id();
+
+	if (!dump_expect_ipi[cpu]) {
+		return 0;
+	}
+	
+	save_this_cpu_state(cpu, regs, current);
+
+	dump_expect_ipi[cpu] = 0;
+	atomic_dec(&waiting_for_dump_ipi);
+
+	/* Mark the task for rescheduling, so that it task spins in schedule */
+	set_tsk_thread_flag(current, TIF_NEED_RESCHED);
+
+	return 1;
+}
+
+/* save registers on other processors */
+void 
+save_other_cpu_states(void)
+{
+	int i;
+
+	if (num_online_cpus() > 1) {
+		atomic_set(&waiting_for_dump_ipi, num_online_cpus()-1);
+		for (i = 0; i < NR_CPUS; i++)
+			dump_expect_ipi[i] = 1;
+		
+		dump_ipi_function_ptr = dump_ipi_handler;
+		dump_send_ipi();
+		/* may be we dont need to wait for NMI to be processed. 
+		   just write out the header at the end of dumping, if
+		   this IPI is not processed untill then, there probably
+		   is a problem and we just fail to capture state of 
+		   other cpus. */
+		if (wait_for_dump_ipi) {
+			while(atomic_read(&waiting_for_dump_ipi))
+				barrier();
+			dump_ipi_function_ptr = NULL;
+		}
+	}
+	return;
+}
+
+/*
+ * Routine to save the old irq affinities and change affinities of all irqs to
+ * the dumping cpu.
+ */
+static void
+__dump_set_irq_affinity(void)
+{
+	int i;
+	int cpu = smp_processor_id();
+
+	memcpy(saved_affinity, irq_affinity, NR_IRQS * sizeof(unsigned long));
+	for (i = 0; i < NR_IRQS; i++) {
+		if (irq_desc[i].handler == NULL)
+			continue;
+		irq_affinity[i] = 1UL << cpu;
+		if (irq_desc[i].handler->set_affinity != NULL)
+			irq_desc[i].handler->set_affinity(i, irq_affinity[i]);
+	}
+}
+
+/*
+ * Restore old irq affinities.
+ */
+static void
+__dump_reset_irq_affinity(void)
+{
+	int i;
+
+	memcpy(irq_affinity, saved_affinity, NR_IRQS * sizeof(unsigned long));
+	for (i = 0; i < NR_IRQS; i++) {
+		if (irq_desc[i].handler == NULL)
+			continue;
+		if (irq_desc[i].handler->set_affinity != NULL)
+			irq_desc[i].handler->set_affinity(i, saved_affinity[i]);
+	}
+}
+
+/* 
+ * Kludge - dump from interrupt context is unreliable (Fixme)
+ *
+ * We do this so that softirqs initiated for dump i/o 
+ * get processed and we don't hang while waiting for i/o
+ * to complete or in any irq synchronization attempt.
+ *
+ * This is not quite legal of course, as it has the side 
+ * effect of making all interrupts & softirqs triggered 
+ * while dump is in progress complete before currently 
+ * pending softirqs and the currently executing interrupt 
+ * code. 
+ */
+static inline void irq_bh_save(void)
+{
+	saved_irq_count = hardirq_count();
+	saved_bh_count = softirq_count();
+	preempt_count() &= ~HARDIRQ_MASK;
+	preempt_count() &= ~SOFTIRQ_MASK;
+}
+
+static inline void irq_bh_restore(void)
+{
+	preempt_count() |= saved_irq_count;
+	preempt_count() |= saved_bh_count;
+}
+
+#else /* !CONFIG_SMP */
+#define save_other_cpu_states()
+#endif /* !CONFIG_SMP */
+
+/*
+ * Name: __dump_silence_system()
+ * Func: Do an architecture-specific silencing of the system.
+ *     - Change irq affinities
+ *     - Wait for other cpus to come out of irq handling
+ *     - Send CALL_FUNCTION_VECTOR ipi to other cpus to put them to spin
+ */
+u16
+__dump_silence_system(unsigned int stage)
+{
+#ifdef CONFIG_SMP
+	if (stage) {	/* Do this after interrupts are enabled */
+		__dump_set_irq_affinity();
+		irq_bh_save();
+		/* synchronize_irq(); TODO: needed ? */
+	}
+#endif
+	return 0;
+}
+
+/*
+ * Name: __dump_resume_system()
+ * Func: Resume the system state in an architecture-specific way.
+ */
+u16
+__dump_resume_system(unsigned int stage)
+{
+#ifdef CONFIG_SMP
+	/* put the irq affinity tables back */
+	__dump_reset_irq_affinity();
+	irq_bh_restore();
+#endif
+	return 0;
+}
+
+/*
+ * Name: __dump_configure_header()
+ * Func: Configure the dump header with all proper values.
+ */
+int
+__dump_configure_header(struct pt_regs *regs)
+{
+	int cpu = smp_processor_id();
+
+	dump_header_asm.dha_smp_num_cpus = num_online_cpus();
+	dump_header_asm.dha_dumping_cpu = cpu;
+
+	save_this_cpu_state(cpu, regs, current);
+
+	save_other_cpu_states();
+
+	return 1;
+}
+
+void
+__init_mem_banks(void)
+{
+	dump_mbanks = 1;
+	dump_mbank[0].start = 0;
+	dump_mbank[0].end  = (((u64) max_mapnr) << PAGE_SHIFT) - 1;
+	dump_mbank[0].type = DUMP_MBANK_TYPE_CONVENTIONAL_MEMORY;
+	return;
+}
+
+/*
+ * Name: __dump_init()
+ * Func: Initialize the dumping routine process.  This is in case
+ *       it's necessary in the future.
+ */
+void
+__dump_init(uint64_t local_memory_start)
+{
+	__init_mem_banks();
+	return;
+}
+
+/*
+ * Name: __dump_open()
+ * Func: Open the dump device (architecture specific).  This is in
+ *       case it's necessary in the future.
+ */
+void
+__dump_open(void)
+{
+	alloc_dha_stack();
+	return;
+}
+
+/*
+ * Name: __dump_cleanup()
+ * Func: Free any architecture specific data structures. This is called
+ *       when the dump module is being removed.
+ */
+void
+__dump_cleanup(void)
+{
+	free_dha_stack();
+	return;
+}
diff -Naur linux-2.5.44.orig/drivers/dump/dump_rle.c linux-2.5.44.lkcd/drivers/dump/dump_rle.c
--- linux-2.5.44.orig/drivers/dump/dump_rle.c	Wed Dec 31 16:00:00 1969
+++ linux-2.5.44.lkcd/drivers/dump/dump_rle.c	Wed Oct 23 02:09:07 2002
@@ -0,0 +1,176 @@
+/*
+ * RLE Compression functions for kernel crash dumps.
+ *
+ * Created by: Matt Robinson (yakker@sourceforge.net)
+ * Copyright 2001 Matt D. Robinson.  All rights reserved.
+ *
+ * This code is released under version 2 of the GNU GPL.
+ */
+
+/* header files */
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/fs.h>
+#include <linux/file.h>
+#include <linux/init.h>
+#include <linux/dump.h>
+
+/*
+ * Name: dump_compress_rle()
+ * Func: Compress a DUMP_PAGE_SIZE (hardware) page down to something more
+ *       reasonable, if possible.  This is the same routine we use in IRIX.
+ */
+static u16
+dump_compress_rle(char *old, u16 oldsize, char *new, u16 newsize)
+{
+	u16 ri, wi, count = 0;
+	u_char value = 0, cur_byte;
+
+	/*
+	 * If the block should happen to "compress" to larger than the
+	 * buffer size, allocate a larger one and change cur_buf_size.
+	 */
+
+	wi = ri = 0;
+
+	while (ri < oldsize) {
+		if (!ri) {
+			cur_byte = value = old[ri];
+			count = 0;
+		} else {
+			if (count == 255) {
+				if (wi + 3 > oldsize) {
+					return oldsize;
+				}
+				new[wi++] = 0;
+				new[wi++] = count;
+				new[wi++] = value;
+				value = cur_byte = old[ri];
+				count = 0;
+			} else { 
+				if ((cur_byte = old[ri]) == value) {
+					count++;
+				} else {
+					if (count > 1) {
+						if (wi + 3 > oldsize) {
+							return oldsize;
+						}
+						new[wi++] = 0;
+						new[wi++] = count;
+						new[wi++] = value;
+					} else if (count == 1) {
+						if (value == 0) {
+							if (wi + 3 > oldsize) {
+								return oldsize;
+							}
+							new[wi++] = 0;
+							new[wi++] = 1;
+							new[wi++] = 0;
+						} else {
+							if (wi + 2 > oldsize) {
+								return oldsize;
+							}
+							new[wi++] = value;
+							new[wi++] = value;
+						}
+					} else { /* count == 0 */
+						if (value == 0) {
+							if (wi + 2 > oldsize) {
+								return oldsize;
+							}
+							new[wi++] = value;
+							new[wi++] = value;
+						} else {
+							if (wi + 1 > oldsize) {
+								return oldsize;
+							}
+							new[wi++] = value;
+						}
+					} /* if count > 1 */
+
+					value = cur_byte;
+					count = 0;
+
+				} /* if byte == value */
+
+			} /* if count == 255 */
+
+		} /* if ri == 0 */
+		ri++;
+
+	}
+	if (count > 1) {
+		if (wi + 3 > oldsize) {
+			return oldsize;
+		}
+		new[wi++] = 0;
+		new[wi++] = count;
+		new[wi++] = value;
+	} else if (count == 1) {
+		if (value == 0) {
+			if (wi + 3 > oldsize)
+				return oldsize;
+			new[wi++] = 0;
+			new[wi++] = 1;
+			new[wi++] = 0;
+		} else {
+			if (wi + 2 > oldsize)
+				return oldsize;
+			new[wi++] = value;
+			new[wi++] = value;
+		}
+	} else { /* count == 0 */
+		if (value == 0) {
+			if (wi + 2 > oldsize)
+				return oldsize;
+			new[wi++] = value;
+			new[wi++] = value;
+		} else {
+			if (wi + 1 > oldsize)
+				return oldsize;
+			new[wi++] = value;
+		}
+	} /* if count > 1 */
+
+	value = cur_byte;
+	count = 0;
+	return wi;
+}
+
+/* setup the rle compression functionality */
+static struct __dump_compress dump_rle_compression = {
+	.compress_type = DUMP_COMPRESS_RLE,
+	.compress_func = dump_compress_rle,
+};
+
+/*
+ * Name: dump_compress_rle_init()
+ * Func: Initialize rle compression for dumping.
+ */
+static int __init
+dump_compress_rle_init(void)
+{
+	dump_register_compression(&dump_rle_compression);
+	return 0;
+}
+
+/*
+ * Name: dump_compress_rle_cleanup()
+ * Func: Remove rle compression for dumping.
+ */
+static void __exit
+dump_compress_rle_cleanup(void)
+{
+	dump_unregister_compression(DUMP_COMPRESS_RLE);
+}
+
+/* module initialization */
+module_init(dump_compress_rle_init);
+module_exit(dump_compress_rle_cleanup);
+
+#ifdef MODULE
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("LKCD Development Team <lkcd-devel@lists.sourceforge.net>");
+MODULE_DESCRIPTION("RLE compression module for crash dump driver");
+#endif /* MODULE */
diff -Naur linux-2.5.44.orig/include/asm-i386/dump.h linux-2.5.44.lkcd/include/asm-i386/dump.h
--- linux-2.5.44.orig/include/asm-i386/dump.h	Wed Dec 31 16:00:00 1969
+++ linux-2.5.44.lkcd/include/asm-i386/dump.h	Wed Oct 23 02:09:29 2002
@@ -0,0 +1,101 @@
+/*
+ * Kernel header file for Linux crash dumps.
+ *
+ * Created by: Matt Robinson (yakker@sgi.com)
+ *
+ * Copyright 1999 Silicon Graphics, Inc. All rights reserved.
+ *
+ * This code is released under version 2 of the GNU GPL.
+ */
+
+/* This header file holds the architecture specific crash dump header */
+#ifndef _ASM_DUMP_H
+#define _ASM_DUMP_H
+
+/* necessary header files */
+#include <asm/ptrace.h>
+#include <asm/page.h>
+#include <linux/threads.h>
+#include <linux/mm.h>
+
+/* definitions */
+#define DUMP_ASM_MAGIC_NUMBER	0xdeaddeadULL	/* magic number            */
+#define DUMP_ASM_VERSION_NUMBER	0x3		/* version number          */
+
+/* max number of cpus */
+#define DUMP_MAX_NUM_CPUS 32
+
+/*
+ * Structure: __dump_header_asm
+ *  Function: This is the header for architecture-specific stuff.  It
+ *            follows right after the dump header.
+ */
+struct __dump_header_asm {
+	/* the dump magic number -- unique to verify dump is valid */
+	u64		dha_magic_number;
+
+	/* the version number of this dump */
+	u32		dha_version;
+
+	/* the size of this header (in case we can't read it) */
+	u32		dha_header_size;
+
+	/* the esp for i386 systems */
+	u32		dha_esp;
+
+	/* the eip for i386 systems */
+	u32		dha_eip;
+
+	/* the dump registers */
+	struct pt_regs	dha_regs;
+
+	/* smp specific */
+	u32		dha_smp_num_cpus;
+	u32		dha_dumping_cpu;
+	struct pt_regs	dha_smp_regs[DUMP_MAX_NUM_CPUS];
+	u32		dha_smp_current_task[DUMP_MAX_NUM_CPUS];
+	u32		dha_stack[DUMP_MAX_NUM_CPUS];
+	u32		dha_stack_ptr[DUMP_MAX_NUM_CPUS];
+} __attribute__((packed));
+
+#ifdef __KERNEL__
+static inline void get_current_regs(struct pt_regs *regs)
+{
+	__asm__ __volatile__("movl %%ebx,%0" : "=m"(regs->ebx));
+	__asm__ __volatile__("movl %%ecx,%0" : "=m"(regs->ecx));
+	__asm__ __volatile__("movl %%edx,%0" : "=m"(regs->edx));
+	__asm__ __volatile__("movl %%esi,%0" : "=m"(regs->esi));
+	__asm__ __volatile__("movl %%edi,%0" : "=m"(regs->edi));
+	__asm__ __volatile__("movl %%ebp,%0" : "=m"(regs->ebp));
+	__asm__ __volatile__("movl %%eax,%0" : "=m"(regs->eax));
+	__asm__ __volatile__("movl %%esp,%0" : "=m"(regs->esp));
+	__asm__ __volatile__("movw %%ss, %%ax;" :"=a"(regs->xss));
+	__asm__ __volatile__("movw %%cs, %%ax;" :"=a"(regs->xcs));
+	__asm__ __volatile__("movw %%ds, %%ax;" :"=a"(regs->xds));
+	__asm__ __volatile__("movw %%es, %%ax;" :"=a"(regs->xes));
+	__asm__ __volatile__("pushfl; popl %0" :"=m"(regs->eflags));
+	regs->eip = (unsigned long)current_text_addr();
+}
+
+extern struct __dump_header_asm dump_header_asm;
+
+#ifdef CONFIG_SMP
+extern unsigned long irq_affinity[];
+extern int (*dump_ipi_function_ptr)(struct pt_regs *);
+extern void dump_send_ipi(void);
+#else
+#define dump_send_ipi()
+#endif
+
+#define DUMP_PAGE_VALID 1
+extern int page_is_ram (unsigned long);
+static inline int dump_page_valid(unsigned long index)
+{
+	if (!pfn_valid(index))
+		return 0;
+	return page_is_ram(index);
+}
+
+#endif /* __KERNEL__ */
+
+#endif /* _ASM_DUMP_H */
diff -Naur linux-2.5.44.orig/include/linux/dump.h linux-2.5.44.lkcd/include/linux/dump.h
--- linux-2.5.44.orig/include/linux/dump.h	Wed Dec 31 16:00:00 1969
+++ linux-2.5.44.lkcd/include/linux/dump.h	Wed Oct 23 02:09:29 2002
@@ -0,0 +1,349 @@
+/*
+ * Kernel header file for Linux crash dumps.
+ *
+ * Created by: Matt Robinson (yakker@sgi.com)
+ * Copyright 1999 - 2002 Silicon Graphics, Inc. All rights reserved.
+ *
+ * vmdump.h to dump.h by: Matt D. Robinson (yakker@sourceforge.net)
+ * Copyright 2001 - 2002 Matt D. Robinson.  All rights reserved.
+ * Copyright (C) 2002 Free Software Foundation, Inc. All rights reserved.
+ *
+ * Most of this is the same old stuff from vmdump.h, except now we're
+ * actually a stand-alone driver plugged into the block layer interface,
+ * with the exception that we now allow for compression modes externally
+ * loaded (e.g., someone can come up with their own).
+ *
+ * This code is released under version 2 of the GNU GPL.
+ */
+
+/* This header file includes all structure definitions for crash dumps. */
+#ifndef _DUMP_H
+#define _DUMP_H
+
+#include <linux/list.h>
+#include <linux/notifier.h>
+
+/* 
+ * Predefine default DUMP_PAGE constants, asm header may override.
+ *
+ * On ia64 discontinuous memory systems it's possible for the memory
+ * banks to stop at 2**12 page alignments, the smallest possible page
+ * size. But the system page size, PAGE_SIZE, is in fact larger.
+ */
+#define DUMP_PAGE_SHIFT 	PAGE_SHIFT
+#define DUMP_PAGE_MASK		PAGE_MASK
+#define DUMP_PAGE_ALIGN(addr)	PAGE_ALIGN(addr)
+#define DUMP_HEADER_OFFSET	PAGE_SIZE
+
+/* keep DUMP_PAGE_SIZE constant to 4K = 1<<12
+ * it may be different from PAGE_SIZE then.
+ */
+#define DUMP_PAGE_SIZE		4096
+
+/* 
+ * Predefined default memcpy() to use when copying memory to the dump buffer.
+ *
+ * On ia64 there is a heads up function that can be called to let the prom
+ * machine check monitor know that the current activity is risky and it should
+ * ignore the fault (nofault). In this case the ia64 header will redefine this
+ * macro to __dump_memcpy() and use it's arch specific version.
+ */
+#define DUMP_memcpy		memcpy
+
+/* necessary header files */
+#include <asm/dump.h>			/* for architecture-specific header */
+
+/* 
+ * Size of the buffer that's used to hold:
+ *
+ *	1. the dump header (padded to fill the complete buffer)
+ *	2. the possibly compressed page headers and data
+ */
+#define DUMP_BUFFER_SIZE	(64 * 1024)  /* size of dump buffer         */
+#define DUMP_HEADER_SIZE	DUMP_BUFFER_SIZE
+
+/* header definitions for s390 dump */
+#define DUMP_MAGIC_S390		0xa8190173618f23fdULL  /* s390 magic number */
+#define S390_DUMP_HEADER_SIZE	4096
+
+/* standard header definitions */
+#define DUMP_MAGIC_NUMBER	0xa8190173618f23edULL  /* dump magic number */
+#define DUMP_MAGIC_LIVE		0xa8190173618f23cdULL  /* live magic number */
+#define DUMP_VERSION_NUMBER	0x8	/* dump version number              */
+#define DUMP_PANIC_LEN		0x100	/* dump panic string length         */
+
+/* dump levels - type specific stuff added later -- add as necessary */
+#define DUMP_LEVEL_NONE		0x0	/* no dumping at all -- just bail   */
+#define DUMP_LEVEL_HEADER	0x1	/* kernel dump header only          */
+#define DUMP_LEVEL_KERN		0x2	/* dump header and kernel pages     */
+#define DUMP_LEVEL_USED		0x4	/* dump header, kernel/user pages   */
+#define DUMP_LEVEL_ALL_RAM	0x8	/* dump header, all RAM pages       */
+#define DUMP_LEVEL_ALL		0x10	/* dump all memory RAM and firmware */
+
+
+/* dump compression options -- add as necessary */
+#define DUMP_COMPRESS_NONE	0x0	/* don't compress this dump         */
+#define DUMP_COMPRESS_RLE	0x1	/* use RLE compression              */
+#define DUMP_COMPRESS_GZIP	0x2	/* use GZIP compression             */
+
+/* dump flags - any dump-type specific flags -- add as necessary */
+#define DUMP_FLAGS_NONE		0x0	/* no flags are set for this dump   */
+#define DUMP_FLAGS_NONDISRUPT	0x1	/* try to keep running after dump   */
+
+/* dump header flags -- add as necessary */
+#define DUMP_DH_FLAGS_NONE	0x0	/* no flags set (error condition!)  */
+#define DUMP_DH_RAW		0x1	/* raw page (no compression)        */
+#define DUMP_DH_COMPRESSED	0x2	/* page is compressed               */
+#define DUMP_DH_END		0x4	/* end marker on a full dump        */
+#define DUMP_DH_TRUNCATED	0x8	/* dump is incomplete               */
+#define DUMP_DH_TEST_PATTERN	0x10	/* dump page is a test pattern      */
+#define DUMP_DH_NOT_USED	0x20	/* 1st bit not used in flags        */
+
+/* names for various dump tunables (they are now all read-only) */
+#define DUMP_ROOT_NAME		"sys/dump"
+#define DUMP_DEVICE_NAME	"dump_device"
+#define DUMP_COMPRESS_NAME	"dump_compress"
+#define DUMP_LEVEL_NAME		"dump_level"
+#define DUMP_FLAGS_NAME		"dump_flags"
+
+/* page size for gzip compression -- buffered slightly beyond hardware PAGE_SIZE used by DUMP */
+#define DUMP_DPC_PAGE_SIZE	(DUMP_PAGE_SIZE + 512)
+
+/* dump ioctl() control options */
+#define DIOSDUMPDEV		1	/* set the dump device              */
+#define DIOGDUMPDEV		2	/* get the dump device              */
+#define DIOSDUMPLEVEL		3	/* set the dump level               */
+#define DIOGDUMPLEVEL		4	/* get the dump level               */
+#define DIOSDUMPFLAGS		5	/* set the dump flag parameters     */
+#define DIOGDUMPFLAGS		6	/* get the dump flag parameters     */
+#define DIOSDUMPCOMPRESS	7	/* set the dump compress level      */
+#define DIOGDUMPCOMPRESS	8	/* get the dump compress level      */
+#define DIOSDUMPMEM		9	/* set the dump buffer memory	    */	
+#define DUMPCONSOLE_MAJOR	245
+#define DUMPCONSOLE_NAME        "netconsole"
+
+struct dump_operations {
+	loff_t (*dump_seek) (loff_t, int);
+	ssize_t (*dump_write) (const char *, size_t, loff_t *);
+	int (*dump_ioctl) (unsigned int, unsigned long);
+	int (*dump_open) (unsigned long);
+	int (*dump_release) (void);
+	int (*dump_start) (unsigned long);
+	int (*dump_end) (unsigned long);
+	int (*dump_ready) (unsigned long);
+};
+
+extern int dump_register_device(struct dump_operations *);
+extern void dump_unregister_device(void);
+
+/*
+ * Structure: __dump_header
+ *  Function: This is the header dumped at the top of every valid crash
+ *            dump.  
+ */
+struct __dump_header {
+	/* the dump magic number -- unique to verify dump is valid */
+	u64	dh_magic_number;
+
+	/* the version number of this dump */
+	u32	dh_version;
+
+	/* the size of this header (in case we can't read it) */
+	u32	dh_header_size;
+
+	/* the level of this dump (just a header?) */
+	u32	dh_dump_level;
+
+	/* 
+	 * We assume dump_page_size to be 4K in every case.
+	 * Store here the configurable system page size (4K, 8K, 16K, etc.) 
+	 */
+	u32	dh_page_size;
+
+	/* the size of all physical memory */
+	u64	dh_memory_size;
+
+	/* the start of physical memory */
+	u64	dh_memory_start;
+
+	/* the end of physical memory */
+	u64	dh_memory_end;
+
+	/* the number of hardware/physical pages in this dump specifically */
+	u32	dh_num_dump_pages;
+
+	/* the panic string, if available */
+	char	dh_panic_string[DUMP_PANIC_LEN];
+
+	/* timeval depends on architecture, two long values */
+	struct {
+		u64 tv_sec;
+		u64 tv_usec;
+	} dh_time; /* the time of the system crash */
+
+	/* the NEW utsname (uname) information -- in character form */
+	/* we do this so we don't have to include utsname.h         */
+	/* plus it helps us be more architecture independent        */
+	/* now maybe one day soon they'll make the [65] a #define!  */
+	char	dh_utsname_sysname[65];
+	char	dh_utsname_nodename[65];
+	char	dh_utsname_release[65];
+	char	dh_utsname_version[65];
+	char	dh_utsname_machine[65];
+	char	dh_utsname_domainname[65];
+
+	/* the address of current task (OLD = void *, NEW = u64) */
+	u64	dh_current_task;
+
+	/* what type of compression we're using in this dump (if any) */
+	u32	dh_dump_compress;
+
+	/* any additional flags */
+	u32	dh_dump_flags;
+
+	/* any additional flags */
+	u32	dh_dump_device;
+} __attribute__((packed));
+
+/*
+ * Structure: __dump_page
+ *  Function: To act as the header associated to each physical page of
+ *            memory saved in the system crash dump.  This allows for
+ *            easy reassembly of each crash dump page.  The address bits
+ *            are split to make things easier for 64-bit/32-bit system
+ *            conversions.
+ *
+ * dp_byte_offset and dp_page_index are landmarks that are helpful when
+ * looking at a hex dump of /dev/vmdump,
+ */
+struct __dump_page {
+	/* the address of this dump page */
+	u64	dp_address;
+
+	/* the size of this dump page */
+	u32	dp_size;
+
+	/* flags (currently DUMP_COMPRESSED, DUMP_RAW or DUMP_END) */
+	u32	dp_flags;
+} __attribute__((packed));
+
+/*
+ * Structure: __lkcdinfo
+ * Function:  This structure contains information needed for the lkcdutils
+ *            package (particularly lcrash) to determine what information is
+ *            associated to this kernel, specifically.
+ */
+struct __lkcdinfo {
+	int	arch;
+	int	ptrsz;
+	int	byte_order;
+	int	linux_release;
+	int	page_shift;
+	int	page_size;
+	u64	page_mask;
+	u64	page_offset;
+	int	stack_offset;
+};
+
+#ifdef __KERNEL__
+
+/*
+ * Structure: __dump_compress
+ *  Function: This is what an individual compression mechanism can use
+ *            to plug in their own compression techniques.  It's always
+ *            best to build these as individual modules so that people
+ *            can put in whatever they want.
+ */
+struct __dump_compress {
+	/* the list_head structure for list storage */
+	struct list_head list;
+
+	/* the type of compression to use (DUMP_COMPRESS_XXX) */
+	int compress_type;
+
+	/* the compression function to call */
+	u16 (*compress_func)(char *, u16, char *, u16);
+};
+
+/* functions for dump compression registration */
+extern void dump_register_compression(struct __dump_compress *);
+extern void dump_unregister_compression(int);
+
+/*
+ * Structure dump_mbank[]:
+ *
+ * For CONFIG_DISCONTIGMEM systems this array specifies the
+ * memory banks/chunks that need to be dumped after a panic.
+ *
+ * For classic systems it specifies a single set of pages from
+ * 0 to max_mapnr.
+ */
+struct __dump_mbank {
+	u64 	start;
+	u64 	end;
+	int	type;
+	int	pad1;
+	long	pad2;
+};
+
+#define DUMP_MBANK_TYPE_CONVENTIONAL_MEMORY		1
+#define DUMP_MBANK_TYPE_OTHER				2
+
+#define MAXCHUNKS 256
+extern int dump_mbanks;
+extern struct __dump_mbank dump_mbank[MAXCHUNKS];
+
+extern struct notifier_block *dump_notifier_list;
+extern int register_dump_notifier(struct notifier_block *);
+extern int unregister_dump_notifier(struct notifier_block *);
+
+/* notification event codes */
+#define DUMP_BEGIN_NONDISRUPT	0x0000	/* non-disruptive dump beginning */
+#define DUMP_BEGIN		0x0001	/* distuptive dump beginning */
+#define DUMP_END		0x0002	/* dump ending */
+#define DUMP_TEST		0x0003	/* probing for capability callbacks */
+
+int dump_execute(char *, struct pt_regs *);
+extern volatile int dump_in_progress;
+extern volatile int dumping_cpu;
+extern volatile int dump_started;
+extern int (*dump_function_ptr)(char *, struct pt_regs *);
+
+/*
+ * dump notifier callbacks to tune the dump driver for 
+ * the disk driver that will be used for the dump. They
+ * are used to modify the dump driver from it's default
+ * behavior.
+ *
+ * NOTE: To support changing the dump device between a
+ *       non-disruptive dump and a future dump we would
+ *	 need to provide the inverse functions also.
+ */
+extern void dump_scheduler_enable(void);
+extern void dump_interrupts_disable(void);
+extern void dump_nondisruptive_disable(void);
+
+static inline void dump(char * str, struct pt_regs * regs)
+{
+	if (dump_function_ptr) {
+		dump_function_ptr((char *)str, regs);
+	}
+}
+
+/*
+ * Common Arch Specific Functions should be declared here.
+ * This allows the C compiler to detect discrepancies.
+ */
+extern void	__dump_open(void);
+extern void	__dump_cleanup(void);
+extern void	__dump_init(u64);
+extern int	__dump_configure_header(struct pt_regs *);
+extern u16	__dump_silence_system(unsigned int);
+extern u16	__dump_resume_system(unsigned int);
+
+#ifndef DUMP_PAGE_VALID
+static inline int dump_page_valid(unsigned long index) { return 1; }
+#endif
+
+#endif /* __KERNEL__ */
+#endif /* _DUMP_H */
diff -Naur linux-2.5.44.orig/include/linux/major.h linux-2.5.44.lkcd/include/linux/major.h
--- linux-2.5.44.orig/include/linux/major.h	Fri Oct 18 21:01:18 2002
+++ linux-2.5.44.lkcd/include/linux/major.h	Wed Oct 23 02:09:07 2002
@@ -160,6 +160,8 @@
 
 #define OSST_MAJOR	206	/* OnStream-SCx0 SCSI tape */
 
+#define CRASH_DUMP_MAJOR	221	/* crash dump interface */
+
 #define IBM_TTY3270_MAJOR       227	/* Official allocations now */
 #define IBM_FS3270_MAJOR        228
 

