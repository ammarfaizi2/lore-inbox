Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261621AbTH2Rzs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 13:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbTH2Rzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 13:55:48 -0400
Received: from web12803.mail.yahoo.com ([216.136.174.38]:38798 "HELO
	web12803.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261621AbTH2Rzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 13:55:45 -0400
Message-ID: <20030829175544.84979.qmail@web12803.mail.yahoo.com>
Date: Fri, 29 Aug 2003 10:55:44 -0700 (PDT)
From: Shantanu Goel <sgoel01@yahoo.com>
Subject: Re: [VM PATCH] Faster reclamation of dirty pages and unused inode/dcache entries in 2.4.22
To: Antonio Vargas <wind@cocodriloo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030829145749.GA709@wind.cocodriloo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am not very knowledgeable about micro-optimizations.
 I'll take your word for it. ;-)  What interests me
more is whether others notice any performance
improvement under swapout with this patch given that
is on the order of milliseconds.

--- Antonio Vargas <wind@cocodriloo.com> wrote:
> On Fri, Aug 29, 2003 at 08:01:11AM -0700, Shantanu
> Goel wrote:
> > Hi kernel hackers,
> > 
> > The VM subsystem in Linux 2.4.22 can cause
> spurious
> > swapouts in the presence of lots of dirty pages. 
> > Presently, as dirty pages are encountered,
> > shrink_cache() schedules a writepage() and moves
> the
> > page to the head of the inactive list.  When a lot
> of
> > dirty pages are present, this can break the FIFO
> > ordering of the inactive list because clean pages
> > further down the list will be reclaimed first. 
> The
> > following patch records the pages being laundered,
> and
> > once SWAP_CLUSTER_MAX pages have been accumulated
> or
> > the scan is complete, goes back and attempts to
> move
> > them back to the tail of the list.
> > 
> > The second part of the patch reclaims unused
> > inode/dentry/dquot entries more aggressively.  I
> have
> > observed that on an NFS server where swap out
> activity
> > is low, the VM can shrink the page cache to the
> point
> > where most pages are used up by unused
> inode/dentry
> > entries.  This is because page cache reclamation
> > succeeds most of the time except when a swap_out()
> > happens.
> > 
> > Feedback and comments are welcome.
> 
> Microoptimization (which helps on x86 a lot):
>  
> -       for (i = nr_pages - 1; i >= 0; i--) {
> -               page = laundry[i];
> +	laundry += nr_pages;
> +	for (i = -nr_pages; ++i ;){
> +               page = laundry[i];
> 
> Your original code reads from higher to lower
> addresses,
> while the new one reads from lower to higer
> addresses.
> 
> The new code changes and then tests the loop
> counter,
> so it's a little bit faster :)
> 
> Both check against zero, so both can use result
> flags
> directly and do no intervening "cmp ecx,CONSTANT".
> 
> To the "powers that be", would this type of
> microoptimizations
> be futher welcomed?
> 
> Greets, Antonio.


__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com
