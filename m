Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279202AbRJWCOO>; Mon, 22 Oct 2001 22:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279201AbRJWCN4>; Mon, 22 Oct 2001 22:13:56 -0400
Received: from mercury.Sun.COM ([192.9.25.1]:59633 "EHLO mercury.Sun.COM")
	by vger.kernel.org with ESMTP id <S279198AbRJWCNj>;
	Mon, 22 Oct 2001 22:13:39 -0400
Message-ID: <3BD4D184.2F8D827D@sun.com>
Date: Mon, 22 Oct 2001 19:10:12 -0700
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, alan@redhat.com,
        torvalds@transmeta.com, jgarzik@mandrakesoft.com
Subject: [PATCH] try #2 for nvram patch + new maintainer?
Content-Type: multipart/mixed;
 boundary="------------26DC27204DAD53F55AD7385E"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------26DC27204DAD53F55AD7385E
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

OK,  So I came to the realization that some of the things we had added to
the nvram driver we were no longer using.  So I ripped them out.  If we
need them later, we can deal with it :)

Attached you will find the first patch to the nvram driver:

* Configure correction
* Minor cleanups of global state
* Add Cobalt Networks CMOS data support
* Export some additional functions

I have another patch which is just formatting (so all tabstops work
properly!).  I'll send that later.

Please apply this for the next 2.4.x.  It appears there is no maintainer
for this driver.  If so, I'd like to take it over.  We're using it, so
someone here may as well maintain it.

Tim
-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
--------------26DC27204DAD53F55AD7385E
Content-Type: text/plain; charset=us-ascii;
 name="nvram.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nvram.diff"

diff -ruN dist-2.4.12+patches/Documentation/Configure.help cvs-2.4.12+patches/Documentation/Configure.help
--- dist-2.4.12+patches/Documentation/Configure.help	Mon Oct 15 10:20:16 2001
+++ cvs-2.4.12+patches/Documentation/Configure.help	Mon Oct 15 10:34:55 2001
@@ -14952,9 +15177,10 @@
 CONFIG_NVRAM
   If you say Y here and create a character special file /dev/nvram
   with major number 10 and minor number 144 using mknod ("man mknod"),
-  you get read and write access to the 50 bytes of non-volatile memory
+  you get read and write access to the extra bytes of non-volatile memory
   in the real time clock (RTC), which is contained in every PC and
-  most Ataris. 
+  most Ataris.  The actual number of bytes varies, depending on the 
+  nvram in the system, but is usually 114.  
 
   This memory is conventionally called "CMOS RAM" on PCs and "NVRAM"
   on Ataris. /dev/nvram may be used to view settings there, or to
diff -ruN dist-2.4.12+patches/drivers/char/nvram.c cvs-2.4.12+patches/drivers/char/nvram.c
--- dist-2.4.12+patches/drivers/char/nvram.c	Mon Oct 15 10:21:41 2001
+++ cvs-2.4.12+patches/drivers/char/nvram.c	Mon Oct 15 10:21:41 2001
@@ -10,8 +10,9 @@
  * "NVRAM" (NV stands for non-volatile).
  *
  * The data are supplied as a (seekable) character device, /dev/nvram. The
- * size of this file is 50, the number of freely available bytes in the memory
- * (i.e., not used by the RTC itself).
+ * size of this file is dependant on the controller.  The usual size is 50, 
+ * the number of freely available bytes in the memory (i.e., not used by the 
+ * RTC itself).
  * 
  * Checksums over the NVRAM contents are managed by this driver. In case of a
  * bad checksum, reads and writes return -EIO. The checksum can be initialized
@@ -26,38 +27,48 @@
  * drivers, this is the case on the Atari.
  *
  *
- * 	1.1	Cesar Barros: SMP locking fixes
- * 		added changelog
+ *      1.1     Cesar Barros: SMP locking fixes
+ *              added changelog
+ *      1.2     Erik Gilling: Cobalt Networks support
+ *              Tim Hockin: general cleanup, Cobalt support
  */
 
-#define NVRAM_VERSION		"1.1"
+#define NVRAM_VERSION            "1.2"
 
 #include <linux/module.h>
 #include <linux/config.h>
 #include <linux/sched.h>
 #include <linux/smp_lock.h>
+#include <linux/nvram.h>
 
-#define PC		1
-#define ATARI	2
+#define PC                       1
+#define ATARI                    2
+#define COBALT                   3
 
 /* select machine configuration */
 #if defined(CONFIG_ATARI)
-#define MACH ATARI
+#  define MACH ATARI
 #elif defined(__i386__) || defined(__x86_64__) || defined(__arm__) /* and others?? */
-#define MACH PC
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
 
 /* RTC in a PC */
-#define CHECK_DRIVER_INIT() 1
+#define CHECK_DRIVER_INIT()     1
 
 /* On PCs, the checksum is built only over bytes 2..31 */
 #define PC_CKS_RANGE_START	2
 #define PC_CKS_RANGE_END	31
 #define PC_CKS_LOC			32
+#define NVRAM_BYTES             (128-NVRAM_FIRST_BYTE)
 
 #define	mach_check_checksum	pc_check_checksum
 #define	mach_set_checksum	pc_set_checksum
@@ -65,6 +76,17 @@
 
 #endif
 
+#if MACH == COBALT
+#define CHECK_DRIVER_INIT()     1
+
+#define NVRAM_BYTES             (128-NVRAM_FIRST_BYTE)
+
+#define mach_check_checksum     cobalt_check_checksum
+#define mach_set_checksum       cobalt_set_checksum
+#define mach_proc_infos         cobalt_proc_infos
+
+#endif
+
 #if MACH == ATARI
 
 /* Special parameters for RTC in Atari machines */
@@ -78,10 +100,11 @@
 #define ATARI_CKS_RANGE_START	0
 #define ATARI_CKS_RANGE_END		47
 #define ATARI_CKS_LOC			48
+#define NVRAM_BYTES             50 /* number of NVRAM bytes */
 
 #define	mach_check_checksum	atari_check_checksum
 #define	mach_set_checksum	atari_set_checksum
-#define	mach_proc_infos		atari_proc_infos
+#define	mach_proc_infos	atari_proc_infos
 
 #endif
 
@@ -98,7 +121,6 @@
 #include <linux/ioport.h>
 #include <linux/fcntl.h>
 #include <linux/mc146818rtc.h>
-#include <linux/nvram.h>
 #include <linux/init.h>
 #include <linux/proc_fs.h>
 #include <linux/spinlock.h>
@@ -107,13 +129,11 @@
 #include <asm/uaccess.h>
 #include <asm/system.h>
 
-static int nvram_open_cnt;	/* #times opened */
-static int nvram_open_mode;		/* special open modes */
-#define	NVRAM_WRITE		1		/* opened for writing (exclusive) */
-#define	NVRAM_EXCL		2		/* opened with O_EXCL */
-
-#define	RTC_FIRST_BYTE		14	/* RTC register number of first NVRAM byte */
-#define	NVRAM_BYTES			128-RTC_FIRST_BYTE	/* number of NVRAM bytes */
+static spinlock_t nvram_state_lock = SPIN_LOCK_UNLOCKED;
+static int nvram_open_cnt;        /* #times opened */
+static int nvram_open_mode;       /* special open modes */
+#define NVRAM_WRITE             1 /* opened for writing (exclusive) */
+#define NVRAM_EXCL              2 /* opened with O_EXCL */
 
 
 static int mach_check_checksum( void );
@@ -132,12 +152,12 @@
 
 static __inline__ unsigned char nvram_read_int( int i )
 {
-	return( CMOS_READ( RTC_FIRST_BYTE+i ) );
+	return( CMOS_READ( NVRAM_FIRST_BYTE+i ) );
 }
 
 static __inline__ void nvram_write_int( unsigned char c, int i )
 {
-	CMOS_WRITE( c, RTC_FIRST_BYTE+i );
+	CMOS_WRITE( c, NVRAM_FIRST_BYTE+i );
 }
 
 static __inline__ int nvram_check_checksum_int( void )
@@ -150,8 +170,7 @@
 	mach_set_checksum();
 }
 
-#if MACH == ATARI
-
+#if (MACH == ATARI) || (MACH == COBALT)
 /*
  * These non-internal functions are provided to be called by other parts of
  * the kernel. It's up to the caller to ensure correct checksum before reading
@@ -161,50 +180,72 @@
  * them. For other configurations (PC), the rest of the kernel can't rely on
  * them being present (this driver may not be configured at all, or as a
  * module), so they access config information themselves.
+ *
+ * Cobalt hardware needs them too
+ *
+ * It is worth noting that these functions all access bytes of general purpose
+ * memory in the NVRAM - that is to say, they all add the NVRAM_FIRST_BYTE
+ * offset.
  */
 
-unsigned char nvram_read_byte( int i )
+unsigned char __nvram_read_byte(int i)
+{
+	return nvram_read_int(i);
+}
+unsigned char nvram_read_byte(int i)
 {
 	unsigned long flags;
 	unsigned char c;
 
-	spin_lock_irqsave (&rtc_lock, flags);
-	c = nvram_read_int( i );
-	spin_unlock_irqrestore (&rtc_lock, flags);
-	return( c );
+	spin_lock_irqsave(&rtc_lock, flags);
+	c = __nvram_read_byte(i);
+	spin_unlock_irqrestore(&rtc_lock, flags);
+	return(c);
 }
 
 /* This races nicely with trying to read with checksum checking (nvram_read) */
-void nvram_write_byte( unsigned char c, int i )
+void __nvram_write_byte(unsigned char c, int i)
+{
+	nvram_write_int(c, i);
+}
+void nvram_write_byte(unsigned char c, int i)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave (&rtc_lock, flags);
-	nvram_write_int( c, i );
-	spin_unlock_irqrestore (&rtc_lock, flags);
+	spin_lock_irqsave(&rtc_lock, flags);
+	__nvram_write_byte(c, i);
+	spin_unlock_irqrestore(&rtc_lock, flags);
 }
 
-int nvram_check_checksum( void )
+int __nvram_check_checksum(void)
+{
+	return nvram_check_checksum_int();
+}
+int nvram_check_checksum(void)
 {
 	unsigned long flags;
 	int rv;
 
-	spin_lock_irqsave (&rtc_lock, flags);
-	rv = nvram_check_checksum_int();
-	spin_unlock_irqrestore (&rtc_lock, flags);
-	return( rv );
+	spin_lock_irqsave(&rtc_lock, flags);
+	rv = __nvram_check_checksum();
+	spin_unlock_irqrestore(&rtc_lock, flags);
+	return rv;
 }
 
-void nvram_set_checksum( void )
+void __nvram_set_checksum(void)
+{
+	nvram_set_checksum_int();
+}
+void nvram_set_checksum(void)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave (&rtc_lock, flags);
-	nvram_set_checksum_int();
-	spin_unlock_irqrestore (&rtc_lock, flags);
+	spin_lock_irqsave(&rtc_lock, flags);
+	__nvram_set_checksum();
+	spin_unlock_irqrestore(&rtc_lock, flags);
 }
 
-#endif /* MACH == ATARI */
+#endif /* MACH == ATARI || MACH == COBALT */
 
 
 /*
@@ -215,7 +256,7 @@
 {
 	switch( origin ) {
 	  case 0:
-		/* nothing to do */
+		/* nothing to do : offset = offset */
 		break;
 	  case 1:
 		offset += file->f_pos;
@@ -230,9 +271,9 @@
 static ssize_t nvram_read(struct file * file,
 	char * buf, size_t count, loff_t *ppos )
 {
-	char contents [NVRAM_BYTES];
+	unsigned char contents [NVRAM_BYTES];
 	unsigned i = *ppos;
-	char *tmp;
+	unsigned char *tmp;
 
 	spin_lock_irq (&rtc_lock);
 	
@@ -259,12 +300,13 @@
 static ssize_t nvram_write(struct file * file,
 		const char * buf, size_t count, loff_t *ppos )
 {
-	char contents [NVRAM_BYTES];
+	unsigned char contents [NVRAM_BYTES];
 	unsigned i = *ppos;
-	char * tmp;
+	unsigned char *tmp;
+	int len;
 
-	if (copy_from_user (contents, buf, (NVRAM_BYTES - i) < count ?
-						(NVRAM_BYTES - i) : count))
+	len = (NVRAM_BYTES - i) < count ? (NVRAM_BYTES - i) : count;
+	if (copy_from_user (contents, buf, len))
 		return -EFAULT;
 
 	spin_lock_irq (&rtc_lock);
@@ -326,30 +368,42 @@
 
 static int nvram_open( struct inode *inode, struct file *file )
 {
+	spin_lock(&nvram_state_lock);
+
 	if ((nvram_open_cnt && (file->f_flags & O_EXCL)) ||
 		(nvram_open_mode & NVRAM_EXCL) ||
-		((file->f_mode & 2) && (nvram_open_mode & NVRAM_WRITE)))
+		((file->f_mode & 2) && (nvram_open_mode & NVRAM_WRITE))) {
+		spin_unlock(&nvram_state_lock);
 		return( -EBUSY );
+	}
 
 	if (file->f_flags & O_EXCL)
 		nvram_open_mode |= NVRAM_EXCL;
 	if (file->f_mode & 2)
 		nvram_open_mode |= NVRAM_WRITE;
+
 	nvram_open_cnt++;
+
+	spin_unlock(&nvram_state_lock);
+
 	return( 0 );
 }
 
 static int nvram_release( struct inode *inode, struct file *file )
 {
-	lock_kernel();
+	spin_lock(&nvram_state_lock);
+
 	nvram_open_cnt--;
-	if (file->f_flags & O_EXCL)
+
+	/* only one instance is open, clear the EXCL bit */
+	if (nvram_open_mode & NVRAM_EXCL)
 		nvram_open_mode &= ~NVRAM_EXCL;
 	if (file->f_mode & 2)
 		nvram_open_mode &= ~NVRAM_WRITE;
-	unlock_kernel();
 
-	return( 0 );
+	spin_unlock(&nvram_state_lock);
+
+	return 0;
 }
 
 
@@ -376,7 +430,6 @@
 		return( 0 );
     *start = buffer + (offset - begin);
     return( size < begin + len - offset ? size : begin + len - offset );
-	
 }
 
 /* This macro frees the machine specific function from bounds checking and
@@ -559,6 +612,176 @@
 #endif
 
 #endif /* MACH == PC */
+
+#if MACH == COBALT
+
+/* the cobalt CMOS has a wider range of it's checksum */
+static int cobalt_check_checksum(void)
+{
+	int i;
+	unsigned short sum = 0;
+
+	for (i = COBT_CMOS_CKS_START; i <= COBT_CMOS_CKS_END; ++i) {
+		if ((i == COBT_CMOS_CHECKSUM) || (i == (COBT_CMOS_CHECKSUM+1)))
+			continue;
+
+		sum += nvram_read_int(i);
+	}
+	return ((sum & 0xffff) == ((nvram_read_int(COBT_CMOS_CHECKSUM) << 8) |
+		nvram_read_int(COBT_CMOS_CHECKSUM+1)));
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
+		sum += nvram_read_int(i);
+	}
+
+	nvram_write_int(sum >> 8, COBT_CMOS_CHECKSUM);
+	nvram_write_int(sum & 0xff, COBT_CMOS_CHECKSUM+1);
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
+	checksum = nvram_check_checksum_int();
+	spin_unlock_irq(&rtc_lock);
+
+	PRINT_PROC("Checksum status: %svalid\n", checksum ? "" : "not ");
+
+	flags = nvram[COBT_CMOS_FLAG_BYTE_0] << 8 | nvram[COBT_CMOS_FLAG_BYTE_1];
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
+ 	}
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
+	PRINT_PROC("HA Mode: %d\n", nvram[COBT_CMOS_HA_MODE]);
+
+	return 1;
+}
+#endif /* CONFIG_PROC_FS */
+
+#endif /* MACH == COBALT */
 
 #if MACH == ATARI
 
diff -ruN dist-2.4.12+patches/include/linux/cobalt-nvram.h cvs-2.4.12+patches/include/linux/cobalt-nvram.h
--- dist-2.4.12+patches/include/linux/cobalt-nvram.h	Wed Dec 31 16:00:00 1969
+++ cvs-2.4.12+patches/include/linux/cobalt-nvram.h	Mon Oct 15 10:23:41 2001
@@ -0,0 +1,112 @@
+/*
+ * $Id: cobalt-nvram.h,v 1.20 2001/10/17 23:16:55 thockin Exp $
+ * cobalt-nvram.h : defines for the various fields in the cobalt NVRAM
+ *
+ * Copyright 2001 Sun Microsystems, Inc.
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
+/* HA mode we're in (Twin Peaks) */
+#define COBT_CMOS_HA_MODE		NVRAM_OFFSET(0x62)
+
+#endif /* COBALT_NVRAM_H */
diff -ruN dist-2.4.12+patches/include/linux/nvram.h cvs-2.4.12+patches/include/linux/nvram.h
--- dist-2.4.12+patches/include/linux/nvram.h	Mon Oct 15 10:23:43 2001
+++ cvs-2.4.12+patches/include/linux/nvram.h	Mon Oct 15 10:23:43 2001
@@ -4,14 +4,26 @@
 #include <linux/ioctl.h>
 
 /* /dev/nvram ioctls */
-#define NVRAM_INIT		_IO('p', 0x40) /* initialize NVRAM and set checksum */
-#define	NVRAM_SETCKS	_IO('p', 0x41) /* recalculate checksum */
+#define NVRAM_INIT        _IO('p', 0x40) /* initialize NVRAM and set checksum */
+#define NVRAM_SETCKS      _IO('p', 0x41) /* recalculate checksum */
+
+
+/* for all current systems, this is where NVRAM starts */
+#define NVRAM_FIRST_BYTE    14
+
+/* all these functions expect an NVRAM offset, not an absolute */
+#define NVRAM_OFFSET(x)   ((x)-NVRAM_FIRST_BYTE)
 
 #ifdef __KERNEL__
-extern unsigned char nvram_read_byte( int i );
-extern void nvram_write_byte( unsigned char c, int i );
-extern int nvram_check_checksum( void );
-extern void nvram_set_checksum( void );
+/* __foo is foo without grabbing the rtc_lock - get it yourself */
+extern unsigned char nvram_read_byte(int i);
+extern unsigned char __nvram_read_byte(int i);
+extern void nvram_write_byte(unsigned char c, int i);
+extern void __nvram_write_byte(unsigned char c, int i);
+extern int nvram_check_checksum(void);
+extern int __nvram_check_checksum(void);
+extern void nvram_set_checksum(void);
+extern void __nvram_set_checksum(void);
 #endif
 
 #endif  /* _LINUX_NVRAM_H */

--------------26DC27204DAD53F55AD7385E--

