Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261418AbULTUcX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbULTUcX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 15:32:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261632AbULTUcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 15:32:23 -0500
Received: from mproxy.gmail.com ([216.239.56.246]:11814 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261418AbULTUbs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 15:31:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=H2NeR/3+XFdgVGqgNYD4bC+2QO6uG2bZvVZztE9s7/FSNxg29/mS2jOoiA7ZH8draOx0bWpmeE6GZVMvXnb68MNxf5bLMTsNraNOA8JDk8i/ZuVmlhoUgfChxL8/pf1CRqdLtuJxsc3h/3PMQ4zFP0hZfSsOhPmQV/CC6mv5MY8=
Message-ID: <892457750412201231461415a1@mail.gmail.com>
Date: Mon, 20 Dec 2004 14:31:48 -0600
From: Jon Mason <jdmason@gmail.com>
Reply-To: Jon Mason <jdmason@gmail.com>
To: Richard Ems <richard.ems@mtg-marinetechnik.de>
Subject: Re: PROBLEM: Network hang: "eth0: Tx timed out (f0080), is buffer full?" (Plain)
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
In-Reply-To: <41C713EF.8050003@mtg-marinetechnik.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_388_16410734.1103574708007"
References: <200412171100.16601.richard.ems@mtg-marinetechnik.de>
	 <89245775041217090726eb2751@mail.gmail.com>
	 <41C31421.7090102@mtg-marinetechnik.de>
	 <8924577504121710054331bb54@mail.gmail.com>
	 <8924577504121712527144a5cf@mail.gmail.com>
	 <41C6E2E1.8030801@mtg-marinetechnik.de>
	 <8924577504122009126c40c1fe@mail.gmail.com>
	 <41C713EF.8050003@mtg-marinetechnik.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_388_16410734.1103574708007
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dec 20 18:49:08 urutu kernel: eth1: HostError! IntStatus 0002. 202 143 8 7c2
Dec 20 18:54:15 urutu kernel: eth1: Tx timed out (d50080) 214 143 800 0
Dec 20 18:59:31 urutu kernel: eth1: Tx timed out (d30080) 212 143 800 0

With the above numbers corresponding to the current tx descriptor, the
current rx descriptor, the DMACtrl register, and the IntEnable
register.

I think we have the culprit.  It appears that the adapter reset in the
function that contains HostError disables interrupts (which prevents
any rx from being serviced).  I have a new patch which should
<crossing fingers> fix the problem (attached for easier patching).  If
it doesn't work, it will fail the same way.  Please apply it to the
original driver.

Thanks,
Jon


--- dl2k.c.orig 2004-12-20 13:59:47.123631016 -0600
+++ dl2k.c      2004-12-20 14:22:31.820165608 -0600
@@ -431,23 +431,14 @@ parse_eeprom (struct net_device *dev)
        return 0;
 }

-static int
-rio_open (struct net_device *dev)
+static void
+rio_up (struct net_device *dev)
 {
        struct netdev_private *np = netdev_priv(dev);
        long ioaddr = dev->base_addr;
        int i;
        u16 macctrl;

-       i = request_irq (dev->irq, &rio_interrupt, SA_SHIRQ, dev->name, dev);
-       if (i)
-               return i;
-
-       /* Reset all logic functions */
-       writew (GlobalReset | DMAReset | FIFOReset | NetworkReset | HostReset,
-               ioaddr + ASICCtrl + 2);
-       mdelay(10);
-
        /* DebugCtrl bit 4, 5, 9 must set */
        writel (readl (ioaddr + DebugCtrl) | 0x0230, ioaddr + DebugCtrl);

@@ -455,8 +446,6 @@ rio_open (struct net_device *dev)
        if (np->jumbo != 0)
                writew (MAX_JUMBO+14, ioaddr + MaxFrameSize);

-       alloc_list (dev);
-
        /* Get station address */
        for (i = 0; i < 6; i++)
                writeb (dev->dev_addr[i], ioaddr + StationAddr0 + i);
@@ -490,12 +479,6 @@ rio_open (struct net_device *dev)
                        ioaddr + MACCtrl);
        }

-       init_timer (&np->timer);
-       np->timer.expires = jiffies + 1*HZ;
-       np->timer.data = (unsigned long) dev;
-       np->timer.function = &rio_timer;
-       add_timer (&np->timer);
-
        /* Start Tx/Rx */
        writel (readl (ioaddr + MACCtrl) | StatsEnable | RxEnable | TxEnable,
                        ioaddr + MACCtrl);
@@ -507,10 +490,38 @@ rio_open (struct net_device *dev)
        macctrl |= (np->rx_flow) ? RxFlowControlEnable : 0;
        writew(macctrl, ioaddr + MACCtrl);

-       netif_start_queue (dev);
-
        /* Enable default interrupts */
        EnableInt ();
+}
+
+static int
+rio_open (struct net_device *dev)
+{
+       struct netdev_private *np = netdev_priv(dev);
+       long ioaddr = dev->base_addr;
+       int i;
+
+       i = request_irq (dev->irq, &rio_interrupt, SA_SHIRQ, dev->name, dev);
+       if (i)
+               return i;
+
+       /* Reset all logic functions */
+       writew (GlobalReset | DMAReset | FIFOReset | NetworkReset | HostReset,
+               ioaddr + ASICCtrl + 2);
+       mdelay(10);
+
+       alloc_list (dev);
+
+       rio_up (dev);
+
+       init_timer (&np->timer);
+       np->timer.expires = jiffies + 1*HZ;
+       np->timer.data = (unsigned long) dev;
+       np->timer.function = &rio_timer;
+       add_timer (&np->timer);
+
+       netif_start_queue (dev);
+
        return 0;
 }

@@ -564,9 +575,11 @@ static void
 rio_tx_timeout (struct net_device *dev)
 {
        long ioaddr = dev->base_addr;
+       struct netdev_private *np = dev->priv;

-       printk (KERN_INFO "%s: Tx timed out (%4.4x), is buffer full?\n",
-               dev->name, readl (ioaddr + TxStatus));
+       printk (KERN_INFO "%s: Tx timed out (%4.4x) %d %d %x %x\n",
+               dev->name, readl (ioaddr + TxStatus), np->cur_tx, np->cur_rx,
+               readl (ioaddr + MACCtrl), readw(ioaddr + IntEnable));
        rio_free_tx(dev, 0);
        dev->if_port = 0;
        dev->trans_start = jiffies;
@@ -1007,10 +1020,13 @@ rio_error (struct net_device *dev, int i
        /* PCI Error, a catastronphic error related to the bus interface
           occurs, set GlobalReset and HostReset to reset. */
        if (int_status & HostError) {
-               printk (KERN_ERR "%s: HostError! IntStatus %4.4x.\n",
-                       dev->name, int_status);
+               printk (KERN_ERR "%s: HostError! IntStatus %4.4x. %d
%d %x %x\n",
+                       dev->name, int_status, np->cur_tx, np->cur_rx,
+                       readl (ioaddr + MACCtrl), readw(ioaddr + IntEnable));
                writew (GlobalReset | HostReset, ioaddr + ASICCtrl + 2);
                mdelay (500);
+
+               rio_up(dev);
        }
 }

------=_Part_388_16410734.1103574708007
Content-Type: text/x-patch; name="dl2k.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="dl2k.patch"

--- dl2k.c.orig=092004-12-20 13:59:47.123631016 -0600
+++ dl2k.c=092004-12-20 14:22:31.820165608 -0600
@@ -431,23 +431,14 @@ parse_eeprom (struct net_device *dev)
 =09return 0;
 }
=20
-static int
-rio_open (struct net_device *dev)
+static void
+rio_up (struct net_device *dev)
 {
 =09struct netdev_private *np =3D netdev_priv(dev);
 =09long ioaddr =3D dev->base_addr;
 =09int i;
 =09u16 macctrl;
 =09
-=09i =3D request_irq (dev->irq, &rio_interrupt, SA_SHIRQ, dev->name, dev);
-=09if (i)
-=09=09return i;
-=09
-=09/* Reset all logic functions */
-=09writew (GlobalReset | DMAReset | FIFOReset | NetworkReset | HostReset,
-=09=09ioaddr + ASICCtrl + 2);
-=09mdelay(10);
-=09
 =09/* DebugCtrl bit 4, 5, 9 must set */
 =09writel (readl (ioaddr + DebugCtrl) | 0x0230, ioaddr + DebugCtrl);
=20
@@ -455,8 +446,6 @@ rio_open (struct net_device *dev)
 =09if (np->jumbo !=3D 0)
 =09=09writew (MAX_JUMBO+14, ioaddr + MaxFrameSize);
=20
-=09alloc_list (dev);
-
 =09/* Get station address */
 =09for (i =3D 0; i < 6; i++)
 =09=09writeb (dev->dev_addr[i], ioaddr + StationAddr0 + i);
@@ -490,12 +479,6 @@ rio_open (struct net_device *dev)
 =09=09=09ioaddr + MACCtrl);
 =09}
=20
-=09init_timer (&np->timer);
-=09np->timer.expires =3D jiffies + 1*HZ;
-=09np->timer.data =3D (unsigned long) dev;
-=09np->timer.function =3D &rio_timer;
-=09add_timer (&np->timer);
-
 =09/* Start Tx/Rx */
 =09writel (readl (ioaddr + MACCtrl) | StatsEnable | RxEnable | TxEnable,=
=20
 =09=09=09ioaddr + MACCtrl);
@@ -507,10 +490,38 @@ rio_open (struct net_device *dev)
 =09macctrl |=3D (np->rx_flow) ? RxFlowControlEnable : 0;
 =09writew(macctrl,=09ioaddr + MACCtrl);
=20
-=09netif_start_queue (dev);
-=09
 =09/* Enable default interrupts */
 =09EnableInt ();
+}
+
+static int
+rio_open (struct net_device *dev)
+{
+=09struct netdev_private *np =3D netdev_priv(dev);
+=09long ioaddr =3D dev->base_addr;
+=09int i;
+=09
+=09i =3D request_irq (dev->irq, &rio_interrupt, SA_SHIRQ, dev->name, dev);
+=09if (i)
+=09=09return i;
+=09
+=09/* Reset all logic functions */
+=09writew (GlobalReset | DMAReset | FIFOReset | NetworkReset | HostReset,
+=09=09ioaddr + ASICCtrl + 2);
+=09mdelay(10);
+=09
+=09alloc_list (dev);
+
+=09rio_up (dev);
+=09
+=09init_timer (&np->timer);
+=09np->timer.expires =3D jiffies + 1*HZ;
+=09np->timer.data =3D (unsigned long) dev;
+=09np->timer.function =3D &rio_timer;
+=09add_timer (&np->timer);
+
+=09netif_start_queue (dev);
+=09
 =09return 0;
 }
=20
@@ -564,9 +575,11 @@ static void
 rio_tx_timeout (struct net_device *dev)
 {
 =09long ioaddr =3D dev->base_addr;
+=09struct netdev_private *np =3D dev->priv;
=20
-=09printk (KERN_INFO "%s: Tx timed out (%4.4x), is buffer full?\n",
-=09=09dev->name, readl (ioaddr + TxStatus));
+=09printk (KERN_INFO "%s: Tx timed out (%4.4x) %d %d %x %x\n",
+=09=09dev->name, readl (ioaddr + TxStatus), np->cur_tx, np->cur_rx,
+=09=09readl (ioaddr + MACCtrl), readw(ioaddr + IntEnable));
 =09rio_free_tx(dev, 0);
 =09dev->if_port =3D 0;
 =09dev->trans_start =3D jiffies;
@@ -1007,10 +1020,13 @@ rio_error (struct net_device *dev, int i
 =09/* PCI Error, a catastronphic error related to the bus interface=20
 =09   occurs, set GlobalReset and HostReset to reset. */
 =09if (int_status & HostError) {
-=09=09printk (KERN_ERR "%s: HostError! IntStatus %4.4x.\n",
-=09=09=09dev->name, int_status);
+=09=09printk (KERN_ERR "%s: HostError! IntStatus %4.4x. %d %d %x %x\n",
+=09=09=09dev->name, int_status, np->cur_tx, np->cur_rx,
+=09=09=09readl (ioaddr + MACCtrl), readw(ioaddr + IntEnable));
 =09=09writew (GlobalReset | HostReset, ioaddr + ASICCtrl + 2);
 =09=09mdelay (500);
+
+=09=09rio_up(dev);
 =09}
 }
=20

------=_Part_388_16410734.1103574708007--
