Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbTIOWIp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 18:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261662AbTIOWIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 18:08:45 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:62401 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261661AbTIOWIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 18:08:37 -0400
Date: Tue, 16 Sep 2003 00:08:29 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, Scott_Kilau@digi.com
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.0-test5-mm2: dgap driver looks ugly
Message-ID: <20030915220828.GA17690@fs.tum.de>
References: <20030914234843.20cea5b3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030914234843.20cea5b3.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 14, 2003 at 11:48:43PM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.0-test5-mm1:
>...
> +dgap.patch
> 
>  Digi Acceleport driver
>...

This driver seems to need a serious cleanup.

The patch below does:
- remove MIN/MAN
- remove (unused) userspace program/conffile locations
- remove a check that compares an ushort witha value it never has on 
  Linux

There seem to be more cleanups needed, these should only be some 
examples.

cu
Adrian

--- linux-2.6.0-test5-mm2-no-smp/drivers/char/digi/dgap/dgap_driver.h.old	2003-09-15 17:52:47.000000000 +0200
+++ linux-2.6.0-test5-mm2-no-smp/drivers/char/digi/dgap/dgap_driver.h	2003-09-15 23:57:28.000000000 +0200
@@ -215,7 +215,6 @@
 #define MYFLIPLEN		N_TTY_BUF_SIZE
 
 #define SBREAK_TIME 0x25
-#define USHRT_MAX   65535
 #define U2BSIZE 0x400
 #define dgap_jiffies_from_ms(a) (((a) * HZ) / 1000)
 
@@ -231,10 +230,6 @@
 # define DIGI_DGAP_MAJOR         22
 #endif
 
-/* The default location of the config script. */
-#define DGAP_CONFIG_PROGRAM	"/usr/sbin/dgap_config"
-#define DGAP_CONFIG_FILE	"/etc/dgap.conf"
-
 /*
  * The parameters we use to define the periods of the moving averages.
  */
@@ -274,20 +269,6 @@
 #endif
 
 /*
- * Only define these in case they are not present in the kernel headers.
- * A grep of /usr/src/linux-<version>/include/linux
- * show others worry about this as well.
- */
-#if !defined(MIN)
-# define MIN(a,b)	((a) < (b) ? (a) : (b))
-#endif
-
-#if !defined(MAX)
-# define MAX(a,b)	((a) > (b) ? (a) : (b))
-#endif
-
-
-/*
  * All the possible states the driver can be while being loaded.
  */
 enum {
--- linux-2.6.0-test5-mm2-no-smp/drivers/char/digi/dgap/dgap_tty.c.old	2003-09-15 23:47:21.000000000 +0200
+++ linux-2.6.0-test5-mm2-no-smp/drivers/char/digi/dgap/dgap_tty.c	2003-09-15 23:50:54.000000000 +0200
@@ -1278,8 +1278,8 @@
 		flip_len = TTY_FLIPBUF_SIZE - tp->flip.count;
 	}
 
-	len = MIN(data_len, flip_len);
-	len = MIN(len, (N_TTY_BUF_SIZE - 1) - tp->read_cnt);
+	len = min(data_len, flip_len);
+	len = min(len, (N_TTY_BUF_SIZE - 1) - tp->read_cnt);
 
 	if (len <= 0) {
 		writeb(1, &(bs->idata));
@@ -1315,7 +1315,7 @@
 	while (n) {
 
 		s = ((head >= tail) ? head : ch->ch_rsize) - tail;
-		s = MIN(s, n);
+		s = min(s, n);
 
 		if (s <= 0)
 			break;
@@ -2513,7 +2513,7 @@
 			cps_limit = 0;
 		}
 
-		bytes_available = MIN(cps_limit, bytes_available);
+		bytes_available = min(cps_limit, bytes_available);
 	}
 
 	return (bytes_available);
@@ -2705,7 +2705,7 @@
 	 * Take minimum of what the user wants to send, and the
 	 * space available in the FEP buffer.
 	 */
-	count = MIN(count, bufcount);
+	count = min(count, bufcount);
 
 	/*
 	 * Bail if no space left.
@@ -2743,7 +2743,7 @@
 			goto out;
 		}
 
-		count = MIN(count, WRITEBUFLEN);
+		count = min(count, WRITEBUFLEN);
 
 		/*
 		 * copy_from_user() returns the number
@@ -3230,9 +3230,6 @@
 	if (ch->ch_digi.digi_bufsize < 10)
 		ch->ch_digi.digi_bufsize = 10;
 
-	if (ch->ch_digi.digi_bufsize > 100000)
-		ch->ch_digi.digi_bufsize = MIN(100000, USHRT_MAX);
-
 	if (ch->ch_digi.digi_maxchar < 1)
 		ch->ch_digi.digi_maxchar = 1;
 
