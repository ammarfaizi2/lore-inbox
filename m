Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262564AbTCRUQs>; Tue, 18 Mar 2003 15:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262569AbTCRUQs>; Tue, 18 Mar 2003 15:16:48 -0500
Received: from tentacle.s2s.msu.ru ([193.232.119.109]:9898 "EHLO
	tentacle.sectorb.msk.ru") by vger.kernel.org with ESMTP
	id <S262564AbTCRUQf>; Tue, 18 Mar 2003 15:16:35 -0500
Date: Tue, 18 Mar 2003 23:27:29 +0300
From: "Vladimir B. Savkin" <savkin@shade.msu.ru>
To: fxzhang@ict.ac.cn
Cc: linux-kernel@vger.kernel.org
Subject: eepro100+NAPI failure
Message-ID: <20030318202728.GA15796@tentacle.sectorb.msk.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Organization: Moscow State Univ., Dept. of Mechanics and Mathematics
X-Operating-System: Linux 2.4.21-pre2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline

Hi!

I'm planning to deploy Intel-based fast ethernet NICs on a busy
router so I decided to try NAPI.

I grabbed eepro100-napi-020619.tar.gz from
ftp://robur.slu.se/pub/Linux/net-development/NAPI/
and applied eepro100-napi.patch from the archive.

The patch is pretty old and some hand-merging was required to
patch eepro100.c from 2.4.21-pre5. I'm attaching the resulting
diff to this message.

To test NAPI performance, I've blasted a stream of short packets 
from another host using pktgen. The bad thing is that receiving host
stopped responding to packets immediately. The effect is 100%
reproducable, eventually it comes back though, black-out can last
from a second to several minutes. Here is what I was able to catch
after 'ethtool -s eth0 msglvl 0xfff':

Mar 18 22:39:18 intermap kernel: eth0: interrupt  status=0x4050.
Mar 18 22:39:18 intermap kernel: switching to poll,status=4050
Mar 18 22:39:18 intermap kernel: eth0: exiting interrupt, status=0x4050.
Mar 18 22:39:18 intermap kernel:  In speedo_poll().
Mar 18 22:39:18 intermap kernel:  In speedo_rx().
Mar 18 22:39:18 intermap kernel:   speedo_rx() status 0000a020 len 64.
Mar 18 22:39:18 intermap last message repeated 25 times
Mar 18 22:39:18 intermap kernel:  In speedo_rx().
Mar 18 22:39:18 intermap kernel:   speedo_rx() status 0000a020 len 64.
Mar 18 22:39:18 intermap kernel:  In speedo_rx().
Mar 18 22:39:18 intermap kernel:   speedo_rx() status 0000a020 len 64.
Mar 18 22:39:18 intermap kernel:  In speedo_rx().
Mar 18 22:39:18 intermap kernel:   speedo_rx() status 0000a020 len 64.
Mar 18 22:39:18 intermap kernel: eth0: interrupt  status=0x4050.
Mar 18 22:39:18 intermap kernel: switching to poll,status=4050
Mar 18 22:39:18 intermap kernel: eth0: exiting interrupt, status=0x4050.
Mar 18 22:39:18 intermap kernel: done,received=29
Mar 18 22:39:18 intermap kernel:  In speedo_poll().
Mar 18 22:39:18 intermap kernel:  In speedo_rx().
Mar 18 22:39:18 intermap kernel:   speedo_rx() status 0000a020 len 64.
Mar 18 22:39:18 intermap last message repeated 13 times
Mar 18 22:39:18 intermap kernel: not done,received=14
Mar 18 22:39:18 intermap kernel:  In speedo_poll().
Mar 18 22:39:18 intermap kernel:  In speedo_rx().
Mar 18 22:39:18 intermap kernel:   speedo_rx() status 0000a020 len 64.
Mar 18 22:39:18 intermap last message repeated 63 times
Mar 18 22:39:18 intermap kernel: No resource,reset
Mar 18 22:39:18 intermap kernel: done,received=64
Mar 18 22:39:19 intermap kernel: eth0: Media control tick, status 0040.
Mar 18 22:39:23 intermap last message repeated 2 times
Mar 18 22:39:23 intermap kernel: eth0: interrupt  status=0x2040.
Mar 18 22:39:23 intermap kernel: switching to poll,status=2040
Mar 18 22:39:23 intermap kernel:  scavenge candidate 63 status 400ca000.
Mar 18 22:39:23 intermap kernel: eth0: interrupt  status=0x0040.
Mar 18 22:39:23 intermap kernel: eth0: exiting interrupt, status=0x0040.
Mar 18 22:39:23 intermap kernel:  In speedo_poll().
Mar 18 22:39:23 intermap kernel:  In speedo_rx().
Mar 18 22:39:23 intermap kernel: No resource,reset
Mar 18 22:39:23 intermap kernel: received==0
Mar 18 22:39:23 intermap kernel: done,received=1
Mar 18 22:39:23 intermap kernel: eth0: interrupt  status=0x4050.
Mar 18 22:39:23 intermap kernel: switching to poll,status=4050
Mar 18 22:39:23 intermap kernel: eth0: exiting interrupt, status=0x4050.
Mar 18 22:39:23 intermap kernel:  In speedo_poll().
Mar 18 22:39:23 intermap kernel:  In speedo_rx().
Mar 18 22:39:23 intermap kernel:   speedo_rx() status 0000a020 len 64.
Mar 18 22:39:23 intermap kernel: done,received=1
Mar 18 22:39:23 intermap kernel: eth0: interrupt  status=0x4050.
Mar 18 22:39:23 intermap kernel: switching to poll,status=4050
Mar 18 22:39:23 intermap kernel: eth0: exiting interrupt, status=0x4050.
Mar 18 22:39:23 intermap kernel:  In speedo_poll().
Mar 18 22:39:23 intermap kernel:  In speedo_rx().
Mar 18 22:39:23 intermap kernel:   speedo_rx() status 0000a020 len 78.
Mar 18 22:39:23 intermap kernel: done,received=1
Mar 18 22:39:23 intermap kernel: eth0: interrupt  status=0xa050.
Mar 18 22:39:23 intermap kernel:  scavenge candidate 0 status 600ca000.
Mar 18 22:39:23 intermap kernel: eth0: interrupt  status=0x0050.
Mar 18 22:39:23 intermap kernel: eth0: exiting interrupt, status=0x0050.

Notice three "eth0: Media control tick, status 0040." messages in a row,
this is precisely the black-out period. During normal activity,
it prints "eth0: Media control tick, status 0050." every 2 seconds.
Moreover, above are only "No resource,reset" messages that were
captured during test run.

This is lspci info about this NIC:

00:0f.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100]
(rev 08)
        Subsystem: Intel Corp. EtherExpress PRO/100+ Management Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at d5500000 (32-bit, non-prefetchable)
[size=4K]
        Region 1: I/O ports at c800 [size=64]
        Region 2: Memory at d5400000 (32-bit, non-prefetchable)
[size=1M]
        Expansion ROM at <unassigned> [disabled] [size=1M]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

Can anyone help me to make NAPI work? Does anyone even use NAPI
with eepro100, I guess not many people since the patch is pretty old
and I could not find it ported to 2.4.21-pre.


:wq
                                        With best regards, 
                                           Vladimir Savkin. 


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=koi8-r
Content-Disposition: attachment; filename="eepro100-napi-for2.4.21-pre5.diff"

--- linux/drivers/net/eepro100-nonapi.c	Mon Mar 17 15:08:40 2003
+++ linux/drivers/net/eepro100.c	Mon Mar 17 15:23:22 2003
@@ -29,7 +29,9 @@
 
 static const char *version =
 "eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html\n"
-"eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others\n";
+"eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others\n"
+"eepro100.c: NAPI\n"
+;
 
 /* A few user-configurable values that apply to all boards.
    First set is undocumented and spelled per Intel recommendations. */
@@ -133,6 +135,8 @@
 #define DEBUG			((debug >= 0) ? (1<<debug)-1 : DEBUG_DEFAULT)
 
 
+#define CONFIG_EEPRO100_NAPI
+
 MODULE_AUTHOR("Maintainer: Andrey V. Savochkin <saw@saw.sw.com.sg>");
 MODULE_DESCRIPTION("Intel i82557/i82558/i82559 PCI EtherExpressPro driver");
 MODULE_LICENSE("GPL");
@@ -499,20 +503,41 @@
 #ifdef CONFIG_PM
 	u32 pm_state[16];
 #endif
+
+	/* added by zfx for NAPI*/
+#ifdef CONFIG_EEPRO100_NAPI
+
+	/* used to pass rx_work_limit into speedo_rx,i don't want to 
+	 * change its prototype
+	 */
+	int curr_work_limit;
+
+	unsigned long poll_switch;
+	unsigned long failed_poll_switch;
+	unsigned long done_poll;
+	unsigned long notdone_poll;
+	unsigned long empty_poll;
+	unsigned long soft_reset_count;
+	unsigned long rx_resume_count;
+	unsigned long alloc_fail;
+	unsigned long long poll_cycles;
+
+#endif
 };
 
+
 /* The parameters for a CmdConfigure operation.
    There are so many options that it would be difficult to document each bit.
    We mostly use the default or recommended settings. */
 static const char i82557_config_cmd[CONFIG_DATA_SIZE] = {
 	22, 0x08, 0, 0,  0, 0, 0x32, 0x03,  1, /* 1=Use MII  0=Use AUI */
 	0, 0x2E, 0,  0x60, 0,
-	0xf2, 0x48,   0, 0x40, 0xf2, 0x80, 		/* 0x40=Force full-duplex */
+	0xf2, 0x48,   0, 0x40, 0xfa, 0x80, 		/* 0x40=Force full-duplex */
 	0x3f, 0x05, };
 static const char i82558_config_cmd[CONFIG_DATA_SIZE] = {
 	22, 0x08, 0, 1,  0, 0, 0x22, 0x03,  1, /* 1=Use MII  0=Use AUI */
 	0, 0x2E, 0,  0x60, 0x08, 0x88,
-	0x68, 0, 0x40, 0xf2, 0x84,		/* Disable FC */
+	0x68, 0, 0x40, 0xfa, 0x84,		/* Disable FC */
 	0x31, 0x05, };
 
 /* PHY media interface chips. */
@@ -549,6 +574,14 @@
 static void set_rx_mode(struct net_device *dev);
 static void speedo_show_state(struct net_device *dev);
 
+#ifdef CONFIG_EEPRO100_NAPI
+
+static int speedo_poll (struct net_device *dev, int *budget);
+static void enable_rx_and_rxnobuf_ints(struct net_device *dev);
+static void disable_rx_and_rxnobuf_ints(struct net_device *dev);
+
+#endif
+
 
 
 #ifdef honor_default_port
@@ -879,6 +912,10 @@
 	dev->set_multicast_list = &set_rx_mode;
 	dev->do_ioctl = &speedo_ioctl;
 
+#ifdef CONFIG_EEPRO100_NAPI
+	dev->poll = speedo_poll;
+	dev->quota = dev->weight = RX_RING_SIZE;
+#endif
 	return 0;
 }
 
@@ -1570,6 +1607,9 @@
 	struct speedo_private *sp;
 	long ioaddr, boguscnt = max_interrupt_work;
 	unsigned short status;
+#ifdef CONFIG_EEPRO100_NAPI
+	int first = 1;
+#endif
 
 	ioaddr = dev->base_addr;
 	sp = (struct speedo_private *)dev->priv;
@@ -1589,12 +1629,17 @@
 		/* Acknowledge all of the current interrupt sources ASAP. */
 		/* Will change from 0xfc00 to 0xff00 when we start handling
 		   FCP and ER interrupts --Dragan */
+#ifndef CONFIG_EEPRO100_NAPI
 		outw(status & 0xfc00, ioaddr + SCBStatus);
-
+#else
+		/* Rx & RxNoBuf is acked in speedo_poll */
+		outw(status & 0xac00, ioaddr + SCBStatus);
+#endif
 		if (netif_msg_intr(sp))
 			printk(KERN_DEBUG "%s: interrupt  status=%#4.4x.\n",
 				   dev->name, status);
 
+#ifndef CONFIG_EEPRO100_NAPI
 		if ((status & 0xfc00) == 0)
 			break;
 
@@ -1606,8 +1651,35 @@
 
 		/* Always check if all rx buffers are allocated.  --SAW */
 		speedo_refill_rx_buffers(dev, 0);
+#else
+		/* Packet received, or Rx error. */
+		if (first && ((status & 0x5000) || (sp->rx_ring_state&(RrNoMem|RrPostponed)) == RrPostponed || (status & 0x3c) != 0x10 ))
+			/* Need to gather the postponed packet. */
+		{
+			if (netif_msg_intr(sp)) 
+				printk(KERN_DEBUG "switching to poll,status=%x\n",status);
+			first = 0;
+			if (netif_rx_schedule_prep(dev)) {
+				sp->poll_switch++;
+				/* disable interrupts caused by arriving packets */
+				disable_rx_and_rxnobuf_ints(dev);
+				/* tell system we have work to be done. */
+				__netif_rx_schedule(dev);
+			}else {
+				/* fix race cases,maybe redundant */
+				disable_rx_and_rxnobuf_ints(dev);
+				sp->failed_poll_switch++;
+			}
+
+		}
+
+		if ((status & 0xac00) == 0)
+			break;
+#endif
 		
 		spin_lock(&sp->lock);
+
+#ifndef CONFIG_EEPRO100_NAPI
 		/*
 		 * The chip may have suspended reception for various reasons.
 		 * Check for that, and re-prime it should this be the case.
@@ -1627,7 +1699,7 @@
 			/* these are all reserved values */
 			break;
 		}
-		
+#endif
 		
 		/* User interrupt, Command/Tx unit interrupt or CU not active. */
 		if (status & 0xA400) {
@@ -1648,7 +1720,12 @@
 			/* Clear all interrupt sources. */
 			/* Will change from 0xfc00 to 0xff00 when we start handling
 			   FCP and ER interrupts --Dragan */
+#ifndef CONFIG_EEPRO100_NAPI
 			outw(0xfc00, ioaddr + SCBStatus);
+#else
+			outw(0xac00, ioaddr + SCBStatus);
+#endif
+
 			break;
 		}
 	} while (1);
@@ -1657,7 +1734,9 @@
 		printk(KERN_DEBUG "%s: exiting interrupt, status=%#4.4x.\n",
 			   dev->name, inw(ioaddr + SCBStatus));
 
+#ifndef final_version
 	clear_bit(0, (void*)&sp->in_interrupt);
+#endif
 	return;
 }
 
@@ -1673,6 +1752,9 @@
 	sp->rx_skbuff[entry] = skb;
 	if (skb == NULL) {
 		sp->rx_ringp[entry] = NULL;
+#ifdef CONFIG_EEPRO100_NAPI
+		sp->alloc_fail++;
+#endif
 		return NULL;
 	}
 	rxf = sp->rx_ringp[entry] = (struct RxFD *)skb->tail;
@@ -1753,12 +1835,127 @@
 			speedo_refill_rx_buf(dev, force) != -1);
 }
 
+#ifdef CONFIG_EEPRO100_NAPI
+static void enable_rx_and_rxnobuf_ints(struct net_device *dev)
+{
+	long ioaddr = dev->base_addr;
+	outw(SCBMaskEarlyRx | SCBMaskFlowCtl, ioaddr + SCBCmd);
+	inw(ioaddr + SCBStatus); /* flushes last write, read-safe */
+};
+
+static void disable_rx_and_rxnobuf_ints(struct net_device *dev)
+{
+	long ioaddr = dev->base_addr;
+	outw(SCBMaskRxDone | SCBMaskRxSuspend | SCBMaskEarlyRx | SCBMaskFlowCtl, ioaddr + SCBCmd);
+	inw(ioaddr + SCBStatus); /* flushes last write, read-safe */
+};
+
+static int speedo_poll (struct net_device *dev, int *budget)
+{
+	struct speedo_private *sp = (struct speedo_private *)dev->priv;
+	long ioaddr, received = 0;
+	unsigned short intr_status;
+
+	ioaddr = dev->base_addr;
+	intr_status = inw(ioaddr + SCBStatus);
+
+	if (netif_msg_intr(sp))
+		printk(KERN_DEBUG " In speedo_poll().\n");
+
+	sp->curr_work_limit = *budget;
+	if (sp->curr_work_limit > dev->quota) 
+		sp->curr_work_limit = dev->quota;
+
+	do {  
+		/* ack Rx & RxNobuf intrs*/
+		outw(intr_status & 0x5000, ioaddr + SCBStatus);
+
+		received += speedo_rx(dev);
+
+		if (sp->curr_work_limit < 0) /* out of quota */
+			goto not_done;
+
+		/* no packets on ring; but new ones can arrive since we last checked  */
+		intr_status = inw(ioaddr + SCBStatus);
+
+		if ((intr_status & 0x5000) == 0) {
+			/* If something arrives in this narrow window,an interrupt 
+			 * will be generated 
+			 */
+			goto done;
+		}
+		/* done! at least thats what it looks like ;->
+		   if new packets came in after our last check on status bits
+		   they'll be caught by the while check and we go back and clear them
+		   since we havent exceeded our quota 
+		 */
+	} while (intr_status & 0x5000);
+
+done:
+	if (!received) {
+		if (netif_msg_intr(sp)) 
+			printk(KERN_DEBUG "received==0\n");
+		received = 1;
+		sp->empty_poll++;
+	}
+	dev->quota -= received;
+	*budget -= received;
+
+	/* we are happy/done, no more packets on ring; put us back
+	 * to where we can start processing interrupts again 
+	 */
+
+	/* The last op happens after poll completion. Which means the following:
+	 * 1. it can race with disabling irqs in irq handler (which are done to 
+	 * schedule polls)
+	 * 2. it can race with dis/enabling irqs in other poll threads
+	 * 3. if an irq raised after the begining of the outer  beginning 
+	 * loop(marked in the code above), it will be immediately
+	 * triggered here.
+	 *
+	 * Summarizing: the logic may results in some redundant irqs both
+	 * due to races in masking and due to too late acking of already
+	 * processed irqs. The good news: no events are ever lost.
+	 */
+	netif_rx_complete(dev);
+	enable_rx_and_rxnobuf_ints(dev);
+
+	sp->done_poll++;
+
+	if (netif_msg_rx_status(sp))
+		printk(KERN_DEBUG "done,received=%lu\n",received);
+
+        return 0;   /* done */
+
+not_done:
+	if (!received) {
+		if (netif_msg_intr(sp)) 
+			printk(KERN_DEBUG "received==0\n");
+		received = 1;
+		sp->empty_poll++;
+	}
+	dev->quota -= received;
+	*budget -= received;
+
+	sp->notdone_poll++;
+
+	if (netif_msg_rx_status(sp))
+		printk(KERN_DEBUG "not done,received=%lu\n",received);
+
+	return 1;  /* not_done */
+}
+
+#endif /* NAPI */
+
 static int
 speedo_rx(struct net_device *dev)
 {
 	struct speedo_private *sp = (struct speedo_private *)dev->priv;
 	int entry = sp->cur_rx % RX_RING_SIZE;
+#ifndef CONFIG_EEPRO100_NAPI
 	int rx_work_limit = sp->dirty_rx + RX_RING_SIZE - sp->cur_rx;
+#endif
+	int received = 0;
 	int alloc_ok = 1;
 	int npkts = 0;
 
@@ -1774,11 +1971,35 @@
 		status = le32_to_cpu(sp->rx_ringp[entry]->status);
 		pkt_len = le32_to_cpu(sp->rx_ringp[entry]->count) & 0x3fff;
 
+#ifndef CONFIG_EEPRO100_NAPI
 		if (!(status & RxComplete))
 			break;
 
 		if (--rx_work_limit < 0)
 			break;
+#else
+		if (!(status & RxComplete)) {
+			int intr_status;
+			unsigned long ioaddr = dev->base_addr;
+
+			intr_status = inw(ioaddr + SCBStatus);
+			/* We check receiver state here because if 
+			 * we have to do soft reset,sp->cur_rx should
+			 * point to an empty entry or something 
+			 * unexpected will happen
+			 */
+			if ((intr_status & 0x3c) != 0x10) {
+				if (netif_msg_intr(sp)) 
+					printk(KERN_DEBUG "No resource,reset\n");
+				speedo_rx_soft_reset(dev);
+				sp->soft_reset_count++;
+			}
+			break;
+		}
+
+		if (--sp->curr_work_limit < 0) 
+			break;
+#endif
 
 		/* Check for a rare out-of-memory case: the current buffer is
 		   the last buffer allocated in the RX ring.  --SAW */
@@ -1844,7 +2065,12 @@
 						PKT_BUF_SZ + sizeof(struct RxFD), PCI_DMA_FROMDEVICE);
 			}
 			skb->protocol = eth_type_trans(skb, dev);
+#ifndef CONFIG_EEPRO100_NAPI
 			netif_rx(skb);
+#else
+			netif_receive_skb(skb);
+			received ++;
+#endif
 			sp->stats.rx_packets++;
 			sp->stats.rx_bytes += pkt_len;
 		}
@@ -1862,7 +2088,7 @@
 	if (npkts)
 		sp->last_rx_time = jiffies;
 
-	return 0;
+	return received;
 }
 
 static int

--ikeVEW9yuYc//A+q--
