Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285644AbRLGW4w>; Fri, 7 Dec 2001 17:56:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285639AbRLGW4n>; Fri, 7 Dec 2001 17:56:43 -0500
Received: from adsl-64-168-153-221.dsl.snfc21.pacbell.net ([64.168.153.221]:42640
	"EHLO unifiedcomputing.com") by vger.kernel.org with ESMTP
	id <S285635AbRLGW4b>; Fri, 7 Dec 2001 17:56:31 -0500
Message-Id: <4.2.2.20011207142839.00b48fe8@slither>
X-Mailer: QUALCOMM Windows Eudora Pro Version 4.2.2 
Date: Fri, 07 Dec 2001 14:47:22 -0800
To: "Stephen C. Tweedie" <sct@redhat.com>
From: "S. Parker" <linux@sparker.net>
Subject: Re: [PATCH] VM system in 2.4.16 doesn't try hard enough for
  user memory...
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20011206124830.C2029@redhat.com>
In-Reply-To: <4.2.2.20011205174951.00ab0e20@slither>
 <4.2.2.20011205174951.00ab0e20@slither>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

At 04:48 AM 12/6/2001 , Stephen C. Tweedie wrote:
>Yes, over-commit protection is far from perfect.  However, it's a
>difficult problem to get right.

Um, at what % solution?  As long as the goal isn't that you under-commit
by more than a small percentage of pages, IMHO, it's an acceptable solution.


> > Also attached is my proposed fix for this problem.  It has the following
> > changes:
> >
> > 1.  Do a better job estimating how much VM is available
> >          vm_enough_memory() was changed to take the sum of all free RAM
> >          and all free swap, subtract up to 1/8th of physical RAM (but not
> >          more than 16MB) as a reserve for system buffers to prevent 
> deadlock,
> >          and compare this to the request.  If the VM request is <= the
> >          available free stuff, then we're set.
>
>That's still just a guestimate: do you have any hard data to back
>up the magic numbers here?

A guestimate of what exactly?  What I did was, using top, verify that
most of the available VM got put to use.  (95%+ on my systems.)
Would hard data such as what
percentage of potential VM resources didn't get used impress you?

While you're right that I haven't done a concrete, deductive, and provably
correct sort of thing, I've done something which seems to me moderately
intuitive and empirically effective.  I recognize that some amount of memory
resources must remain available for the operating system to page in/out, and
otherwise do I/O with, and refuse to commit that to user processes.

Admittedly better solutions are possible, and indeed although I haven't
looked in detail at the code in Eduardo Horvath's March 2000 patch prop
[Really disabling overcommit.], I'd certainly agree that a patch with
an approach like that would be technically superior.  Is such a patch
being seriously considered for inclusion in 2.4?

For me this problem is a serious one.  It's trivial to hit in real life,
and get your process killed.  And I can't have that.  The OS needs to err
on the conservative side, or it's not a usable system for me.


> > 2.  Be willing to sleep for memory chunks larger than 8 pages.
> >          __alloc_pages had an uncommented piece of code, that I couldn't
> >          see any reason to have.  It doesn't matter how big the piece of
> >          memory is--if we're low, and it's a sleepable request, we should
> >          sleep.  Now it does.  (Can anyone explain to me why this coded was
> >          added originally??)
>
>That's totally separate: *all* user VM allocations are done with
>order-0 allocations, so this can't have any effect on VM overcommit.

Well, I'll go back and check where they were coming from, but I *was* seeing
12-page allocation requests when running the test program I posted, on an
otherwise idle system.

But I still think my change, and question remain valid:  These are not handling
GFP_ATOMIC requests, so the kernel is allowed to sleep, why doesn't 
it?  Getting
memory is always better than being refused, it seems to me.  This code which
makes it not sleep was recently touched (it had been checking for order > 1,
now it's order > 3?, if my memory is correct.)  My question is:  why was this
done, and why keep it at all?


>Ultimately, your patch still doesn't protect against overcommit: if
>you run two large, lazy memory using applications in parallel, you'll
>still get each of them being told there's enough VM left at the time
>of sbrk/mmap, and they will both later on find out at page fault time
>that there's not enough memory to go round.

Interestingly, even if I run many of my test program in parallel, it does
*not* over-commit.  (At least, it certainly never calls on the OOM killer.
Perhaps it is over-commiting on some level, but if it is, I don't notice it...)

Do you have a test case which causes over-commit (and therefore OOM kill)
against my patch?

Thanks,

         ~sparker

