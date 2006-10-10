Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750831AbWJJOzb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbWJJOzb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 10:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932135AbWJJOzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 10:55:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:24529 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750831AbWJJOz3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 10:55:29 -0400
Date: Tue, 10 Oct 2006 16:55:26 +0200
From: Karsten Keil <kkeil@suse.de>
To: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re:[PATCH] ISDN: several minor fixes
Message-ID: <20061010145526.GA20160@pingi.kke.suse.de>
Mail-Followup-To: Jeff Garzik <jeff@garzik.org>,
	Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: SuSE Linux AG
X-Operating-System: Linux 2.6.16.21-0.23-smp x86_64
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


pcbit: kill 'may be used uninitialized' warning.  although the code does
eventually fill the 32 bits it cares about, the variable truly is
accessed uninitialized in each macro.  Easier to just clean it up now.

sc: fix a ton of obviously incorrect printk's (some with missing
arguments even)

Signed-off-by: Jeff Garzik <jeff@garzik.org>
Acked-by: Karsten Keil <kkeil@suse.de>

---

 drivers/isdn/pcbit/layer2.c |    1 +
 drivers/isdn/sc/init.c      |   23 ++++++++++++-----------
 drivers/isdn/sc/packet.c    |   14 +++++++-------
 drivers/isdn/sc/shmem.c     |    2 +-
 4 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/drivers/isdn/pcbit/layer2.c b/drivers/isdn/pcbit/layer2.c
index 13e7d21..937fd21 100644
--- a/drivers/isdn/pcbit/layer2.c
+++ b/drivers/isdn/pcbit/layer2.c
@@ -311,6 +311,7 @@ pcbit_deliver(void *data)
 		dev->read_queue = frame->next;
 		spin_unlock_irqrestore(&dev->lock, flags);
 
+		msg = 0;
 		SET_MSG_CPU(msg, 0);
 		SET_MSG_PROC(msg, 0);
 		SET_MSG_CMD(msg, frame->skb->data[2]);
diff --git a/drivers/isdn/sc/init.c b/drivers/isdn/sc/init.c
index 222ca7c..06c9872 100644
--- a/drivers/isdn/sc/init.c
+++ b/drivers/isdn/sc/init.c
@@ -98,13 +98,14 @@ #endif
 			 * Confirm the I/O Address with a test
 			 */
 			if(io[b] == 0) {
-				pr_debug("I/O Address 0x%x is in use.\n");
+				pr_debug("I/O Address invalid.\n");
 				continue;
 			}
 
 			outb(0x18, io[b] + 0x400 * EXP_PAGE0);
 			if(inb(io[b] + 0x400 * EXP_PAGE0) != 0x18) {
-				pr_debug("I/O Base 0x%x fails test\n");
+				pr_debug("I/O Base 0x%x fails test\n",
+					 io[b] + 0x400 * EXP_PAGE0);
 				continue;
 			}
 		}
@@ -158,8 +159,8 @@ #endif
 			outb(0xFF, io[b] + RESET_OFFSET);
 			msleep_interruptible(10000);
 		}
-		pr_debug("RAM Base for board %d is 0x%x, %s probe\n", b, ram[b],
-			ram[b] == 0 ? "will" : "won't");
+		pr_debug("RAM Base for board %d is 0x%lx, %s probe\n", b,
+			ram[b], ram[b] == 0 ? "will" : "won't");
 
 		if(ram[b]) {
 			/*
@@ -168,7 +169,7 @@ #endif
 			 * board model
 			 */
 			if(request_region(ram[b], SRAM_PAGESIZE, "sc test")) {
-				pr_debug("request_region for RAM base 0x%x succeeded\n", ram[b]);
+				pr_debug("request_region for RAM base 0x%lx succeeded\n", ram[b]);
 			 	model = identify_board(ram[b], io[b]);
 				release_region(ram[b], SRAM_PAGESIZE);
 			}
@@ -204,7 +205,7 @@ #endif
 			 * Nope, there was no place in RAM for the
 			 * board, or it couldn't be identified
 			 */
-			 pr_debug("Failed to find an adapter at 0x%x\n", ram[b]);
+			 pr_debug("Failed to find an adapter at 0x%lx\n", ram[b]);
 			 continue;
 		}
 
@@ -451,7 +452,7 @@ static int identify_board(unsigned long 
 	HWConfig_pl hwci;
 	int x;
 
-	pr_debug("Attempting to identify adapter @ 0x%x io 0x%x\n",
+	pr_debug("Attempting to identify adapter @ 0x%lx io 0x%x\n",
 		rambase, iobase);
 
 	/*
@@ -490,7 +491,7 @@ static int identify_board(unsigned long 
 	outb(PRI_BASEPG_VAL, pgport);
 	msleep_interruptible(1000);
 	sig = readl(rambase + SIG_OFFSET);
-	pr_debug("Looking for a signature, got 0x%x\n", sig);
+	pr_debug("Looking for a signature, got 0x%lx\n", sig);
 	if(sig == SIGNATURE)
 		return PRI_BOARD;
 
@@ -500,7 +501,7 @@ static int identify_board(unsigned long 
 	outb(BRI_BASEPG_VAL, pgport);
 	msleep_interruptible(1000);
 	sig = readl(rambase + SIG_OFFSET);
-	pr_debug("Looking for a signature, got 0x%x\n", sig);
+	pr_debug("Looking for a signature, got 0x%lx\n", sig);
 	if(sig == SIGNATURE)
 		return BRI_BOARD;
 
@@ -510,7 +511,7 @@ static int identify_board(unsigned long 
 	 * Try to spot a card
 	 */
 	sig = readl(rambase + SIG_OFFSET);
-	pr_debug("Looking for a signature, got 0x%x\n", sig);
+	pr_debug("Looking for a signature, got 0x%lx\n", sig);
 	if(sig != SIGNATURE)
 		return -1;
 
@@ -540,7 +541,7 @@ static int identify_board(unsigned long 
 	memcpy_fromio(&rcvmsg, &(dpm->rsp_queue[dpm->rsp_tail]), MSG_LEN);
 	pr_debug("Got HWConfig response, status = 0x%x\n", rcvmsg.rsp_status);
 	memcpy(&hwci, &(rcvmsg.msg_data.HWCresponse), sizeof(HWConfig_pl));
-	pr_debug("Hardware Config: Interface: %s, RAM Size: %d, Serial: %s\n"
+	pr_debug("Hardware Config: Interface: %s, RAM Size: %ld, Serial: %s\n"
 		 "                 Part: %s, Rev: %s\n",
 		 hwci.st_u_sense ? "S/T" : "U", hwci.ram_size,
 		 hwci.serial_no, hwci.part_no, hwci.rev_no);
diff --git a/drivers/isdn/sc/packet.c b/drivers/isdn/sc/packet.c
index f50defc..1e04676 100644
--- a/drivers/isdn/sc/packet.c
+++ b/drivers/isdn/sc/packet.c
@@ -44,7 +44,7 @@ int sndpkt(int devId, int channel, struc
 		return -ENODEV;
 	}
 
-	pr_debug("%s: sndpkt: frst = 0x%x nxt = %d  f = %d n = %d\n",
+	pr_debug("%s: sndpkt: frst = 0x%lx nxt = %d  f = %d n = %d\n",
 		sc_adapter[card]->devicename,
 		sc_adapter[card]->channel[channel].first_sendbuf,
 		sc_adapter[card]->channel[channel].next_sendbuf,
@@ -66,7 +66,7 @@ int sndpkt(int devId, int channel, struc
 	ReqLnkWrite.buff_offset = sc_adapter[card]->channel[channel].next_sendbuf *
 		BUFFER_SIZE + sc_adapter[card]->channel[channel].first_sendbuf;
 	ReqLnkWrite.msg_len = data->len; /* sk_buff size */
-	pr_debug("%s: writing %d bytes to buffer offset 0x%x\n",
+	pr_debug("%s: writing %d bytes to buffer offset 0x%lx\n",
 			sc_adapter[card]->devicename,
 			ReqLnkWrite.msg_len, ReqLnkWrite.buff_offset);
 	memcpy_toshmem(card, (char *)ReqLnkWrite.buff_offset, data->data, ReqLnkWrite.msg_len);
@@ -74,7 +74,7 @@ int sndpkt(int devId, int channel, struc
 	/*
 	 * sendmessage
 	 */
-	pr_debug("%s: sndpkt size=%d, buf_offset=0x%x buf_indx=%d\n",
+	pr_debug("%s: sndpkt size=%d, buf_offset=0x%lx buf_indx=%d\n",
 		sc_adapter[card]->devicename,
 		ReqLnkWrite.msg_len, ReqLnkWrite.buff_offset,
 		sc_adapter[card]->channel[channel].next_sendbuf);
@@ -124,7 +124,7 @@ void rcvpkt(int card, RspMessage *rcvmsg
 			return;
 		}
 		skb_put(skb, rcvmsg->msg_data.response.msg_len);
-		pr_debug("%s: getting data from offset: 0x%x\n",
+		pr_debug("%s: getting data from offset: 0x%lx\n",
 			sc_adapter[card]->devicename,
 			rcvmsg->msg_data.response.buff_offset);
 		memcpy_fromshmem(card,
@@ -143,7 +143,7 @@ void rcvpkt(int card, RspMessage *rcvmsg
 /*		memset_shmem(card, rcvmsg->msg_data.response.buff_offset, 0, BUFFER_SIZE); */
 		newll.buff_offset = rcvmsg->msg_data.response.buff_offset;
 		newll.msg_len = BUFFER_SIZE;
-		pr_debug("%s: recycled buffer at offset 0x%x size %d\n",
+		pr_debug("%s: recycled buffer at offset 0x%lx size %d\n",
 			sc_adapter[card]->devicename,
 			newll.buff_offset, newll.msg_len);
 		sendmessage(card, CEPID, ceReqTypeLnk, ceReqClass1, ceReqLnkRead,
@@ -186,7 +186,7 @@ int setup_buffers(int card, int c)
 	sc_adapter[card]->channel[c-1].num_sendbufs = nBuffers / 2;
 	sc_adapter[card]->channel[c-1].free_sendbufs = nBuffers / 2;
 	sc_adapter[card]->channel[c-1].next_sendbuf = 0;
-	pr_debug("%s: send buffer setup complete: first=0x%x n=%d f=%d, nxt=%d\n",
+	pr_debug("%s: send buffer setup complete: first=0x%lx n=%d f=%d, nxt=%d\n",
 				sc_adapter[card]->devicename,
 				sc_adapter[card]->channel[c-1].first_sendbuf,
 				sc_adapter[card]->channel[c-1].num_sendbufs,
@@ -203,7 +203,7 @@ int setup_buffers(int card, int c)
 			((sc_adapter[card]->channel[c-1].first_sendbuf +
 			(nBuffers / 2) * buffer_size) + (buffer_size * i));
 		RcvBuffOffset.msg_len = buffer_size;
-		pr_debug("%s: adding RcvBuffer #%d offset=0x%x sz=%d bufsz:%d\n",
+		pr_debug("%s: adding RcvBuffer #%d offset=0x%lx sz=%d bufsz:%d\n",
 				sc_adapter[card]->devicename,
 				i + 1, RcvBuffOffset.buff_offset, 
 				RcvBuffOffset.msg_len,buffer_size);
diff --git a/drivers/isdn/sc/shmem.c b/drivers/isdn/sc/shmem.c
index 2485482..6f58862 100644
--- a/drivers/isdn/sc/shmem.c
+++ b/drivers/isdn/sc/shmem.c
@@ -61,7 +61,7 @@ void memcpy_toshmem(int card, void *dest
 	spin_unlock_irqrestore(&sc_adapter[card]->lock, flags);
 	pr_debug("%s: set page to %#x\n",sc_adapter[card]->devicename,
 		((sc_adapter[card]->shmem_magic + ch * SRAM_PAGESIZE)>>14)|0x80);
-	pr_debug("%s: copying %d bytes from %#x to %#x\n",
+	pr_debug("%s: copying %d bytes from %#lx to %#lx\n",
 		sc_adapter[card]->devicename, n,
 		(unsigned long) src,
 		sc_adapter[card]->rambase + ((unsigned long) dest %0x4000));

