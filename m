Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261799AbTBOLK6>; Sat, 15 Feb 2003 06:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261527AbTBOLK6>; Sat, 15 Feb 2003 06:10:58 -0500
Received: from mail6.bluewin.ch ([195.186.4.229]:12464 "EHLO mail6.bluewin.ch")
	by vger.kernel.org with ESMTP id <S261701AbTBOLJE>;
	Sat, 15 Feb 2003 06:09:04 -0500
Date: Sat, 15 Feb 2003 12:18:31 +0100
From: Roger Luethi <rl@hellgate.ch>
To: Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>
Subject: [4/4][via-rhine][PATCH] Reset function rewrite
Message-ID: <20030215111831.GA11254@k3.hellgate.ch>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@digeo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="sXc4Kmr5FA7axrvy"
Content-Disposition: inline
In-Reply-To: <20030215111705.GA11127@k3.hellgate.ch>
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.5.60 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sXc4Kmr5FA7axrvy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The new reset function only waits up to 0.1 ms for the reset to complete,
instead of 10 ms. However, it introduces the use of a forced reset flag if
a chip doesn't seem cooperative. This fixes cases where until now only
reloading the driver or even rebooting the machine would bring the chip
back.


--sXc4Kmr5FA7axrvy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="via-rhine-1.16rc-04_reset.diff"

--- 03_duplex/drivers/net/via-rhine.c	Fri Feb 14 19:07:17 2003
+++ 04_reset/drivers/net/via-rhine.c	Fri Feb 14 19:13:04 2003
@@ -523,24 +523,25 @@ static int  via_rhine_close(struct net_d
 static void wait_for_reset(struct net_device *dev, int chip_id, char *name)
 {
 	long ioaddr = dev->base_addr;
-	int i;
 
-	/* VT86C100A may need long delay after reset (dlink) */
-	if (chip_id == VT86C100A)
+	udelay(5);
+
+	if (readw(ioaddr + ChipCmd) & CmdReset) {
+		printk(KERN_INFO "%s: Reset did not complete in 5 us. "
+			"Trying harder.\n", name);
+
+		/* Rhine-II needs to be forced sometimes */
+		if (chip_id == VT6102)
+			writeb(0x40, ioaddr + 0x81);
+
+		/* VT86C100A may need long delay after reset (dlink) */
+		/* Seen on Rhine-II as well (rl) */
 		udelay(100);
+	}
 
-	i = 0;
-	do {
-		udelay(5);
-		i++;
-		if(i > 2000) {
-			printk(KERN_ERR "%s: reset did not complete in 10 ms.\n", name);
-			break;
-		}
-	} while(readw(ioaddr + ChipCmd) & CmdReset);
 	if (debug > 1)
-		printk(KERN_INFO "%s: reset finished after %d microseconds.\n",
-			   name, 5*i);
+		printk(KERN_INFO "%s: Reset %s.\n", name,
+			(readw(ioaddr + ChipCmd) & CmdReset) ? "failed" : "succeeded");
 }
 
 #ifdef USE_MEM

--sXc4Kmr5FA7axrvy--
