Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750911AbWFFSPd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750911AbWFFSPd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 14:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750903AbWFFSPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 14:15:33 -0400
Received: from silver.veritas.com ([143.127.12.111]:37730 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1750894AbWFFSPc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 14:15:32 -0400
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.05,214,1146466800"; 
   d="scan'208"; a="38885571:sNHT23806076"
Date: Tue, 6 Jun 2006 19:15:21 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
cc: Christoph Lameter <clameter@sgi.com>, Andrew Morton <akpm@osdl.org>,
       mbligh@google.com, apw@shadowen.org, mbligh@mbligh.org,
       linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: 2.6.17-rc5-mm1
In-Reply-To: <1149617155.29059.74.camel@localhost>
Message-ID: <Pine.LNX.4.64.0606061909360.31871@blonde.wat.veritas.com>
References: <447DEF49.9070401@google.com>  <20060531140652.054e2e45.akpm@osdl.org>
 <447E093B.7020107@mbligh.org>  <20060531144310.7aa0e0ff.akpm@osdl.org>
 <447E104B.6040007@mbligh.org>  <447F1702.3090405@shadowen.org>
 <44842C01.2050604@shadowen.org>  <Pine.LNX.4.64.0606051137400.17951@schroedinger.engr.sgi.com>
  <44848DD2.7010506@shadowen.org>  <Pine.LNX.4.64.0606051304360.18543@schroedinger.engr.sgi.com>
  <44848F45.1070205@shadowen.org> <44849075.5070802@google.com> 
 <Pine.LNX.4.64.0606051325351.18717@schroedinger.engr.sgi.com> 
 <Pine.LNX.4.64.0606051334010.18717@schroedinger.engr.sgi.com> 
 <20060605135812.30138205.akpm@osdl.org>  <Pine.LNX.4.64.0606060537460.6045@blonde.wat.veritas.com>
  <Pine.LNX.4.64.0606060923250.27550@schroedinger.engr.sgi.com> 
 <Pine.LNX.4.64.0606061805380.28806@blonde.wat.veritas.com> 
 <Pine.LNX.4.64.0606061023080.27969@schroedinger.engr.sgi.com> 
 <Pine.LNX.4.64.0606061850001.30030@blonde.wat.veritas.com>
 <1149617155.29059.74.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 06 Jun 2006 18:15:31.0469 (UTC) FILETIME=[325C73D0:01C68995]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jun 2006, Martin Schwidefsky wrote:
> On Tue, 2006-06-06 at 18:59 +0100, Hugh Dickins wrote:
> > Even s390 is okay, isn't it?  MartinS's swp_type returns the highest
> > type, 31, corresponding to 32 types, as on every other architecture.
> > You and I and Martin Bligh would prefer this patch...
> 
> As long as nobody will have the smart idea to increase MAX_SWAPFILES to
> more than 32 I'm fine with it.

Thanks, Martin: we know very well that we cannot increase MAX_SWAPFILES
without going through all the architectures adjusting their swap ptes
(and maybe making MAX_SWAPFILES_SHIFT per-arch), so I don't see any
problem there.  But Christoph has observed that the comment becomes
out-of-date, so updated patch (adding your ack) below...


Remove unnecessary obfuscation from sys_swapon's range check on swap
type, which blew up causing memory corruption once swapless migration
made MAX_SWAPFILES no longer 2 ^ MAX_SWAPFILES_SHIFT.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

--- 2.6.17-rc5-mm3/mm/swapfile.c	2006-06-04 11:52:47.000000000 +0100
+++ linux/mm/swapfile.c	2006-06-06 19:08:51.000000000 +0100
@@ -1392,19 +1392,7 @@ asmlinkage long sys_swapon(const char __
 		if (!(p->flags & SWP_USED))
 			break;
 	error = -EPERM;
-	/*
-	 * Test if adding another swap device is possible. There are
-	 * two limiting factors: 1) the number of bits for the swap
-	 * type swp_entry_t definition and 2) the number of bits for
-	 * the swap type in the swap ptes as defined by the different
-	 * architectures. To honor both limitations a swap entry
-	 * with swap offset 0 and swap type ~0UL is created, encoded
-	 * to a swap pte, decoded to a swp_entry_t again and finally
-	 * the swap type part is extracted. This will mask all bits
-	 * from the initial ~0UL that can't be encoded in either the
-	 * swp_entry_t or the architecture definition of a swap pte.
-	 */
-	if (type > swp_type(pte_to_swp_entry(swp_entry_to_pte(swp_entry(~0UL,0))))) {
+	if (type >= MAX_SWAPFILES) {
 		spin_unlock(&swap_lock);
 		goto out;
 	}
