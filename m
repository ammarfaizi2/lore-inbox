Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261228AbVA0WJI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbVA0WJI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 17:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbVA0WJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 17:09:08 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:54672 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261228AbVA0WI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 17:08:59 -0500
Date: Fri, 28 Jan 2005 15:09:40 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Ake <Ake.Sandgren@hpc2n.umu.se>, linux-kernel@vger.kernel.org,
       Rik van Riel <riel@redhat.com>
Subject: Re: Bug in 2.4.26 in mm/filemap.c when using RLIMIT_RSS
In-Reply-To: <20050127074459.GH26308@logos.cnet>
Message-ID: <Pine.LNX.4.61.0501281502540.10979@goblin.wat.veritas.com>
References: <20050126110750.GE7349@hpc2n.umu.se> 
    <20050126144904.GE26308@logos.cnet> <20050127063849.GA11119@hpc2n.umu.se> 
    <20050127074459.GH26308@logos.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jan 2005, Marcelo Tosatti wrote:
> On Thu, Jan 27, 2005 at 07:38:49AM +0100, Ake wrote:
> > On Wed, Jan 26, 2005 at 12:49:04PM -0200, Marcelo Tosatti wrote:
> > > 
> > > --- a/mm/filemap.c.orig	2004-11-17 09:54:22.000000000 -0200
> > > +++ b/mm/filemap.c	2005-01-26 15:21:10.614842296 -0200
> > > @@ -2609,6 +2609,9 @@
> > >  	error = -EIO;
> > >  	rlim_rss = current->rlim ?  current->rlim[RLIMIT_RSS].rlim_cur :
> > >  				LONG_MAX; /* default: see resource.h */
> > > +
> > > +	rlim_rss = (rlim_rss & PAGE_MASK) >> PAGE_SHIFT;
> > > +
> > >  	if ((vma->vm_mm->rss + (end - start)) > rlim_rss)
> > >  		return error;

Isn't the right fix just to remove rlim_rss and this RLIMIT_RSS code
from here?  It's pretty silly for madvise alone to be taking notice
of it.  Presumably the code crept in by mistake from some tree which
was using an RLIMIT_RSS patch on 2.4.

> > Since we don't use it i can't really test it, but a visual inspection is
> > good enough in this simple case. And since this is the only place in 2.4
> > that RLIMIT_RSS is used, the problem is solved.
> > 
> > BTW do you know if there is any plans for 2.6++ to actually use
> > RLIMIT_RSS? I saw a hint in that direction in mm/thrash.c
> > grab_swap_token but it is commented out and only skeleton code...
> 
> Nope, RLIMIT_RSS does not seem to be used at all in v2.6:
> 
> Its there for compatibility reasons, support for it might be added
> in the future?

Rik had a patch implementing RLIMIT_RSS in 2.6-mm for a while.
But I think there were a couple of problems with it, and no great
demand for the feature, so Andrew dropped it until someone makes
a better case for it.

Hugh
