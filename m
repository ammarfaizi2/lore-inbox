Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132240AbRCVXZ3>; Thu, 22 Mar 2001 18:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132243AbRCVXZT>; Thu, 22 Mar 2001 18:25:19 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:23292 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S132240AbRCVXZM>;
	Thu, 22 Mar 2001 18:25:12 -0500
Date: Thu, 22 Mar 2001 15:23:16 -0800
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Andy Chou <acc@cs.stanford.edu>
Subject: Re : 16 potential locking bugs in 2.4.1 (wavelan patch attached)
Message-ID: <20010322152316.A13162@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Andy Chou :
> Here are some more results from the MC project. These are 16 errors found 
> in 2.4.1 related to inconsistent use of locks. As usual, if you can 
> verify any of these or show that they are false positives, please let us 
> know by CC'ing mc@cs.stanford.edu. 
> 
> -Andy Chou 
>
> -----------------------------------------------------------------------------
> 
> [BUG] error condition 
> /u2/acc/oses/linux/2.4.1/drivers/net/pcmcia/wavelan_cs.c:2561:wavelan_get_wireless_stats:
> ERROR:LOCK:2528:2561: Inconsistent 
> lock using `spin_lock':2528 
> 
> static iw_stats * 
> wavelan_get_wireless_stats(device * dev) 
> { 
>   ... 
> --> Lock 
>   spin_lock_irqsave (&lp->lock, flags); 
> 
>   if(lp == (net_local *) NULL) 
> --> Missing unlock? 
>     return (iw_stats *) NULL; 
> 
> -----------------------------------------------------------------------------

	Thanks for the hint (actually, also thanks to LWN for
reporting this, I don't read the list).
	At first, I felt offended to have such an obvious bug in my
driver, and then I check the master copy of the driver in the Pcmcia
package that I maintain, and it doesn't contain this bug. So whoever
did the port from Pcmcia -> kernel introduced this one :-(
	Patch attached. Have fun...

	Jean


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="wav_cs.spinret.diff"

diff -u -p linux/drivers/net/pcmcia/wireless.24d/wavelan_cs.c linux/drivers/net/pcmcia/wavelan_cs.c
--- linux/drivers/net/pcmcia/wireless.24d/wavelan_cs.c	Thu Mar 22 15:08:46 2001
+++ linux/drivers/net/pcmcia/wavelan_cs.c	Thu Mar 22 15:10:25 2001
@@ -2524,11 +2524,13 @@ wavelan_get_wireless_stats(device *	dev)
   printk(KERN_DEBUG "%s: ->wavelan_get_wireless_stats()\n", dev->name);
 #endif
 
+  /* Pure paranoia */
+  if(lp == (net_local *) NULL)
+    return (iw_stats *) NULL;
+
   /* Disable interrupts & save flags */
   spin_lock_irqsave (&lp->lock, flags);
 
-  if(lp == (net_local *) NULL)
-    return (iw_stats *) NULL;
   wstats = &lp->wstats;
 
   /* Get data from the mmc */

--CE+1k2dSO48ffgeK--
