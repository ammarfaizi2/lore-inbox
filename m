Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274133AbRI3U3I>; Sun, 30 Sep 2001 16:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274080AbRI3U27>; Sun, 30 Sep 2001 16:28:59 -0400
Received: from air-1.osdlab.org ([65.201.151.5]:6675 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S274070AbRI3U2u>;
	Sun, 30 Sep 2001 16:28:50 -0400
Message-ID: <3BB77FD7.696CFC58@osdlab.org>
Date: Sun, 30 Sep 2001 13:25:59 -0700
From: "Randy.Dunlap" <rddunlap@osdlab.org>
Organization: OSDL
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-20mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mingo@elte.hu, linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
        netdev@oss.sgi.com, jgarzik@mandrakesoft.com
Subject: Re: [patch] netconsole-2.4.10-B1
In-Reply-To: <Pine.LNX.4.33.0109291146440.1715-100000@localhost.localdomain> <3BB77591.C1349C09@osdlab.org>
Content-Type: multipart/mixed;
 boundary="------------BC742B6CC3660A9A3E7C6B46"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------BC742B6CC3660A9A3E7C6B46
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

"Randy.Dunlap" wrote:
> 
> Ingo Molnar wrote:
> >
> >
> > does it make more sense now? :)
> 
> Thanks for the definitions.  I can work with them,
> although I think that there's much room for improvement...


and I did.  Eliminating typos on 'insmod netconsole.o ...' helps.  :)

Here's 3c59x.c patched for netconsole (HAVE_POLL_CONTROLLER).

Ingo, you _are_ planning to use most or all of Andreas's patches,
aren't you?

I'm interested in using netconsole early (during boot).
Any problems doing that, other than getting module parameters
to it?  I can fix that part.

~Randy
--------------BC742B6CC3660A9A3E7C6B46
Content-Type: text/plain; charset=us-ascii;
 name="3c59x-poll.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="3c59x-poll.patch"

--- linux/drivers/net/3c59x.c.org	Sun Aug 12 12:27:18 2001
+++ linux/drivers/net/3c59x.c	Sun Sep 30 12:37:39 2001
@@ -842,6 +842,7 @@
 static int vortex_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
 static void vortex_tx_timeout(struct net_device *dev);
 static void acpi_set_WOL(struct net_device *dev);
+static void vorboom_poll(struct net_device *dev);
 
 /* This driver uses 'options' to pass the media type, full-duplex flag, etc. */
 /* Option count limit only -- unlimited interfaces are supported. */
@@ -1328,6 +1329,9 @@
 	dev->set_multicast_list = set_rx_mode;
 	dev->tx_timeout = vortex_tx_timeout;
 	dev->watchdog_timeo = (watchdog * HZ) / 1000;
+#ifdef HAVE_POLL_CONTROLLER
+	dev->poll_controller = &vorboom_poll;
+#endif
 	if (pdev && vp->enable_wol) {
 		vp->pm_state_valid = 1;
  		pci_save_state(vp->pdev, vp->power_state);
@@ -2295,6 +2299,29 @@
 handler_exit:
 	spin_unlock(&vp->lock);
 }
+
+#ifdef HAVE_POLL_CONTROLLER
+
+/*
+ * Polling 'interrupt' - used by things like netconsole to send skbs
+ * without having to re-enable interrupts. It's not called while
+ * the interrupt routine is executing.
+ */
+
+static void vorboom_poll (struct net_device *dev)
+{
+	struct vortex_private *vp = (struct vortex_private *)dev->priv;
+
+	disable_irq(dev->irq);
+	if (vp->full_bus_master_tx)
+		boomerang_interrupt(dev->irq, dev, 0);
+	else
+		vortex_interrupt(dev->irq, dev, 0);
+	enable_irq(dev->irq);
+}
+
+#endif
+
 
 static int vortex_rx(struct net_device *dev)
 {

--------------BC742B6CC3660A9A3E7C6B46--

