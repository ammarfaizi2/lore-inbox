Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264711AbTB0LfR>; Thu, 27 Feb 2003 06:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264729AbTB0LfQ>; Thu, 27 Feb 2003 06:35:16 -0500
Received: from mail3.bluewin.ch ([195.186.1.75]:25797 "EHLO mail3.bluewin.ch")
	by vger.kernel.org with ESMTP id <S264711AbTB0LfM>;
	Thu, 27 Feb 2003 06:35:12 -0500
Date: Thu, 27 Feb 2003 12:45:04 +0100
From: Roger Luethi <rl@hellgate.ch>
To: Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>,
       Rogier Wolff <R.E.Wolff@BitWizard.nl>
Subject: [1/2][via-rhine][PATCH] reset logic
Message-ID: <20030227114504.GA4087@k3.hellgate.ch>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@digeo.com>, Rogier Wolff <R.E.Wolff@BitWizard.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline
In-Reply-To: <20030227114417.GA3970@k3.hellgate.ch>
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.5.63 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Since Linus and Jeff raised the issue of PCI posted writes, I cleaned up
wait_for_reset() some more. Experiments show that with MMIO, a reset may
indeed take seemingly longer -- that is fixed by flushing that buffer.

Also, the driver now polls the appropriate register while waiting for the
reset to finish.


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="via-rhine-1.17rc-01_reset.diff"

--- 06_2.5.62/drivers/net/via-rhine.c	Thu Feb 20 18:20:56 2003
+++ 07_reset/drivers/net/via-rhine.c	Sat Feb 22 01:18:26 2003
@@ -368,6 +368,8 @@ enum chip_capability_flags {
 #else
 #define RHINE_IOTYPE (PCI_USES_IO  | PCI_USES_MASTER | PCI_ADDR0)
 #endif
+/* Beware of PCI posted writes */
+#define IOSYNC	do { readb(dev->base_addr + StationAddr); } while (0)
 
 /* directly indexed by enum via_rhine_chips, above */
 static struct via_rhine_chip_info via_rhine_chip_info[] __devinitdata =
@@ -530,11 +532,12 @@ static int  via_rhine_close(struct net_d
 static void wait_for_reset(struct net_device *dev, int chip_id, char *name)
 {
 	long ioaddr = dev->base_addr;
+	int boguscnt = 20;
 
-	udelay(5);
+	IOSYNC;
 
 	if (readw(ioaddr + ChipCmd) & CmdReset) {
-		printk(KERN_INFO "%s: Reset did not complete in 5 us. "
+		printk(KERN_INFO "%s: Reset not complete yet. "
 			"Trying harder.\n", name);
 
 		/* Rhine-II needs to be forced sometimes */
@@ -543,12 +546,14 @@ static void wait_for_reset(struct net_de
 
 		/* VT86C100A may need long delay after reset (dlink) */
 		/* Seen on Rhine-II as well (rl) */
-		udelay(100);
+		while ((readw(ioaddr + ChipCmd) & CmdReset) && --boguscnt);
+			udelay(5);
+
 	}
 
 	if (debug > 1)
 		printk(KERN_INFO "%s: Reset %s.\n", name,
-			(readw(ioaddr + ChipCmd) & CmdReset) ? "failed" : "succeeded");
+			boguscnt ? "succeeded" : "failed");
 }
 
 #ifdef USE_MEM

--5mCyUwZo2JvN/JJP--
