Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278247AbRJSBRb>; Thu, 18 Oct 2001 21:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278261AbRJSBRP>; Thu, 18 Oct 2001 21:17:15 -0400
Received: from patan.Sun.COM ([192.18.98.43]:4036 "EHLO patan.sun.com")
	by vger.kernel.org with ESMTP id <S278263AbRJSBQv>;
	Thu, 18 Oct 2001 21:16:51 -0400
Message-ID: <3BCF7E51.BC051C31@sun.com>
Date: Thu, 18 Oct 2001 18:13:53 -0700
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jgarzik@mandrakesoft.com, alan@redhat.com, torvalds@transmeta.com
Subject: [PATCH]  biggish NVRAM driver patch
Content-Type: multipart/mixed;
 boundary="------------3723CCBD41800E0C29912817"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------3723CCBD41800E0C29912817
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

All,

Attached is a largish patch to nvram.c for various things.  We've been
using this for some time, and I have submitted it a few times before.  Last
time it was OK'ed, but never turned up in a release.


* Paging - support paged NVRAMs
* Formatting - nice on all tabstops
* Cobalt support - have the ability to dump cobalt information
* Natsemi superio paging support

Please apply for the next 2.4.x, or let me know if anything is wrong with
the patch.

Thanks!
p.s. - is there a maintainer for the NVRAM driver?  If not I volunteer to
take it over.

Tim

-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
--------------3723CCBD41800E0C29912817
Content-Type: text/plain; charset=us-ascii;
 name="nvram.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nvram.diff"

diff -ruN dist-2.4.12+patches/Documentation/Configure.help cvs-2.4.12+patches/Documentation/Configure.help
--- dist-2.4.12+patches/Documentation/Configure.help	Mon Oct 15 10:20:16 2001
+++ cvs-2.4.12+patches/Documentation/Configure.help	Mon Oct 15 10:34:55 2001
@@ -15038,9 +15177,11 @@
 CONFIG_NVRAM
   If you say Y here and create a character special file /dev/nvram
   with major number 10 and minor number 144 using mknod ("man mknod"),
-  you get read and write access to the 50 bytes of non-volatile memory
+  you get read and write access to the extra bytes of non-volatile memory
   in the real time clock (RTC), which is contained in every PC and
-  most Ataris. 
+  most Ataris.  The actual number of bytes varies, depending on the 
+  nvram in the system, but is usually 50.  In addition, multiple banks or
+  'pages' of nvram may be available.
 
   This memory is conventionally called "CMOS RAM" on PCs and "NVRAM"
   on Ataris. /dev/nvram may be used to view settings there, or to
@@ -15058,6 +15199,15 @@
   inserted in and removed from the running kernel whenever you want).
   The module will be called nvram.o. If you want to compile it as a
   module, say M here and read Documentation/modules.txt.
+
+NatSemi PC[89]7317 paged NVRAM support
+CONFIG_NVRAM_NATSEMI_PC87317
+  If you have a National Semiconductor PC87317 or PC97317 Superio chip,
+  you may want to say Y here.  This provides access to NVRAM pages other
+  than the default.  Some systems, like some Cobalt Networks servers, use 
+  these other pages.
+
+  If in doubt, say N here.
 
 Joystick support
 CONFIG_JOYSTICK
diff -ruN dist-2.4.12+patches/drivers/char/Config.in cvs-2.4.12+patches/drivers/char/Config.in
--- dist-2.4.12+patches/drivers/char/Config.in	Mon Oct 15 10:21:38 2001
+++ cvs-2.4.12+patches/drivers/char/Config.in	Mon Oct 15 10:21:38 2001
@@ -182,6 +182,9 @@
 
 dep_tristate 'Intel i8x0 Random Number Generator support' CONFIG_INTEL_RNG $CONFIG_PCI
 tristate '/dev/nvram support' CONFIG_NVRAM
+if [ "$CONFIG_NVRAM" = "y" -o "$CONFIG_NVRAM" = "m" ]; then
+   bool '  NatSemi PC[89]7317 paged NVRAM support' CONFIG_NVRAM_NATSEMI_PC87317
+fi
 tristate 'Enhanced Real Time Clock Support' CONFIG_RTC
 if [ "$CONFIG_IA64" = "y" ]; then
    bool 'EFI Real Time Clock Services' CONFIG_EFI_RTC
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
@@ -25,43 +26,91 @@
  * the kernel and is not a module. Since the functions are used by some Atari
  * drivers, this is the case on the Atari.
  *
+ * For some systems, the NVRAM has multiple pages.  To facilitate this, this 
+ * device also supports get/set page ioctl()s.  In addition to the standard 
+ * hardware pages, this driver supports a "magic" page.  Many systems have 
+ * NVRAM or non-volatile bits that don't live in the standard places.  The 
+ * magic page (NVRAM_MAGIC_PAGE) provides a way for these systems to export 
+ * this data.
  *
- * 	1.1	Cesar Barros: SMP locking fixes
- * 		added changelog
+ * This file also provides some knowledge of the National Semiconductor
+ * PC[89]7317 Superio chips' RTC/NVRAM.  These are particularly intersting.
+ * The low 64 bytes are mapped into each of three pages.  The high 64 bytes of
+ * each page are different.  There is also a mechanism (ignored here) to
+ * address another 128 bytes of NVRAM.  The first page's high 64 bytes are
+ * general purpose.  The second page is reserved for RTC activity.  The third
+ * page is for the Advanced Power Controller.  We've exported some of that
+ * interface here.  
+ *   -- Erik Gilling <erik.gilling@sun.com>, Tim Hockin <thockin@sun.com>
+ *
+ *      1.2     Erik Gilling: Cobalt Networks support
+ *              Tim Hockin: general cleanup, generic magic page
+ *              Adrian Sun: NatSemi APC code
+ *      1.1     Cesar Barros: SMP locking fixes
+ *              added changelog
  */
 
-#define NVRAM_VERSION		"1.1"
+#define NVRAM_VERSION            "1.2"
 
 #include <linux/module.h>
 #include <linux/config.h>
 #include <linux/sched.h>
 #include <linux/smp_lock.h>
 
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
-#define PC_CKS_RANGE_START	2
-#define PC_CKS_RANGE_END	31
-#define PC_CKS_LOC			32
-
-#define	mach_check_checksum	pc_check_checksum
-#define	mach_set_checksum	pc_set_checksum
-#define	mach_proc_infos		pc_proc_infos
+#define PC_CKS_RANGE_START      2
+#define PC_CKS_RANGE_END        31
+#define PC_CKS_LOC              32
+#define NVRAM_BYTES             (128-NVRAM_FIRST_BYTE)
+#define NVRAM_PAGES             1 /* pages, !including magic */
+
+#define mach_check_checksum     pc_check_checksum
+#define mach_set_checksum       pc_set_checksum
+#define mach_proc_infos         pc_proc_infos
+#define mach_magic_read         pc_magic_read
+#define mach_magic_write        pc_magic_write
+
+#endif
+
+#if MACH == COBALT
+/* RTC in a Cobalt Networks system */
+#define CHECK_DRIVER_INIT()     1
+
+#define NVRAM_BYTES             (128-NVRAM_FIRST_BYTE)
+#if defined(CONFIG_NVRAM_NATSEMI_PC87317) && defined(CONFIG_COBALT_GEN_V)
+#define NVRAM_PAGES             3
+#else
+#define NVRAM_PAGES             1
+#endif
+
+#define mach_check_checksum     cobalt_check_checksum
+#define mach_set_checksum       cobalt_set_checksum
+#define mach_proc_infos         cobalt_proc_infos
+#define mach_magic_read         cobalt_magic_read
+#define mach_magic_write        cobalt_magic_write
 
 #endif
 
@@ -70,18 +119,22 @@
 /* Special parameters for RTC in Atari machines */
 #include <asm/atarihw.h>
 #include <asm/atariints.h>
-#define RTC_PORT(x)			(TT_RTC_BAS + 2*(x))
-#define CHECK_DRIVER_INIT() (MACH_IS_ATARI && ATARIHW_PRESENT(TT_CLK))
+#define RTC_PORT(x)             (TT_RTC_BAS + 2*(x))
+#define CHECK_DRIVER_INIT()     (MACH_IS_ATARI && ATARIHW_PRESENT(TT_CLK))
 
 /* On Ataris, the checksum is over all bytes except the checksum bytes
  * themselves; these are at the very end */
-#define ATARI_CKS_RANGE_START	0
-#define ATARI_CKS_RANGE_END		47
-#define ATARI_CKS_LOC			48
-
-#define	mach_check_checksum	atari_check_checksum
-#define	mach_set_checksum	atari_set_checksum
-#define	mach_proc_infos		atari_proc_infos
+#define ATARI_CKS_RANGE_START   0
+#define ATARI_CKS_RANGE_END     47
+#define ATARI_CKS_LOC           48
+#define NVRAM_BYTES             50 /* number of NVRAM bytes */
+#define NVRAM_PAGES             1
+
+#define mach_check_checksum     atari_check_checksum
+#define mach_set_checksum       atari_set_checksum
+#define mach_proc_infos         atari_proc_infos
+#define mach_magic_read         atari_magic_read
+#define mach_magic_write        atari_magic_write
 
 #endif
 
@@ -106,23 +159,28 @@
 #include <asm/io.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
+#include <asm/atomic.h>
 
-static int nvram_open_cnt;	/* #times opened */
-static int nvram_open_mode;		/* special open modes */
-#define	NVRAM_WRITE		1		/* opened for writing (exclusive) */
-#define	NVRAM_EXCL		2		/* opened with O_EXCL */
-
-#define	RTC_FIRST_BYTE		14	/* RTC register number of first NVRAM byte */
-#define	NVRAM_BYTES			128-RTC_FIRST_BYTE	/* number of NVRAM bytes */
+static int curpage;
+static spinlock_t nvram_state_lock = SPIN_LOCK_UNLOCKED;
+static int nvram_open_cnt;        /* #times opened */
+static int nvram_open_mode;       /* special open modes */
+#define NVRAM_WRITE             1 /* opened for writing (exclusive) */
+#define NVRAM_EXCL              2 /* opened with O_EXCL */
 
 
 static int mach_check_checksum( void );
 static void mach_set_checksum( void );
 #ifdef CONFIG_PROC_FS
 static int mach_proc_infos( unsigned char *contents, char *buffer, int *len,
-							off_t *begin, off_t offset, int size );
+                            off_t *begin, off_t offset, int size );
+static unsigned char mach_magic_read(int addr);
+static void mach_magic_write(unsigned char val, int addr);
 #endif
 
+#ifdef CONFIG_NVRAM_NATSEMI_PC87317
+static int natsemi_set_page(int arg);
+#endif
 
 /*
  * These are the internal NVRAM access functions, which do NOT disable
@@ -130,28 +188,70 @@
  * level function, so they need to be done only once per syscall.
  */
 
+static unsigned char magic_page_read(int addr)
+{
+	return mach_magic_read(addr);
+}
+
+static void magic_page_write(unsigned char val, int addr)
+{
+	mach_magic_write(val, addr);
+}
+
+/* 
+ * Anything that calls this to set the page MUST also reset the page to 0 
+ * since this page can also affect the RTC.
+ *
+ * Be sure to have the rtc_lock before setting the page
+ */
+static int set_page(int arg)
+{
+	curpage = arg;
+
+	if (arg == NVRAM_MAGIC_PAGE) {
+		return 0;
+	}
+
+#ifdef CONFIG_NVRAM_NATSEMI_PC87317
+	return natsemi_set_page(arg);
+#endif 
+   
+	return -EINVAL;
+}
+
 static __inline__ unsigned char nvram_read_int( int i )
 {
-	return( CMOS_READ( RTC_FIRST_BYTE+i ) );
+	if (curpage == NVRAM_MAGIC_PAGE) {
+		return magic_page_read(i);
+	} else {
+		return CMOS_READ(NVRAM_FIRST_BYTE+i);
+	}
 }
 
 static __inline__ void nvram_write_int( unsigned char c, int i )
 {
-	CMOS_WRITE( c, RTC_FIRST_BYTE+i );
+	if (curpage == NVRAM_MAGIC_PAGE) {
+		magic_page_write(c, i);
+	} else {
+		CMOS_WRITE(c, NVRAM_FIRST_BYTE+i);
+	}
 }
 
 static __inline__ int nvram_check_checksum_int( void )
 {
-	return( mach_check_checksum() );
+	if (!curpage)
+		return( mach_check_checksum() );
+	else
+		return 1;
 }
 
 static __inline__ void nvram_set_checksum_int( void )
 {
-	mach_set_checksum();
+	if (!curpage)
+		mach_set_checksum();
 }
 
-#if MACH == ATARI
-
+#if (MACH == ATARI) || (MACH == COBALT)
 /*
  * These non-internal functions are provided to be called by other parts of
  * the kernel. It's up to the caller to ensure correct checksum before reading
@@ -161,61 +261,117 @@
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
+}
+
+void __nvram_set_checksum(void)
+{
+	nvram_set_checksum_int();
+}
+void nvram_set_checksum(void)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&rtc_lock, flags);
+	__nvram_set_checksum();
+	spin_unlock_irqrestore(&rtc_lock, flags);
 }
 
-void nvram_set_checksum( void )
+/* paged reads/writes */
+unsigned char __nvram_read_page_byte(int page, int i)
+{
+	unsigned char c;
+	set_page(page);
+	c = nvram_read_int(i);
+	set_page(0);
+	return c;
+}
+unsigned char nvram_read_page_byte(int page, int i)
 {
 	unsigned long flags;
+	unsigned char c;
 
-	spin_lock_irqsave (&rtc_lock, flags);
-	nvram_set_checksum_int();
-	spin_unlock_irqrestore (&rtc_lock, flags);
+	spin_lock_irqsave(&rtc_lock, flags);
+	c = __nvram_read_page_byte(page, i);
+	spin_unlock_irqrestore(&rtc_lock, flags);
+	return(c);
 }
 
-#endif /* MACH == ATARI */
+void __nvram_write_page_byte(int page, unsigned char c, int i)
+{
+	set_page(page);
+	nvram_write_int(c, i);
+	set_page(0);
+}
+void nvram_write_page_byte(int page, unsigned char c, int i)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&rtc_lock, flags);
+	__nvram_write_page_byte(page, c, i);
+	spin_unlock_irqrestore(&rtc_lock, flags);
+}
+#endif /* MACH == ATARI || MACH == COBALT */
 
 
 /*
  * The are the file operation function for user access to /dev/nvram
  */
 
-static long long nvram_llseek(struct file *file,loff_t offset, int origin )
+static loff_t nvram_llseek(struct file *file,loff_t offset, int origin )
 {
-	switch( origin ) {
+	switch (origin) {
 	  case 0:
-		/* nothing to do */
+		/* nothing to do : offset = offset */
 		break;
 	  case 1:
 		offset += file->f_pos;
@@ -224,24 +380,26 @@
 		offset += NVRAM_BYTES;
 		break;
 	}
-	return( (offset >= 0) ? (file->f_pos = offset) : -EINVAL );
+	return (offset >= 0) ? (file->f_pos = offset) : -EINVAL;
 }
 
 static ssize_t nvram_read(struct file * file,
 	char * buf, size_t count, loff_t *ppos )
 {
-	char contents [NVRAM_BYTES];
+	unsigned char contents [NVRAM_BYTES];
 	unsigned i = *ppos;
-	char *tmp;
+	unsigned char *tmp;
 
 	spin_lock_irq (&rtc_lock);
-	
+	set_page((int)file->private_data);
+
 	if (!nvram_check_checksum_int())
 		goto checksum_err;
 
 	for (tmp = contents; count-- > 0 && i < NVRAM_BYTES; ++i, ++tmp)
 		*tmp = nvram_read_int(i);
 
+	set_page(0);
 	spin_unlock_irq (&rtc_lock);
 
 	if (copy_to_user (buf, contents, tmp - contents))
@@ -252,22 +410,25 @@
 	return (tmp - contents);
 
 checksum_err:
+	set_page(0);
 	spin_unlock_irq (&rtc_lock);
 	return -EIO;
 }
 
-static ssize_t nvram_write(struct file * file,
-		const char * buf, size_t count, loff_t *ppos )
+static ssize_t nvram_write(struct file * file, const char * buf, 
+		           size_t count, loff_t *ppos )
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
+	set_page((int)file->private_data);
 
 	if (!nvram_check_checksum_int())
 		goto checksum_err;
@@ -277,6 +438,7 @@
 
 	nvram_set_checksum_int();
 
+	set_page(0);
 	spin_unlock_irq (&rtc_lock);
 
 	*ppos = i;
@@ -284,112 +446,172 @@
 	return (tmp - contents);
 
 checksum_err:
+	set_page(0);
 	spin_unlock_irq (&rtc_lock);
 	return -EIO;
 }
 
 static int nvram_ioctl( struct inode *inode, struct file *file,
-						unsigned int cmd, unsigned long arg )
+                        unsigned int cmd, unsigned long arg )
 {
 	int i;
 	
 	switch( cmd ) {
 
-	  case NVRAM_INIT:			/* initialize NVRAM contents and checksum */
+	  case NVRAM_INIT: 
+		/* initialize NVRAM contents and checksum */
 		if (!capable(CAP_SYS_ADMIN))
-			return( -EACCES );
+			return -EACCES;
 
-		spin_lock_irq (&rtc_lock);
+		spin_lock_irq(&rtc_lock);
+		set_page((int)file->private_data);
 
 		for( i = 0; i < NVRAM_BYTES; ++i )
 			nvram_write_int( 0, i );
 		nvram_set_checksum_int();
 		
-		spin_unlock_irq (&rtc_lock);
-		return( 0 );
+		set_page(0);
+		spin_unlock_irq(&rtc_lock);
+		return 0;
 	  
-	  case NVRAM_SETCKS:		/* just set checksum, contents unchanged
-								 * (maybe useful after checksum garbaged
-								 * somehow...) */
+	  case NVRAM_SETCKS: 
+		/* just set checksum, contents unchanged
+		 * (maybe useful after checksum garbaged
+		 * somehow...) */
 		if (!capable(CAP_SYS_ADMIN))
-			return( -EACCES );
+			return -EACCES;
 
 		spin_lock_irq (&rtc_lock);
+		set_page((int)file->private_data);
 		nvram_set_checksum_int();
+		set_page(0);
 		spin_unlock_irq (&rtc_lock);
-		return( 0 );
+		return 0;
+
+	  case NVRAM_GETPAGE: {
+		int p;
+
+		if (!capable(CAP_SYS_ADMIN))
+			return -EACCES;
+
+		p = (int)file->private_data;
+
+		if (copy_to_user ((int *)arg, &p, sizeof(p)))
+			return -EFAULT;
+
+		return 0;
+	  }
+
+	  case NVRAM_SETPAGE: {
+		if (!capable(CAP_SYS_ADMIN))
+			return -EACCES;
+
+		if (arg >= NVRAM_PAGES && arg != NVRAM_MAGIC_PAGE)
+			return -EINVAL;
+
+		(int)file->private_data = arg;
+
+		return 0;
+	  }
+
+	  case NVRAM_GETNPAGES: {
+		int npages = NVRAM_PAGES;
+		if (copy_to_user((int *)arg, &npages, sizeof(npages)))
+			return -EFAULT;
+		return 0;
+	  }
+
+	  case NVRAM_GETSIZE: {
+		int nbytes = NVRAM_BYTES;
+		if (copy_to_user((int *)arg, &nbytes, sizeof(nbytes)))
+			return -EFAULT;
+		return 0;
+	  }
 
 	  default:
-		return( -EINVAL );
+		return -EINVAL;
 	}
 }
 
 static int nvram_open( struct inode *inode, struct file *file )
 {
+	spin_lock(&nvram_state_lock);
+
 	if ((nvram_open_cnt && (file->f_flags & O_EXCL)) ||
 		(nvram_open_mode & NVRAM_EXCL) ||
-		((file->f_mode & 2) && (nvram_open_mode & NVRAM_WRITE)))
-		return( -EBUSY );
+		((file->f_mode & 2) && (nvram_open_mode & NVRAM_WRITE))) {
+		spin_unlock(&nvram_state_lock);
+		return -EBUSY;
+	}
 
 	if (file->f_flags & O_EXCL)
 		nvram_open_mode |= NVRAM_EXCL;
 	if (file->f_mode & 2)
 		nvram_open_mode |= NVRAM_WRITE;
+	/* use private_data for current page */
+	(int)file->private_data = 0;
+
 	nvram_open_cnt++;
-	return( 0 );
+
+	spin_unlock(&nvram_state_lock);
+
+	return 0;
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
 
 
 #ifndef CONFIG_PROC_FS
 static int nvram_read_proc( char *buffer, char **start, off_t offset,
-			    int size, int *eof, void *data) { return 0; }
+                            int size, int *eof, void *data) { return 0; }
 #else
 
 static int nvram_read_proc( char *buffer, char **start, off_t offset,
-							int size, int *eof, void *data )
+                            int size, int *eof, void *data )
 {
 	unsigned char contents[NVRAM_BYTES];
-    int i, len = 0;
-    off_t begin = 0;
+	int i, len = 0;
+	off_t begin = 0;
 
 	spin_lock_irq (&rtc_lock);
 	for( i = 0; i < NVRAM_BYTES; ++i )
 		contents[i] = nvram_read_int( i );
 	spin_unlock_irq (&rtc_lock);
-	
+
 	*eof = mach_proc_infos( contents, buffer, &len, &begin, offset, size );
 
-    if (offset >= begin + len)
+	if (offset >= begin + len)
 		return( 0 );
-    *start = buffer + (offset - begin);
-    return( size < begin + len - offset ? size : begin + len - offset );
-	
+	*start = buffer + (offset - begin);
+	return( size < begin + len - offset ? size : begin + len - offset );
 }
 
 /* This macro frees the machine specific function from bounds checking and
  * this like that... */
-#define	PRINT_PROC(fmt,args...)							\
-	do {												\
-		*len += sprintf( buffer+*len, fmt, ##args );	\
-		if (*begin + *len > offset + size)				\
-			return( 0 );								\
-		if (*begin + *len < offset) {					\
-			*begin += *len;								\
-			*len = 0;									\
-		}												\
+#define PRINT_PROC(fmt,args...) \
+	do { \
+		*len += sprintf( buffer+*len, fmt, ##args ); \
+		if (*begin + *len > offset + size) \
+			return( 0 ); \
+		if (*begin + *len < offset) { \
+			*begin += *len; \
+			*len = 0; \
+		} \
 	} while(0)
 
 #endif /* CONFIG_PROC_FS */
@@ -417,11 +639,12 @@
 
 	/* First test whether the driver should init at all */
 	if (!CHECK_DRIVER_INIT())
-	    return( -ENXIO );
+		return( -ENXIO );
 
 	ret = misc_register( &nvram_dev );
 	if (ret) {
-		printk(KERN_ERR "nvram: can't misc_register on minor=%d\n", NVRAM_MINOR);
+		printk(KERN_ERR "nvram: can't misc_register on minor=%d\n", 
+			NVRAM_MINOR);
 		goto out;
 	}
 	if (!create_proc_read_entry("driver/nvram",0,0,nvram_read_proc,NULL)) {
@@ -493,7 +716,7 @@
 };
 
 static int pc_proc_infos( unsigned char *nvram, char *buffer, int *len,
-						  off_t *begin, off_t offset, int size )
+                          off_t *begin, off_t offset, int size )
 {
 	int checksum;
 	int type;
@@ -505,7 +728,7 @@
 	PRINT_PROC( "Checksum status: %svalid\n", checksum ? "" : "not " );
 
 	PRINT_PROC( "# floppies     : %d\n",
-				(nvram[6] & 1) ? (nvram[6] >> 6) + 1 : 0 );
+		(nvram[6] & 1) ? (nvram[6] >> 6) + 1 : 0 );
 	PRINT_PROC( "Floppy 0 type  : " );
 	type = nvram[2] >> 4;
 	if (type < sizeof(floppy_types)/sizeof(*floppy_types))
@@ -534,32 +757,208 @@
 		PRINT_PROC( "none\n" );
 
 	PRINT_PROC( "HD type 48 data: %d/%d/%d C/H/S, precomp %d, lz %d\n",
-				nvram[18] | (nvram[19] << 8),
-				nvram[20], nvram[25],
-				nvram[21] | (nvram[22] << 8),
-				nvram[23] | (nvram[24] << 8) );
+		nvram[18] | (nvram[19] << 8),
+		nvram[20], nvram[25],
+		nvram[21] | (nvram[22] << 8),
+		nvram[23] | (nvram[24] << 8) );
 	PRINT_PROC( "HD type 49 data: %d/%d/%d C/H/S, precomp %d, lz %d\n",
-				nvram[39] | (nvram[40] << 8),
-				nvram[41], nvram[46],
-				nvram[42] | (nvram[43] << 8),
-				nvram[44] | (nvram[45] << 8) );
+		nvram[39] | (nvram[40] << 8),
+		nvram[41], nvram[46],
+		nvram[42] | (nvram[43] << 8),
+		nvram[44] | (nvram[45] << 8) );
 
 	PRINT_PROC( "DOS base memory: %d kB\n", nvram[7] | (nvram[8] << 8) );
 	PRINT_PROC( "Extended memory: %d kB (configured), %d kB (tested)\n",
-				nvram[9] | (nvram[10] << 8),
-				nvram[34] | (nvram[35] << 8) );
+		nvram[9] | (nvram[10] << 8),
+		nvram[34] | (nvram[35] << 8) );
 
 	PRINT_PROC( "Gfx adapter    : %s\n", gfx_types[ (nvram[6] >> 4)&3 ] );
 
 	PRINT_PROC( "FPU            : %sinstalled\n",
-				(nvram[6] & 2) ? "" : "not " );
+		(nvram[6] & 2) ? "" : "not " );
 	
 	return( 1 );
 }
 #endif
 
+static unsigned char pc_magic_read(int addr) { return 0; };
+static void pc_magic_write(unsigned char val, int addr) { return; };
+
 #endif /* MACH == PC */
 
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
+static unsigned char cobalt_magic_read(int addr) { return 0; }
+static void cobalt_magic_write(unsigned char val, int addr) { return; }
+
+#endif /* MACH == COBALT */
+
 #if MACH == ATARI
 
 static int atari_check_checksum( void )
@@ -627,7 +1026,7 @@
 #define fieldsize(a)	(sizeof(a)/sizeof(*a))
 
 static int atari_proc_infos( unsigned char *nvram, char *buffer, int *len,
-			    off_t *begin, off_t offset, int size )
+                             off_t *begin, off_t offset, int size )
 {
 	int checksum = nvram_check_checksum();
 	int i;
@@ -645,7 +1044,8 @@
 	if (i < 0)
 		PRINT_PROC( "0x%02x (undefined)\n", nvram[1] );
 
-	PRINT_PROC( "SCSI arbitration : %s\n", (nvram[16] & 0x80) ? "on" : "off" );
+	PRINT_PROC( "SCSI arbitration : %s\n", 
+		(nvram[16] & 0x80) ? "on" : "off" );
 	PRINT_PROC( "SCSI host ID     : " );
 	if (nvram[16] & 0x80)
 		PRINT_PROC( "%d\n", nvram[16] & 7 );
@@ -668,32 +1068,63 @@
 		PRINT_PROC( "%u (undefined)\n", nvram[7] );
 	PRINT_PROC( "Date format      : " );
 	PRINT_PROC( dateformat[nvram[8]&7],
-				nvram[9] ? nvram[9] : '/', nvram[9] ? nvram[9] : '/' );
+		nvram[9] ? nvram[9] : '/', nvram[9] ? nvram[9] : '/' );
 	PRINT_PROC( ", %dh clock\n", nvram[8] & 16 ? 24 : 12 );
 	PRINT_PROC( "Boot delay       : " );
 	if (nvram[10] == 0)
 		PRINT_PROC( "default" );
 	else
 		PRINT_PROC( "%ds%s\n", nvram[10],
-					nvram[10] < 8 ? ", no memory test" : "" );
+			nvram[10] < 8 ? ", no memory test" : "" );
 
 	vmode = (nvram[14] << 8) || nvram[15];
 	PRINT_PROC( "Video mode       : %s colors, %d columns, %s %s monitor\n",
-				colors[vmode & 7],
-				vmode & 8 ? 80 : 40,
-				vmode & 16 ? "VGA" : "TV",
-				vmode & 32 ? "PAL" : "NTSC" );
+		colors[vmode & 7],
+		vmode & 8 ? 80 : 40,
+		vmode & 16 ? "VGA" : "TV",
+		vmode & 32 ? "PAL" : "NTSC" );
 	PRINT_PROC( "                   %soverscan, compat. mode %s%s\n",
-				vmode & 64 ? "" : "no ",
-				vmode & 128 ? "on" : "off",
-				vmode & 256 ?
-				  (vmode & 16 ? ", line doubling" : ", half screen") : "" );
+		vmode & 64 ? "" : "no ",
+		vmode & 128 ? "on" : "off",
+		vmode & 256 ?
+		(vmode & 16 ? ", line doubling" : ", half screen") : "" );
 		
 	return( 1 );
 }
 #endif
 
+static unsigned char atari_magic_read(int addr) { return 0; };
+static void atari_magic_write(unsigned char val, int addr) { return; };
+
 #endif /* MACH == ATARI */
+
+#ifdef CONFIG_NVRAM_NATSEMI_PC87317
+static int natsemi_set_page(int arg)
+{
+	unsigned char val;
+
+	val = CMOS_READ(0xa);
+	val &= ~0x70;
+
+	switch (arg) {
+	case 0:
+		val |= 0x20;
+		break;
+	 
+	case 1:
+		val |= 0x30;
+		break;
+
+	case 2:
+		val |= 0x40;
+		break;
+	}
+
+	CMOS_WRITE(val, 0xa);
+
+	return 0;
+}
+#endif
 
 MODULE_LICENSE("GPL");
 
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
@@ -4,14 +4,36 @@
 #include <linux/ioctl.h>
 
 /* /dev/nvram ioctls */
-#define NVRAM_INIT		_IO('p', 0x40) /* initialize NVRAM and set checksum */
-#define	NVRAM_SETCKS	_IO('p', 0x41) /* recalculate checksum */
+#define NVRAM_INIT        _IO('p', 0x40) /* initialize NVRAM and set checksum */
+#define NVRAM_SETCKS      _IO('p', 0x41) /* recalculate checksum */
+#define NVRAM_GETPAGE     _IO('p', 0x42) /* get nvram page */
+#define NVRAM_SETPAGE     _IO('p', 0x43) /* set nvram page */
+#define NVRAM_GETNPAGES   _IO('p', 0x44) /* get the number of pages */
+#define NVRAM_GETSIZE     _IO('p', 0x45) /* get the nvram page size */
+
+#define NVRAM_MAGIC_PAGE  0x10000
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
+extern unsigned char nvram_read_page_byte(int page, int i);
+extern unsigned char __nvram_read_page_byte(int page, int i);
+extern void nvram_write_page_byte(int page, unsigned char c, int i);
+extern void __nvram_write_page_byte(int page, unsigned char c, int i);
 #endif
 
 #endif  /* _LINUX_NVRAM_H */

--------------3723CCBD41800E0C29912817--

