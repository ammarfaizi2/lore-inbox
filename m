Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132439AbRDNPtW>; Sat, 14 Apr 2001 11:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132462AbRDNPtM>; Sat, 14 Apr 2001 11:49:12 -0400
Received: from p3EE224A7.dip.t-dialin.net ([62.226.36.167]:29701 "HELO
	dragon.flyn.org") by vger.kernel.org with SMTP id <S132439AbRDNPsw>;
	Sat, 14 Apr 2001 11:48:52 -0400
Date: Thu, 12 Apr 2001 16:46:53 -0400
From: "W. Michael Petullo" <mike@flyn.org>
To: gniibe@mri.co.jp, linux-kernel@vger.kernel.org
Subject: patch for PLIP and slow, interrupt-less computers
Message-ID: <20010412164653.A10864@dragon.flyn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux dragon.flyn.org 2.4.3-pre7 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have written a quick patch for the PLIP driver contained in the 2.4.3
version of the Linux kernel.  This patch allows one to use PLIP with
computers which have an interrupt-less parallel port and a slow processor.
The stock PLIP driver constantly times out on my 80486-based laptop.
This patch adds the ability to specify two key values, trigger_wait and
nibble_wait, when loading the PLIP driver.

Using this patch and adding the following entry to the modules.conf file
on the computers on either side of my PLIP link makes the connection
work nicely:

# Because my laptop is so slow.
options plip                    trigger_wait=50000 nibble_wait=300000

Here is the patch:

================================================================================

--- plip.c	Tue Feb 13 16:15:05 2001
+++ /tmp/linux/drivers/net/plip.c	Thu Apr 12 16:07:07 2001
@@ -137,10 +137,10 @@
 #define PLIP_DELAY_UNIT		   1
 
 /* Connection time out = PLIP_TRIGGER_WAIT * PLIP_DELAY_UNIT usec */
-#define PLIP_TRIGGER_WAIT	 500
+static unsigned long trigger_wait = 500;
 
 /* Nibble time out = PLIP_NIBBLE_WAIT * PLIP_DELAY_UNIT usec */
-#define PLIP_NIBBLE_WAIT        3000
+static unsigned long nibble_wait = 3000;
 
 /* Bottom halves */
 static void plip_kick_bh(struct net_device *dev);
@@ -345,8 +345,8 @@
 	nl->port_owner = 0;
 
 	/* Initialize constants */
-	nl->trigger	= PLIP_TRIGGER_WAIT;
-	nl->nibble	= PLIP_NIBBLE_WAIT;
+	nl->trigger	= trigger_wait;
+	nl->nibble	= nibble_wait;
 
 	/* Initialize task queue structures */
 	INIT_LIST_HEAD(&nl->immediate.list);
@@ -1297,6 +1297,8 @@
 
 MODULE_PARM(parport, "1-" __MODULE_STRING(PLIP_MAX) "i");
 MODULE_PARM(timid, "1i");
+MODULE_PARM(trigger_wait, "i");
+MODULE_PARM(nibble_wait, "i");
 
 static struct net_device *dev_plip[PLIP_MAX] = { NULL, };

================================================================================
 
-- 
W. Michael Petullo

:wq
