Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317881AbSGZRt1>; Fri, 26 Jul 2002 13:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317887AbSGZRt1>; Fri, 26 Jul 2002 13:49:27 -0400
Received: from harrier.cohaesio.com ([212.97.128.50]:16912 "EHLO
	harrier.cohaesio.com") by vger.kernel.org with ESMTP
	id <S317881AbSGZRt0>; Fri, 26 Jul 2002 13:49:26 -0400
From: "Anders K. Pedersen" <akp@cohaesio.com>
Subject: sbc60xxwdt watchdog driver problems
Date: Fri, 26 Jul 2002 19:52:40 +0200
Organization: Cohaesio A/S
Message-ID: <3D418C68.CF823A45@cohaesio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Trace: harrier.cohaesio.com 1027705960 23559 212.97.128.160 (26 Jul 2002 17:52:40 GMT)
X-Complaints-To: newsmaster@news.cohaesio.com
X-Accept-Language: en
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have some problems with the sbc60xxwdt watchdog driver in current
stable kernels. The primary problem is that the driver can't
request_region(WDT_STOP, 1, ...) because this port (0x45) is in a region
reserved for the timer (0x40-0x5f). As a temporary workaround, I have
commented the request_region() and release_region() for this port out,
which lets the driver function properly, but this probably isn't the
correct solution?

A minor issue is that doing an "echo foobar >/dev/watchdog" logs, that
the watchdog has been started, but this isn't actually the case, as the
/dev/watchdog device is closed before the driver writes to the WDT_START
port. This is fixed by the patch below.

Another minor issue, is that the fop_write call always returns, that
exactly 1 byte (if any) has been written, even though all 'count' bytes
in the buffer are handled at once. This is also fixed by the patch
below.

The patch is against 2.4.19-rc1, but there hasn't been any changes to
the driver from 2.4.18 to 2.4.19-rc3, so it should apply to all of
these. Any comments?


--- drivers/char/sbc60xxwdt.c.orig	Tue Jul 16 15:54:42 2002
+++ drivers/char/sbc60xxwdt.c	Fri Jul 26 19:29:35 2002
@@ -138,7 +138,9 @@
 {
 	next_heartbeat = jiffies + WDT_HEARTBEAT;
 
-	/* Start the timer */
+	/* Start the watchdog ... */
+	inb_p(WDT_START);
+	/* ... and the timer */
 	timer.expires = jiffies + WDT_INTERVAL;	
 	add_timer(&timer);
 	printk(OUR_NAME ": Watchdog timer is now enabled.\n");  
@@ -168,10 +170,6 @@
 	{
 		size_t ofs;
 
-		/* note: just in case someone wrote the magic character
-		 * five months ago... */
-		wdt_expect_close = 0;
-
 		/* now scan */
 		for(ofs = 0; ofs != count; ofs++) 
 		{
@@ -180,10 +178,12 @@
 				return -EFAULT;
 			if(c == 'V')
 				wdt_expect_close = 1;
+			else
+				wdt_expect_close = 0;
 		}
 		/* Well, anyhow someone wrote to us, we should return that favour */
 		next_heartbeat = jiffies + WDT_HEARTBEAT;
-		return 1;
+		return count;
 	}
 	return 0;
 }
@@ -300,15 +300,15 @@
 
 	unregister_reboot_notifier(&wdt_notifier);
 	release_region(WDT_START,1);
-	release_region(WDT_STOP,1);
+	//release_region(WDT_STOP,1);
 }
 
 static int __init sbc60xxwdt_init(void)
 {
 	int rc = -EBUSY;
 
-	if (!request_region(WDT_STOP, 1, "SBC 60XX WDT"))
-		goto err_out;
+	//if (!request_region(WDT_STOP, 1, "SBC 60XX WDT"))
+	//	goto err_out;
 	if (!request_region(WDT_START, 1, "SBC 60XX WDT"))
 		goto err_out_region1;
 
@@ -333,7 +333,7 @@
 err_out_region2:
 	release_region(WDT_START,1);
 err_out_region1:
-	release_region(WDT_STOP,1);
+	//release_region(WDT_STOP,1);
 err_out:
 	return rc;
 }


Regards,
Anders K. Pedersen
