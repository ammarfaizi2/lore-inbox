Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275808AbRI1CyG>; Thu, 27 Sep 2001 22:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275809AbRI1Cx4>; Thu, 27 Sep 2001 22:53:56 -0400
Received: from mail100.mail.bellsouth.net ([205.152.58.40]:9392 "EHLO
	imf00bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S275808AbRI1Cxl>; Thu, 27 Sep 2001 22:53:41 -0400
Message-ID: <3BB3E647.F2B33A41@bellsouth.net>
Date: Thu, 27 Sep 2001 22:53:59 -0400
From: Albert Cranford <ac9410@bellsouth.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>, Ingo Molnar <mingo@elte.hu>
CC: ookhoi@dds.nl, linux-kernel@vger.kernel.org
Subject: Re: [patch] netconsole - log kernel messages over the network. 2.4.10.
In-Reply-To: <20010927171818.H774@humilis> <3BB36A6A.B0736CA2@zip.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Great tool Ingo thanks.  Below is a tested tulip patch.
Thanks Andrew for the the inspiration.
Albert
Andrew Morton wrote:
> 
> Ookhoi wrote:
> >
> 
> What we need is for a bunch of people to implement poll_controller()
> for *their* ethernet driver and contribute the tested diffs
> back to Ingo.
> 


/etc/rc.d/rc.netconsole 192.168.1.2
dev=eth0 target_ip=0xC0A80102 source_port=6666 target_port=6666 \
        target_eth_byte0=0x00 target_eth_byte1=0x03 target_eth_byte2=0x6D \
        target_eth_byte3=0x16 target_eth_byte4=0x51 target_eth_byte5=0xAE
Using /lib/modules/2.4.10/kernel/drivers/net/netconsole.o

~~~~~~~~~~~   DMESG from server  ~~~~~~~~~~~~~~~~
Linux version 2.4.10 (root@home1) (gcc version 3.0.1) \
        #1 Thu Sep 27 22:28:20 EDT 2001
.......
Linux Tulip driver version 0.9.15-pre6 (July 2, 2001)
eth0: ADMtek Comet rev 17 at 0xdc00, 00:03:6D:16:4E:39, IRQ 10.
.........
netconsole: using network device <eth0>
netconsole: using source IP -64.-88.1.10
netconsole: using target IP -64.-88.1.2
netconsole: using source UDP port: 6666
netconsole: using target UDP port: 6666
netconsole: using target ethernet address 00:03:6d:16:51:ae.
netconsole: network logging started up successfully!
netconsole-client -server 0xc0a8010a -client 0xc0a80102 -port 6666
~~~~~~~~~ Start netconsole-client ~~~~~~~~
displaying netconsole output from server 0xc0a8010a, \
        client 0xc0a80102, UDP port 6666.
~~~~~~~~~ Alt-SysRq-s on Server output to client ~~~~~
SysRq : Emergency Sync
Syncing device 08:04 ... OK
Syncing device 08:12 ... OK
Syncing device 08:01 ... OK
Done.
~~~~~~~~~~ PATCH BEGIN ~~~~~~~~~~~~~~~
--- linux/drivers/net/tulip/tulip_core.c.orig   Thu Sep 27 21:04:14 2001
+++ linux/drivers/net/tulip/tulip_core.c        Thu Sep 27 10:10:15 2001
@@ -243,6 +243,7 @@
 static struct net_device_stats *tulip_get_stats(struct net_device *dev);
 static int private_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
 static void set_rx_mode(struct net_device *dev);
+static void poll_tulip(struct net_device *dev);
 
 
 
@@ -1671,6 +1672,9 @@
        dev->get_stats = tulip_get_stats;
        dev->do_ioctl = private_ioctl;
        dev->set_multicast_list = set_rx_mode;
+#ifdef HAVE_POLL_CONTROLLER
+       dev->poll_controller = &poll_tulip;
+#endif
 
        if (register_netdev(dev))
                goto err_out_free_ring;
@@ -1839,6 +1843,24 @@
 
        /* pci_power_off (pdev, -1); */
 }
+
+
+#ifdef HAVE_POLL_CONTROLLER
+
+/*
+ * Polling 'interrupt' - used by things like netconsole to send skbs
+ * without having to re-enable interrupts. It's not called while
+ * the interrupt routine is executing.
+ */
+
+static void poll_tulip (struct net_device *dev)
+{
+       disable_irq(dev->irq);
+       tulip_interrupt (dev->irq, dev, NULL);
+       enable_irq(dev->irq);
+}
+
+#endif
 
 
 static struct pci_driver tulip_driver = {
~~~~~~~~~~ PATCH END ~~~~~~~~~~~~~~~

-- 
Albert Cranford Deerfield Beach FL USA
ac9410@bellsouth.net

