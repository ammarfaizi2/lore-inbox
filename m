Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261645AbSLHMjl>; Sun, 8 Dec 2002 07:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265414AbSLHMjl>; Sun, 8 Dec 2002 07:39:41 -0500
Received: from dp.samba.org ([66.70.73.150]:45447 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261645AbSLHMji>;
	Sun, 8 Dec 2002 07:39:38 -0500
Date: Sun, 8 Dec 2002 23:44:44 +1100
From: Anton Blanchard <anton@samba.org>
To: linux-kernel@vger.kernel.org
Subject: 2.5.50 + e100 benchmarking
Message-ID: <20021208124444.GA18751@krispykreme>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi,

Ive got the benchmarking itch and am still waiting for the mail to
deliver me some e1000 size christmas presents, so Ive started playing
with some e100s that were lying around.

Setup:

2.5.50-BK, 2 ppc64 partitions, one e100 card in each, 1500 byte MTU.
In all the runs we were pumping 11.76MB/sec down the socket.

We are sending bytes down a TCP socket (using tridge's socklib), the send
side looks like:

write(4, "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ"..., 65536) = 65536

So we are pushing 64kB into the networking layer at a time. And the
read side looks like this:

read(3, "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ"..., 65536) = 8688

So we are getting about 8kB per read. (Im guessing due to rx interrupt
mitigation).

First let me explain the patches I have attached.

1. e100_nodisable
e100_intr was the worst function in a profile. PCI reads are very costly
(and PCI reads that flush posted writes are even worse) and we were
disabling and enabling the on chip interrupt bit for each interrupt
(both operations had a PCI read to flush the write).

The question is, why do we need to disable and reenable interrupts via
the on chip status register? At least on ppc64 we cant take the same
interrupt recursively, isnt this the case on x86?

Andrew Morton's cyclesoak to the rescue:

Before:
System load:  6.4% || Free:  74.4%(0) 100.1%(1) 100.1%(2)  99.7%(3)

After:
System load:  5.1% || Free:  79.6%(0) 100.0%(1) 100.1%(2)  99.7%(3)

(Ignore the 3 other cpus, I have locked both irq and process to cpu 0)

74.4% -> 79.6% idle. So e100_nodisable is worth 5% on my machine. Not bad.

2. e100_txchecksum
In recent 2.5 I found almost every tx packet had an invalid pseudo
header checksum. We didnt catch this in 2.4 because we would only use tx
checksumming for zero copy. In 2.5 we use it whenever we can (and thats
good, our copy_to/from_user has been optimised to within an inch of its
life thanks to paulus).

Anyway, I know zip about this stuff but it seems (from a quick look
of the acenic and tg3 drivers) that Linux always computes this
checksum. Bottom line is the patch fixes the problems I was seeing.

OK now to get a feel for what is going on:

sending (roughly):
9k irqs/second
900 context switches/second
20.5% CPU

receiving (roughly):
2.3k irqs/second
3k context switches/second
13.5% CPU

Most of the extra cost on send appears to be the higher interrupt rate.
So this begs the question, can we be more agressive with the tx
interrupt mitigation? I had a quick play with some of the e100 options
and it gave some short term relief (4k/sec) but then jumped back up to
9k/sec again.

For those who have made it this far down, here are some profiles :)

http://samba.org/~anton/linux/2.5.50-BK/e100/

Keep in mind no idle time shows up here because I was running akpm(TM)
cyclesoak.

As you can see for the receiving side (sock_sink), copy_tofrom user is
the worst offender. Very nice. Ignore plpar_hcall_norets, its some magic
we do for dynamic PCI mapping. Also note profile hits get attributed to
the following instruction, eg in e100intr we see a bunch of time just
after the first lhbrx (the number on the left is % time of the entire
function). lhbrx is a byte reversed load - in this case it happens to be
a PCI memory read.

On the send side (sock_source) the higher interrupt rate shows up.
(hmm I wonder how we got idle time here, cyclesoak should have sucked
all of it up).

Anton

--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=e100_nodisable

===== drivers/net/e100/e100_main.c 1.30 vs edited =====
--- 1.30/drivers/net/e100/e100_main.c	Sat Nov 30 03:18:46 2002
+++ edited/drivers/net/e100/e100_main.c	Sun Dec  8 20:54:06 2002
@@ -1774,15 +1774,11 @@
 		return;
 	}
 
-	/* disable intr before we ack & after identifying the intr as ours */
-	e100_dis_intr(bdp);
-
 	writew(intr_status, &bdp->scb->scb_status);	/* ack intrs */
 	readw(&bdp->scb->scb_status);
 
 	/* the device is closed, don't continue or else bad things may happen. */
 	if (!netif_running(dev)) {
-		e100_set_intr_mask(bdp);
 		return;
 	}
 
@@ -1801,8 +1797,6 @@
 		bdp->tx_count = 0;	/* restart tx interrupt batch count */
 		e100_tx_srv(bdp);
 	}
-
-	e100_set_intr_mask(bdp);
 }
 
 /**


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=e100_txchecksum

===== drivers/net/e100/e100.h 1.19 vs edited =====
--- 1.19/drivers/net/e100/e100.h	Wed Nov  6 03:31:33 2002
+++ edited/drivers/net/e100/e100.h	Sun Dec  8 20:43:03 2002
@@ -705,8 +705,6 @@
 #define IPCB_HARDWAREPARSING_ENABLE	BIT_0
 #define IPCB_INSERTVLAN_ENABLE 		BIT_1
 #define IPCB_IP_ACTIVATION_DEFAULT      IPCB_HARDWAREPARSING_ENABLE
-
-#define FOLD_CSUM(_XSUM)  ((((_XSUM << 16) | (_XSUM >> 16)) + _XSUM) >> 16)
 
 /* Transmit Buffer Descriptor (TBD)*/
 typedef struct _tbd_t {
===== drivers/net/e100/e100_main.c 1.30 vs edited =====
--- 1.30/drivers/net/e100/e100_main.c	Sat Nov 30 03:18:46 2002
+++ edited/drivers/net/e100/e100_main.c	Sun Dec  8 20:54:06 2002
@@ -2053,32 +2047,6 @@
 }
 
 /**
- * e100_pseudo_hdr_csum - compute IP pseudo-header checksum
- * @ip: points to the header of the IP packet
- *
- * Return the 16 bit checksum of the IP pseudo-header.,which is computed
- * on the fields: IP src, IP dst, next protocol, payload length.
- * The checksum vaule is returned in network byte order.
- */
-static inline u16
-e100_pseudo_hdr_csum(const struct iphdr *ip)
-{
-	u32 pseudo = 0;
-	u32 payload_len = 0;
-
-	payload_len = ntohs(ip->tot_len) - (ip->ihl * 4);
-
-	pseudo += htons(payload_len);
-	pseudo += (ip->protocol << 8);
-	pseudo += ip->saddr & 0x0000ffff;
-	pseudo += (ip->saddr & 0xffff0000) >> 16;
-	pseudo += ip->daddr & 0x0000ffff;
-	pseudo += (ip->daddr & 0xffff0000) >> 16;
-
-	return FOLD_CSUM(pseudo);
-}
-
-/**
  * e100_prepare_xmit_buff - prepare a buffer for transmission
  * @bdp: atapter's private data struct
  * @skb: skb to send
@@ -2121,27 +2089,13 @@
 
 		if ((ip->protocol == IPPROTO_TCP) ||
 		    (ip->protocol == IPPROTO_UDP)) {
-			u16 *chksum;
-
 			tcb->tcbu.ipcb.ip_activation_high =
 				IPCB_HARDWAREPARSING_ENABLE;
 			tcb->tcbu.ipcb.ip_schedule |=
 				IPCB_TCPUDP_CHECKSUM_ENABLE;
 
-			if (ip->protocol == IPPROTO_TCP) {
-				struct tcphdr *tcp;
-
-				tcp = (struct tcphdr *) ((u32 *) ip + ip->ihl);
-				chksum = &(tcp->check);
+			if (ip->protocol == IPPROTO_TCP)
 				tcb->tcbu.ipcb.ip_schedule |= IPCB_TCP_PACKET;
-			} else {
-				struct udphdr *udp;
-
-				udp = (struct udphdr *) ((u32 *) ip + ip->ihl);
-				chksum = &(udp->check);
-			}
-
-			*chksum = e100_pseudo_hdr_csum(ip);
 		}
 	}
 


--OXfL5xGRrasGEqWY--
