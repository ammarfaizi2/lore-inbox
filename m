Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272903AbTG3OIR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 10:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272904AbTG3OIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 10:08:17 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:12044 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S272903AbTG3OHv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 10:07:51 -0400
Date: Wed, 30 Jul 2003 16:06:58 +0200
From: Willy Tarreau <willy@w.ods.org>
To: davem@redhat.com, jgarzik@pobox.com, marcelo@conectiva.com.br
Cc: netdev@oss.sgi.com, bonding-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.22-pre9-bk : bonding bug fixes
Message-ID: <20030730140658.GA14437@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Marcelo, David, Jeff...

there are still a few bugs in the current bonding driver. I've reported them
several times now, but perhaps not at the right places...

So :
  - the first patch fixes a typo in the MODULE_PARM_DESC

  - the second one adds a comment and a warning around some code I don't
    understand, but which cannot be executed. It's within function
    bond_xmit_activebackup, and only executes if bond->mode != ACTIVEBACKUP....

  - now the last one fixes a kernel panic due to a cheap hack which was introduced
    to determine the source IP address to use with ARP checks. It takes the first
    address of the first slave, and puts a lock on it. If there's no address, its
    ip_ptr is NULL, and the kernel panics while trying to get the lock. You can
    reproduce it easily this way :

    # modprobe eth0
    # modprobe bonding mode=active-backup miimon=1000
    # ip link set bond0 up
    # ifenslave bond0 eth0
    => kernel panic !

Now here are the patches. I really hope to get them into 2.4.22, since I'm a
bit fed up with my server panicing each time I try a vanilla new kernel which
I forget to patch...

Cheers,
Willy


======== first one ==========

--- linux-2.4.22-pre9-bk/drivers/net/bonding/bond_main.c	Wed Jul 30 09:49:48 2003
+++ linux-2.4.22-pre9-bk-bond/drivers/net/bonding/bond_main.c	Wed Jul 30 15:09:15 2003
@@ -524,7 +524,7 @@
 MODULE_PARM(miimon, "i");
 MODULE_PARM_DESC(miimon, "Link check interval in milliseconds");
 MODULE_PARM(use_carrier, "i");
-MODULE_PARM_DESC(use_carrier, "Use netif_carrier_ok (vs MII ioctls) in miimon; 09 for off, 1 for on (default)");
+MODULE_PARM_DESC(use_carrier, "Use netif_carrier_ok (vs MII ioctls) in miimon; 0 for off, 1 for on (default)");
 MODULE_PARM(mode, "s");
 MODULE_PARM_DESC(mode, "Mode of operation : 0 for round robin, 1 for active-backup, 2 for xor");
 MODULE_PARM(arp_interval, "i");



======== second one ==========

--- linux-2.4.22-pre9-bk/drivers/net/bonding/bond_main.c	Wed Jul 30 15:12:11 2003
+++ linux-2.4.22-pre9-bk-bond/drivers/net/bonding/bond_main.c	Wed Jul 30 15:31:01 2003
@@ -3281,6 +3281,19 @@
 		memcpy(&my_ip, the_ip, 4);
 	}
 
+	/* w.tarreau - 2003/07/30
+	 * I don't understand the logic here :
+	 * - this code should be run only if we're NOT in active-backup mode, which
+	 *   is the only mode for which this function will be called.
+	 * - the comment says the code tries to avoid sending broadcasts for ARP
+	 *   requests when the destination is known. This is obviously wrong since
+	 *   it will prevent you from changing the dead equipment you were checking
+	 *   without reloading the bonding driver ! High availability and low
+	 *   network usage never mix well ...
+	 */
+#warning "This code may need a fix !"
+#ifdef HOW_CAN_THIS_BE_CALLED
+
 	/* if we are sending arp packets and don't know 
 	 * the target hw address, save it so we don't need 
 	 * to use a broadcast address.
@@ -3302,6 +3315,7 @@
 				memcpy(arp_target_hw_addr, eth_hdr->h_dest, ETH_ALEN);
 		}
 	}
+#endif
 
 	read_lock(&bond->lock);
 

========= third one ==========


--- linux-2.4.22-pre9-bk/drivers/net/bonding/bond_main.c	Wed Jul 30 15:09:15 2003
+++ linux-2.4.22-pre9-bk-bond/drivers/net/bonding/bond_main.c	Wed Jul 30 15:12:11 2003
@@ -1594,11 +1594,14 @@
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


