Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262214AbULQWEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262214AbULQWEW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 17:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbULQWAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 17:00:36 -0500
Received: from dsl027-176-166.sfo1.dsl.speakeasy.net ([216.27.176.166]:63891
	"EHLO waste.org") by vger.kernel.org with ESMTP id S262182AbULQV6F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 16:58:05 -0500
Date: Fri, 17 Dec 2004 13:57:52 -0800
From: Matt Mackall <mpm@selenic.com>
To: Mark Broadbent <markb@wetlettuce.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Lockup with 2.6.9-ac15 related to netconsole
Message-ID: <20041217215752.GP2767@waste.org>
References: <59719.192.102.214.6.1103214002.squirrel@webmail.wetlettuce.com> <20041216211024.GK2767@waste.org> <34721.192.102.214.6.1103274614.squirrel@webmail.wetlettuce.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34721.192.102.214.6.1103274614.squirrel@webmail.wetlettuce.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2004 at 09:10:14AM -0000, Mark Broadbent wrote:
> 
> Matt Mackall said:
> > On Thu, Dec 16, 2004 at 04:20:02PM -0000, Mark Broadbent wrote:
> >> Hi,
> >>
> >> I'm having problem using ethereal/tcpdump in conjunction with the
> >> netconsole (built as a module).  If the netconsole is loaded and I try
> >> to launch tcpdump on the same interface as the netconsole is
> >> transmitting I get a hard lock-up.  The following commands can
> >> consistently do this: # tcpdump -i eth0
> >> eth0: Promiscuous Mode Entered
> >> <... normal output ...>
> >> ^C
> >> # modprobe netconsole
> >> # tcpdump -i eth0
> >> eth0: Promiscuous Mode Entered
> >> <4>NMI Watchdog detected LOCKUP
> >
> > Joy. Can you try it on your other interface to see if it's
> > driver-specific?
> 
> Tried using eth1 which is using the r8169 but it doesn't support polling. 
> I also tried with 2.6.10-rc3-bk10 but it still doesn't support polling. 
> Also it still locks up using eth0 (the tulip driver) with 2.6.10-rc3-bk10.

Please try the attached untested, uncompiled patch to add polling to
r8169:

Index: l/drivers/net/r8169.c
===================================================================
--- l.orig/drivers/net/r8169.c	2004-11-04 10:53:04.779520000 -0800
+++ l/drivers/net/r8169.c	2004-12-17 13:30:35.367771000 -0800
@@ -1120,6 +1120,9 @@
 	dev->weight = R8169_NAPI_WEIGHT;
 	printk(KERN_INFO PFX "NAPI enabled\n");
 #endif
+#ifdef CONFIG_NET_POLL_CONTROLLER
+	dev->poll_controller = rtl8169_netpoll;
+#endif
 	tp->intr_mask = 0xffff;
 	tp->pci_dev = pdev;
 	tp->mmio_addr = ioaddr;
@@ -1839,6 +1842,15 @@
 }
 #endif
 
+#ifdef CONFIG_NET_POLL_CONTROLLER
+static void rtl8169_netpoll(struct net_device *dev)
+{
+	disable_irq(dev->irq);
+	rtl8169_interrupt(dev->irq, netdev, NULL);
+	enable_irq(dev->irq);
+}
+#endif
+
 static int
 rtl8169_close(struct net_device *dev)
 {


--
Mathematics is the supreme nostalgia of our time.
