Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S155643AbQESWWo>; Fri, 19 May 2000 18:22:44 -0400
Received: by vger.rutgers.edu id <S155591AbQESWW0>; Fri, 19 May 2000 18:22:26 -0400
Received: from itaipu.nitnet.com.br ([200.255.111.241]:4193 "HELO itaipu.nitnet.com.br") by vger.rutgers.edu with SMTP id <S155581AbQESWUa>; Fri, 19 May 2000 18:20:30 -0400
Date: Fri, 19 May 2000 19:00:03 -0300
To: linux-kernel@vger.rutgers.edu
Subject: [PATCH] nvram.c fixes
Message-ID: <20000519190003.A800@cesarb.personal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
From: Cesar Eduardo Barros <cesarb@nitnet.com.br>
Sender: owner-linux-kernel@vger.rutgers.edu


This patch fixes the following issues in nvram.c:

1. Everything in nvram.c would race with rtc.c (and maybe other code) in other
   CPU (SMP) called from userspace (like rtc_ioctl)
2. nvram_read and nvram_write didn't return -EFAULT when they should

To fix the second issue I had to move the copy from/to userspace to outside the
critical region.

This patch doesn't fix the following issues:

1. nvram_{{read,write}_byte,{check,set}_checksum} are atomic, but they are
   probably used in a batch of three or four operations, and the whole batch
   should be atomic wrt other rtc operations (rtc_lock). This issue is worse
   if nvram_write is used and someone tries to read with nvram_read (the
   checksum is bad until nvram_set_checksum is used).
2. nvram_{{read,write}_byte,{check,set}_checksum} and a _nolock version of them
   all should be moved to a header file somewhere. They're trivially inlined
   and are very small.
3. Having every file in the whole kernel which uses rtc_lock define it as an
   extern is silly. It should be placed in a header somewhere.
4. The indentation is awful in some parts of nvram.c.

This has not been tested or even compiled, and something is probably wrong.
Comments?


diff -Naur linux-2.3.99-pre9-2/drivers/char/nvram.c linux-2.3.99-pre9-2+nvramfix/drivers/char/nvram.c
--- linux-2.3.99-pre9-2/drivers/char/nvram.c	Mon May 15 20:30:45 2000
+++ linux-2.3.99-pre9-2+nvramfix/drivers/char/nvram.c	Fri May 19 18:37:40 2000
@@ -81,7 +81,7 @@
 #endif
 
 /* Note that *all* calls to CMOS_READ and CMOS_WRITE must be done with
- * interrupts disabled. Due to the index-port/data-port design of the RTC, we
+ * rtc_lock held. Due to the index-port/data-port design of the RTC, we
  * don't want two different things trying to get to it at once. (e.g. the
  * periodic 11 min sync from time.c vs. this driver.)
  */
@@ -96,11 +96,13 @@
 #include <linux/nvram.h>
 #include <linux/init.h>
 #include <linux/proc_fs.h>
+#include <linux/spinlock.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
 
+extern spinlock_t rtc_lock;
 
 static int nvram_open_cnt = 0;	/* #times opened */
 static int nvram_open_mode;		/* special open modes */
@@ -163,21 +165,20 @@
 	unsigned long flags;
 	unsigned char c;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave (&rtc_lock, flags);
 	c = nvram_read_int( i );
-	restore_flags(flags);
+	spin_unlock_irqrestore (&rtc_lock, flags);
 	return( c );
 }
 
+/* This races nicely with trying to read with checksum checking (nvram_read) */
 void nvram_write_byte( unsigned char c, int i )
 {
 	unsigned long flags;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave (&rtc_lock, flags);
 	nvram_write_int( c, i );
-	restore_flags(flags);
+	spin_unlock_irqrestore (&rtc_lock, flags);
 }
 
 int nvram_check_checksum( void )
@@ -185,10 +186,9 @@
 	unsigned long flags;
 	int rv;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave (&rtc_lock, flags);
 	rv = nvram_check_checksum_int();
-	restore_flags(flags);
+	spin_unlock_irqrestore (&rtc_lock, flags);
 	return( rv );
 }
 
@@ -196,10 +196,9 @@
 {
 	unsigned long flags;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave (&rtc_lock, flags);
 	nvram_set_checksum_int();
-	restore_flags(flags);
+	spin_unlock_irqrestore (&rtc_lock, flags);
 }
 
 #endif /* MACH == ATARI */
@@ -228,63 +227,67 @@
 static ssize_t nvram_read(struct file * file,
 	char * buf, size_t count, loff_t *ppos )
 {
-	unsigned long flags;
+	char * contents [NVRAM_BYTES];
 	unsigned i = *ppos;
-	char *tmp = buf;
-	
-	if (i != *ppos)
-		return -EINVAL;
+	char *tmp;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irq (&rtc_lock);
 	
-	if (!nvram_check_checksum_int()) {
-		restore_flags(flags);
-		return( -EIO );
-	}
+	if (!nvram_check_checksum_int())
+		goto checksum_err;
+
+	for (tmp = contents; count-- > 0 && i < NVRAM_BYTES; ++i, ++tmp)
+		*tmp = nvram_read_int(i);
+
+	spin_unlock_irq (&rtc_lock);
+
+	copy_to_user_ret (buf, contents, tmp - contents, -EFAULT);
 
-	for( ; count-- > 0 && i < NVRAM_BYTES; ++i, ++tmp )
-		put_user( nvram_read_int(i), tmp );
 	*ppos = i;
 
-	restore_flags(flags);
-	return( tmp - buf );
+	return (tmp - contents);
+
+checksum_err:
+	spin_unlock_irq (&rtc_lock);
+	return -EIO;
 }
 
 static ssize_t nvram_write(struct file * file,
 		const char * buf, size_t count, loff_t *ppos )
 {
-	unsigned long flags;
+	char * contents [NVRAM_BYTES];
 	unsigned i = *ppos;
-	const char *tmp = buf;
 	char c;
-	
-	if (i != *ppos)
-		return -EINVAL;
 
-	save_flags(flags);
-	cli();
-	
-	if (!nvram_check_checksum_int()) {
-		restore_flags(flags);
-		return( -EIO );
-	}
+	/* could comebody please help me indent this better? */
+	copy_from_user_ret (contents, buf, (NVRAM_BYTES - i) < count ?
+						(NVRAM_BYTES - i) : count,
+				-EFAULT);
+
+	spin_lock_irq (&rtc_lock);
+
+	if (!nvram_check_checksum_int())
+		goto checksum_err;
+
+	for (tmp = contents; count-- > 0 && i < NVRAM_BYTES; ++i, ++tmp)
+		nvram_write_int (*tmp, i);
 
-	for( ; count-- > 0 && i < NVRAM_BYTES; ++i, ++tmp ) {
-		get_user( c, tmp );
-		nvram_write_int( c, i );
-	}
 	nvram_set_checksum_int();
+
+	spin_unlock_irq (&rtc_lock);
+
 	*ppos = i;
 
-	restore_flags(flags);
-	return( tmp - buf );
+	return (tmp - contents);
+
+checksum_err:
+	spin_unlock_irq (&rtc_lock);
+	return -EIO;
 }
 
 static int nvram_ioctl( struct inode *inode, struct file *file,
 						unsigned int cmd, unsigned long arg )
 {
-	unsigned long flags;
 	int i;
 	
 	switch( cmd ) {
@@ -293,14 +296,13 @@
 		if (!capable(CAP_SYS_ADMIN))
 			return( -EACCES );
 
-		save_flags(flags);
-		cli();
+		spin_lock_irq (&rtc_lock);
 
 		for( i = 0; i < NVRAM_BYTES; ++i )
 			nvram_write_int( 0, i );
 		nvram_set_checksum_int();
 		
-		restore_flags(flags);
+		spin_unlock_irq (&rtc_lock);
 		return( 0 );
 	  
 	  case NVRAM_SETCKS:		/* just set checksum, contents unchanged
@@ -309,10 +311,9 @@
 		if (!capable(CAP_SYS_ADMIN))
 			return( -EACCES );
 
-		save_flags(flags);
-		cli();
+		spin_lock_irq (&rtc_lock);
 		nvram_set_checksum_int();
-		restore_flags(flags);
+		spin_unlock_irq (&rtc_lock);
 		return( 0 );
 
 	  default:
@@ -357,16 +358,14 @@
 static int nvram_read_proc( char *buffer, char **start, off_t offset,
 							int size, int *eof, void *data )
 {
-	unsigned long flags;
 	unsigned char contents[NVRAM_BYTES];
     int i, len = 0;
     off_t begin = 0;
-	
-	save_flags(flags);
-	cli();
+
+	spin_lock_irq (&rtc_lock);
 	for( i = 0; i < NVRAM_BYTES; ++i )
 		contents[i] = nvram_read_int( i );
-	restore_flags(flags);
+	spin_unlock_irq (&rtc_lock);
 	
 	*eof = mach_proc_infos( contents, buffer, &len, &begin, offset, size );
 
@@ -476,15 +475,13 @@
 static int pc_proc_infos( unsigned char *nvram, char *buffer, int *len,
 						  off_t *begin, off_t offset, int size )
 {
-	unsigned long flags;
 	int checksum;
 	int type;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irq (&rtc_lock);
 	checksum = nvram_check_checksum_int();
-	restore_flags(flags);
-	
+	spin_unlock_irq (&rtc_lock);
+
 	PRINT_PROC( "Checksum status: %svalid\n", checksum ? "" : "not " );
 
 	PRINT_PROC( "# floppies     : %d\n",

-- 
Cesar Eduardo Barros
cesarb@nitnet.com.br
cesarb@dcc.ufrj.br

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
