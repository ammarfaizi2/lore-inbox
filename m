Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262096AbTCVKbp>; Sat, 22 Mar 2003 05:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262103AbTCVKbp>; Sat, 22 Mar 2003 05:31:45 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:27913 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id <S262096AbTCVKbo>;
	Sat, 22 Mar 2003 05:31:44 -0500
Date: Sat, 22 Mar 2003 11:37:52 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Tomi Hakala <tomi.hakala@clinet.fi>
Cc: linux-kernel@vger.kernel.org, ctindel@ieee.org
Subject: Re: [2.4.21-pre5] ethernet bonding caused system lockup
Message-ID: <20030322103752.GC26167@alpha.home.local>
References: <3E7C3707.4E583F8@clinet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E7C3707.4E583F8@clinet.fi>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 22, 2003 at 12:12:23PM +0200, Tomi Hakala wrote:
> Hello,
> 
> Last night I experienced total system lockup when I added second NIC to
> bond0 group, no OOPS or anything, system stopped to respond immediatiately.

I had the same problem here, but with an oops. I tracked it down to the bond
driver trying to get the slave's IP address for arp requests. It crashes if
the slave doesn't have an IP address.

This patch works for me, but I haven't submitted it yet. I haven't worked on
bonding for a long time, and saw that a lot of new features came in. I don't
know if they have been widely tested yet.

Cheers,
Willy

--- 20030207/drivers/net/bonding.c	Thu Mar  6 21:57:55 2003
+++ fix/drivers/net/bonding.c	Mon Mar 17 21:45:04 2003
@@ -276,6 +276,10 @@
  * 2003/02/07 - Tony Cureington <tony.cureington * hp_com>
  *	- Fix bond_mii_monitor() logic error that could result in
  *	  bonding round-robin mode ignoring links after failover/recovery
+ *
+ * 2003/03/17 - Willy Tarreau <wtarreau at meta-x.org>
+ *	- fix bond_enslave() which could oops when the slave had no
+ *	  IP address.
  */
 
 #include <linux/config.h>
@@ -382,7 +386,7 @@
 MODULE_PARM(miimon, "i");
 MODULE_PARM_DESC(miimon, "Link check interval in milliseconds");
 MODULE_PARM(use_carrier, "i");
-MODULE_PARM_DESC(use_carrier, "Use netif_carrier_ok (vs MII ioctls) in miimon; 09 for off, 1 for on (default)");
+MODULE_PARM_DESC(use_carrier, "Use netif_carrier_ok (vs MII ioctls) in miimon; 0 for off, 1 for on (default)");
 MODULE_PARM(mode, "s");
 MODULE_PARM_DESC(mode, "Mode of operation : 0 for round robin, 1 for active-backup, 2 for xor");
 MODULE_PARM(arp_interval, "i");
@@ -1163,11 +1167,14 @@
 #endif
 			bond_set_slave_inactive_flags(new_slave);
 		}
-		read_lock_irqsave(&(((struct in_device *)slave_dev->ip_ptr)->lock), rflags);
-		ifap= &(((struct in_device *)slave_dev->ip_ptr)->ifa_list);
-		ifa = *ifap;
-		my_ip = ifa->ifa_address;
-		read_unlock_irqrestore(&(((struct in_device *)slave_dev->ip_ptr)->lock), rflags);
+		if (((struct in_device *)slave_dev->ip_ptr) != NULL) {
+			read_lock_irqsave(&(((struct in_device *)slave_dev->ip_ptr)->lock), rflags);
+			ifap= &(((struct in_device *)slave_dev->ip_ptr)->ifa_list);
+			ifa = *ifap;
+			if (ifa != NULL)
+				my_ip = ifa->ifa_address;
+			read_unlock_irqrestore(&(((struct in_device *)slave_dev->ip_ptr)->lock), rflags);
+		}
 
 		/* if there is a primary slave, remember it */
 		if (primary != NULL)
