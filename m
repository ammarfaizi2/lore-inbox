Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261608AbTH2R36 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 13:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261643AbTH2R35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 13:29:57 -0400
Received: from 224.Red-217-125-129.pooles.rima-tde.net ([217.125.129.224]:54252
	"HELO cocodriloo.com") by vger.kernel.org with SMTP id S261608AbTH2R3r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 13:29:47 -0400
Date: Fri, 29 Aug 2003 16:57:49 +0200
From: Antonio Vargas <wind@cocodriloo.com>
To: Shantanu Goel <sgoel01@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [VM PATCH] Faster reclamation of dirty pages and unused inode/dcache entries in 2.4.22
Message-ID: <20030829145749.GA709@wind.cocodriloo.com>
References: <20030829150111.72151.qmail@web12802.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030829150111.72151.qmail@web12802.mail.yahoo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 29, 2003 at 08:01:11AM -0700, Shantanu Goel wrote:
> Hi kernel hackers,
> 
> The VM subsystem in Linux 2.4.22 can cause spurious
> swapouts in the presence of lots of dirty pages. 
> Presently, as dirty pages are encountered,
> shrink_cache() schedules a writepage() and moves the
> page to the head of the inactive list.  When a lot of
> dirty pages are present, this can break the FIFO
> ordering of the inactive list because clean pages
> further down the list will be reclaimed first.  The
> following patch records the pages being laundered, and
> once SWAP_CLUSTER_MAX pages have been accumulated or
> the scan is complete, goes back and attempts to move
> them back to the tail of the list.
> 
> The second part of the patch reclaims unused
> inode/dentry/dquot entries more aggressively.  I have
> observed that on an NFS server where swap out activity
> is low, the VM can shrink the page cache to the point
> where most pages are used up by unused inode/dentry
> entries.  This is because page cache reclamation
> succeeds most of the time except when a swap_out()
> happens.
> 
> Feedback and comments are welcome.

Microoptimization (which helps on x86 a lot):
 
-       for (i = nr_pages - 1; i >= 0; i--) {
-               page = laundry[i];
+	laundry += nr_pages;
+	for (i = -nr_pages; ++i ;){
+               page = laundry[i];

Your original code reads from higher to lower addresses,
while the new one reads from lower to higer addresses.

The new code changes and then tests the loop counter,
so it's a little bit faster :)

Both check against zero, so both can use result flags
directly and do no intervening "cmp ecx,CONSTANT".

To the "powers that be", would this type of microoptimizations
be futher welcomed?

Greets, Antonio.
