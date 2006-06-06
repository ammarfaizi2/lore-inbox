Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750819AbWFFSFG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbWFFSFG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 14:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbWFFSFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 14:05:05 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:12179 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750819AbWFFSFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 14:05:03 -0400
Date: Tue, 6 Jun 2006 11:04:43 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       mbligh@google.com, apw@shadowen.org, mbligh@mbligh.org,
       linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: 2.6.17-rc5-mm1
In-Reply-To: <1149614184.29059.47.camel@localhost>
Message-ID: <Pine.LNX.4.64.0606061039570.27969@schroedinger.engr.sgi.com>
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
 <1149614184.29059.47.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jun 2006, Martin Schwidefsky wrote:

> swp_type(pte_to_swp_entry(swp_entry_to_pte(swp_entry(~0UL,0))))
> evaluates to 31 for s390. The idea has been that the creation of a swap
> entry with ~0UL as the type should mask off all bits that can not be
> represented in a swap entry. Convert it back and you have the maximum
> number of swap devices. That should be true for all architectures.

It evaluates to 31 it seems for all platforms. Could we replace this 
expression with MAX_SWAPFILES? While we at it get rid of the "type" 
variable because we are usually using pointers to swap_info.

Note that there is  still another similar check in there for an arch 
specific test of the number of pages available per swap device.


Index: linux-2.6.17-rc5-mm2/mm/swapfile.c
===================================================================
--- linux-2.6.17-rc5-mm2.orig/mm/swapfile.c	2006-06-01 10:03:07.127259731 -0700
+++ linux-2.6.17-rc5-mm2/mm/swapfile.c	2006-06-06 10:50:09.692165312 -0700
@@ -1363,12 +1363,11 @@ __initcall(procswaps_init);
  */
 asmlinkage long sys_swapon(const char __user * specialfile, int swap_flags)
 {
-	struct swap_info_struct * p;
+	struct swap_info_struct *p,*q;
 	char *name = NULL;
 	struct block_device *bdev = NULL;
 	struct file *swap_file = NULL;
 	struct address_space *mapping;
-	unsigned int type;
 	int i, prev;
 	int error;
 	static int least_priority;
@@ -1387,29 +1386,19 @@ asmlinkage long sys_swapon(const char __
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 	spin_lock(&swap_lock);
-	p = swap_info;
-	for (type = 0 ; type < nr_swapfiles ; type++,p++)
+
+	for (p = swap_info; p < swap_info + nr_swapfiles; p++)
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
+
+	if (p == swap_info + MAX_SWAPFILES) {
 		spin_unlock(&swap_lock);
 		goto out;
 	}
-	if (type >= nr_swapfiles)
-		nr_swapfiles = type+1;
+	if (p >= swap_info + nr_swapfiles)
+		nr_swapfiles++;
+
 	INIT_LIST_HEAD(&p->extent_list);
 	p->flags = SWP_USED;
 	p->swap_file = NULL;
@@ -1445,10 +1434,9 @@ asmlinkage long sys_swapon(const char __
 	inode = mapping->host;
 
 	error = -EBUSY;
-	for (i = 0; i < nr_swapfiles; i++) {
-		struct swap_info_struct *q = &swap_info[i];
+	for (q = swap_info; q < swap_info + nr_swapfiles; q++) {
 
-		if (i == type || !q->swap_file)
+		if (q == p || !q->swap_file)
 			continue;
 		if (mapping == q->swap_file->f_mapping)
 			goto bad_swap;




