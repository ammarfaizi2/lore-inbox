Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964834AbWFSSqY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964834AbWFSSqY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 14:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964825AbWFSSnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 14:43:49 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:17097 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932544AbWFSSnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 14:43:25 -0400
Message-Id: <20060619183405.715054000@klappe.arndb.de>
References: <20060619183315.653672000@klappe.arndb.de>
Date: Mon, 19 Jun 2006 20:33:27 +0200
From: arnd@arndb.de
To: paulus@samba.org
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: [patch 12/20] spufs: dont try to access SPE channel 1 count
Content-Disposition: inline; filename=spufs-channel-1-count.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The save/restore sequence for SPE contexts currently attempts to save
and restore the channel count for SPE channel 1 (the SPU_WriteEventMask
channel.  But the CBE architecture (section 9.11.2) clearly states
that this channel does not have an associated count.  Hardware simply
ignores the attempt to write this count, but the simulator generates
a warning message.

WARNING: 279721590: SPE7: Attempt to write channel count for CH 1 with
no associated count is ignored.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Index: powerpc.git/arch/powerpc/platforms/cell/spufs/switch.c
===================================================================
--- powerpc.git.orig/arch/powerpc/platforms/cell/spufs/switch.c
+++ powerpc.git/arch/powerpc/platforms/cell/spufs/switch.c
@@ -622,12 +622,17 @@ static inline void save_ppuint_mb(struct
 static inline void save_ch_part1(struct spu_state *csa, struct spu *spu)
 {
 	struct spu_priv2 __iomem *priv2 = spu->priv2;
-	u64 idx, ch_indices[7] = { 0UL, 1UL, 3UL, 4UL, 24UL, 25UL, 27UL };
+	u64 idx, ch_indices[7] = { 0UL, 3UL, 4UL, 24UL, 25UL, 27UL };
 	int i;
 
 	/* Save, Step 42:
-	 *     Save the following CH: [0,1,3,4,24,25,27]
 	 */
+
+	/* Save CH 1, without channel count */
+	out_be64(&priv2->spu_chnlcntptr_RW, 1);
+	csa->spu_chnldata_RW[1] = in_be64(&priv2->spu_chnldata_RW);
+
+	/* Save the following CH: [0,3,4,24,25,27] */
 	for (i = 0; i < 7; i++) {
 		idx = ch_indices[i];
 		out_be64(&priv2->spu_chnlcntptr_RW, idx);
@@ -1105,13 +1110,18 @@ static inline void clear_spu_status(stru
 static inline void reset_ch_part1(struct spu_state *csa, struct spu *spu)
 {
 	struct spu_priv2 __iomem *priv2 = spu->priv2;
-	u64 ch_indices[7] = { 0UL, 1UL, 3UL, 4UL, 24UL, 25UL, 27UL };
+	u64 ch_indices[7] = { 0UL, 3UL, 4UL, 24UL, 25UL, 27UL };
 	u64 idx;
 	int i;
 
 	/* Restore, Step 20:
-	 *     Reset the following CH: [0,1,3,4,24,25,27]
 	 */
+
+	/* Reset CH 1 */
+	out_be64(&priv2->spu_chnlcntptr_RW, 1);
+	out_be64(&priv2->spu_chnldata_RW, 0UL);
+
+	/* Reset the following CH: [0,3,4,24,25,27] */
 	for (i = 0; i < 7; i++) {
 		idx = ch_indices[i];
 		out_be64(&priv2->spu_chnlcntptr_RW, idx);
@@ -1572,12 +1582,17 @@ static inline void restore_decr_wrapped(
 static inline void restore_ch_part1(struct spu_state *csa, struct spu *spu)
 {
 	struct spu_priv2 __iomem *priv2 = spu->priv2;
-	u64 idx, ch_indices[7] = { 0UL, 1UL, 3UL, 4UL, 24UL, 25UL, 27UL };
+	u64 idx, ch_indices[7] = { 0UL, 3UL, 4UL, 24UL, 25UL, 27UL };
 	int i;
 
 	/* Restore, Step 59:
-	 *     Restore the following CH: [0,1,3,4,24,25,27]
 	 */
+
+	/* Restore CH 1 without count */
+	out_be64(&priv2->spu_chnlcntptr_RW, 1);
+	out_be64(&priv2->spu_chnldata_RW, csa->spu_chnldata_RW[1]);
+
+	/* Restore the following CH: [0,3,4,24,25,27] */
 	for (i = 0; i < 7; i++) {
 		idx = ch_indices[i];
 		out_be64(&priv2->spu_chnlcntptr_RW, idx);

--

