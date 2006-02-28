Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932603AbWB1XEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932603AbWB1XEv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 18:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932702AbWB1XEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 18:04:51 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:44219 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932603AbWB1XEu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 18:04:50 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH -mm 2/2] mm: make shrink_all_memory try harder
Date: Wed, 1 Mar 2006 00:04:28 +0100
User-Agent: KMail/1.9.1
Cc: pavel@suse.cz, linux-kernel@vger.kernel.org
References: <200602271926.20294.rjw@sisk.pl> <200602281825.55355.rjw@sisk.pl> <20060228104638.2251d469.akpm@osdl.org>
In-Reply-To: <20060228104638.2251d469.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603010004.29968.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 28 February 2006 19:46, Andrew Morton wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> >
> > On Tuesday 28 February 2006 04:25, Andrew Morton wrote:
> > > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > > >
> > > > Make shrink_all_memory() repeat the attempts to free more memory if there
> > > > seems to be no pages to free.
> > > > 
> > > 
> > > This description doesn't describe what the problem is, not how the patch
> > > fixes it.  So I'm kinda left guessing.
> > 
> > I have described it in the 0/0 message, but I should have repeated that in the
> > changelog, sorry.
> 
> Actually these [patch 0/n] emails are a nuisance - some poor schmuck just
> has to copy-n-paste that text into the fist patch's changelog anwyay.
> 
> > > swsusp should call drop_pagecache() and then drop_slab() before trying to
> > > use shrink_all_memory(), btw.
> > 
> > Well, sometimes we don't need to free a lot of memory.
> 
> OK.  But if clean pagecache and reclaimable slabs are left in memory,
> they'll have to be written to swap, won't they?

Yes, but then we write them more or less linearly and we can also compress
them. :-)
 
> It could well be more efficent to restore them from swap.  Slower suspend,
> faster resume.
> 
> > > +	if (retry-- && ret < nr_pages) {
> > > +		blk_congestion_wait(WRITE, HZ/5);
> > > +		goto repeat;
> > > +	}
> > 
> > I'd like to do this only if ret is 0.
> 
> Well I figured that this was a more general approach: we were _asked_ to
> free that many pages.  If we haven't done that yet, keep trying.  Can you
> test that code please?

So far, it works just fine.  Thanks.

[Tested on 2.6.16-rc4-mm2, because -rc5-mm1 crashes on my system in a
spectacular way (already reported separately).]
