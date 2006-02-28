Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751119AbWB1SsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbWB1SsJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 13:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbWB1SsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 13:48:09 -0500
Received: from smtp.osdl.org ([65.172.181.4]:11713 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751119AbWB1SsG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 13:48:06 -0500
Date: Tue, 28 Feb 2006 10:46:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pavel@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH -mm 2/2] mm: make shrink_all_memory try harder
Message-Id: <20060228104638.2251d469.akpm@osdl.org>
In-Reply-To: <200602281825.55355.rjw@sisk.pl>
References: <200602271926.20294.rjw@sisk.pl>
	<200602271930.03171.rjw@sisk.pl>
	<20060227192532.0a71e19b.akpm@osdl.org>
	<200602281825.55355.rjw@sisk.pl>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> wrote:
>
> On Tuesday 28 February 2006 04:25, Andrew Morton wrote:
> > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > >
> > > Make shrink_all_memory() repeat the attempts to free more memory if there
> > > seems to be no pages to free.
> > > 
> > 
> > This description doesn't describe what the problem is, not how the patch
> > fixes it.  So I'm kinda left guessing.
> 
> I have described it in the 0/0 message, but I should have repeated that in the
> changelog, sorry.

Actually these [patch 0/n] emails are a nuisance - some poor schmuck just
has to copy-n-paste that text into the fist patch's changelog anwyay.

> > swsusp should call drop_pagecache() and then drop_slab() before trying to
> > use shrink_all_memory(), btw.
> 
> Well, sometimes we don't need to free a lot of memory.

OK.  But if clean pagecache and reclaimable slabs are left in memory,
they'll have to be written to swap, won't they?

It could well be more efficent to restore them from swap.  Slower suspend,
faster resume.

> > +	if (retry-- && ret < nr_pages) {
> > +		blk_congestion_wait(WRITE, HZ/5);
> > +		goto repeat;
> > +	}
> 
> I'd like to do this only if ret is 0.

Well I figured that this was a more general approach: we were _asked_ to
free that many pages.  If we haven't done that yet, keep trying.  Can you
test that code please?

