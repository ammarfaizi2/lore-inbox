Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280364AbRKFUFX>; Tue, 6 Nov 2001 15:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280417AbRKFUFN>; Tue, 6 Nov 2001 15:05:13 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:8720 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S280364AbRKFUFB>; Tue, 6 Nov 2001 15:05:01 -0500
Date: Tue, 6 Nov 2001 21:04:51 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: <Philip.Blundell@pobox.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>,
        Andreas Dilger <adilger@turbolabs.com>
Subject: [PATCH] lp.c, eexpress.c jiffies cleanup
Message-ID: <Pine.LNX.4.30.0111062039440.23693-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Philip, Linus, Alan,

one more jiffies cleanup patch to use comparison macros as pointed out by
Andreas Dilger on lkml.
I try to bundle files with the same maintainer to reduce email overhead.
If my procedure of mailing the maintainer as well as Cc:ing Linus and Alan
is incorrect, please drop me a short note.

In eexpress.c I also turned absolute jiffies number into multiples of HZ,
yet the resulting timeout values still do not always seem reasonable to
me.

Tim

--- ../linux-2.4.14-pre6/drivers/char/lp.c	Wed Oct 31 23:06:19 2001
+++ drivers/char/lp.c	Tue Nov  6 20:37:30 2001
@@ -302,7 +302,7 @@
 	size_t copy_size = count;

 #ifdef LP_STATS
-	if (jiffies-lp_table[minor].lastcall > LP_TIME(minor))
+	if (time_after(jiffies, lp_table[minor].lastcall + LP_TIME(minor)))
 		lp_table[minor].runchars = 0;

 	lp_table[minor].lastcall = jiffies;
--- ../linux-2.4.14-pre6/drivers/net/eexpress.c	Sun Sep 30 21:26:06 2001
+++ drivers/net/eexpress.c	Tue Nov  6 20:52:59 2001
@@ -504,7 +504,7 @@

 	if (lp->started)
 	{
-		if ((jiffies - dev->trans_start)>50)
+		if (time_after(jiffies, dev->trans_start + HZ/2))
 		{
 			if (lp->tx_link==lp->last_tx_restart)
 			{
@@ -560,7 +560,7 @@
 	}
 	else
 	{
-		if ((jiffies-lp->init_time)>10)
+		if (time_after(jiffies, lp->init_time + HZ/10))
 		{
 			unsigned short status = scb_status(dev);
 			printk(KERN_WARNING "%s: i82586 startup timed out, status %04x, resetting...\n",
@@ -725,8 +725,8 @@

 static void eexp_cmd_clear(struct net_device *dev)
 {
-	unsigned long int oldtime = jiffies;
-	while (scb_rdcmd(dev) && ((jiffies-oldtime)<10));
+	unsigned long timeout = jiffies + HZ/10;
+	while (scb_rdcmd(dev) && (time_before(jiffies, timeout)));
 	if (scb_rdcmd(dev)) {
 		printk("%s: command didn't clear\n", dev->name);
 	}
@@ -1598,16 +1598,16 @@
                 }
         }
         if (kick) {
-                unsigned long oj;
+                unsigned long timeout;
                 scb_command(dev, SCB_CUsuspend);
                 outb(0, ioaddr+SIGNAL_CA);
                 outb(0, ioaddr+SIGNAL_CA);
 #if 0
                 printk("%s: waiting for CU to go suspended\n", dev->name);
 #endif
-                oj = jiffies;
+                timeout = jiffies + 20*HZ;
                 while ((SCB_CUstat(scb_status(dev)) == 2) &&
-                       ((jiffies-oj) < 2000));
+                       time_before(jiffies, timeout));
 		if (SCB_CUstat(scb_status(dev)) == 2)
 			printk("%s: warning, CU didn't stop\n", dev->name);
                 lp->started &= ~(STARTED_CU);


