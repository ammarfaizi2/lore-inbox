Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265713AbUBKTkV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 14:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265728AbUBKTkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 14:40:20 -0500
Received: from ida.rowland.org ([192.131.102.52]:56324 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S265713AbUBKTkK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 14:40:10 -0500
Date: Wed, 11 Feb 2004 14:40:09 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: eric.piel@tremplin-utc.net
cc: Johannes Erdfelt <johannes@erdfelt.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Slight optimisation of the uhci-hcd init code
In-Reply-To: <1076335524.402793a4d04e9@mailetu.utc.fr>
Message-ID: <Pine.LNX.4.44L0.0402111436580.791-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric, Johannes:

Thought you might like to see this...  I need to make sure it works right, 
and then it's going in.

Alan Stern


===== uhci-hcd.c 1.80 vs edited =====
--- 1.80/drivers/usb/host/uhci-hcd.c	Tue Feb 10 00:33:10 2004
+++ edited/drivers/usb/host/uhci-hcd.c	Wed Feb 11 14:34:51 2004
@@ -2336,16 +2336,17 @@
 	}
 
 	/*
-	 * 8 Interrupt queues; link int2 to int1, int4 to int2, etc
+	 * 8 Interrupt queues; link all higher int queues to int1,
 	 * then link int1 to control and control to bulk
 	 */
-	uhci->skel_int128_qh->link = cpu_to_le32(uhci->skel_int64_qh->dma_handle) | UHCI_PTR_QH;
-	uhci->skel_int64_qh->link = cpu_to_le32(uhci->skel_int32_qh->dma_handle) | UHCI_PTR_QH;
-	uhci->skel_int32_qh->link = cpu_to_le32(uhci->skel_int16_qh->dma_handle) | UHCI_PTR_QH;
-	uhci->skel_int16_qh->link = cpu_to_le32(uhci->skel_int8_qh->dma_handle) | UHCI_PTR_QH;
-	uhci->skel_int8_qh->link = cpu_to_le32(uhci->skel_int4_qh->dma_handle) | UHCI_PTR_QH;
-	uhci->skel_int4_qh->link = cpu_to_le32(uhci->skel_int2_qh->dma_handle) | UHCI_PTR_QH;
-	uhci->skel_int2_qh->link = cpu_to_le32(uhci->skel_int1_qh->dma_handle) | UHCI_PTR_QH;
+	uhci->skel_int128_qh->link =
+			uhci->skel_int64_qh->link =
+			uhci->skel_int32_qh->link =
+			uhci->skel_int16_qh->link =
+			uhci->skel_int8_qh->link =
+			uhci->skel_int4_qh->link =
+			uhci->skel_int2_qh->link =
+			cpu_to_le32(uhci->skel_int1_qh->dma_handle) | UHCI_PTR_QH;
 	uhci->skel_int1_qh->link = cpu_to_le32(uhci->skel_ls_control_qh->dma_handle) | UHCI_PTR_QH;
 
 	uhci->skel_ls_control_qh->link = cpu_to_le32(uhci->skel_hs_control_qh->dma_handle) | UHCI_PTR_QH;
@@ -2361,39 +2362,33 @@
 	uhci->skel_term_qh->element = cpu_to_le32(uhci->term_td->dma_handle);
 
 	/*
-	 * Fill the frame list: make all entries point to
-	 * the proper interrupt queue.
+	 * Fill the frame list: make all entries point to the proper
+	 * interrupt queue.
 	 *
-	 * This is probably silly, but it's a simple way to
-	 * scatter the interrupt queues in a way that gives
-	 * us a reasonable dynamic range for irq latencies.
+	 * The interrupt queues will be interleaved as evenly as possible.
+	 * There's not much to be done about period-1 interrupts; they have
+	 * to occur in every frame.  But we can schedule period-2 interrupts
+	 * in odd-numbered frames, period-4 interrupts in frames congruent
+	 * to 2 (mod 4), and so on.  This way each frame only has two
+	 * interrupt QHs, which will help spread out bandwidth utilization.
 	 */
 	for (i = 0; i < UHCI_NUMFRAMES; i++) {
-		int irq = 0;
+		int irq;
 
-		if (i & 1) {
-			irq++;
-			if (i & 2) {
-				irq++;
-				if (i & 4) { 
-					irq++;
-					if (i & 8) { 
-						irq++;
-						if (i & 16) {
-							irq++;
-							if (i & 32) {
-								irq++;
-								if (i & 64)
-									irq++;
-							}
-						}
-					}
-				}
-			}
-		}
+		/*
+		 * ffs (Find First bit Set) does exactly what we need:
+		 * 1,3,5,...  => ffs = 0 => use skel_int2_qh = skelqh[6],
+		 * 2,6,10,... => ffs = 1 => use skel_int4_qh = skelqh[5], etc.
+		 * ffs > 6 => not on any high-period queue, so use
+		 *	skel_int1_qh = skelqh[7].
+		 * Add UHCI_NUMFRAMES to insure at least one bit is set.
+		 */
+		irq = 6 - (int) __ffs(i + UHCI_NUMFRAMES);
+		if (irq < 0)
+			irq = 7;
 
 		/* Only place we don't use the frame list routines */
-		uhci->fl->frame[i] = cpu_to_le32(uhci->skelqh[7 - irq]->dma_handle);
+		uhci->fl->frame[i] = cpu_to_le32(uhci->skelqh[irq]->dma_handle);
 	}
 
 	start_hc(uhci);

