Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316475AbSEOVna>; Wed, 15 May 2002 17:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316493AbSEOVn3>; Wed, 15 May 2002 17:43:29 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:22546 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S316475AbSEOVn1>;
	Wed, 15 May 2002 17:43:27 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200205152143.g4FLhLs17344@oboe.it.uc3m.es>
Subject: Re: Kernel deadlock using nbd over acenic driver
To: steve@gw.chygwyn.com
Date: Wed, 15 May 2002 23:43:21 +0200 (MET DST)
Cc: alan@lxorguk.ukuu.org.uk, chen_xiangping@emc.com, kumbera@yahoo.com,
        linux kernel <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Addresses got munged locally, but as I'm postmaster, I get the mail
after 26 bounces, so no hassle ...)

Let's see if I follow ...

> thanks for the info. I'm starting to form some ideas of what the problem
> with nbd might be. Here is my initial idea of what might be going on:
> 
>  1. Something happens which starts lots of I/O (e.g. the ext3/xfs journal
>     flush that Xiangping says usually triggers the problem)

Is this any kind of i/o? Such as swapping? You mean something which
takes the i/o lock, or which generally exercises the i/o system .. And
are there any particular characteristics to the "a lot" that you have
in mind, such as maybe running us out of requests on that device (no), or 
running us low on available free buffers (yes?).

>  2. One of the threads doing the writes blocks running the device I/O

If a thread blocks running its own device i/o queue, that would be 
a fatal error for most of the kernel. The i/o lock is held. And -
correct me on this - interrupts are disabled?

So I assume you are talking about "a bug in something, somewhere".


>     queue and causing nbd_send_req(), nbd_xmit() to block in the 
>     sendmsg() call (trying to allocate memory GFP_NOIO). I think we

Well,  I do the networking in userspace in ENBD, but it is still
going to cause a sendmsg() to happen. If that sendmsg is blocked, then
the client daemon is blocked, and the kernel will time out the daemon,
and rollback the requests in let it have .. and that IS what is
observed.

Yes - a blocked userspace daemon is what I believe to be observed.
Blocked in networking matches what I have heard.

>     only need to have each memory zones free pages just below pages_min
>     at the right time to trigger this.

I don't understand the specific allusion, but I gather you are talking
about low free pages. Yes, being run out of memory matches the reports.
Particularly the people who are swapping over nbd under memory pressure
are in that situation.

So - is that situation handled differently in the old VM?

>  3. Since bdflush will most likely be running it waits for the dirty
>     blocks its submitted to finish being written back to the
>     nbd device to finish.

Umm ... well, that's bdflush for you! As far as I recall bdflush
tries various different kinds of hard to get rid of dirty stuff?
Let's suppose its in sync mode, and see where we get ..

> So something to try is this, in nbd_send_req() add the lines:
> 
> 	if (current->flags & PF_MEMALLOC == 0) {
> 		current->flags |= PF_MEMALLOC;
> 		we_set_memalloc = 1;
> 	}

Uh, I can't try that directly, because my networking is done from
userspace in ENBD.  But I abstract from that that you want us to
notice that PF_MEMALLOC is not set, and set it, and remember when
we set it. Kernel nbd does this in the context of the process that is
stuck in kernel forever, but I can do it whenever the process
enters the kernel to pick up a request.

> before the first nbd_xmit() call and
> 
> 	if (we_set_memalloc)
> 		current->flags &= ~PF_MEMALLOC;
> 
> at the end just before the return; rememebring to declare the variable:

You want to invert the change after having sent the networking data out.

Well, I think this raises the priority for getting memory of the process
doing the networking. Yep. I can do that. It's a real userspace process
for me, but it's in a tight loop doing the protocol, and nothing else.

> int we_set_memalloc = 0;

Why don't we do it always? Surely what you are saying is that a process
doing networking needs priority for memory? If so, the right place to
do this is in send_msg, not in nbd, as it's a generic problem, just
one that happens to be exposed by nbd.

> at the top of the function. We know that since the box stays responsive to
> pings that there must be some free memory, so I suspect some kind of
> "priority inversion" is at work here.

OK ... that is a high priority process waiting on a low priority
process, and thereby keeping it locked out.

> Another interesting idea... if we changed the icmp receive function so that
> it leaked all echo request packets rather than recycling them we could
> measure the free memory after the box has hung by seeing how many times
> we can ping it before it stops replying. An interesting way to
> measure free memory, but probably quite effective :-)

That is not a bad test. I've asked if anybody can get mem stats out via
magic key combos, but never had any comeback on that.

> It looks like adding the line:
> 
> 	if (icmph->type == ICMP_ECHO) return;
> 
> just after (icmp_pointers[icmph->type].handler)(skb); in icmp.c:icmp_rcv()
> should do the trick in this case.

I think it would be easier to get stats out in a sysreq sort of way!

> Those are my current thoughts. Let me know if you are sure that some of
> what I've said is right/wrong, otherwise I'll have a go tomorrow at

Back in 2.2 times, there was a network memory priority problem "solved"
in 2.2.17. I was never convinced by the solution. It addressed the
network competing for memory against other claimants, and arranged that
the network won. But I did not see that that stopped one running out
of memory, and then the network blocking against _nothing_.

The only strategy that will work is to reserve some memory for the net,
and this processes networking in particular! How much? Well, as big
as a max_sectors for the device, at any rate.


> trying to prove some of it on my test system here,

Peter
