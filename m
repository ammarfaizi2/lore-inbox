Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262586AbVA0Ljn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262586AbVA0Ljn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 06:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262585AbVA0Ljn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 06:39:43 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52870 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262586AbVA0Lji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 06:39:38 -0500
Date: Thu, 27 Jan 2005 05:44:59 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Ake <Ake.Sandgren@hpc2n.umu.se>
Cc: linux-kernel@vger.kernel.org, Rik van Riel <riel@redhat.com>
Subject: Re: Bug in 2.4.26 in mm/filemap.c when using RLIMIT_RSS
Message-ID: <20050127074459.GH26308@logos.cnet>
References: <20050126110750.GE7349@hpc2n.umu.se> <20050126144904.GE26308@logos.cnet> <20050127063849.GA11119@hpc2n.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050127063849.GA11119@hpc2n.umu.se>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2005 at 07:38:49AM +0100, Ake wrote:

> On Wed, Jan 26, 2005 at 12:49:04PM -0200, Marcelo Tosatti wrote:
> > > There is also a misinformative comment in fs/proc/array.c
 > > in proc_pid_stat where it says
> > > mm ? mm->rss : 0, /* you might want to shift this left 3 */
> > > the number 3 should probably be PAGE_SHIFT-10.
> 
> Don't forget the comment (it's still there in 2.6) :-)
> 
> > Amazing that this has never been noticed before - I bet not many people use RSS 
> > limits with madvise().
> 
> Neither do we. :-)
> 
> I just found it when trying to figure out if the kernel actually used
> any of the rlimits and if so how.
> (Trying to make PBS work correctly)
> 
> > This transform the rlimit in pages before the comparison, can you please test
> > it.
> > 
> > --- a/mm/filemap.c.orig	2004-11-17 09:54:22.000000000 -0200
> > +++ b/mm/filemap.c	2005-01-26 15:21:10.614842296 -0200
> > @@ -2609,6 +2609,9 @@
> >  	error = -EIO;
> >  	rlim_rss = current->rlim ?  current->rlim[RLIMIT_RSS].rlim_cur :
> >  				LONG_MAX; /* default: see resource.h */
> > +
> > +	rlim_rss = (rlim_rss & PAGE_MASK) >> PAGE_SHIFT;
> > +
> >  	if ((vma->vm_mm->rss + (end - start)) > rlim_rss)
> >  		return error;
> 
> Since we don't use it i can't really test it, but a visual inspection is
> good enough in this simple case. And since this is the only place in 2.4
> that RLIMIT_RSS is used, the problem is solved.
> 
> BTW do you know if there is any plans for 2.6++ to actually use
> RLIMIT_RSS? I saw a hint in that direction in mm/thrash.c
> grab_swap_token but it is commented out and only skeleton code...

Nope, RLIMIT_RSS does not seem to be used at all in v2.6:

linux-2.6.11-rc1 # findgrep RLIMIT_RSS
./fs/proc/array.c
./include/asm-arm26/resource.h
./include/asm-ia64/resource.h
./include/asm-frv/resource.h
./include/asm-i386/resource.h
./include/asm-alpha/resource.h
./include/asm-ppc64/resource.h
./include/asm-x86_64/resource.h
./include/asm-s390/resource.h
./include/asm-mips/resource.h
./include/asm-sparc64/resource.h
./include/asm-cris/resource.h
./include/asm-v850/resource.h
./include/asm-m68k/resource.h
./include/asm-sparc/resource.h
./include/asm-parisc/resource.h
./include/asm-arm/resource.h
./include/asm-sh/resource.h
./include/asm-m32r/resource.h
./include/asm-h8300/resource.h
./include/asm-ppc/resource.h

> I'm asking since the above code piece has been removed.

Its there for compatibility reasons, support for it might be added
in the future?
