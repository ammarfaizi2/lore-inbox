Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945932AbWBCT42@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945932AbWBCT42 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 14:56:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945935AbWBCT4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 14:56:24 -0500
Received: from gold.veritas.com ([143.127.12.110]:21063 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1945934AbWBCT4R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 14:56:17 -0500
Date: Fri, 3 Feb 2006 19:56:55 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Willem Riede <osst@riede.org>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: [PATCH] osst: don't doublefree pages from scatterlist
In-Reply-To: <Pine.LNX.4.61.0602031842290.14065@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0602031955240.14829@goblin.wat.veritas.com>
References: <Pine.LNX.4.63.0512271807130.4955@kai.makisara.local>
 <20060104172727.GA320@tau.solarneutrino.net> <Pine.LNX.4.63.0601042334310.5087@kai.makisara.local>
 <20060105201249.GB1795@tau.solarneutrino.net> <Pine.LNX.4.64.0601051312380.3169@g5.osdl.org>
 <20060109033149.GC283@tau.solarneutrino.net> <Pine.LNX.4.64.0601082000450.3169@g5.osdl.org>
 <Pine.LNX.4.61.0601090933160.7632@goblin.wat.veritas.com>
 <20060109185350.GG283@tau.solarneutrino.net> <Pine.LNX.4.61.0601091922550.15426@goblin.wat.veritas.com>
 <20060118001252.GB821@tau.solarneutrino.net> <Pine.LNX.4.61.0601181556050.9110@goblin.wat.veritas.com>
 <Pine.LNX.4.61.0602031842290.14065@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 03 Feb 2006 19:56:16.0260 (UTC) FILETIME=[E4871C40:01C628FB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On some architectures, mapping the scatterlist may coalesce entries:
if that coalesced list is then used for freeing the pages afterwards,
there's a danger that pages may be doubly freed (and others leaked).

Fix OnStream SCSI Tape's normalize_buffer by freeing from a second list
beyond the I/O scatterlist, saving page pointers with their lengths.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---
Warning: untested!

 drivers/scsi/osst.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

--- 2.6.16-rc2/drivers/scsi/osst.c	2006-01-03 03:21:10.000000000 +0000
+++ linux/drivers/scsi/osst.c	2006-02-03 09:59:37.000000000 +0000
@@ -5152,7 +5152,8 @@ static struct osst_buffer * new_tape_buf
 	else
 		priority = GFP_KERNEL;
 
-	i = sizeof(struct osst_buffer) + (osst_max_sg_segs - 1) * sizeof(struct scatterlist);
+	i = sizeof(struct osst_buffer) +
+		(2 * osst_max_sg_segs - 1) * sizeof(struct scatterlist);
 	tb = (struct osst_buffer *)kmalloc(i, priority);
 	if (!tb) {
 		printk(KERN_NOTICE "osst :I: Can't allocate new tape buffer.\n");
@@ -5227,6 +5228,8 @@ static int enlarge_buffer(struct osst_bu
 #if DEBUG
 			STbuffer->buffer_size = got;
 #endif
+			memcpy(STbuffer->sg + STbuffer->sg_segs, STbuffer->sg,
+				STbuffer->sg_segs * sizeof(STbuffer->sg[0]));
 			normalize_buffer(STbuffer);
 			return 0;
 		}
@@ -5235,6 +5238,9 @@ static int enlarge_buffer(struct osst_bu
 		STbuffer->buffer_size = got;
 		STbuffer->sg_segs = ++segs;
 	}
+	/* Save uncoalesced scatterlist of pages to be freed */
+	memcpy(STbuffer->sg + STbuffer->sg_segs, STbuffer->sg,
+		STbuffer->sg_segs * sizeof(STbuffer->sg[0]));
 #if DEBUG
 	if (debugging) {
 		printk(OSST_DEB_MSG
@@ -5254,9 +5260,10 @@ static int enlarge_buffer(struct osst_bu
 /* Release the segments */
 static void normalize_buffer(struct osst_buffer *STbuffer)
 {
-  int i, order, b_size;
+	int i, order, b_size;
 
-	for (i=0; i < STbuffer->sg_segs; i++) {
+	/* Scatterlist entries may have been coalesced: free saved pagelist */
+	for (i = STbuffer->sg_segs; i < 2*STbuffer->sg_segs; i++) {
 
 		for (b_size = PAGE_SIZE, order = 0;
 		     b_size < STbuffer->sg[i].length;
