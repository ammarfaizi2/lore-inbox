Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271741AbRJTIvC>; Sat, 20 Oct 2001 04:51:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271800AbRJTIun>; Sat, 20 Oct 2001 04:50:43 -0400
Received: from femail43.sdc1.sfba.home.com ([24.254.60.37]:48289 "EHLO
	femail43.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S271741AbRJTIuX>; Sat, 20 Oct 2001 04:50:23 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
Organization: Boundaries Unlimited
To: Timur Tabi <ttabi@interactivesi.com>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Allocating more than 890MB in the kernel?
Date: Sat, 20 Oct 2001 00:40:57 -0400
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0110191204210.21846-100000@hill.cs.ucr.edu> <9qq0mo$eun$1@cesium.transmeta.com> <3BD08B57.1070604@interactivesi.com>
In-Reply-To: <3BD08B57.1070604@interactivesi.com>
MIME-Version: 1.0
Message-Id: <0110200040570M.15870@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 19 October 2001 16:21, Timur Tabi wrote:
> H. Peter Anvin wrote:
> > That's because you're running out of address space, not memory.
> > HIGHMEM doesn't do anything for the latter -- it can't.  You start
> > running into a lot of fundamental problems when your memory size gets
> > in the same (or higher) ballpark than your address space.
> >
> > The best solution is go buy a 64-bit CPU.  There isn't much else you
> > can do about it.
>
> That's completely missing the point of my request (which, I admit, I didn't
> make clear).  I need to allocate about 3/4 of available memory in the
> kernel. If I had 2GB of RAM, I'd need to allocate 1.5GB.  If I had 8 GB of
> RAM, I'd need to allocate 6GB.  I just used 3GB/4GB because it's our
> current test platform.

Each user process has 32 bit pointers for memory.  This means they only have 
4 gigabytes of virtual address space, regardless of how many physical pages 
the machine has.  The kernel doesn't use segment:offset addressing.  It just 
uses the offset.  Flat memory model.

Now your page tables can shuffle memory around (using physical pages, swap, 
etc), but that's irrelevant.  You've still only got 4 gigs of virtual space 
per process to work with on a 32 bit system.  The register you're ultimately 
dereferencing to access memory isn't big enough to hold a number larger than 
that.

To simplify the page tables, the kernel is in shared memory.  The first 
gigabyte of every process's address space is the kernel.  The kernel's page 
table is sort of spliced into everybody's page table.  And there was much 
rejoicing.

The problem is, you're trying to allocate kernel memory, meaning you hit the 
1 gigabyte limit.  And that includes the kernel itself.  You can recompile so 
the kernel has more than 1 gig of everybody's virtual address range reserved 
to it, but that reduces the amount of virtual memory user space processes 
have (4 gigs - 1 gig) because the kernel space (shared memory) is mapped into 
each and every process so the process can access kernel resources easily.  
(You do NOT want to change page tables for every system call.  We're not 
going there.)

To allocate more memory than that, you need to allocate pages in user space.  
To allocate more than 4 gigabytes of memory, you MUST use more than one 
process (you only have 4 gigs of virtual address space per process, so two 
processes must use overlapping virtual address ranges to point to different 
pages.  Perhaps they could communicate with each other through a shared mmap. 
 Congratulations, you've just reinvented expanded memory.)

Or, we could get back to the "buy a real computer" answer everybody's been 
giving you: buy a 64 bit computer that has more than 4 gigabytes of virtual 
address space per process.  Then you have 64 bit pointers for your virtual 
addresses, and can directly address virtual petabytes or exabytes or whatever 
comes next...

Rob
