Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310436AbSCGSNT>; Thu, 7 Mar 2002 13:13:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310437AbSCGSNK>; Thu, 7 Mar 2002 13:13:10 -0500
Received: from dsl-213-023-043-059.arcor-ip.net ([213.23.43.59]:64693 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S310434AbSCGSM4>;
	Thu, 7 Mar 2002 13:12:56 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: yodaiken@fsmlabs.com
Subject: Re: [RFC] Arch option to touch newly allocated pages
Date: Thu, 7 Mar 2002 19:07:23 +0100
X-Mailer: KMail [version 1.3.2]
Cc: yodaiken@fsmlabs.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Jeff Dike <jdike@karaya.com>, Benjamin LaHaise <bcrl@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
In-Reply-To: <E16iyGp-0002IL-00@the-village.bc.nu> <E16izrK-00038v-00@starship.berlin> <20020307095046.A29364@hq.fsmlabs.com>
In-Reply-To: <20020307095046.A29364@hq.fsmlabs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16j2IV-0003B6-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 7, 2002 05:50 pm, yodaiken@fsmlabs.com wrote:
> On Thu, Mar 07, 2002 at 04:31:10PM +0100, Daniel Phillips wrote:
> > > > > Why is that a fix? And how can it work?
> > > > 
> > > > Since there is always at least one freeable page in the system (or we're oom) then
> > > > we just have to find it and we know we can forcibly unmap it.  We do need to know
> > > > the total of pinned pages, I should have said locked/dirty/pinned.
> > > 
> > > What if we are oom?
> > 
> > This problem didn't get any worse, we still have to deal with it.  We can wait, so
> > we deal with it in the standard way (i.e., we puke, have to do something about that.)
> 
> So it can return NULL? 

Returning null here won't help if the caller doesn't have a fallback, or if the fallback
is unacceptable, such as losing a filesystem transaction.

> > > What if we are on our way to deadlock?
> > 
> > huh??
> 
> Process A needs 4 pages, Process B needs 4 pages, each grabs 3.

This is no new deadlock.  Supposing each has successfully grabbed 3, what
good does it do if the process is too clueless to release the pages it's
already grabbed, because the 4th page alloc fails?  (The first 3 may have
been alloced in a completely different part of the program.)  And if the
process does know how to do this, it should tell the VM that *then* the VM
should feel free to fail it.

> One easy, traditional unix algorithm for dealing with this is
> 	for(i=0; i < 4; i++)if !(p[i]=kmallloc(...))
>                                 free all that we have so far

Just or in GFP_ok_to_fail there.

> > > What if the caller of kmalloc will make less good use of the page
> > > than the current owner of the page?
> > 
> > That's life, that's what lrus are for.
> 
> Really? I thought LRUs were to approximate working sets. Obviously
> if a program is kmallocing its working set is changing but that
> does not tell us anything about whether it is a correct decision to
> rip a page from the working set of another process.

We're getting way far from the original question here.  Our lru has no
concept of working set, it's completely global.  That's not so great and
it's another problem to tackle.  Sometime.

> > You won't find one if you don't look for it.
> 
> I'm too dumb to come up with a solution here, but you are the one
> changing the interface, so surely you have a couple of "less borked"
> solutions in mind - right?

Yes.  Well, I'm not alone here, ping Marcelo on that if you like.  This is
known borkness that's been deferred while more pressing borkness is dealt
with.

-- 
Daniel
