Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287886AbSAHFJT>; Tue, 8 Jan 2002 00:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287885AbSAHFJK>; Tue, 8 Jan 2002 00:09:10 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:30225 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S287648AbSAHFJA>; Tue, 8 Jan 2002 00:09:00 -0500
Message-ID: <3C3A7DA7.381D033D@zip.com.au>
Date: Mon, 07 Jan 2002 21:03:35 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: Ivan Passos <ivan@cyclades.com>, linux-kernel@vger.kernel.org
Subject: Re: Serial Driver Name Question (kernels 2.4.x)
In-Reply-To: <3C38BC19.72ECE86@zip.com.au>,
		<3C34024A.EDA31D24@zip.com.au>
		<3C33E0D3.B6E932D6@zip.com.au>
		<3C33BCF3.20BE9E92@cyclades.com>
		<200201030637.g036bxe03425@vindaloo.ras.ucalgary.ca>
		<200201062012.g06KCIu16158@vindaloo.ras.ucalgary.ca>
		<3C38BC19.72ECE86@zip.com.au> <200201070636.g076asR25565@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ tty driver name breakage ]

Richard, can we please get this wrapped up?

My preferred approach is to change the driver naming scheme
so that we don't have to put printf control-strings everywhere.
We can remove a number of ifdefs that way.

So for serial.c:

--- linux-2.4.18-pre2/drivers/char/tty_io.c	Mon Jan  7 16:48:02 2002
+++ linux-akpm/drivers/char/tty_io.c	Mon Jan  7 20:56:38 2002
@@ -193,10 +193,13 @@ _tty_make_name(struct tty_struct *tty, c
 
 	if (!tty) /* Hmm.  NULL pointer.  That's fun. */
 		strcpy(buf, "NULL tty");
-	else
-		sprintf(buf, name,
-			idx + tty->driver.name_base);
-		
+	else {
+#ifdef CONFIG_DEVFS_FS
+		sprintf(buf, "%s/%d", name, idx + tty->driver.name_base);
+#else
+		sprintf(buf, "%s%d", name, idx + tty->driver.name_base);
+#endif
+	}		
 	return buf;
 }
 
--- linux-2.4.18-pre2/drivers/char/serial.c	Mon Jan  7 16:48:02 2002
+++ linux-akpm/drivers/char/serial.c	Mon Jan  7 20:58:09 2002
@@ -5387,7 +5387,7 @@ static int __init rs_init(void)
 	serial_driver.driver_name = "serial";
 #endif
 #if (LINUX_VERSION_CODE > 0x2032D && defined(CONFIG_DEVFS_FS))
-	serial_driver.name = "tts/%d";
+	serial_driver.name = "tts";
 #else
 	serial_driver.name = "ttyS";
 #endif
