Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265677AbTF2OAi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 10:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265675AbTF2OAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 10:00:38 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:14084 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S265676AbTF2OAc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 10:00:32 -0400
Date: Sun, 29 Jun 2003 16:14:13 +0200
From: Willy TARREAU <willy@w.ods.org>
To: bonding-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Cc: marcelo@conectiva.com.br
Subject: [PATCH-2.4][RESEND] Oops with bonding when enslaving IP-less interface
Message-ID: <20030629141413.GA345@pcw.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I sent this patch a while ago, but I think it got lost. With the new bonding
code now in 2.4.22-pre2, you get an oops if you enslave devices which have no
IP address. This is because of a piece of code which follows slave_dev->ip_ptr
to get an IP address to use in ARP requests. I think that eventhough usefull,
the implementation is a bit broken because of a global my_ip variable assigned
once for all, and common to all bonds handled by the same module instance.

Anyway, here is a simple fix. It simply checks that the pointers are valid
before following them.

Of course, a better fix would be to have a my_ip per bond device, and either
use a user-supplied one or the bond device's primary address, but I don't have
time to change this.

Here is the patch, rediffed against 2.4.22-pre2.

Cheers,
Willy


diff -ur linux-2.4.22-pre2/drivers/net/bonding/bond_main.c linux-2.4.22-pre2-bond-oops/drivers/net/bonding/bond_main.c
--- linux-2.4.22-pre2/drivers/net/bonding/bond_main.c	Sun Jun 29 11:52:38 2003
+++ linux-2.4.22-pre2-bond-oops/drivers/net/bonding/bond_main.c	Sun Jun 29 15:55:26 2003
@@ -385,6 +385,10 @@
  *	- In conjunction with fix for ifenslave -c, in
  *	  bond_change_active(), changing to the already active slave
  *	  is no longer an error (it successfully does nothing).
+ *
+ * 2003/03/17 - Willy Tarreau <wtarreau at meta-x.org>
+ *	- fix bond_enslave() which could oops when the slave had no
+ *	  IP address.
  */
 
 #include <linux/config.h>
@@ -521,7 +525,7 @@
 MODULE_PARM(miimon, "i");
 MODULE_PARM_DESC(miimon, "Link check interval in milliseconds");
 MODULE_PARM(use_carrier, "i");
-MODULE_PARM_DESC(use_carrier, "Use netif_carrier_ok (vs MII ioctls) in miimon; 09 for off, 1 for on (default)");
+MODULE_PARM_DESC(use_carrier, "Use netif_carrier_ok (vs MII ioctls) in miimon; 0 for off, 1 for on (default)");
 MODULE_PARM(mode, "s");
 MODULE_PARM_DESC(mode, "Mode of operation : 0 for round robin, 1 for active-backup, 2 for xor");
 MODULE_PARM(arp_interval, "i");
@@ -1591,11 +1595,14 @@
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
 		if (primary != NULL) {
