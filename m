Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129047AbQJ3IIX>; Mon, 30 Oct 2000 03:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129066AbQJ3IID>; Mon, 30 Oct 2000 03:08:03 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:3590 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129047AbQJ3IHz>; Mon, 30 Oct 2000 03:07:55 -0500
Date: Mon, 30 Oct 2000 01:04:34 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
Message-ID: <20001030010434.A19615@vger.timpanogas.org>
In-Reply-To: <39FCB09E.93B657EC@timpanogas.org> <E13q2R7-0006S7-00@the-village.bc.nu> <20001029183531.A7155@vger.timpanogas.org> <20001030074700.A31783@gruyere.muc.suse.de> <20001029235821.A19076@vger.timpanogas.org> <20001030080858.A32204@gruyere.muc.suse.de> <20001030001646.A19136@vger.timpanogas.org> <20001030083827.B32389@gruyere.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001030083827.B32389@gruyere.muc.suse.de>; from ak@suse.de on Mon, Oct 30, 2000 at 08:38:27AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 
> > When you say it reloads it's VM, you mean it reloads the CR3 register?  
> 
> Yes.
> 
> No. In 2.4 you could probably use the on demand lazy vm mechanism ingo described for
> the nfsd processes. In 2.2 it is a bit more tricky, if I remember right lazy mm needed
> quite a few changes.
> 
> But before doing too many changes i would first verify if that is really the problem.

We will never beat NetWare on scaling if this is the case, even in 2.4.  
Andre and my first job will be to create an arch port with MANOS that
disables this and restructures the VM.  

> PTEs are read for aging on memory pressure in vmscan.
> 
> segment register reload happen on interrupt entry, to load the kernel cs/ds (are they that
> costly?). If it was really costly you could probably check in interrupt entry if you're
> already running in kernel space and skip it.

They are.  segment register reloads will trigger the following:

IDT table atomic fetch to verify  (LOCK#) (if triggered by task gate from INTR)
GDT table atomic fetch to verify  (LOCK#)
LDT table atomic fetch to verify  (LOCK#) (if present)
PDE table atomic fetch to verify  (LOCK#)

The process has to verify that the loaded segment descriptor is valid, and
it will fetch from all these tables to do it, with up to 4 (LOCK#) 
assertions occurring invisibly in the hardware underneath (which will
generate 4 non-cacheable memory references, in addition to wrecking 
havoc on the affected L1/L2 cache lines).  Oink.  It only does this 
when you load one, not when you save one, like pushing it on the 
stack.  Since you look at MANOS code, you'll note that in 
CONTEXT.386, I do and add esp, 3 * 4 instead of poppping the segment
registers off the stack if they are in the kernel address space.  

Linux should do the same, if possible as an optimization.


> 
> > 
> 
> 2.2 does not use checksum-copy-to-user in TCP RX, csum is either done separate or in hardware.
> It does csum-copy-fragment for TX, as well as UDP.  

Yes, I know, this is what I was referrring to.  Received are always ugly,
there's always at least one copy into cache for the write, sometimes
more...

Jeff

> 
> -Andi
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
