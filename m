Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265908AbRGJHXN>; Tue, 10 Jul 2001 03:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265907AbRGJHW4>; Tue, 10 Jul 2001 03:22:56 -0400
Received: from mercury.Sun.COM ([192.9.25.1]:54215 "EHLO mercury.Sun.COM")
	by vger.kernel.org with ESMTP id <S265902AbRGJHWg>;
	Tue, 10 Jul 2001 03:22:36 -0400
Message-ID: <3B4AAEFC.72A07FDA@sun.com>
Date: Tue, 10 Jul 2001 00:30:04 -0700
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: alan@redhat.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH]  nvram driver
Content-Type: multipart/mixed;
 boundary="------------12AD54F61942796801C3862F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------12AD54F61942796801C3862F
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

All,

Attached is a patch to the nvram driver.

* Add support (via ioctl()) for paged nvram systems
* Add support for NatSemi PC[89]7317 chips to be paged
* Add Cobalt Networks support to NVRAM
* Make NVRAM_BYTES be machine dependant
* Add a 'magic' page for machine-specific NVRAM-like functions
* spinlock the nvram state
* remove a lock_kernel()
* Add Cobalt Magic page support

Please let me know if there is any reason this can not be included in the
general kernel source.

Thanks

Tim
-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
--------------12AD54F61942796801C3862F
Content-Type: text/plain; charset=us-ascii;
 name="nvram.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nvram.diff"

diff -ruN dist-2.4.6/Documentation/Configure.help cobalt-2.4.6/Documentation/Configure.help
--- dist-2.4.6/Documentation/Configure.help	Mon Jul  2 14:07:55 2001
+++ cobalt-2.4.6/Documentation/Configure.help	Mon Jul  9 11:02:57 2001
@@ -14649,9 +14784,11 @@
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
@@ -14669,6 +14806,15 @@
   inserted in and removed from the running kernel whenever you want).
   The module will be called nvram.o. If you want to compile it as a
   module, say M here and read Documentation/modules.txt.
+
+NatSemi PC[89]7317 paged NVRAM support
+CONFIG_NVRAM_NATSEMI
+  If you have a National Semiconductor PC87317 or PC97317 Superio chip,
+  you may want to say Y here.  This provides access to NVRAM pages other
+  than the default.  Some systems, like some Cobalt Networks servers, use 
+  these other pages.
+
+  If in doubt, say N here.
 
 Joystick support
 CONFIG_JOYSTICK
diff -ruN dist-2.4.6/drivers/char/Config.in cobalt-2.4.6/drivers/char/Config.in
--- dist-2.4.6/drivers/char/Config.in	Tue Jul  3 14:10:35 2001
+++ cobalt-2.4.6/drivers/char/Config.in	Mon Jul  9 11:03:34 2001
@@ -158,6 +158,9 @@
 
 dep_tristate 'Intel i8x0 Random Number Generator support' CONFIG_INTEL_RNG $CONFIG_PCI
 tristate '/dev/nvram support' CONFIG_NVRAM
+if [ "$CONFIG_NVRAM" = "y" -o "$CONFIG_NVRAM" = "m" ]; then
+   bool '  NatSemi PC[89]7317 paged NVRAM support' CONFIG_NVRAM_NATSEMI
+fi
 tristate 'Enhanced Real Time Clock Support' CONFIG_RTC
 if [ "$CONFIG_IA64" = "y" ]; then
    bool 'EFI Real Time Clock Services' CONFIG_EFI_RTC
diff -ruN dist-2.4.6/drivers/char/nvram.c cobalt-2.4.6/drivers/char/nvram.c
--- dist-2.4.6/drivers/char/nvram.c	Wed Jun 27 17:10:55 2001
+++ cobalt-2.4.6/drivers/char/nvram.c	Mon Jul  9 12:24:41 2001
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
@@ -25,12 +26,31 @@
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
  * 	1.1	Cesar Barros: SMP locking fixes
  * 		added changelog
  */
 
-#define NVRAM_VERSION		"1.1"
+#define NVRAM_VERSION		"1.2"
 
 #include <linux/module.h>
 #include <linux/config.h>
@@ -39,14 +59,20 @@
 
 #define PC		1
 #define ATARI	2
+#define COBALT  3
 
 /* select machine configuration */
 #if defined(CONFIG_ATARI)
-#define MACH ATARI
+#  define MACH ATARI
 #elif defined(__i386__) || defined(__arm__) /* and others?? */
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
@@ -58,10 +84,34 @@
 #define PC_CKS_RANGE_START	2
 #define PC_CKS_RANGE_END	31
 #define PC_CKS_LOC			32
+#define	NVRAM_BYTES			50	/* number of NVRAM bytes */
+#define NVRAM_PAGES			1	/* pages, !including magic */
 
 #define	mach_check_checksum	pc_check_checksum
 #define	mach_set_checksum	pc_set_checksum
 #define	mach_proc_infos		pc_proc_infos
+#define mach_magic_read		pc_magic_read
+#define mach_magic_write	pc_magic_write
+
+#endif
+
+#if MACH == COBALT
+/* RTC in a Cobalt Networks system */
+#define CHECK_DRIVER_INIT() 1
+
+/* Give us some more space */
+#define	NVRAM_BYTES		(0x80 - RTC_FIRST_BYTE)
+#if defined(CONFIG_NVRAM_NATSEMI) && defined(CONFIG_COBALT_GEN_V)
+#define NVRAM_PAGES		3
+#else
+#define NVRAM_PAGES		1
+#endif
+
+#define	mach_check_checksum	cobalt_check_checksum
+#define	mach_set_checksum       cobalt_set_checksum
+#define	mach_proc_infos	        cobalt_proc_infos
+#define mach_magic_read		cobalt_magic_read
+#define mach_magic_write	cobalt_magic_write
 
 #endif
 
@@ -78,10 +128,14 @@
 #define ATARI_CKS_RANGE_START	0
 #define ATARI_CKS_RANGE_END		47
 #define ATARI_CKS_LOC			48
+#define	NVRAM_BYTES			50	/* number of NVRAM bytes */
+#define NVRAM_PAGES			1
 
 #define	mach_check_checksum	atari_check_checksum
 #define	mach_set_checksum	atari_set_checksum
 #define	mach_proc_infos		atari_proc_infos
+#define mach_magic_read		atari_magic_read
+#define mach_magic_write	atari_magic_write
 
 #endif
 
@@ -106,14 +160,16 @@
 #include <asm/io.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
+#include <asm/atomic.h>
 
+static atomic_t curpage = ATOMIC_INIT(0);
+static spinlock_t nvram_state_lock = SPIN_LOCK_UNLOCKED;
 static int nvram_open_cnt;	/* #times opened */
-static int nvram_open_mode;		/* special open modes */
-#define	NVRAM_WRITE		1		/* opened for writing (exclusive) */
-#define	NVRAM_EXCL		2		/* opened with O_EXCL */
+static int nvram_open_mode;	/* special open modes */
+#define NVRAM_WRITE		1 /* opened for writing (exclusive) */
+#define NVRAM_EXCL		2 /* opened with O_EXCL */
 
-#define	RTC_FIRST_BYTE		14	/* RTC register number of first NVRAM byte */
-#define	NVRAM_BYTES			128	/* number of NVRAM bytes */
+#define	RTC_FIRST_BYTE		14 /* RTC register number of first NVRAM byte */
 
 
 static int mach_check_checksum( void );
@@ -121,8 +177,13 @@
 #ifdef CONFIG_PROC_FS
 static int mach_proc_infos( unsigned char *contents, char *buffer, int *len,
 							off_t *begin, off_t offset, int size );
+static unsigned char mach_magic_read(int addr);
+static void mach_magic_write(unsigned char val, int addr);
 #endif
 
+#ifdef CONFIG_NVRAM_NATSEMI
+static int natsemi_set_page(int arg);
+#endif
 
 /*
  * These are the internal NVRAM access functions, which do NOT disable
@@ -130,24 +191,75 @@
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
+ * since this page can also affect the RTC
+ */
+static int hw_set_page(int arg)
+{
+	if (arg == NVRAM_MAGIC_PAGE) {
+		return 0;
+	}
+
+#ifdef CONFIG_NVRAM_NATSEMI
+	return natsemi_set_page(arg);
+#endif 
+   
+	return -EINVAL;
+}
+
 static __inline__ unsigned char nvram_read_int( int i )
 {
-	return( CMOS_READ( RTC_FIRST_BYTE+i ) );
+	int p = atomic_read(&curpage);
+	if (p == NVRAM_MAGIC_PAGE) {
+	    return magic_page_read(i);
+	} else {
+	    unsigned char c;
+	    hw_set_page(p);
+	    c = CMOS_READ(RTC_FIRST_BYTE+i);
+	    hw_set_page(0);
+	    return c;
+	}
 }
 
 static __inline__ void nvram_write_int( unsigned char c, int i )
 {
-	CMOS_WRITE( c, RTC_FIRST_BYTE+i );
+	int p = atomic_read(&curpage);
+	if (p == NVRAM_MAGIC_PAGE) {
+	    magic_page_write(c, i);
+	} else {
+	    hw_set_page(p);
+	    CMOS_WRITE(c, RTC_FIRST_BYTE+i);
+	    hw_set_page(0);
+	}
 }
 
 static __inline__ int nvram_check_checksum_int( void )
 {
-	return( mach_check_checksum() );
+	int p = atomic_read(&curpage);
+
+	if (!p)
+		return( mach_check_checksum() );
+	else
+		return 1;
 }
 
 static __inline__ void nvram_set_checksum_int( void )
 {
-	mach_set_checksum();
+	int p = atomic_read(&curpage);
+
+	if (!p)
+		mach_set_checksum();
 }
 
 #if MACH == ATARI
@@ -204,6 +316,16 @@
 	spin_unlock_irqrestore (&rtc_lock, flags);
 }
 
+void nvram_set_page(int newpage)
+{
+	atomic_set(&curpage, newpage);
+}
+
+int nvram_get_page(void)
+{
+	return atomic_read(&curpage);
+}
+
 #endif /* MACH == ATARI */
 
 
@@ -211,11 +333,11 @@
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
@@ -224,15 +346,15 @@
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
 	
@@ -259,9 +381,9 @@
 static ssize_t nvram_write(struct file * file,
 		const char * buf, size_t count, loff_t *ppos )
 {
-	char contents [NVRAM_BYTES];
+	unsigned char contents [NVRAM_BYTES];
 	unsigned i = *ppos;
-	char * tmp;
+	unsigned char *tmp;
 
 	if (copy_from_user (contents, buf, (NVRAM_BYTES - i) < count ?
 						(NVRAM_BYTES - i) : count))
@@ -290,14 +412,14 @@
 
 static int nvram_ioctl( struct inode *inode, struct file *file,
 						unsigned int cmd, unsigned long arg )
-{
+{	
 	int i;
 	
 	switch( cmd ) {
 
 	  case NVRAM_INIT:			/* initialize NVRAM contents and checksum */
 		if (!capable(CAP_SYS_ADMIN))
-			return( -EACCES );
+			return -EACCES;
 
 		spin_lock_irq (&rtc_lock);
 
@@ -306,50 +428,103 @@
 		nvram_set_checksum_int();
 		
 		spin_unlock_irq (&rtc_lock);
-		return( 0 );
+		return 0;
 	  
 	  case NVRAM_SETCKS:		/* just set checksum, contents unchanged
 								 * (maybe useful after checksum garbaged
 								 * somehow...) */
 		if (!capable(CAP_SYS_ADMIN))
-			return( -EACCES );
+			return -EACCES;
 
 		spin_lock_irq (&rtc_lock);
 		nvram_set_checksum_int();
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
+		p = atomic_read(&curpage);
+		    
+		if (copy_to_user ((int *)arg, &p, sizeof(p)))
+		    return -EFAULT;
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
+		atomic_set(&curpage, arg);
+
+		return 0;
+	  }
+	     
+	  case NVRAM_GETNPAGES: {
+		int npages = NVRAM_PAGES;
+		if (copy_to_user((int *)arg, &npages, sizeof(npages)))
+		    return -EFAULT;
+		return 0;
+	  }
+
+	  case NVRAM_GETSIZE: {
+		int nbytes = NVRAM_BYTES;
+		if (copy_to_user((int *)arg, &nbytes, sizeof(nbytes)))
+		    return -EFAULT;
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
+	atomic_set(&curpage, 0);
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
 
 
@@ -361,22 +536,22 @@
 static int nvram_read_proc( char *buffer, char **start, off_t offset,
 							int size, int *eof, void *data )
 {
-	unsigned char contents[NVRAM_BYTES];
+    unsigned char contents[NVRAM_BYTES];
     int i, len = 0;
     off_t begin = 0;
-
-	spin_lock_irq (&rtc_lock);
-	for( i = 0; i < NVRAM_BYTES; ++i )
-		contents[i] = nvram_read_int( i );
-	spin_unlock_irq (&rtc_lock);
-	
-	*eof = mach_proc_infos( contents, buffer, &len, &begin, offset, size );
-
+    
+    spin_lock_irq (&rtc_lock);
+    for( i = 0; i < NVRAM_BYTES; ++i )
+	contents[i] = nvram_read_int( i );
+    spin_unlock_irq (&rtc_lock);
+    
+    *eof = mach_proc_infos( contents, buffer, &len, &begin, offset, size );
+    
     if (offset >= begin + len)
-		return( 0 );
+	return( 0 );
     *start = buffer + (offset - begin);
     return( size < begin + len - offset ? size : begin + len - offset );
-	
+    
 }
 
 /* This macro frees the machine specific function from bounds checking and
@@ -558,8 +733,285 @@
 }
 #endif
 
+static unsigned char pc_magic_read(int addr) { return 0; };
+static void pc_magic_write(unsigned char val, int addr) { return; };
+
 #endif /* MACH == PC */
 
+#if MACH == COBALT
+
+/* the cobalt CMOS has a wider range of it's checksum */
+static int cobalt_check_checksum( void )
+{
+    int i;
+    unsigned short sum = 0;
+
+    for( i = COBT_CMOS_CKS_START; i <= COBT_CMOS_CKS_END; ++i )
+    {
+	if( (i == COBT_CMOS_CHECKSUM) || 
+	    (i == (COBT_CMOS_CHECKSUM+1)) )
+	    continue;
+
+	sum += nvram_read_int( i );
+    }
+    return( (sum & 0xffff) ==
+	    ((nvram_read_int(COBT_CMOS_CHECKSUM) << 8) |
+	     nvram_read_int(COBT_CMOS_CHECKSUM+1)) );
+}
+
+static void cobalt_set_checksum( void )
+{
+    int i;
+    unsigned short sum = 0;
+    
+    for( i = COBT_CMOS_CKS_START; i <= COBT_CMOS_CKS_END; ++i )
+    {
+	if( (i == COBT_CMOS_CHECKSUM) || 
+	    (i == (COBT_CMOS_CHECKSUM+1)) )
+	    continue;
+
+	sum += nvram_read_int( i );
+    }
+    
+    nvram_write_int( sum >> 8, COBT_CMOS_CHECKSUM );
+    nvram_write_int( sum & 0xff, COBT_CMOS_CHECKSUM+1 );
+}
+
+#ifdef CONFIG_PROC_FS
+
+static int cobalt_proc_infos( unsigned char *nvram, char *buffer, int *len,
+			      off_t *begin, off_t offset, int size )
+{ 
+    int i;
+    unsigned int checksum;
+    unsigned int val;
+    char sernum[14];
+    char *key = "cNoEbTaWlOtR!";
+
+    spin_lock_irq (&rtc_lock);
+    checksum = nvram_check_checksum_int();
+    spin_unlock_irq (&rtc_lock);
+    
+    PRINT_PROC( "Checksum status: %svalid\n", checksum ? "" : "not " );
+    
+    val = nvram[COBT_CMOS_FLAG_BYTE_0] << 8 |
+	nvram[COBT_CMOS_FLAG_BYTE_1];
+    
+    PRINT_PROC( "Console: %s\n", 
+		val & COBT_CMOS_CONSOLE_FLAG ?  "on": "off" );
+    
+    PRINT_PROC( "Firmware Debug Messages: %s\n", 
+		val & COBT_CMOS_DEBUG_FLAG ? "on": "off" );
+    
+    PRINT_PROC( "Auto Prompt: %s\n", 
+		val & COBT_CMOS_AUTO_PROMPT_FLAG ? "on": "off" );
+    
+    PRINT_PROC( "Shutdown Status: %s\n", 
+		val & COBT_CMOS_CLEAN_BOOT_FLAG ? "clean": "dirty" );
+    
+    PRINT_PROC( "Hardware Probe: %s\n", 
+		val & COBT_CMOS_HW_NOPROBE_FLAG ? "partial": "full" );
+    
+    PRINT_PROC( "System Fault: %sdetected\n", 
+		val & COBT_CMOS_SYSFAULT_FLAG ? "": "not " );
+    
+    PRINT_PROC( "Panic on OOPS: %s\n", 
+		val & COBT_CMOS_OOPSPANIC_FLAG ? "yes": "no" );
+    
+    PRINT_PROC( "Boot Method: " );
+    switch( nvram[ COBT_CMOS_BOOT_METHOD ] )
+    {
+	case COBT_CMOS_BOOT_METHOD_DISK:
+	    PRINT_PROC( "disk\n" );
+	    break;
+	    
+	case COBT_CMOS_BOOT_METHOD_ROM:
+	    PRINT_PROC( "rom\n" );
+	    break;
+	    
+	case COBT_CMOS_BOOT_METHOD_NET:
+	    PRINT_PROC( "net\n" );
+	    break;
+	    
+	default:
+	    PRINT_PROC( "unknown\n" );
+	    break;
+    }
+    
+    PRINT_PROC( "Primary Boot Device: %d:%d\n", 
+		nvram[ COBT_CMOS_BOOT_DEV0_MAJ ],
+		nvram[ COBT_CMOS_BOOT_DEV0_MIN ] );
+    PRINT_PROC( "Secondary Boot Device: %d:%d\n", 
+		nvram[ COBT_CMOS_BOOT_DEV1_MAJ ],
+		nvram[ COBT_CMOS_BOOT_DEV1_MIN ] );
+    PRINT_PROC( "Tertiary Boot Device: %d:%d\n", 
+		nvram[ COBT_CMOS_BOOT_DEV2_MAJ ],
+		nvram[ COBT_CMOS_BOOT_DEV2_MIN ] );
+    
+    PRINT_PROC( "Uptime: %d\n", 		 
+		nvram[ COBT_CMOS_UPTIME_0 ] << 24 |  
+		nvram[ COBT_CMOS_UPTIME_1 ] << 16 |  
+		nvram[ COBT_CMOS_UPTIME_2 ] << 8  |  
+		nvram[ COBT_CMOS_UPTIME_3 ] );
+    
+    PRINT_PROC( "Boot Count: %d\n", 		 
+		nvram[ COBT_CMOS_BOOTCOUNT_0 ] << 24 |  
+		nvram[ COBT_CMOS_BOOTCOUNT_1 ] << 16 |  
+		nvram[ COBT_CMOS_BOOTCOUNT_2 ] << 8  |  
+		nvram[ COBT_CMOS_BOOTCOUNT_3 ] );
+    
+    /* 13 bytes of serial num */
+    for( i=0 ; i<13 ; i++ )
+	sernum[i] = nvram[COBT_CMOS_SYS_SERNUM_0 + i];
+    sernum[13] = '\0';
+    
+    val = 0xff; /*nvram[COBT_CMOS_SYS_SERNUM_CSUM]; */
+    checksum = 0;
+    for( i=0 ; i<13 ; i++ )
+	checksum += sernum[i] ^ key[i];
+    
+    checksum = ((checksum & 0x7f) ^ (0xd6)) & 0xff;
+
+    PRINT_PROC( "Serial Number: %s\n", ( checksum == val )? sernum : "unset" );
+
+    PRINT_PROC( "Rom Revison: %d.%d.%d\n", nvram[COBT_CMOS_ROM_REV_MAJ],
+		nvram[COBT_CMOS_ROM_REV_MIN], nvram[COBT_CMOS_ROM_REV_REV] );
+
+    PRINT_PROC( "Language: %c%c\n", nvram[ COBT_CMOS_LANGUAGE_0 ],
+		nvram[ COBT_CMOS_LANGUAGE_1 ] );
+
+    PRINT_PROC( "HA Mode: %d\n", nvram[ COBT_CMOS_HA_MODE ] );
+
+    return 1;
+}
+#endif /* CONFIG_PROC_FS */
+
+#define NS_GP1_EN0		0x04
+#define NS_GP1_EN0_PME2_E	0x02
+#define NATSEMI_GPE1_PORT	0x530
+#define NS_PORT_APCR6		0x4c  
+#define cobt_get_powerfail()	__cobt_wake_powerfail(0, 0)
+#define cobt_set_powerfail(a)	__cobt_wake_powerfail(1, (a))
+#define cobt_get_powerapply()	__cobt_wake_powerapply(0, 0)
+#define cobt_set_powerapply(a)	__cobt_wake_powerapply(1, (a))
+static u8 __cobt_wake_powerfail(const u8 set, const u8 val)
+{
+#if defined(CONFIG_NVRAM_NATSEMI) && defined(CONFIG_COBALT_GEN_V)
+    u8 reg;
+
+    hw_set_page(2); /* APC bank */
+    reg = CMOS_READ(NS_PORT_APCR6);
+    if (set) {
+        reg = !val ? (reg | 0x80) : (reg & ~0xc0);
+	CMOS_WRITE(reg, NS_PORT_APCR6);
+    }
+    hw_set_page(0);
+    return (reg & 0x80) ? 0 : 1;
+#else
+    return 0;
+#endif
+}
+
+static u8 __cobt_wake_powerapply(const u8 set, const u8 val)
+{
+#if defined(CONFIG_NVRAM_NATSEMI) && defined(CONFIG_COBALT_GEN_V)
+    u8 reg;
+    reg = inb(NATSEMI_GPE1_PORT | NS_GP1_EN0);
+    if (set) {
+        reg = val ? (reg | NS_GP1_EN0_PME2_E) : (reg & ~NS_GP1_EN0_PME2_E);
+        outb(reg, NATSEMI_GPE1_PORT | NS_GP1_EN0);
+    }
+    return (reg & NS_GP1_EN0_PME2_E) ? 1 : 0;
+#else
+    return 0;
+#endif
+}
+
+static unsigned char cobalt_magic_read(int addr)
+{
+	unsigned char val;
+	switch (addr) {
+		case COBT_CMOS_MP_POWER:
+			if (cobt_get_powerapply())
+				return COBT_CMOS_MP_POWER_ON;
+			if (cobt_get_powerfail())
+				return COBT_CMOS_MP_POWER_SAME;
+			return COBT_CMOS_MP_POWER_OFF;
+
+		case COBT_CMOS_MP_ALARM_SEC:
+			val = CMOS_READ( RTC_SECONDS_ALARM );
+			return val;
+
+		case COBT_CMOS_MP_ALARM_EN:
+			val = CMOS_READ( RTC_REG_B);
+			return val & (0x1 << 5);
+
+		case COBT_CMOS_MP_ALARM_MIN:
+			val = CMOS_READ( RTC_MINUTES_ALARM );
+			return val;
+		
+		case COBT_CMOS_MP_ALARM_HOUR:
+			val = CMOS_READ( RTC_HOURS_ALARM );
+			return val;
+
+		default:
+			return 0;
+	}
+}
+
+static void cobalt_magic_write(unsigned char val, int addr)
+{
+	switch (addr) {
+		case COBT_CMOS_MP_POWER:
+			switch (val) {
+				case COBT_CMOS_MP_POWER_OFF:
+					cobt_set_powerfail(0);
+					cobt_set_powerapply(0);
+					break;
+
+				case COBT_CMOS_MP_POWER_SAME:
+					cobt_set_powerfail(1);
+					cobt_set_powerapply(0);
+					break;
+
+				case COBT_CMOS_MP_POWER_ON:
+					cobt_set_powerfail(1);
+					cobt_set_powerapply(1);
+					break;
+			}
+			break;
+
+		case COBT_CMOS_MP_ALARM_EN: {
+			unsigned char tmp_val;
+			tmp_val = CMOS_READ( RTC_REG_B );
+
+			/* set (or don't) alarm enable bit */
+			tmp_val &= ~ (0x1 << 5); 
+			tmp_val |= (val&0x1) << 5;
+
+			CMOS_WRITE( tmp_val,  RTC_REG_B );
+			break;
+		}
+
+		case COBT_CMOS_MP_ALARM_SEC:
+			CMOS_WRITE( val,  RTC_SECONDS_ALARM );
+			break;
+ 
+		case COBT_CMOS_MP_ALARM_MIN:
+			CMOS_WRITE( val, RTC_MINUTES_ALARM );
+			break;
+
+		case COBT_CMOS_MP_ALARM_HOUR:
+			CMOS_WRITE( val, RTC_HOURS_ALARM );
+			break;
+
+		default:
+			break;
+	}
+}
+
+#endif /* MACH == COBALT */
+
 #if MACH == ATARI
 
 static int atari_check_checksum( void )
@@ -693,7 +1145,38 @@
 }
 #endif
 
+static unsigned char atari_magic_read(int addr) { return 0; };
+static void atari_magic_write(unsigned char val, int addr) { return; };
+
 #endif /* MACH == ATARI */
+
+#ifdef CONFIG_NVRAM_NATSEMI
+static int natsemi_set_page(int arg)
+{
+    unsigned char val;
+    
+    val = CMOS_READ(0xa);
+    val &= ~0x70;
+
+    switch (arg) {
+	case 0:
+	    val |= 0x20;
+	    break;
+	    
+	case 1:
+	    val |= 0x30;
+	    break;
+
+	case 2:
+	    val |= 0x40;
+	    break;
+    }
+    
+    CMOS_WRITE(val, 0xa);
+
+    return 0;
+}
+#endif
 
 /*
  * Local variables:
diff -ruN dist-2.4.6/include/linux/cobalt-nvram.h cobalt-2.4.6/include/linux/cobalt-nvram.h
--- dist-2.4.6/include/linux/cobalt-nvram.h	Wed Dec 31 16:00:00 1969
+++ cobalt-2.4.6/include/linux/cobalt-nvram.h	Thu Jun 28 10:30:45 2001
@@ -0,0 +1,114 @@
+/*
+ * $Id: cobalt-nvram.h,v 1.6 2001/06/27 00:36:19 thockin Exp $
+ * cobalt-nvram.h : defines for the various fields in the cobalt NVRAM
+ *
+ * Copyright 2001 Sun Microsystems, Inc.
+ */
+
+#ifndef COBALT_NVRAM_H
+#define COBALT_NVRAM_H
+
+
+#define COBT_CMOS_INFO_MAX		0x7f	/* top address allowed */
+#define COBT_CMOS_BIOS_DRIVE_INFO	0x12	/* drive info would go here */
+
+#define COBT_NVRAM(b)			((b)-0xe)
+
+#define COBT_CMOS_CKS_START		COBT_NVRAM(0x0e)
+#define COBT_CMOS_CKS_END		COBT_NVRAM(0x7f)
+
+/* flag bytes - 16 flags for now, leave room for more */
+#define COBT_CMOS_FLAG_BYTE_0		COBT_NVRAM(0x10)
+#define COBT_CMOS_FLAG_BYTE_1		COBT_NVRAM(0x11)
+
+/* leave byte 0x12 blank - Linux looks for drive info here */
+
+/* flags in flag bytes - up to 16 */
+#define COBT_CMOS_FLAG_MIN		0x0001
+#define COBT_CMOS_CONSOLE_FLAG		0x0001 /* console on/off */
+#define COBT_CMOS_DEBUG_FLAG		0x0002 /* ROM debug messages */
+#define COBT_CMOS_AUTO_PROMPT_FLAG	0x0004 /* boot to ROM prompt? */
+#define COBT_CMOS_CLEAN_BOOT_FLAG	0x0008 /* set by a clean shutdown */
+#define COBT_CMOS_HW_NOPROBE_FLAG	0x0010 /* go easy on the probing */
+#define COBT_CMOS_SYSFAULT_FLAG	0x0020 /* system fault detected */
+#define COBT_CMOS_OOPSPANIC_FLAG	0x0040 /* panic on oops */
+#define COBT_CMOS_FLAG_MAX		0x0040
+
+/* index of default boot method */
+#define COBT_CMOS_BOOT_METHOD		COBT_NVRAM(0x20)
+#define COBT_CMOS_BOOT_METHOD_DISK	0
+#define COBT_CMOS_BOOT_METHOD_ROM	1
+#define COBT_CMOS_BOOT_METHOD_NET	2
+
+#define COBT_CMOS_BOOT_DEV_MIN		COBT_NVRAM(0x21)
+/* major #, minor # of first through fourth boot device */
+#define COBT_CMOS_BOOT_DEV0_MAJ		COBT_NVRAM(0x21)
+#define COBT_CMOS_BOOT_DEV0_MIN		COBT_NVRAM(0x22)
+#define COBT_CMOS_BOOT_DEV1_MAJ		COBT_NVRAM(0x23)
+#define COBT_CMOS_BOOT_DEV1_MIN		COBT_NVRAM(0x24)
+#define COBT_CMOS_BOOT_DEV2_MAJ		COBT_NVRAM(0x25)
+#define COBT_CMOS_BOOT_DEV2_MIN		COBT_NVRAM(0x26)
+#define COBT_CMOS_BOOT_DEV3_MAJ		COBT_NVRAM(0x27)
+#define COBT_CMOS_BOOT_DEV3_MIN		COBT_NVRAM(0x28)
+#define COBT_CMOS_BOOT_DEV_MAX		COBT_NVRAM(0x28)
+
+/* checksum of bytes 0xe-0x7f */
+#define COBT_CMOS_CHECKSUM		COBT_NVRAM(0x2e)
+
+/* running uptime counter, units of 5 minutes (32 bits =~ 41000 years) */
+#define COBT_CMOS_UPTIME_0		COBT_NVRAM(0x30)
+#define COBT_CMOS_UPTIME_1		COBT_NVRAM(0x31)
+#define COBT_CMOS_UPTIME_2		COBT_NVRAM(0x32)
+#define COBT_CMOS_UPTIME_3		COBT_NVRAM(0x33)
+
+/* count of successful boots (32 bits) */
+#define COBT_CMOS_BOOTCOUNT_0		COBT_NVRAM(0x38)
+#define COBT_CMOS_BOOTCOUNT_1		COBT_NVRAM(0x39)
+#define COBT_CMOS_BOOTCOUNT_2		COBT_NVRAM(0x3a)
+#define COBT_CMOS_BOOTCOUNT_3		COBT_NVRAM(0x3b)
+
+/* 13 bytes: system serial number, same as on the back of the system */
+#define COBT_CMOS_SYS_SERNUM_LEN	13
+#define COBT_CMOS_SYS_SERNUM_0		COBT_NVRAM(0x40)
+#define COBT_CMOS_SYS_SERNUM_1		COBT_NVRAM(0x41)
+#define COBT_CMOS_SYS_SERNUM_2		COBT_NVRAM(0x42)
+#define COBT_CMOS_SYS_SERNUM_3		COBT_NVRAM(0x43)
+#define COBT_CMOS_SYS_SERNUM_4		COBT_NVRAM(0x44)
+#define COBT_CMOS_SYS_SERNUM_5		COBT_NVRAM(0x45)
+#define COBT_CMOS_SYS_SERNUM_6		COBT_NVRAM(0x46)
+#define COBT_CMOS_SYS_SERNUM_7		COBT_NVRAM(0x47)
+#define COBT_CMOS_SYS_SERNUM_8		COBT_NVRAM(0x48)
+#define COBT_CMOS_SYS_SERNUM_9		COBT_NVRAM(0x49)
+#define COBT_CMOS_SYS_SERNUM_10		COBT_NVRAM(0x4a)
+#define COBT_CMOS_SYS_SERNUM_11		COBT_NVRAM(0x4b)
+#define COBT_CMOS_SYS_SERNUM_12		COBT_NVRAM(0x4c)
+/* checksum for serial num - 1 byte */
+#define COBT_CMOS_SYS_SERNUM_CSUM	COBT_NVRAM(0x4f)
+
+#define COBT_CMOS_ROM_REV_MAJ		COBT_NVRAM(0x50) /* 0-255 */
+#define COBT_CMOS_ROM_REV_MIN		COBT_NVRAM(0x51) /* 0-255 */
+#define COBT_CMOS_ROM_REV_REV		COBT_NVRAM(0x52) /* 0-255 */
+
+/* ROM language - 2 bytes */
+#define COBT_CMOS_LANGUAGE_0		COBT_NVRAM(0x60)
+#define COBT_CMOS_LANGUAGE_1		COBT_NVRAM(0x61)
+
+/* HA mode we're in (Twin Peaks) */
+#define COBT_CMOS_HA_MODE		COBT_NVRAM(0x62)
+
+
+/* values in our 'magic' NVRAM page */
+#define COBT_CMOS_MP_POWER		0x0 /* all power options are here */
+#define COBT_CMOS_MP_POWER_OFF		0x0
+#define COBT_CMOS_MP_POWER_SAME	0x1
+#define COBT_CMOS_MP_POWER_ON		0x2
+
+/* Aliases for RTC CMOS values since they are not
+ * exported by /dev/nvram
+ */
+#define COBT_CMOS_MP_ALARM_EN		0x1 /* Wake on Alarm Enable */
+#define COBT_CMOS_MP_ALARM_SEC		0x2 /* Wake Seconds */
+#define COBT_CMOS_MP_ALARM_MIN		0x3 /* Wake Minutes */
+#define COBT_CMOS_MP_ALARM_HOUR		0x4 /* Wake Hour */
+
+#endif /* COBALT_NVRAM_H */
diff -ruN dist-2.4.6/include/linux/nvram.h cobalt-2.4.6/include/linux/nvram.h
--- dist-2.4.6/include/linux/nvram.h	Fri Oct 29 10:58:00 1999
+++ cobalt-2.4.6/include/linux/nvram.h	Mon Jul  9 15:43:35 2001
@@ -6,12 +6,20 @@
 /* /dev/nvram ioctls */
 #define NVRAM_INIT		_IO('p', 0x40) /* initialize NVRAM and set checksum */
 #define	NVRAM_SETCKS	_IO('p', 0x41) /* recalculate checksum */
+#define	NVRAM_GETPAGE	_IO('p', 0x42) /* get nvram page */
+#define	NVRAM_SETPAGE	_IO('p', 0x43) /* set nvram page */
+#define	NVRAM_GETNPAGES	_IO('p', 0x44) /* get the number of pages */
+#define	NVRAM_GETSIZE	_IO('p', 0x45) /* get the nvram page size */
+
+#define NVRAM_MAGIC_PAGE	0x10000
 
 #ifdef __KERNEL__
 extern unsigned char nvram_read_byte( int i );
 extern void nvram_write_byte( unsigned char c, int i );
 extern int nvram_check_checksum( void );
 extern void nvram_set_checksum( void );
+extern void nvram_set_page(int newpage);
+extern int nvram_get_page(void);
 #endif
 
 #endif  /* _LINUX_NVRAM_H */

--------------12AD54F61942796801C3862F--

