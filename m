Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129750AbQKORCW>; Wed, 15 Nov 2000 12:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130294AbQKORCB>; Wed, 15 Nov 2000 12:02:01 -0500
Received: from d06lmsgate-3.uk.ibm.com ([195.212.29.3]:50829 "EHLO
	d06lmsgate-3.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S129750AbQKORB4>; Wed, 15 Nov 2000 12:01:56 -0500
From: richardj_moore@uk.ibm.com
X-Lotus-FromDomain: IBMGB
To: Andrea Arcangeli <andrea@suse.de>
cc: Josue.Amaro@oracle.com, linux-kernel@vger.kernel.org
Message-ID: <80256998.005AB3E4.00@d06mta06.portsmouth.uk.ibm.com>
Date: Wed, 15 Nov 2000 15:24:32 +0000
Subject: Re: [ANNOUNCE] Generalised Kernel Hooks Interface (GKHI)
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Please respond to Andrea Arcangeli <andrea@suse.de>

To:   Richard J Moore/UK/IBM@IBMGB
cc:
Subject:  Re: [ANNOUNCE] Generalised Kernel Hooks Interface (GKHI)




On Wed, Nov 15, 2000 at 05:14:57AM +0000, richardj_moore@uk.ibm.com wrote:
>
>
> Andrea,
>
> I am very greatful for your detailed analysis. I have yet to digest
> everything you commented but will get back to you on all points you raise
> very soon. Here are my thoughts so far:

I'm glad you appreciated my comments. I think dprobes gives an higher
level of flexibility for debugging purposes and I'd really like to
include it in the aa kernels until it will be included into the mainstream.

> When I announced GKHI I did state that SMP support was to follow. The

I probably overlooked that part of your announcement, sorry.

> updates are trivial but I didn't wan't to release the code until I had
had
> a chance to test it.

Very promising.

Note that SMP could introduce non trivial issues: the self modifying
changes
should be atomic with respect of the other CPUs executing the self
modifying
code and specs are often not very explicit about side effects of self
modifying
code in SMP, it's not only a matter of implementing the GKHI locks with SMP
locks).

> Are you claiming that flush_icache_range has an error and should
implement
> the IA32 instruction flush as I did using CPUID? If this is the case has

Exactly.

> this error been officially reported?

I hope I did that in my email :). Actually when I fixed the alpha port
some month ago (alpha needs an explicit imb() to flush the speculative
icache and it was really crashing in modules because of the missing
smp_imb) I
also noticed IA32 was buggy, since also IA32 execute out of order and specs
says we must do a cpuid as only way to serialize the istream.  But I didn't
fixed IA32 because nobody ever got bitten by that race because of
timing/implementation reasons, but to be correcet we should do cpuid also
in
flush_icache_range.

Once flush_icache_range is fixed in IA32 you can use it inside GKHI too
(and then you'll get it right on all architectures).

> Thanks for this information. Reserving a syscall will become irrelvant
when
> we release Dprobes as a module using gkhi since we will use ioctl() as
the
> application interface.

Ok (still you need to reserve a blockdevice major minor number with Linus
though).

> Well, not necessarily so while lkcd is not get accepted into the standard
> kernel source. [..]

It won't until it uses a separate driver that doesn't depend on scsi or
ide layer.

Even ignoring the safety problem of scsi layer potentially corrupted by
memory corruption at crash time, the scsi layer doesn't work without being
interrupt driven. It will recurse on the stack badly if somebody ever tries
to
use it polled. Probably similar thing happens with IDE (but none IDE polled
hardware exists so we don't know). I documented all this in the `Linux
Kernel
Debugging' document on my ftp area in ftp.suse.com.

> [.] But also, even when lkcd becomes accepted, using gkhi with
> lkcd will allow a crash dump capability to be actived dynamically. [..]

We can control everything dynamically without self modifying code.

The _only_ point of self modifying code is performance. None other reason
to use it. lkcd is definitely called in an extremely slow path (infact
if all goes right it should never be recalled), so it doesn't give
any advantage to use self modifying code there.

> [..] That
> gives the user more fexibility. Even enterprise customers can sometimes
> hedge their bets when it comes to RAS-like features.

I agree that being able to enable/disable lkcd dynamically is fine
feature.

Andrea



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
