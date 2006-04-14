Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965086AbWDNBCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965086AbWDNBCm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 21:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965039AbWDNBCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 21:02:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54718 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965086AbWDNBCl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 21:02:41 -0400
Date: Thu, 13 Apr 2006 18:01:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: hugh@veritas.com, linux-kernel@vger.kernel.org, lee.schermerhorn@hp.com,
       linux-mm@kvack.org, taka@valinux.co.jp, marcelo.tosatti@cyclades.com,
       kamezawa.hiroyu@jp.fujitsu.com
Subject: Re: [PATCH 2/5] Swapless V2: Add migration swap entries
Message-Id: <20060413180159.0c01beb7.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604131743180.15965@schroedinger.engr.sgi.com>
References: <20060413235406.15398.42233.sendpatchset@schroedinger.engr.sgi.com>
	<20060413235416.15398.49978.sendpatchset@schroedinger.engr.sgi.com>
	<20060413171331.1752e21f.akpm@osdl.org>
	<Pine.LNX.4.64.0604131728150.15802@schroedinger.engr.sgi.com>
	<20060413174232.57d02343.akpm@osdl.org>
	<Pine.LNX.4.64.0604131743180.15965@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@sgi.com> wrote:
>
> On Thu, 13 Apr 2006, Andrew Morton wrote:
> 
> > Christoph Lameter <clameter@sgi.com> wrote:
> > >
> > > On Thu, 13 Apr 2006, Andrew Morton wrote:
> > > 
> > > > Christoph Lameter <clameter@sgi.com> wrote:
> > > > >
> > > > > +
> > > > >  +	if (unlikely(is_migration_entry(entry))) {
> > > > 
> > > > Perhaps put the unlikely() in is_migration_entry()?
> > > > 
> > > > >  +		yield();
> > > > 
> > > > Please, no yielding.
> > > > 
> > > > _especially_ no unchangelogged, uncommented yielding.
> > > 
> > > Page migration is ongoing so its best to do something else first.
> > 
> > That doesn't help a lot.  What is "something else"?  What are the dynamics
> > in there, and why do you feel that some sort of delay is needed?
> 
> Page migration is ongoing for the page that was faulted. This means 
> the migration thread has torn down the ptes and replaced them with 
> migration entries in order to prevent access to this page. The migration
> thread is continuing the process of tearing down ptes, copying the page 
> and then rebuilding the ptes.  When the ptes are back then the fault 
> handler will no longer be invoked or it will fix up some of the bits in 
> the ptes. This takes a short time, the more ptes point to a page the 
> longer it will take to replace them.

So we falsely return VM_FAULT_MINOR and let userspace retake the pagefault,
thus implementing a form of polling, yes?  If so, there is no "something
else" which this process can do.

Pages are locked during migration.  The faulting process will sleep in
lock_page() until migration is complete.  Except we've gone and diddled
with the swap pte so do_swap_page() can no longer locate the page which
needs to be locked.

Doing a busy-wait seems a bit lame.  Perhaps it would be better to go to
sleep on some global queue, poke that queue each time a page migration
completes?

