Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263640AbTKDEoS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 23:44:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263650AbTKDEoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 23:44:18 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:38563 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S263640AbTKDEoP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 23:44:15 -0500
Date: Mon, 3 Nov 2003 23:43:11 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: "M.H.VanLeeuwen" <vanl@megsinet.net>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.0-test8 ISAPNP ne.c initialization
Message-ID: <20031103234311.GE16854@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	"M.H.VanLeeuwen" <vanl@megsinet.net>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.10.10009211329001.1627-100000@penguin.transmeta.com> <3F97596F.3E1A6F23@megsinet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F97596F.3E1A6F23@megsinet.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 22, 2003 at 11:30:39PM -0500, M.H.VanLeeuwen wrote:
> Hi,
> 
>  The level of isapnp_init was moved to after apci sometime ago.  Since it is now
>  after net_dev_init, ISA PNP NICs fail to initialized at boot.  This is particularily
>  problematic for NFS root filesystems like mine, or none modular systems.
>  I've been patching my kernel since at least 2.5.65 with the attached...
> 
>  This fix allows ISA PNP NIC cards to work during net_dev_init, and still
>  leaves isapnp_init after apci_init, though I don't know if it is the right
>  thing todo, it works for me...
> 
> Comments from Alan Cox a long while back:
> >We must initialise ACPI before ISAPnP because we need PCI and ACPI to
> >know what system resources we must not hit. How about moving the
> >net_dev_init to later?
>

-->snip

> -device_initcall(isapnp_init);
> +fs_initcall(isapnp_init);

I'm concerned that moving isapnp further down will spark some new problems.
Also this would be far later in the init cycle than most buses.

-->snip

> -subsys_initcall(net_dev_init);
> +fs_initcall(net_dev_init);

-->snip

How about something like this? (untested)

The patch removes the legacy probing function from dev.c and gives it its
own initcall later in the cycle.  Any testing would be appreciated.  I
also have some patches that update the probing code in some of these
drivers so that they don't have to use legacy techniques but they need
to be updated to test9.  This fix is probably the least intrusive.

--- a/drivers/net/Space.c	2003-10-25 18:42:56.000000000 +0000
+++ b/drivers/net/Space.c	2003-11-01 22:15:01.000000000 +0000
@@ -422,7 +422,7 @@
 extern int loopback_init(void);

 /*  Statically configured drivers -- order matters here. */
-void __init probe_old_netdevs(void)
+int __init net_olddevs_init(void)
 {
 	int num;

@@ -450,8 +450,12 @@
 #ifdef CONFIG_LTPC
 	ltpc_probe();
 #endif
+
+	return 0;
 }

+device_initcall(net_olddevs_init);
+
 /*
  * The @dev_base list is protected by @dev_base_lock and the rtln
  * semaphore.
--- a/include/linux/netdevice.h	2003-10-25 18:44:45.000000000 +0000
+++ b/include/linux/netdevice.h	2003-11-01 22:11:04.000000000 +0000
@@ -494,7 +494,6 @@
 extern struct net_device		*dev_base;		/* All devices */
 extern rwlock_t				dev_base_lock;		/* Device list lock */

-extern void		probe_old_netdevs(void);
 extern int			netdev_boot_setup_add(char *name, struct ifmap *map);
 extern int 			netdev_boot_setup_check(struct net_device *dev);
 extern struct net_device    *dev_getbyhwaddr(unsigned short type, char *hwaddr);
--- a/net/core/dev.c	2003-10-25 18:43:39.000000000 +0000
+++ b/net/core/dev.c	2003-11-02 16:10:51.000000000 +0000
@@ -3007,8 +3007,6 @@

 	dev_boot_phase = 0;

-	probe_old_netdevs();
-
 	open_softirq(NET_TX_SOFTIRQ, net_tx_action, NULL);
 	open_softirq(NET_RX_SOFTIRQ, net_rx_action, NULL);

