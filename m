Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292270AbSBYVAh>; Mon, 25 Feb 2002 16:00:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292234AbSBYVAR>; Mon, 25 Feb 2002 16:00:17 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:56450 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S292216AbSBYVAE>;
	Mon, 25 Feb 2002 16:00:04 -0500
Date: Mon, 25 Feb 2002 15:57:31 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        Rusty Russell <rusty@rustcorp.com.au>, mingo@elte.hu,
        Matthew Kirkwood <matthew@hairy.beasts.org>,
        David Axmark <david@mysql.com>,
        William Lee Irwin III <wli@holomorphy.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Lightweight userspace semaphores...
Message-ID: <20020225155731.A2226@elinux01.watson.ibm.com>
In-Reply-To: <Pine.LNX.4.33.0202250808150.3268-100000@home.transmeta.com> <E16fOAO-0005Ml-00@the-village.bc.nu> <20020225113239.A11675@redhat.com> <20020225132335.C1163@elinux01.watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020225132335.C1163@elinux01.watson.ibm.com>; from frankeh@watson.ibm.com on Mon, Feb 25, 2002 at 01:23:35PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All, I uploaded my latest version on this to lse.sourceforge.net
you can get to by http://prdownloads.sourceforge.net/lse/ulocks-2.4.17.tar.bz2

Hope you find some time to look at it and respond to the questions
and positions I outlined in the message before.

-- Hubertus Franke

On Mon, Feb 25, 2002 at 01:23:35PM -0500, Hubertus Franke wrote:
> On Mon, Feb 25, 2002 at 11:32:40AM -0500, Benjamin LaHaise wrote:
> > On Mon, Feb 25, 2002 at 04:39:56PM +0000, Alan Cox wrote:
> > > _alloca
> > > mmap
> > > 
> > > Still fits on the stack 8)
> > 
> > Are we sure that forcing semaphore overhead to the size of a page is a 
> > good idea?  I'd much rather see a sleep/wakeup mechanism akin to wait 
> > queues be exported by the kernel so that userspace can implement a rich 
> > set of locking functions on top of that in whatever shared memory is 
> > being used.
> > 
> > 		-ben
> > -
> 
> Amen, I agree Ben. As I indicated in my previous note, one can
> implement various versions of spinning, starvation, non-starvation locks
> based on the appropriateness for a given app and scenario.
> For instance the multiple reader/single writer requires 2 queues.
> If as Ben stated something similar to the SysV implementation is desired
> where a single lock holds multiple waiting queues, that should be straight
> forward to implement. Waiting queues could be allocated on demand as well.
> 
> I'd like to see an implementation that facilitate that.
> My implementation separates the state to the user level and the 
> waiting to the kernel level. There are race conditions that need to 
> be resolved with respect to wakeup. They can be all encoded into
> the atomic word maintained in shared memory in user space.
> 
> For more complex locks I'd like to have compare_and_swap instructions.
> As I stated, I have implemented some of the more complicated locks
> (spinning, convoy avoidance, etc.) and they have all passed some rigorous
> stress test.
> 
> As for allocation on the stack. If indeed there are kernel objects
> associated with the address, they need to be cleared upon exit from
> the issueing subroutine (at least in my implementation).
> 
> 
> At this point, could be go through and delineate some of the requirements
> first.
> E.g.  (a) filedescriptors vs. vaddr
>       (b) explicit vs. implicite allocation  
>       (c) system call interface vs. device driver
>       (d) state management in user space only or in kernel as well
> 	        i.e. how many are waiting, how many are woken up.
>       (e) semaphores only or multiple queues
>       (f) protection through an exported handle with some MAGIC or
>           through virtual memory access rights
>       (g) persistence on mmap or not 
> 
> Here is my point of view:
> (a) vaddr 
> (b) implicite
> (c) syscall
> (d) user only
> (e) multiple queues
> (f) virtual memory access rights.
> (g) persistent  (if you don't want persistence you remove the underlying object)
> 	
> I requested some input on my original message a couple of weeks regarding 
> these points (but only got one on (b)).
> 
> Could everybody respond to (a)-(f) for a show of hands.
> Could we also consolidate some pointers of the various implementations
> that are out there and then see what the pluses and minuses of the various
> implementations are  and how they score against (a)-(f).
> 
> -- Hubertus Franke
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
