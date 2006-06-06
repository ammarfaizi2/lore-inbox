Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbWFFR72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbWFFR72 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 13:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbWFFR72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 13:59:28 -0400
Received: from silver.veritas.com ([143.127.12.111]:49924 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1750732AbWFFR71
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 13:59:27 -0400
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.05,214,1146466800"; 
   d="scan'208"; a="38884843:sNHT22526764"
Date: Tue, 6 Jun 2006 18:59:12 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Christoph Lameter <clameter@sgi.com>
cc: Andrew Morton <akpm@osdl.org>, mbligh@google.com, apw@shadowen.org,
       mbligh@mbligh.org, linux-kernel@vger.kernel.org, ak@suse.de,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: 2.6.17-rc5-mm1
In-Reply-To: <Pine.LNX.4.64.0606061023080.27969@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.64.0606061850001.30030@blonde.wat.veritas.com>
References: <447DEF49.9070401@google.com> <20060531140652.054e2e45.akpm@osdl.org>
 <447E093B.7020107@mbligh.org> <20060531144310.7aa0e0ff.akpm@osdl.org>
 <447E104B.6040007@mbligh.org> <447F1702.3090405@shadowen.org>
 <44842C01.2050604@shadowen.org> <Pine.LNX.4.64.0606051137400.17951@schroedinger.engr.sgi.com>
 <44848DD2.7010506@shadowen.org> <Pine.LNX.4.64.0606051304360.18543@schroedinger.engr.sgi.com>
 <44848F45.1070205@shadowen.org> <44849075.5070802@google.com>
 <Pine.LNX.4.64.0606051325351.18717@schroedinger.engr.sgi.com>
 <Pine.LNX.4.64.0606051334010.18717@schroedinger.engr.sgi.com>
 <20060605135812.30138205.akpm@osdl.org> <Pine.LNX.4.64.0606060537460.6045@blonde.wat.veritas.com>
 <Pine.LNX.4.64.0606060923250.27550@schroedinger.engr.sgi.com>
 <Pine.LNX.4.64.0606061805380.28806@blonde.wat.veritas.com>
 <Pine.LNX.4.64.0606061023080.27969@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 06 Jun 2006 17:59:23.0046 (UTC) FILETIME=[F122D460:01C68992]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jun 2006, Christoph Lameter wrote:
> 
> Would it not be better for an arch to explicitly tell us how many swap 
> devices are supported? Then we could make the swap_info array shorter and 
> get rid of this cryptic test.

If they differed at all, yes.

> This test also creates a problem for the migration entries: It is really 
> not clear until runtime how many swap devices are supported so we cannot 
> take the last 2 for page migration. In order for page migration to work 
> all NUMA arches that do not support 32 swap devices need to define 
> CONFIG_MIGRATION=n. Seems that this is only s390?

Even s390 is okay, isn't it?  MartinS's swp_type returns the highest
type, 31, corresponding to 32 types, as on every other architecture.
You and I and Martin Bligh would prefer this patch...


Remove unnecessary obfuscation from sys_swapon's range check on swap
type, which blew up causing memory corruption once swapless migration
made MAX_SWAPFILES no longer 2 ^ MAX_SWAPFILES_SHIFT.

Signed-off-by: Hugh Dickins <hugh@veritas.com>

--- 2.6.17-rc5-mm3/mm/swapfile.c	2006-06-04 11:52:47.000000000 +0100
+++ linux/mm/swapfile.c	2006-06-06 18:53:40.000000000 +0100
@@ -1404,7 +1404,7 @@ asmlinkage long sys_swapon(const char __
 	 * from the initial ~0UL that can't be encoded in either the
 	 * swp_entry_t or the architecture definition of a swap pte.
 	 */
-	if (type > swp_type(pte_to_swp_entry(swp_entry_to_pte(swp_entry(~0UL,0))))) {
+	if (type >= MAX_SWAPFILES) {
 		spin_unlock(&swap_lock);
 		goto out;
 	}
