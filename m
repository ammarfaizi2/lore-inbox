Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263912AbTEOJeJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 05:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263915AbTEOJeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 05:34:09 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:27016
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263912AbTEOJeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 05:34:07 -0400
Date: Thu, 15 May 2003 11:46:56 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@redhat.com>
Cc: Dave McCracken <dmccr@us.ibm.com>, Andrew Morton <akpm@digeo.com>,
       mika.penttila@kolumbus.fi, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: Race between vmtruncate and mapped areas?
Message-ID: <20030515094656.GB1429@dualathlon.random>
References: <20030515004915.GR1429@dualathlon.random> <Pine.LNX.4.44.0305142234120.20800-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305142234120.20800-100000@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 14, 2003 at 10:36:23PM -0400, Rik van Riel wrote:
> On Thu, 15 May 2003, Andrea Arcangeli wrote:
> 
> > --- x/include/linux/fs.h.~1~	2003-05-14 23:26:19.000000000 +0200
> > +++ x/include/linux/fs.h	2003-05-15 02:35:57.000000000 +0200
> > @@ -421,6 +421,8 @@ struct address_space {
> >  	struct vm_area_struct	*i_mmap;	/* list of private mappings */
> >  	struct vm_area_struct	*i_mmap_shared; /* list of shared mappings */
> >  	spinlock_t		i_shared_lock;  /* and spinlock protecting it */
> > +	int			truncate_sequence1; /* serialize ->nopage against truncate */
> > +	int			truncate_sequence2; /* serialize ->nopage against truncate */
> 
> How about calling them truncate_start and truncate_end ?

Normally we use start/end for ranges, this is not a range, so I wouldn't
suggest it, but I don't care about names.

> > --- x/mm/vmscan.c.~1~	2003-05-14 23:26:12.000000000 +0200
> > +++ x/mm/vmscan.c	2003-05-15 00:22:57.000000000 +0200
> > @@ -165,11 +165,10 @@ drop_pte:
> >  		goto drop_pte;
> >  
> >  	/*
> > -	 * Anonymous buffercache pages can be left behind by
> > +	 * Anonymous buffercache pages can't be left behind by
> >  	 * concurrent truncate and pagefault.
> >  	 */
> > -	if (page->buffers)
> > -		goto preserve;
> > +	BUG_ON(page->buffers);
> 
> I wonder if there is nothing else that can leave behind
> buffers in this way.

that's why I left the BUG_ON, if there's anything else I want to know,
there shouldn't be anything else as the comment also suggest. I recall
when we discussed this single check with Andrew and that was the only
reason we left it AFIK.

> > +	mb(); /* spin_lock has inclusive semantics */
> > +	if (unlikely(truncate_sequence != mapping->truncate_sequence1)) {
> > +		struct inode *inode;
> 
> This code looks like it should work, but IMHO it is very subtle
> so it should really get some documentation.

Andrea
