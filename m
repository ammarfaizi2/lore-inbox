Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262997AbRFFNgi>; Wed, 6 Jun 2001 09:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263144AbRFFNg3>; Wed, 6 Jun 2001 09:36:29 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:46123 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S262997AbRFFNgT>; Wed, 6 Jun 2001 09:36:19 -0400
To: Andrew Morton <andrewm@uow.edu.au>
Cc: "Jeffrey W. Baker" <jwbaker@acm.org>,
        Derek Glidden <dglidden@illusionary.com>, linux-kernel@vger.kernel.org
Subject: Re: Break 2.4 VM in five easy steps
In-Reply-To: <3B1D5ADE.7FA50CD0@illusionary.com>
	<Pine.LNX.4.33.0106051634540.8311-100000@heat.gghcwest.com>
	<3B1D927E.1B2EBE76@uow.edu.au>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 06 Jun 2001 07:32:34 -0600
In-Reply-To: <3B1D927E.1B2EBE76@uow.edu.au>
Message-ID: <m14rtt7mz1.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <andrewm@uow.edu.au> writes:

> "Jeffrey W. Baker" wrote:
> > 
> > Because the 2.4 VM is so broken, and
> > because my machines are frequently deeply swapped,
> 
> The swapoff algorithms in 2.2 and 2.4 are basically identical.
> The problem *appears* worse in 2.4 because it uses lots
> more swap.

And 2.4 does delayed swap deallocation.  We don't appear to optimize
the case where a page is only used by the swap cache.  That should
be able to save some cpu overhead if nothing else.

And I do know that in the early 2.2 timeframe, swapoff was used
to generate an artifically high VM load, for testing the VM.  It looks
like that testing procedure has been abandoned :)

> > they can sometimes take over 30 minutes to shutdown.
> 
> Yes. The sys_swapoff() system call can take many minutes
> of CPU time.  It basically does:
> 
> 	for (each page in swap device) {
> 		for (each process) {
> 			for (each page used by this process)
> 				stuff
> 
> It's interesting that you've found a case where this
> actually has an operational impact.

Agreed.
 
> Haven't looked at it closely, but I think the algorithm
> could become something like:
> 
> 	for (each process) {
> 		for (each page in this process) {
> 			if (page is on target swap device)
> 				get_it_off()
> 		}
> 	}
> 
> 	for (each page in swap device) {
> 		if (it is busy)
> 			complain()
> 	}

You would need to handle the shared memory case as well.
But otherwise this looks sound.  I would suggest going
through page->address_space->i_mmap_shared to find all of the
potential mappings but the swapper address space is used by all
processes that have pages in swap.

> That's 10^4 to 10^6 times faster.

It looks like it could be.  The bottleneck should be diskio, if it
is not we have a noticeable inefficient algorithm.

Eric
