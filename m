Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130841AbQKJUf0>; Fri, 10 Nov 2000 15:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131416AbQKJUfF>; Fri, 10 Nov 2000 15:35:05 -0500
Received: from d06lmsgate-2.uk.ibm.com ([195.212.29.2]:55034 "EHLO
	d06lmsgate-2.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S130841AbQKJUfE>; Fri, 10 Nov 2000 15:35:04 -0500
From: richardj_moore@uk.ibm.com
X-Lotus-FromDomain: IBMGB
To: Matti Aarnio <matti.aarnio@zmailer.org>
cc: Michael Rothwell <rothwell@holly-springs.nc.us>,
        linux-kernel@vger.kernel.org
Message-ID: <80256993.00710E9F.00@d06mta06.portsmouth.uk.ibm.com>
Date: Fri, 10 Nov 2000 19:31:51 +0000
Subject: Re: [ANNOUNCE] Generalised Kernel Hooks Interface (GKHI)
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Matti,


>    Please educate me, what does "our RAS offerings" mean here ?
>    (I didn't find "RAS" at your signature-URL site, but I didn't
>     poke around very much..)

RAS = Reliabilty, Availability & Serviceability = those things that are are
not mainline to an OS but add the qualities named in the acronym. That
includes self-healing, recoverability, diagnosis etc..
My specialism is in probelm diagnosis. When I say RAS I generally mean
debugging/diagnosis aids, but I also mean it not from a developement
standpoint but from a support standpoint. Which depending on how a system
is deployed can be very different things.

>    I do know that when IBM suits speak with phrases like that,
>    they are selling me something which costs $$$.

No always. All this stuff (Linux RAS) is free and given away under GPL. And
I'm not waring a suit either ;-) RAS in general is not sexy, it's difficult
to sell. So it's pad for from after sales service and other indirect means.

>    Which definitely gives proprietary, binary only, hook image...
>    But GKHI, and DProbes are neither. Thus I am confused, but can
>    understand the furor...

Well I sort of can and can't as well. Here's a couple of circumstances
where I'd find GKHI useful:

I'm developing DProbes, I need the SGI KDB, a complex patch, as a debugging
aid. I also want to keep up with various kernel version. I've got limited
time so would like to spend it on DProbes on not re-working patches. So, I
know that DProbes only needs to get control in three places in kernel
processing:
1) Trap 1 handler
2) Trap 3 handler
3) Pagefault handler.

I reason that if I had a call inserted into the kernel source at these
points to respective entry points in my DProbes code I'd not have to spend
much time integrating SGI's KDB with DProbes.
The I realise if I leave the calls nop'd and dynamically patch them in
later I can build the kernel once and re-build DProbes (now a module) many
times over - and sometimes without re-booting.

So I create GKHI to mess around with NOPs converitng them into calls.

Second scenario:
I have a customer running Linux for a business purpose. They are not
developers and have no programming skill. Every now and again their system
crashes and they have to reboot. And down time costs them in real terms.

So they say to IBM, you supplied this ... system, you fix it. OK we say,
we'll need a dump. We'll send you a kernel with SGI's crash dump built in.
On no you won't they say, you're not sending us any more dodgy code until
you've fixed this problem. Anyway the server is in a secure remote branch
office. There's no technoical support on site and we cannot possibly have
developers messing with that system. Now suppose SGI or IBM have converted
SGI Kernel Crash Dump to a module and we supplly the system customised with
a few GKHI hooks in place. Then we say issue the following command: insmod
lkcd.o

We get a dump and discover that some cheesehead had overlaid a spinlock
causing re-entrancy and a crash. OK we say we know what happened by not who
did it. So, we need to trace all storage alterations to the spin-lock.
There are only a few valid user's of that spin-lock, which if we had a
trace, we could eliminate. By now DProbes and Linux Trace Toolkit are
working well together, and providing a dynamic trace capability. Also
DProbes is now offering the capability of probes on storage modifications.
So we say to the customer please issue three commands: insmod lkcd; insmod
dprobes; insmod ltt;

The system crashes, we get the trace. We duly find the address from which
the spin-lock was overwriten. We look in the dump and find it's a routine
in a device driver that's been passed invalid data, but actually, not
passed, but placed on a work queue. And furthermore the invalid data has a
particular look to it.

We explain to the customer that we now need just one more pice of
information. So finally we place a dprobe on the enqueuing routine, looking
at data enqueued until the invalid pattern occurs and make the probe
trigger another dump.

And finally we have it. The enqueuing routine was another driver .....

This scenario is not untypical of the sort of problem I earnt my living
solving for the past n years.

Now we could have supplied a system with Crash Dump, Dprobes, LTT, KDB, a
dozen other specialised RAS tools. The kernel would have 50% bigger, cost
us considerable time and effort whenever kernel maintenance was applied -
with obvious consequences. And in the end 99.9% of the time we don't need
these facilities, coz after all Linux is a pretty stable platform. So why
not allow them to be brought in dynamically.



Richard Moore -  RAS Project Lead - Linux Technology Centre (PISC).

http://oss.software.ibm.com/developerworks/opensource/linux
Office: (+44) (0)1962-817072, Mobile: (+44) (0)7768-298183
IBM UK Ltd,  MP135 Galileo Centre, Hursley Park, Winchester, SO21 2JN, UK


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
