Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262040AbULCGVh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbULCGVh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 01:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbULCGVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 01:21:36 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:64163 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262040AbULCGVd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 01:21:33 -0500
Date: Fri, 3 Dec 2004 17:18:35 +1100
From: Nathan Scott <nathans@sgi.com>
To: Stefan Schmidt <zaphodb@zaphods.net>, Andrew Morton <akpm@osdl.org>
Cc: xhejtman@mail.muni.cz, marcelo.tosatti@cyclades.com,
       piggin@cyberone.com.au, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com
Subject: Re: Kernel 2.6.9 Multiple Page Allocation Failures
Message-ID: <20041203061835.GF1228@frodo>
References: <20041113144743.GL20754@zaphods.net> <20041116093311.GD11482@logos.cnet> <20041116170527.GA3525@mail.muni.cz> <20041121014350.GJ4999@zaphods.net> <20041121024226.GK4999@zaphods.net> <20041202195422.GA20771@mail.muni.cz> <20041202122546.59ff814f.akpm@osdl.org> <20041202210348.GD20771@mail.muni.cz> <20041202223146.GA31508@zaphods.net> <20041202145610.49e27b49.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041202145610.49e27b49.akpm@osdl.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

On Thu, Dec 02, 2004 at 02:56:10PM -0800, Andrew Morton wrote:
> Stefan Schmidt <zaphodb@zaphods.net> wrote:
> >
> > and ~80kpps in each direction at ~44k interrupts/s, so the problematic
> > combination seems to be many open files, high i/o transaction rate or
> > troughput and heavy networking load. (tso currently on)
> > Caching on ext2-fs in general seemed to generate less page allocation errors
> > than on xfs and none of the traces i looked over so far showed involvement
> > of the filesystem i.e. were all triggered by alloc_skb.
> 
> hm, OK, interesting.
> 
> It's quite possible that XFS is performing rather too many GFP_ATOMIC
> allocations and is depleting the page reserves.  Although increasing
> /proc/sys/vm/min_free_kbytes should help there.
> 
> Nathan, it would be a worthwhile exercise to consider replacing GFP_ATOMIC
> with (GFP_ATOMIC & ~ __GFP_HIGH) where appropriate.
> ...

(i.e. zero?  so future-proofing for if GFP_ATOMIC != __GFP_HIGH?)

> If there are places in XFS where it only needs one of these two behaviours,
> it would be good to select just that one.

OK, I took a quick look through - there's two places where we use
GFP_ATOMIC at the moment.  One is a log debug/tracing chunk of code,
wont be coming into play here, I'll go back and rework that later.
The second is in the metadata buffering code, and is in a spot where
we can cope with a failure (don't need to dip into emergency pools
at all) but looks like we're avoiding sleeping there.

Does this patch improve things for your workload, Stefan?

cheers.

-- 
Nathan


Index: xfs-linux-2.6/fs/xfs/linux-2.6/xfs_buf.c
===================================================================
--- xfs-linux-2.6.orig/fs/xfs/linux-2.6/xfs_buf.c
+++ xfs-linux-2.6/fs/xfs/linux-2.6/xfs_buf.c
@@ -183,7 +183,7 @@
 {
 	a_list_t	*aentry;
 
-	aentry = kmalloc(sizeof(a_list_t), GFP_ATOMIC);
+	aentry = kmalloc(sizeof(a_list_t), (GFP_ATOMIC & ~__GFP_HIGH));
 	if (aentry) {
 		spin_lock(&as_lock);
 		aentry->next = as_free_head;
