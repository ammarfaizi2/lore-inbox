Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264057AbUECVlO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264057AbUECVlO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 17:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264039AbUECVlC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 17:41:02 -0400
Received: from pop.gmx.net ([213.165.64.20]:62139 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264057AbUECVic (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 17:38:32 -0400
X-Authenticated: #21910825
Message-ID: <4096BBC8.60509@gmx.net>
Date: Mon, 03 May 2004 23:38:16 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040114
X-Accept-Language: de, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Netdev <netdev@oss.sgi.com>, Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] tulip driver deadlocks on device removal
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a CardBus network card with tulip chipset:
# lspci -nv
[...]
0000:05:00.0 Class 0200: 13d1:ab02 (rev 11)
        Subsystem: 13d1:ab02
        Flags: bus master, medium devsel, latency 64, IRQ 11
        I/O ports at 4800 [size=268M]
        Memory at 11000000 (32-bit, non-prefetchable) [size=1K]
        Expansion ROM at 00020000 [disabled]
        Capabilities: [c0] Power Management version 2

If I remove the card, my machine freezes instantly. This is due to a
stupid dev->poll function of the tulip driver.

drivers/net/tulip/interrupt.c:tulip_poll() gets stuck in an endless loop
in interrupt context if the hardware returns 0xffffffff on certain reads.
But this is exactly what happens if you remove a pci device.

My patch replaces the deadlock with something resembling a livelock. At
least SysRq-S works now because we leave the poll function after some time.

However, the poll function is called again and again and again regardless
of its return value. How can I stop that?

Carl-Daniel

--- a/drivers/net/tulip/interrupt.c	2004-05-03 20:31:14.000000000 +0200
+++ b/drivers/net/tulip/interrupt.c	2004-05-03 20:51:06.000000000 +0200
@@ -113,6 +113,7 @@
 	int entry = tp->cur_rx % RX_RING_SIZE;
 	int rx_work_limit = *budget;
 	int received = 0;
+	int innercnt = 0;

 	if (!netif_running(dev))
 		goto done;
@@ -129,10 +130,12 @@
 #endif

 	if (tulip_debug > 4)
-		printk(KERN_DEBUG " In tulip_rx(), entry %d %8.8x.\n", entry,
+		printk(KERN_DEBUG " In tulip_poll(), entry %d %8.8x.\n", entry,
 			   tp->rx_ring[entry].status);

        do {
+		innercnt++;
+
                /* Acknowledge current RX interrupt sources. */
                outl((RxIntr | RxNoBuf), dev->base_addr + CSR5);

@@ -141,12 +144,13 @@
                while ( ! (tp->rx_ring[entry].status & cpu_to_le32(DescOwned))) {
                        s32 status = le32_to_cpu(tp->rx_ring[entry].status);

+			innercnt = 0;

                        if (tp->dirty_rx + RX_RING_SIZE == tp->cur_rx)
                                break;

                        if (tulip_debug > 5)
-                               printk(KERN_DEBUG "%s: In tulip_rx(), entry %d %8.8x.\n",
+                               printk(KERN_DEBUG "%s: In tulip_poll(), entry %d %8.8x.\n",
                                       dev->name, entry, status);
                        if (--rx_work_limit < 0)
                                goto not_done;
@@ -254,6 +258,11 @@
                 * No idea how to fix this if "playing with fire" will fail
                 * tomorrow (night 011029). If it will not fail, we won
                 * finally: amount of IO did not increase at all. */
+		if (innercnt > 5) {
+			printk(KERN_INFO "More than five loops without doing anything!\n");
+			goto not_done;
+		}
+
        } while ((inl(dev->base_addr + CSR5) & RxIntr));

 done:
@@ -321,8 +330,10 @@
          return 0;

  not_done:
-         if (!received) {
+         if (!received && (innercnt <= 5)) {

+		printk(KERN_NOTICE "tulip_poll: Bugger. This does not happen.\n");
+		/* If it is not going to happen, why do anything about it? */
                  received = dev->quota; /* Not to happen */
          }
          dev->quota -= received;

