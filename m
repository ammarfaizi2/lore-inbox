Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129118AbQJaVyx>; Tue, 31 Oct 2000 16:54:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129130AbQJaVyn>; Tue, 31 Oct 2000 16:54:43 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:64266 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129118AbQJaVyf>; Tue, 31 Oct 2000 16:54:35 -0500
Message-ID: <39FF3E9D.76A392E9@timpanogas.org>
Date: Tue, 31 Oct 2000 14:50:21 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Reto Baettig <baettig@scs.ch>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
In-Reply-To: <E13qhzo-0008DX-00@the-village.bc.nu> <39FF3CE6.19452C2D@timpanogas.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



"Jeff V. Merkey" wrote:
> 
> Alan Cox wrote:
> >
> > > Why not solve the problem at the source and completely redesign the
> > > network stack? Get rid of the old sk_buff & co! Rip the whole network
> > > layer out! Redesign it and give the user a possibility of Zero-Copy
> > > networking!
> >
> > For one because you don't need to do that to get zero copy networking for
> > most real world cases. Tux already implements the neccessary infrastructure
> > for these.
> 
> The code in the networking layer is fine, in fact, it's absolutely
> great.  This is not
> the problem.   The problem are all the clocks wasted reloading TLBs and
> the background
> memory activitiy caused by Linux's heavy dependence in Intel's
> protection hardware model.
> 
> Step 1 is to load the entire OS at ring 0 with protection completely
> disabled system wide,
> put in the kernel optimizations for AGI and context switch locking, and
> stub the top half of Linus's scheduler.  The global memory structures in
> his kernel may or may not hurt performance, depending on how they are
> accessed by multiple processors.  I will need to start profiling with a
> ring 0 port first and determine frequency of access that's hardware
> measured.
> 
> The next step would be to start peeling off different subsystems and
> re-parallelizing them
> on the merged kernel.  There's an awful lot of areas in Linus' that are
> going to be a
> problem, but I'll work through them one at a time.  When I first
> parallelized NetWare, I wrote
> an independent SMP kernel then loaded the entire NetWare 4.1 image as a
> single process.  The next step was to start peeling off layers from
> NetWare and plugging them in one by one and parallelizing them.  I am
> using the same approach here.  When I was finished, I had peeled NetWare
> like a banana and completely reintegrated it on a new kernel.  This
> approach works because it allows you to stage each layer.
> 
> The next step will be to modify the loader to allow the existing
> protection scheme to exist in true user space.  WRD's will hold off CR3
> switching so long as I/O is coming in or out of the box.  I anticipate
> this will take until March of next year to get right.
> 
> Jeff
> 


One other point.  You guys can try as hard as you can to hack around
this problem, but it will never scale like NetWare unless a
fundamentally different approach is adopted.  I've built this before,
and what we are doing is building in all the Linux functionality with
the identical code -- basically a Linux NetWare -- into a NetWare
framework.  All the protection can still be there, it just needs to be
restructured with some LAN based design assumptions.  I think the
industry will be pleased with the result.  I do not believe any of the
proposed hacks will get there unless this different approach is
investigated.   

Jeff




> packets via a WTD scheduler,
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
