Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129555AbQKAKAF>; Wed, 1 Nov 2000 05:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129552AbQKAJ7z>; Wed, 1 Nov 2000 04:59:55 -0500
Received: from smtp1.mail.yahoo.com ([128.11.69.60]:17420 "HELO
	smtp1.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129355AbQKAJ7m>; Wed, 1 Nov 2000 04:59:42 -0500
X-Apparently-From: <p?gortmaker@yahoo.com>
Message-ID: <39FFE80A.5F1072D4@yahoo.com>
Date: Wed, 01 Nov 2000 04:53:14 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
X-Mailer: Mozilla 3.04 (X11; I; Linux 2.2.17 i486)
MIME-Version: 1.0
To: Miquel van Smoorenburg <miquels@cistron.nl>
CC: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: Linux 2.2.18pre18 [rtc_lock]
In-Reply-To: <E13peHk-0005ep-00@the-village.bc.nu> <8th8sk$9rs$1@enterprise.cistron.net>
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miquel van Smoorenburg wrote:
> 
> In article <E13peHk-0005ep-00@the-village.bc.nu>,
> Alan Cox  <alan@lxorguk.ukuu.org.uk> wrote:
> >2.2.18pre18
> >o      Fix rtc_lock for ide-probe, and hd.c            (Richard Johnson)
> 
> I need this to get it to compile:

[include <linux/mc146818rtc.h> to get the extern spinlock decl.]

I just looked at pre18 and there are 2 other cases where the rtc lock
should be deployed - those being in the floppy driver, and in the nvram
driver.

As an added bonus you get a fixed nvram driver that no longer does
get/put_user from within a cli() region.

Paul.

--- include/asm-i386/floppy.h.orig	Wed Jul  1 03:28:48 1998
+++ include/asm-i386/floppy.h	Wed Nov  1 04:01:18 2000
@@ -285,8 +285,23 @@
 static int FDC1 = 0x3f0;
 static int FDC2 = -1;
 
-#define FLOPPY0_TYPE	((CMOS_READ(0x10) >> 4) & 15)
-#define FLOPPY1_TYPE	(CMOS_READ(0x10) & 15)
+#define FLOPPY0_TYPE	({				\
+	unsigned long flags;				\
+	unsigned char val;				\
+	spin_lock_irqsave(&rtc_lock, flags);		\
+	val = (CMOS_READ(0x10) >> 4) & 15;		\
+	spin_unlock_irqrestore(&rtc_lock, flags);	\
+	val;						\
+})
+
+#define FLOPPY1_TYPE	({				\
+	unsigned long flags;				\
+	unsigned char val;				\
+	spin_lock_irqsave(&rtc_lock, flags);		\
+	val = CMOS_READ(0x10) & 15;			\
+	spin_unlock_irqrestore(&rtc_lock, flags);	\
+	val;						\
+})
 
 #define N_FDC 2
 #define N_DRIVE 8
--- drivers/char/nvram.c.orig	Wed Jun 28 13:35:50 2000
+++ drivers/char/nvram.c	Wed Nov  1 04:04:36 2000
@@ -25,9 +25,10 @@
  * the kernel and is not a module. Since the functions are used by some Atari
  * drivers, this is the case on the Atari.
  *
+ * 1.0a		Paul Gortmaker: use rtc_lock, fix get/put_user in cli bugs.
  */
 
-#define NVRAM_VERSION		"1.0"
+#define NVRAM_VERSION		"1.0a"
 
 #include <linux/module.h>
 #include <linux/config.h>
@@ -78,10 +79,12 @@
 #define	mach_set_checksum	atari_set_checksum
 #define	mach_proc_infos		atari_proc_infos
 
+static spinlock_t rtc_lock;	/* optimized away; no SMP m68K */
+
 #endif
 
 /* Note that *all* calls to CMOS_READ and CMOS_WRITE must be done with
- * interrupts disabled. Due to the index-port/data-port design of the RTC, we
+ * rtc_lock held. Due to the index-port/data-port design of the RTC, we
  * don't want two different things trying to get to it at once. (e.g. the
  * periodic 11 min sync from time.c vs. this driver.)
  */
@@ -233,23 +236,28 @@
 	unsigned long flags;
 	unsigned i = *ppos;
 	char *tmp = buf;
+	int checksum;
 	
 	if (i != *ppos)
 		return -EINVAL;
 
-	save_flags(flags);
-	cli();
-	
-	if (!nvram_check_checksum_int()) {
-		restore_flags(flags);
+	spin_lock_irqsave(&rtc_lock, flags);
+	checksum = nvram_check_checksum_int();
+	spin_unlock_irqrestore(&rtc_lock, flags);
+
+	if (!checksum)
 		return( -EIO );
-	}
 
 	for( ; count-- > 0 && i < NVRAM_BYTES; ++i, ++tmp )
-		put_user( nvram_read_int(i), tmp );
+	{
+		int val;
+		spin_lock_irqsave(&rtc_lock, flags);
+		val = nvram_read_int(i);
+		spin_unlock_irqrestore(&rtc_lock, flags);
+		put_user( val, tmp );
+	}
 	*ppos = i;
 
-	restore_flags(flags);
 	return( tmp - buf );
 }
 
@@ -260,26 +268,31 @@
 	unsigned i = *ppos;
 	const char *tmp = buf;
 	char c;
+	int checksum;
 	
 	if (i != *ppos)
 		return -EINVAL;
 
-	save_flags(flags);
-	cli();
-	
-	if (!nvram_check_checksum_int()) {
-		restore_flags(flags);
+	spin_lock_irqsave(&rtc_lock, flags);
+	checksum = nvram_check_checksum_int();
+	spin_unlock_irqrestore(&rtc_lock, flags);
+
+	if (!checksum)
 		return( -EIO );
-	}
 
 	for( ; count-- > 0 && i < NVRAM_BYTES; ++i, ++tmp ) {
 		get_user( c, tmp );
+		spin_lock_irqsave(&rtc_lock, flags);
 		nvram_write_int( c, i );
+		spin_unlock_irqrestore(&rtc_lock, flags);
 	}
+
+	spin_lock_irqsave(&rtc_lock, flags);
 	nvram_set_checksum_int();
+	spin_unlock_irqrestore(&rtc_lock, flags);
+
 	*ppos = i;
 
-	restore_flags(flags);
 	return( tmp - buf );
 }
 
@@ -295,14 +308,13 @@
 		if (!capable(CAP_SYS_ADMIN))
 			return( -EACCES );
 
-		save_flags(flags);
-		cli();
+		spin_lock_irqsave(&rtc_lock, flags);
 
 		for( i = 0; i < NVRAM_BYTES; ++i )
 			nvram_write_int( 0, i );
 		nvram_set_checksum_int();
 		
-		restore_flags(flags);
+		spin_unlock_irqrestore(&rtc_lock, flags);
 		return( 0 );
 	  
 	  case NVRAM_SETCKS:		/* just set checksum, contents unchanged
@@ -311,10 +323,9 @@
 		if (!capable(CAP_SYS_ADMIN))
 			return( -EACCES );
 
-		save_flags(flags);
-		cli();
+		spin_lock_irqsave(&rtc_lock, flags);
 		nvram_set_checksum_int();
-		restore_flags(flags);
+		spin_unlock_irqrestore(&rtc_lock, flags);
 		return( 0 );
 
 	  default:
@@ -363,11 +374,10 @@
     int i, len = 0;
     off_t begin = 0;
 	
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&rtc_lock, flags);
 	for( i = 0; i < NVRAM_BYTES; ++i )
 		contents[i] = nvram_read_int( i );
-	restore_flags(flags);
+	spin_unlock_irqrestore(&rtc_lock, flags);
 	
 	*eof = mach_proc_infos( contents, buffer, &len, &begin, offset, size );
 




_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
