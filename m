Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281204AbRKEQMQ>; Mon, 5 Nov 2001 11:12:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281205AbRKEQMH>; Mon, 5 Nov 2001 11:12:07 -0500
Received: from yktgi01e0-s1.watson.ibm.com ([198.81.209.16]:32147 "HELO
	ssm22.watson.ibm.com") by vger.kernel.org with SMTP
	id <S281204AbRKEQLx>; Mon, 5 Nov 2001 11:11:53 -0500
Date: Mon, 5 Nov 2001 09:11:06 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: Patch and Performance of larger pipes
Message-ID: <20011105091106.B19533@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
In-Reply-To: <OF2428DABF.B9AD95A4-ON86256AEA.005A4949@raleigh.ibm.com> <20011024153930.A12944@watson.ibm.com> <20011030133124.A16257@watson.ibm.com> <3BE42BB5.7AF5F56F@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <3BE42BB5.7AF5F56F@colorfullife.com>; from Manfred Spraul on Sat, Nov 03, 2001 at 06:39:01PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Manfred Spraul <manfred@colorfullife.com> [20011103 12;39]:"
> Hubertus Franke wrote:
> >  32k        512      500           0         1.09       -78.3
> 
> I understand the slowdown, but 78% are too large.
> With my patch applied, the read syscall probably returns after 4608
> bytes instead of all 32 kB. Could you check that you don't delay after
> every syscall, but only after 32 kB are read?

You are right on the money. 4608 every read call.....
Now we ran also our patch terms out we also don't return right 
on 32KB, but dependent on the pipe-size return more than 4608.
Even on vanilla, it seems the blocking read semantics are 
wait for at least 1 byte and then return as much as you can.
We are running somemore experiments now to see what exactly is going on.

> 
> > 
> > Whereas Manfred's patch is doing 12% degradation on 2-way and 78%
> > degradation on UP.
> >
> I found the problem:
> The current code does syscall coalescing.
> 
> On UP, I get
> <<<<<<<<
> $dd if=/dev/zero bs=4096 count=20000 | dd bs=1M of=/dev/null
> 20000+0 records in
> 20000+0 records out
> 78+1 records in
> 78+1 records out
> $dd if=/dev/zero bs=4096 count=20000 | dd bs=1M of=/dev/null
> 20000+0 records in
> 20000+0 records out
> 77+2 records in
> 77+2 records out
> <<<<<<<< [ok, it it SMP, but the 2nd cpu executes 'for(;;);']
> Only 80 read syscalls are needed. With my patch applied, I'd get around
> 10000 syscalls.
> 
> I haven't found a simple way to fix it yet, probably I must wait until
> the cache flushing functions are cleaned up.
> --
> 	Manfred

Let's first agree exactly on the read semantics that we want to see ?
Than let's keep comparing where things are heading to see what 
makes the most sense.

> 
> _______________________________________________
> Lse-tech mailing list
> Lse-tech@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/lse-tech
