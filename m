Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318966AbSHFCqm>; Mon, 5 Aug 2002 22:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318968AbSHFCqm>; Mon, 5 Aug 2002 22:46:42 -0400
Received: from patan.Sun.COM ([192.18.98.43]:29865 "EHLO patan.sun.com")
	by vger.kernel.org with ESMTP id <S318966AbSHFCqe>;
	Mon, 5 Aug 2002 22:46:34 -0400
Message-ID: <3D4F3962.3050303@sun.com>
Date: Mon, 05 Aug 2002 19:50:10 -0700
From: Tim Hockin <thockin@sun.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] nvram - add Cobalt support
Content-Type: multipart/mixed;
 boundary="------------060701010208090907080103"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060701010208090907080103
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch adds support for Cobalt systems to the nvram driver.  In the 
process, the nvram symbols were exported, and a few other minor cleanup 
went in.  This iwll soon be available through bk, but I thought I'd 
solicit any gripes before I push it up. :)

This is another in a series of patches trying desperately to get our 
tree synced :).  If it all looks ok, I'll ask Marcelo and Linus to pull it.

Tim

-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com

--------------060701010208090907080103
Content-Type: text/plain;
 name="bk-rev-1.582.2.81.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bk-rev-1.582.2.81.patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.582.2.80 -> 1.582.2.81
#	include/linux/nvram.h	1.1     -> 1.3    
#	drivers/char/nvram.c	1.9     -> 1.11   
#	drivers/char/Makefile	1.18    -> 1.19   
#	Documentation/Configure.help	1.110   -> 1.111  
#	               (new)	        -> 1.2     include/linux/cobalt-nvram.h
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/02	th122948@scl3.sfbay.sun.com	1.582.2.81
# Add Cobalt Networks support to nvram driver
# export nvram interfaces
# general cleanup of nvram driver
# protect nvram state with a lock
# fix nvram O_EXCL hack to actually work
# --------------------------------------------
#
diff -Nru a/Documentation/Configure.help b/Documentation/Configure.help
--- a/Documentation/Configure.help	Mon Aug  5 18:55:26 2002
+++ b/Documentation/Configure.help	Mon Aug  5 18:55:26 2002
@@ -18187,9 +18187,10 @@
 CONFIG_NVRAM
   If you say Y here and create a character special file /dev/nvram
   with major number 10 and minor number 144 using mknod ("man mknod"),
-  you get read and write access to the 50 bytes of non-volatile memory
-  in the real time clock (RTC), which is contained in every PC and
-  most Ataris.
+  you get read and write access to the extra bytes of non-volatile
+  memory in the real time clock (RTC), which is contained in every PC
+  and most Ataris.  The actual number of bytes varies, depending on the
+  nvram in the system, but is usually 114 (128-14 for the RTC).
 
   This memory is conventionally called "CMOS RAM" on PCs and "NVRAM"
   on Ataris. /dev/nvram may be used to view settings there, or to
diff -Nru a/drivers/char/Makefile b/drivers/char/Makefile
--- a/drivers/char/Makefile	Mon Aug  5 18:55:26 2002
+++ b/drivers/char/Makefile	Mon Aug  5 18:55:26 2002
@@ -24,7 +24,7 @@
 export-objs     :=	busmouse.o console.o keyboard.o sysrq.o \
 			misc.o pty.o random.o selection.o serial.o \
 			sonypi.o tty_io.o tty_ioctl.o generic_serial.o \
-			au1000_gpio.o
+			au1000_gpio.o nvram.o
 
 mod-subdirs	:=	joystick ftape drm drm-4.0 pcmcia
 
diff -Nru a/drivers/char/nvram.c b/drivers/char/nvram.c
--- a/drivers/char/nvram.c	Mon Aug  5 18:55:26 2002
+++ b/drivers/char/nvram.c	Mon Aug  5 18:55:26 2002
@@ -3,6 +3,7 @@
  *
  * Copyright (C) 1997 Roman Hodek <Roman.Hodek@informatik.uni-erlangen.de>
  * idea by and with help from Richard Jelinek <rj@suse.de>
+ * Portions copyright (c) 2001,2002 Sun Microsystems (thockin@sun.com)
  *
  * This driver allows you to access the contents of the non-volatile memory in
  * the mc146818rtc.h real-time clock. This chip is built into all PCs and into
@@ -10,9 +11,10 @@
  * "NVRAM" (NV stands for non-volatile).
  *
  * The data are supplied as a (seekable) character device, /dev/nvram. The
- * size of this file is 50, the number of freely available bytes in the memory
- * (i.e., not used by the RTC itself).
- * 
+ * size of this file is dependant on the controller.  The usual size is 114,
+ * the number of freely available bytes in the memory (i.e., not used by the
+ * RTC itself).
+ *
  * Checksums over the NVRAM contents are managed by this driver. In case of a
  * bad checksum, reads and writes return -EIO. The checksum can be initialized
  * to a sane state either by ioctl(NVRAM_INIT) (clear whole NVRAM) or
@@ -28,25 +30,35 @@
  *
  * 	1.1	Cesar Barros: SMP locking fixes
  * 		added changelog
+ * 	1.2	Erik Gilling: Cobalt Networks support
+ * 		Tim Hockin: general cleanup, Cobalt support
  */
 
-#define NVRAM_VERSION		"1.1"
+#define NVRAM_VERSION	"1.2"
 
 #include <linux/module.h>
 #include <linux/config.h>
 #include <linux/sched.h>
 #include <linux/smp_lock.h>
+#include <linux/nvram.h>
 
 #define PC		1
 #define ATARI		2
+#define COBALT		3
 
 /* select machine configuration */
 #if defined(CONFIG_ATARI)
-#define MACH ATARI
+#  define MACH ATARI
 #elif defined(__i386__) || defined(__x86_64__) || defined(__arm__)  /* and others?? */
 #define MACH PC
+#  if defined(CONFIG_COBALT)
+#    include <linux/cobalt-nvram.h>
+#    define MACH COBALT
+#  else
+#    define MACH PC
+#  endif
 #else
-#error Cannot build nvram driver for this machine configuration.
+#  error Cannot build nvram driver for this machine configuration.
 #endif
 
 #if MACH == PC
@@ -58,10 +70,23 @@
 #define PC_CKS_RANGE_START	2
 #define PC_CKS_RANGE_END	31
 #define PC_CKS_LOC		32
+#define NVRAM_BYTES		(128-NVRAM_FIRST_BYTE)
+
+#define mach_check_checksum	pc_check_checksum
+#define mach_set_checksum	pc_set_checksum
+#define mach_proc_infos		pc_proc_infos
+
+#endif
+
+#if MACH == COBALT
+
+#define CHECK_DRIVER_INIT()     1
+
+#define NVRAM_BYTES		(128-NVRAM_FIRST_BYTE)
 
-#define	mach_check_checksum	pc_check_checksum
-#define	mach_set_checksum	pc_set_checksum
-#define	mach_proc_infos		pc_proc_infos
+#define mach_check_checksum	cobalt_check_checksum
+#define mach_set_checksum	cobalt_set_checksum
+#define mach_proc_infos		cobalt_proc_infos
 
 #endif
 
@@ -79,9 +104,9 @@
 #define ATARI_CKS_RANGE_END	47
 #define ATARI_CKS_LOC		48
 
-#define	mach_check_checksum	atari_check_checksum
-#define	mach_set_checksum	atari_set_checksum
-#define	mach_proc_infos		atari_proc_infos
+#define mach_check_checksum	atari_check_checksum
+#define mach_set_checksum	atari_set_checksum
+#define mach_proc_infos		atari_proc_infos
 
 #endif
 
@@ -98,7 +123,6 @@
 #include <linux/ioport.h>
 #include <linux/fcntl.h>
 #include <linux/mc146818rtc.h>
-#include <linux/nvram.h>
 #include <linux/init.h>
 #include <linux/proc_fs.h>
 #include <linux/spinlock.h>
@@ -107,15 +131,11 @@
 #include <asm/uaccess.h>
 #include <asm/system.h>
 
+static spinlock_t nvram_state_lock = SPIN_LOCK_UNLOCKED;
 static int nvram_open_cnt;	/* #times opened */
 static int nvram_open_mode;	/* special open modes */
-
-#define	NVRAM_WRITE		1	/* opened for writing (exclusive) */
-#define	NVRAM_EXCL		2	/* opened with O_EXCL */
-
-#define	RTC_FIRST_BYTE		14	/* RTC register number of first
-					 * NVRAM byte */
-#define	NVRAM_BYTES		128-RTC_FIRST_BYTE /* number of NVRAM bytes */
+#define NVRAM_WRITE		1 /* opened for writing (exclusive) */
+#define NVRAM_EXCL		2 /* opened with O_EXCL */
 
 static int mach_check_checksum(void);
 static void mach_set_checksum(void);
@@ -126,95 +146,85 @@
 #endif
 
 /*
- * These are the internal NVRAM access functions, which do NOT disable
- * interrupts and do not check the checksum. Both tasks are left to higher
- * level function, so they need to be done only once per syscall.
- */
-
-static __inline__ unsigned char
-nvram_read_int(int i)
-{
-	return CMOS_READ(RTC_FIRST_BYTE + i);
-}
-
-static __inline__ void
-nvram_write_int(unsigned char c, int i)
-{
-	CMOS_WRITE(c, RTC_FIRST_BYTE + i);
-}
-
-static __inline__ int
-nvram_check_checksum_int(void)
-{
-	return mach_check_checksum();
-}
-
-static __inline__ void
-nvram_set_checksum_int(void)
-{
-	mach_set_checksum();
-}
-
-#if MACH == ATARI
-
-/*
- * These non-internal functions are provided to be called by other parts of
+ * These functions are provided to be called internally or by other parts of
  * the kernel. It's up to the caller to ensure correct checksum before reading
  * or after writing (needs to be done only once).
  *
- * They're only built if CONFIG_ATARI is defined, because Atari drivers use
- * them. For other configurations (PC), the rest of the kernel can't rely on
- * them being present (this driver may not be configured at all, or as a
- * module), so they access config information themselves.
+ * It is worth noting that these functions all access bytes of general
+ * purpose memory in the NVRAM - that is to say, they all add the
+ * NVRAM_FIRST_BYTE offset.  Pass them offsets into NVRAM as if you did not 
+ * know about the RTC cruft.
  */
 
 unsigned char
+__nvram_read_byte(int i)
+{
+	return CMOS_READ(NVRAM_FIRST_BYTE + i);
+}
+
+unsigned char
 nvram_read_byte(int i)
 {
 	unsigned long flags;
 	unsigned char c;
 
 	spin_lock_irqsave(&rtc_lock, flags);
-	c = nvram_read_int(i);
+	c = __nvram_read_byte(i);
 	spin_unlock_irqrestore(&rtc_lock, flags);
 	return c;
 }
 
 /* This races nicely with trying to read with checksum checking (nvram_read) */
 void
+__nvram_write_byte(unsigned char c, int i)
+{
+	CMOS_WRITE(c, NVRAM_FIRST_BYTE + i);
+}
+
+void
 nvram_write_byte(unsigned char c, int i)
 {
 	unsigned long flags;
 
 	spin_lock_irqsave(&rtc_lock, flags);
-	nvram_write_int(c, i);
+	__nvram_write_byte(c, i);
 	spin_unlock_irqrestore(&rtc_lock, flags);
 }
 
 int
+__nvram_check_checksum(void)
+{
+	return mach_check_checksum();
+}
+
+int
 nvram_check_checksum(void)
 {
 	unsigned long flags;
 	int rv;
 
 	spin_lock_irqsave(&rtc_lock, flags);
-	rv = nvram_check_checksum_int();
+	rv = __nvram_check_checksum();
 	spin_unlock_irqrestore(&rtc_lock, flags);
 	return rv;
 }
 
 void
+__nvram_set_checksum(void)
+{
+	mach_set_checksum();
+}
+
+void
 nvram_set_checksum(void)
 {
 	unsigned long flags;
 
 	spin_lock_irqsave(&rtc_lock, flags);
-	nvram_set_checksum_int();
+	__nvram_set_checksum();
 	spin_unlock_irqrestore(&rtc_lock, flags);
 }
 
-#endif /* MACH == ATARI */
-
 /*
  * The are the file operation function for user access to /dev/nvram
  */
@@ -239,17 +249,17 @@
 static ssize_t
 nvram_read(struct file *file, char *buf, size_t count, loff_t *ppos)
 {
-	char contents[NVRAM_BYTES];
+	unsigned char contents[NVRAM_BYTES];
 	unsigned i = *ppos;
-	char *tmp;
+	unsigned char *tmp;
 
 	spin_lock_irq(&rtc_lock);
 
-	if (!nvram_check_checksum_int())
+	if (!__nvram_check_checksum())
 		goto checksum_err;
 
 	for (tmp = contents; count-- > 0 && i < NVRAM_BYTES; ++i, ++tmp)
-		*tmp = nvram_read_int(i);
+		*tmp = __nvram_read_byte(i);
 
 	spin_unlock_irq(&rtc_lock);
 
@@ -268,23 +278,24 @@
 static ssize_t
 nvram_write(struct file *file, const char *buf, size_t count, loff_t *ppos)
 {
-	char contents[NVRAM_BYTES];
+	unsigned char contents[NVRAM_BYTES];
 	unsigned i = *ppos;
-	char *tmp;
+	unsigned char *tmp;
+	int len;
 
-	if (copy_from_user(contents, buf, (NVRAM_BYTES - i) < count ?
-	    (NVRAM_BYTES - i) : count))
+	len = (NVRAM_BYTES - i) < count ? (NVRAM_BYTES - i) : count;
+	if (copy_from_user(contents, buf, len))
 		return -EFAULT;
 
 	spin_lock_irq(&rtc_lock);
 
-	if (!nvram_check_checksum_int())
+	if (!__nvram_check_checksum())
 		goto checksum_err;
 
 	for (tmp = contents; count-- > 0 && i < NVRAM_BYTES; ++i, ++tmp)
-		nvram_write_int(*tmp, i);
+		__nvram_write_byte(*tmp, i);
 
-	nvram_set_checksum_int();
+	__nvram_set_checksum();
 
 	spin_unlock_irq(&rtc_lock);
 
@@ -305,27 +316,28 @@
 
 	switch (cmd) {
 
-	case NVRAM_INIT:	/* initialize NVRAM contents and checksum */
+	case NVRAM_INIT:
+		/* initialize NVRAM contents and checksum */
 		if (!capable(CAP_SYS_ADMIN))
 			return -EACCES;
 
 		spin_lock_irq(&rtc_lock);
 
 		for (i = 0; i < NVRAM_BYTES; ++i)
-			nvram_write_int(0, i);
-		nvram_set_checksum_int();
+			__nvram_write_byte(0, i);
+		__nvram_set_checksum();
 
 		spin_unlock_irq(&rtc_lock);
 		return 0;
 
-	case NVRAM_SETCKS:	/* just set checksum, contents unchanged
-				 * (maybe useful after checksum garbaged
-				 * somehow...) */
+	case NVRAM_SETCKS:
+		/* just set checksum, contents unchanged (maybe useful after 
+		 * checksum garbaged somehow...) */
 		if (!capable(CAP_SYS_ADMIN))
 			return -EACCES;
 
 		spin_lock_irq(&rtc_lock);
-		nvram_set_checksum_int();
+		__nvram_set_checksum();
 		spin_unlock_irq(&rtc_lock);
 		return 0;
 
@@ -337,29 +349,40 @@
 static int
 nvram_open(struct inode *inode, struct file *file)
 {
+	spin_lock(&nvram_state_lock);
+
 	if ((nvram_open_cnt && (file->f_flags & O_EXCL)) ||
 	    (nvram_open_mode & NVRAM_EXCL) ||
-	    ((file->f_mode & 2) && (nvram_open_mode & NVRAM_WRITE)))
+	    ((file->f_mode & 2) && (nvram_open_mode & NVRAM_WRITE))) {
+		spin_unlock(&nvram_state_lock);
 		return -EBUSY;
+	}
 
 	if (file->f_flags & O_EXCL)
 		nvram_open_mode |= NVRAM_EXCL;
 	if (file->f_mode & 2)
 		nvram_open_mode |= NVRAM_WRITE;
 	nvram_open_cnt++;
+
+	spin_unlock(&nvram_state_lock);
+
 	return 0;
 }
 
 static int
 nvram_release(struct inode *inode, struct file *file)
 {
-	lock_kernel();
+	spin_lock(&nvram_state_lock);
+
 	nvram_open_cnt--;
-	if (file->f_flags & O_EXCL)
+
+	/* if only one instance is open, clear the EXCL bit */
+	if (nvram_open_mode & NVRAM_EXCL)
 		nvram_open_mode &= ~NVRAM_EXCL;
 	if (file->f_mode & 2)
 		nvram_open_mode &= ~NVRAM_WRITE;
-	unlock_kernel();
+
+	spin_unlock(&nvram_state_lock);
 
 	return 0;
 }
@@ -383,7 +406,7 @@
 
 	spin_lock_irq(&rtc_lock);
 	for (i = 0; i < NVRAM_BYTES; ++i)
-		contents[i] = nvram_read_int(i);
+		contents[i] = __nvram_read_byte(i);
 	spin_unlock_irq(&rtc_lock);
 
 	*eof = mach_proc_infos(contents, buffer, &len, &begin, offset, size);
@@ -397,7 +420,7 @@
 
 /* This macro frees the machine specific function from bounds checking and
  * this like that... */
-#define	PRINT_PROC(fmt,args...)					\
+#define PRINT_PROC(fmt,args...)					\
 	do {							\
 		*len += sprintf(buffer+*len, fmt, ##args);	\
 		if (*begin + *len > offset + size)		\
@@ -477,11 +500,13 @@
 {
 	int i;
 	unsigned short sum = 0;
+	unsigned short expect;
 
 	for (i = PC_CKS_RANGE_START; i <= PC_CKS_RANGE_END; ++i)
-		sum += nvram_read_int(i);
-	return ((sum & 0xffff) ==
-	    ((nvram_read_int(PC_CKS_LOC)<<8) | nvram_read_int(PC_CKS_LOC+1)));
+		sum += __nvram_read_byte(i);
+	expect = __nvram_read_byte(PC_CKS_LOC)<<8 |
+	    __nvram_read_byte(PC_CKS_LOC+1);
+	return ((sum & 0xffff) == expect);
 }
 
 static void
@@ -491,9 +516,9 @@
 	unsigned short sum = 0;
 
 	for (i = PC_CKS_RANGE_START; i <= PC_CKS_RANGE_END; ++i)
-		sum += nvram_read_int(i);
-	nvram_write_int(sum >> 8, PC_CKS_LOC);
-	nvram_write_int(sum & 0xff, PC_CKS_LOC + 1);
+		sum += __nvram_read_byte(i);
+	__nvram_write_byte(sum >> 8, PC_CKS_LOC);
+	__nvram_write_byte(sum & 0xff, PC_CKS_LOC + 1);
 }
 
 #ifdef CONFIG_PROC_FS
@@ -518,7 +543,7 @@
 	int type;
 
 	spin_lock_irq(&rtc_lock);
-	checksum = nvram_check_checksum_int();
+	checksum = __nvram_check_checksum();
 	spin_unlock_irq(&rtc_lock);
 
 	PRINT_PROC("Checksum status: %svalid\n", checksum ? "" : "not ");
@@ -576,6 +601,177 @@
 
 #endif /* MACH == PC */
 
+#if MACH == COBALT
+
+/* the cobalt CMOS has a wider range of it's checksum */
+static int cobalt_check_checksum(void)
+{
+	int i;
+	unsigned short sum = 0;
+	unsigned short expect;
+
+	for (i = COBT_CMOS_CKS_START; i <= COBT_CMOS_CKS_END; ++i) {
+		if ((i == COBT_CMOS_CHECKSUM) || (i == (COBT_CMOS_CHECKSUM+1)))
+			continue;
+
+		sum += __nvram_read_byte(i);
+	}
+	expect = __nvram_read_byte(COBT_CMOS_CHECKSUM) << 8 |
+	    __nvram_read_byte(COBT_CMOS_CHECKSUM+1);
+	return ((sum & 0xffff) == expect);
+}
+
+static void cobalt_set_checksum(void)
+{
+	int i;
+	unsigned short sum = 0;
+
+	for (i = COBT_CMOS_CKS_START; i <= COBT_CMOS_CKS_END; ++i) {
+		if ((i == COBT_CMOS_CHECKSUM) || (i == (COBT_CMOS_CHECKSUM+1)))
+			continue;
+
+		sum += __nvram_read_byte(i);
+	}
+
+	__nvram_write_byte(sum >> 8, COBT_CMOS_CHECKSUM);
+	__nvram_write_byte(sum & 0xff, COBT_CMOS_CHECKSUM+1);
+}
+
+#ifdef CONFIG_PROC_FS
+
+static int cobalt_proc_infos(unsigned char *nvram, char *buffer, int *len,
+	off_t *begin, off_t offset, int size)
+{
+	int i;
+	unsigned int checksum;
+	unsigned int flags;
+	char sernum[14];
+	char *key = "cNoEbTaWlOtR!";
+	unsigned char bto_csum;
+
+	spin_lock_irq(&rtc_lock);
+	checksum = __nvram_check_checksum();
+	spin_unlock_irq(&rtc_lock);
+
+	PRINT_PROC("Checksum status: %svalid\n", checksum ? "" : "not ");
+
+	flags = nvram[COBT_CMOS_FLAG_BYTE_0] << 8 
+	    | nvram[COBT_CMOS_FLAG_BYTE_1];
+
+	PRINT_PROC("Console: %s\n",
+		flags & COBT_CMOS_CONSOLE_FLAG ?  "on": "off");
+
+	PRINT_PROC("Firmware Debug Messages: %s\n",
+		flags & COBT_CMOS_DEBUG_FLAG ? "on": "off");
+
+	PRINT_PROC("Auto Prompt: %s\n",
+		flags & COBT_CMOS_AUTO_PROMPT_FLAG ? "on": "off");
+
+	PRINT_PROC("Shutdown Status: %s\n",
+		flags & COBT_CMOS_CLEAN_BOOT_FLAG ? "clean": "dirty");
+
+	PRINT_PROC("Hardware Probe: %s\n",
+		flags & COBT_CMOS_HW_NOPROBE_FLAG ? "partial": "full");
+
+	PRINT_PROC("System Fault: %sdetected\n",
+		flags & COBT_CMOS_SYSFAULT_FLAG ? "": "not ");
+
+	PRINT_PROC("Panic on OOPS: %s\n",
+		flags & COBT_CMOS_OOPSPANIC_FLAG ? "yes": "no");
+
+	PRINT_PROC("Delayed Cache Initialization: %s\n",
+		flags & COBT_CMOS_DELAY_CACHE_FLAG ? "yes": "no");
+
+	PRINT_PROC("Show Logo at Boot: %s\n",
+		flags & COBT_CMOS_NOLOGO_FLAG ? "no": "yes");
+
+	PRINT_PROC("Boot Method: ");
+	switch (nvram[COBT_CMOS_BOOT_METHOD]) {
+	case COBT_CMOS_BOOT_METHOD_DISK:
+		PRINT_PROC("disk\n");
+		break;
+
+	case COBT_CMOS_BOOT_METHOD_ROM:
+		PRINT_PROC("rom\n");
+		break;
+
+	case COBT_CMOS_BOOT_METHOD_NET:
+		PRINT_PROC("net\n");
+		break;
+
+	default:
+		PRINT_PROC("unknown\n");
+		break;
+	}
+
+	PRINT_PROC("Primary Boot Device: %d:%d\n",
+		nvram[COBT_CMOS_BOOT_DEV0_MAJ],
+		nvram[COBT_CMOS_BOOT_DEV0_MIN] );
+	PRINT_PROC("Secondary Boot Device: %d:%d\n",
+		nvram[COBT_CMOS_BOOT_DEV1_MAJ],
+		nvram[COBT_CMOS_BOOT_DEV1_MIN] );
+	PRINT_PROC("Tertiary Boot Device: %d:%d\n",
+		nvram[COBT_CMOS_BOOT_DEV2_MAJ],
+		nvram[COBT_CMOS_BOOT_DEV2_MIN] );
+
+	PRINT_PROC("Uptime: %d\n",
+		nvram[COBT_CMOS_UPTIME_0] << 24 |
+		nvram[COBT_CMOS_UPTIME_1] << 16 |
+		nvram[COBT_CMOS_UPTIME_2] << 8  |
+		nvram[COBT_CMOS_UPTIME_3]);
+
+	PRINT_PROC("Boot Count: %d\n",
+		nvram[COBT_CMOS_BOOTCOUNT_0] << 24 |
+		nvram[COBT_CMOS_BOOTCOUNT_1] << 16 |
+		nvram[COBT_CMOS_BOOTCOUNT_2] << 8  |
+		nvram[COBT_CMOS_BOOTCOUNT_3]);
+
+	/* 13 bytes of serial num */
+	for (i=0 ; i<13 ; i++) {
+		sernum[i] = nvram[COBT_CMOS_SYS_SERNUM_0 + i];
+	}
+	sernum[13] = '\0';
+
+	checksum = 0;
+	for (i=0 ; i<13 ; i++) {
+		checksum += sernum[i] ^ key[i];
+	}
+	checksum = ((checksum & 0x7f) ^ (0xd6)) & 0xff;
+
+	PRINT_PROC("Serial Number: %s", sernum);
+	if (checksum != nvram[COBT_CMOS_SYS_SERNUM_CSUM]) {
+		PRINT_PROC(" (invalid checksum)");
+	}
+	PRINT_PROC("\n");
+
+	PRINT_PROC("Rom Revison: %d.%d.%d\n", nvram[COBT_CMOS_ROM_REV_MAJ],
+		nvram[COBT_CMOS_ROM_REV_MIN], nvram[COBT_CMOS_ROM_REV_REV]);
+
+	PRINT_PROC("BTO Server: %d.%d.%d.%d", nvram[COBT_CMOS_BTO_IP_0],
+		nvram[COBT_CMOS_BTO_IP_1], nvram[COBT_CMOS_BTO_IP_2],
+		nvram[COBT_CMOS_BTO_IP_3]);
+	bto_csum = nvram[COBT_CMOS_BTO_IP_0] + nvram[COBT_CMOS_BTO_IP_1]
+		+ nvram[COBT_CMOS_BTO_IP_2] + nvram[COBT_CMOS_BTO_IP_3];
+	if (bto_csum != nvram[COBT_CMOS_BTO_IP_CSUM]) {
+		PRINT_PROC(" (invalid checksum)");
+	}
+	PRINT_PROC("\n");
+
+	if (flags & COBT_CMOS_VERSION_FLAG
+	 && nvram[COBT_CMOS_VERSION] >= COBT_CMOS_VER_BTOCODE) {
+		PRINT_PROC("BTO Code: 0x%x\n",
+			nvram[COBT_CMOS_BTO_CODE_0] << 24 |
+			nvram[COBT_CMOS_BTO_CODE_1] << 16 |
+			nvram[COBT_CMOS_BTO_CODE_2] << 8 |
+			nvram[COBT_CMOS_BTO_CODE_3]);
+	}
+
+	return 1;
+}
+#endif /* CONFIG_PROC_FS */
+
+#endif /* MACH == COBALT */
+
 #if MACH == ATARI
 
 static int
@@ -585,9 +781,9 @@
 	unsigned char sum = 0;
 
 	for (i = ATARI_CKS_RANGE_START; i <= ATARI_CKS_RANGE_END; ++i)
-		sum += nvram_read_int(i);
-	return (nvram_read_int(ATARI_CKS_LOC) == (~sum & 0xff) &&
-	    nvram_read_int(ATARI_CKS_LOC + 1) == (sum & 0xff));
+		sum += __nvram_read_byte(i);
+	return (__nvram_read_byte(ATARI_CKS_LOC) == (~sum & 0xff) &&
+	    __nvram_read_byte(ATARI_CKS_LOC + 1) == (sum & 0xff));
 }
 
 static void
@@ -597,9 +793,9 @@
 	unsigned char sum = 0;
 
 	for (i = ATARI_CKS_RANGE_START; i <= ATARI_CKS_RANGE_END; ++i)
-		sum += nvram_read_int(i);
-	nvram_write_int(~sum, ATARI_CKS_LOC);
-	nvram_write_int(sum, ATARI_CKS_LOC + 1);
+		sum += __nvram_read_byte(i);
+	__nvram_write_byte(~sum, ATARI_CKS_LOC);
+	__nvram_write_byte(sum, ATARI_CKS_LOC + 1);
 }
 
 #ifdef CONFIG_PROC_FS
@@ -716,4 +912,11 @@
 
 MODULE_LICENSE("GPL");
 
-EXPORT_NO_SYMBOLS;
+EXPORT_SYMBOL(__nvram_read_byte);
+EXPORT_SYMBOL(nvram_read_byte);
+EXPORT_SYMBOL(__nvram_write_byte);
+EXPORT_SYMBOL(nvram_write_byte);
+EXPORT_SYMBOL(__nvram_check_checksum);
+EXPORT_SYMBOL(nvram_check_checksum);
+EXPORT_SYMBOL(__nvram_set_checksum);
+EXPORT_SYMBOL(nvram_set_checksum);
diff -Nru a/include/linux/cobalt-nvram.h b/include/linux/cobalt-nvram.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/linux/cobalt-nvram.h	Mon Aug  5 18:55:26 2002
@@ -0,0 +1,109 @@
+/*
+ * $Id: cobalt-nvram.h,v 1.20 2001/10/17 23:16:55 thockin Exp $
+ * cobalt-nvram.h : defines for the various fields in the cobalt NVRAM
+ *
+ * Copyright 2001,2002 Sun Microsystems, Inc.
+ */
+
+#ifndef COBALT_NVRAM_H
+#define COBALT_NVRAM_H
+
+#include <linux/nvram.h>
+
+#define COBT_CMOS_INFO_MAX		0x7f	/* top address allowed */
+#define COBT_CMOS_BIOS_DRIVE_INFO	0x12	/* drive info would go here */
+
+#define COBT_CMOS_CKS_START		NVRAM_OFFSET(0x0e)
+#define COBT_CMOS_CKS_END		NVRAM_OFFSET(0x7f)
+
+/* flag bytes - 16 flags for now, leave room for more */
+#define COBT_CMOS_FLAG_BYTE_0		NVRAM_OFFSET(0x10)
+#define COBT_CMOS_FLAG_BYTE_1		NVRAM_OFFSET(0x11)
+
+/* flags in flag bytes - up to 16 */
+#define COBT_CMOS_FLAG_MIN		0x0001
+#define COBT_CMOS_CONSOLE_FLAG		0x0001 /* console on/off */
+#define COBT_CMOS_DEBUG_FLAG		0x0002 /* ROM debug messages */
+#define COBT_CMOS_AUTO_PROMPT_FLAG	0x0004 /* boot to ROM prompt? */
+#define COBT_CMOS_CLEAN_BOOT_FLAG	0x0008 /* set by a clean shutdown */
+#define COBT_CMOS_HW_NOPROBE_FLAG	0x0010 /* go easy on the probing */
+#define COBT_CMOS_SYSFAULT_FLAG		0x0020 /* system fault detected */
+#define COBT_CMOS_OOPSPANIC_FLAG	0x0040 /* panic on oops */
+#define COBT_CMOS_DELAY_CACHE_FLAG	0x0080 /* delay cache initialization */
+#define COBT_CMOS_NOLOGO_FLAG		0x0100 /* hide "C" logo @ boot */
+#define COBT_CMOS_VERSION_FLAG		0x0200 /* the version field is valid */
+#define COBT_CMOS_FLAG_MAX		0x0200
+
+/* leave byte 0x12 blank - Linux looks for drive info here */
+
+/* CMOS structure version, valid if COBT_CMOS_VERSION_FLAG is true */
+#define COBT_CMOS_VERSION		NVRAM_OFFSET(0x13)
+#define COBT_CMOS_VER_BTOCODE		1 /* min. version needed for btocode */
+
+/* index of default boot method */
+#define COBT_CMOS_BOOT_METHOD		NVRAM_OFFSET(0x20)
+#define COBT_CMOS_BOOT_METHOD_DISK	0
+#define COBT_CMOS_BOOT_METHOD_ROM	1
+#define COBT_CMOS_BOOT_METHOD_NET	2
+
+#define COBT_CMOS_BOOT_DEV_MIN		NVRAM_OFFSET(0x21)
+/* major #, minor # of first through fourth boot device */
+#define COBT_CMOS_BOOT_DEV0_MAJ		NVRAM_OFFSET(0x21)
+#define COBT_CMOS_BOOT_DEV0_MIN		NVRAM_OFFSET(0x22)
+#define COBT_CMOS_BOOT_DEV1_MAJ		NVRAM_OFFSET(0x23)
+#define COBT_CMOS_BOOT_DEV1_MIN		NVRAM_OFFSET(0x24)
+#define COBT_CMOS_BOOT_DEV2_MAJ		NVRAM_OFFSET(0x25)
+#define COBT_CMOS_BOOT_DEV2_MIN		NVRAM_OFFSET(0x26)
+#define COBT_CMOS_BOOT_DEV3_MAJ		NVRAM_OFFSET(0x27)
+#define COBT_CMOS_BOOT_DEV3_MIN		NVRAM_OFFSET(0x28)
+#define COBT_CMOS_BOOT_DEV_MAX		NVRAM_OFFSET(0x28)
+
+/* checksum of bytes 0xe-0x7f */
+#define COBT_CMOS_CHECKSUM		NVRAM_OFFSET(0x2e)
+
+/* running uptime counter, units of 5 minutes (32 bits =~ 41000 years) */
+#define COBT_CMOS_UPTIME_0		NVRAM_OFFSET(0x30)
+#define COBT_CMOS_UPTIME_1		NVRAM_OFFSET(0x31)
+#define COBT_CMOS_UPTIME_2		NVRAM_OFFSET(0x32)
+#define COBT_CMOS_UPTIME_3		NVRAM_OFFSET(0x33)
+
+/* count of successful boots (32 bits) */
+#define COBT_CMOS_BOOTCOUNT_0		NVRAM_OFFSET(0x38)
+#define COBT_CMOS_BOOTCOUNT_1		NVRAM_OFFSET(0x39)
+#define COBT_CMOS_BOOTCOUNT_2		NVRAM_OFFSET(0x3a)
+#define COBT_CMOS_BOOTCOUNT_3		NVRAM_OFFSET(0x3b)
+
+/* 13 bytes: system serial number, same as on the back of the system */
+#define COBT_CMOS_SYS_SERNUM_LEN	13
+#define COBT_CMOS_SYS_SERNUM_0		NVRAM_OFFSET(0x40)
+#define COBT_CMOS_SYS_SERNUM_1		NVRAM_OFFSET(0x41)
+#define COBT_CMOS_SYS_SERNUM_2		NVRAM_OFFSET(0x42)
+#define COBT_CMOS_SYS_SERNUM_3		NVRAM_OFFSET(0x43)
+#define COBT_CMOS_SYS_SERNUM_4		NVRAM_OFFSET(0x44)
+#define COBT_CMOS_SYS_SERNUM_5		NVRAM_OFFSET(0x45)
+#define COBT_CMOS_SYS_SERNUM_6		NVRAM_OFFSET(0x46)
+#define COBT_CMOS_SYS_SERNUM_7		NVRAM_OFFSET(0x47)
+#define COBT_CMOS_SYS_SERNUM_8		NVRAM_OFFSET(0x48)
+#define COBT_CMOS_SYS_SERNUM_9		NVRAM_OFFSET(0x49)
+#define COBT_CMOS_SYS_SERNUM_10		NVRAM_OFFSET(0x4a)
+#define COBT_CMOS_SYS_SERNUM_11		NVRAM_OFFSET(0x4b)
+#define COBT_CMOS_SYS_SERNUM_12		NVRAM_OFFSET(0x4c)
+/* checksum for serial num - 1 byte */
+#define COBT_CMOS_SYS_SERNUM_CSUM	NVRAM_OFFSET(0x4f)
+
+#define COBT_CMOS_ROM_REV_MAJ		NVRAM_OFFSET(0x50)
+#define COBT_CMOS_ROM_REV_MIN		NVRAM_OFFSET(0x51)
+#define COBT_CMOS_ROM_REV_REV		NVRAM_OFFSET(0x52)
+
+#define COBT_CMOS_BTO_CODE_0		NVRAM_OFFSET(0x53)
+#define COBT_CMOS_BTO_CODE_1		NVRAM_OFFSET(0x54)
+#define COBT_CMOS_BTO_CODE_2		NVRAM_OFFSET(0x55)
+#define COBT_CMOS_BTO_CODE_3		NVRAM_OFFSET(0x56)
+
+#define COBT_CMOS_BTO_IP_CSUM		NVRAM_OFFSET(0x57)
+#define COBT_CMOS_BTO_IP_0		NVRAM_OFFSET(0x58)
+#define COBT_CMOS_BTO_IP_1		NVRAM_OFFSET(0x59)
+#define COBT_CMOS_BTO_IP_2		NVRAM_OFFSET(0x5a)
+#define COBT_CMOS_BTO_IP_3		NVRAM_OFFSET(0x5b)
+
+#endif /* COBALT_NVRAM_H */
diff -Nru a/include/linux/nvram.h b/include/linux/nvram.h
--- a/include/linux/nvram.h	Mon Aug  5 18:55:26 2002
+++ b/include/linux/nvram.h	Mon Aug  5 18:55:26 2002
@@ -4,14 +4,24 @@
 #include <linux/ioctl.h>
 
 /* /dev/nvram ioctls */
-#define NVRAM_INIT		_IO('p', 0x40) /* initialize NVRAM and set checksum */
-#define	NVRAM_SETCKS	_IO('p', 0x41) /* recalculate checksum */
+#define NVRAM_INIT	_IO('p', 0x40) /* initialize NVRAM and set checksum */
+#define NVRAM_SETCKS	_IO('p', 0x41) /* recalculate checksum */
+
+/* for all current systems, this is where NVRAM starts */
+#define NVRAM_FIRST_BYTE    14
+/* all these functions expect an NVRAM offset, not an absolute */
+#define NVRAM_OFFSET(x)   ((x)-NVRAM_FIRST_BYTE)
 
 #ifdef __KERNEL__
-extern unsigned char nvram_read_byte( int i );
-extern void nvram_write_byte( unsigned char c, int i );
-extern int nvram_check_checksum( void );
-extern void nvram_set_checksum( void );
+/* __foo is foo without grabbing the rtc_lock - get it yourself */
+extern unsigned char __nvram_read_byte(int i);
+extern unsigned char nvram_read_byte(int i);
+extern void __nvram_write_byte(unsigned char c, int i);
+extern void nvram_write_byte(unsigned char c, int i);
+extern int __nvram_check_checksum(void);
+extern int nvram_check_checksum(void);
+extern void __nvram_set_checksum(void);
+extern void nvram_set_checksum(void);
 #endif
 
 #endif  /* _LINUX_NVRAM_H */

--------------060701010208090907080103--

