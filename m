Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262252AbVBBRSC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262252AbVBBRSC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 12:18:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262655AbVBBRRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 12:17:45 -0500
Received: from science.horizon.com ([192.35.100.1]:3896 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S262530AbVBBRRD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 12:17:03 -0500
Date: 2 Feb 2005 17:17:02 -0000
Message-ID: <20050202171702.24523.qmail@science.horizon.com>
From: linux@horizon.com
To: lorenzo@gnu.org, mingo@elte.hu
Subject: Re: [PATCH] OpenBSD Networking-related randomization port
Cc: arjan@infradead.org, bunk@stusta.de, chrisw@osdl.org, davem@redhat.com,
       hlein@progressive-comp.com, linux-kernel@vger.kernel.org,
       linux@horizon.com, netdev@oss.sgi.com, shemminger@osdl.org,
       Valdis.Kletnieks@vt.edu
In-Reply-To: <20050131201141.GA4879@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

*Sigh*.  This thread is heading into the weeds.

I have things I should be doing instead, but since nobody seems to
actually be looking at what the patch *does*, I guess I'll have
to dig into it a bit more...

Yes, licensing issues need to be resolved before a patch can go in.
Yes, code style standards needs to be kept up.
And yes, SMP-locking issues need to be looked at.
(And yes, ipv6 needs to be looked at, too!)

But before getting sidetracked into the fine details, could
folks please take a step back from the trees and look at the forest?

Several people have asked (especially when the first patch came out),
but I haven't seen any answers to the Big Questions:

1) Does this patch improve Linux's networking behaviour in any way?
2) Are the techniques in this patch a good way to achieve those
   improvements?


Let's look at the various parts of the change:

- Increases the default random pool size.
  Opinion: whatever.  No real cost, except memory.  Increases the
  maximum amount that can be read from /dev/random without blocking.
  Note that this is already adjustable at run time, so the question
  is why put it in the kernel config.

  If you want this, I'd suggest instead an option under CONFIG_EMBEDDED to
  shrink the pools and possibly get rid of the run-time changing code,
  then you could increase the default with less concern.

- Changes the TCP ISN generation algorithm.
  I have't seen any good side to this.  The current algorithm can be
  used for OS fingerprinting based on starting two TCP connections from
  different sources (ports or IPs) and noticing that the ISNs
  only differ in the low 24 bits, but is that a serious issue?
  If it is, there are better ways to deal with it that still preserve
  the valuable timer property.

  I point out that the entire reason for the cryptographically
  marginal half_md4_transform oprtation was that a full MD5 was a very
  noticeable performance bottleneck; the hash was only justified by
  the significant real-world attacks.  obsd_get_random uses two calls
  to half_md4_transform.  Which is the same cost as a full MD4 call.
  Frankly, they could just change half_md4_transform to return 64 bits
  instead of 32 and make do with one call.

- Changes to the IP ID generation algorithm.
  All it actually does is change the way the initial inet->id is
  initialized for the inet_opt structure associated with the TCP socket.
  And if you look at ip_output.c:ip_push_pending_frames(), you'll see
  that, if DF is set (as is usual for a TCP connection), iph->id (the
  actual IP header ID) is set to htons(inet->id++).  So it's still
  an incrementing sequence.

  This is in fact (see the comment in ip.h:ip_select_ident()) a workaround
  for a Microsoft VJ compression bug.  The fix was added in 2.4.4 (via
  DaveM's zerocopy-beta-3 patch); before that, Linux 2.4 sent a constant
  zero as the IP ID of DF packets.  See discussion at
	http://www.postel.org/pipermail/end2end-interest/2001-May/thread.html
	http://tcp-impl.lerc.nasa.gov/tcp-impl/list/archive/2378.html
  I'm not finding the diagnosis of the problem.  I saw one report at
	http://oss.sgi.com/projects/netdev/archive/2001-01/msg00006.html
  and Dave Miller is pretty much on top of it when he posts
	http://marc.theaimsgroup.com/?l=linux-kernel&m=98275316400452&w=2
  but I haven't found the actual debugging leading to the conclusion.

  This also led to some discussion of the OpenBSD IP ID algorithm that
  I haven't fully waded through at
	http://mail-index.netbsd.org/tech-net/2003/11/

  If the packet is fragmentable (the only time the IP ID is really
  needed by the receiver), it's done by route.c:__ip_select_ident().
  Wherein the system uses inet_getid to assign p->ip_id_count++
  based on the route cache's struct inet_peer *p.

  (If the route cache is OOM, the system falls back on random IP ID
  assignment.)

  This latter technique nicely prevents the sort of stealth port
  scanning that was mentioned earlier in this thread, and prevents
  a person at address A from guessing the IP ID range I'm using to
  talk to address B.  So note that the boast about "Randomized IP IDs"
  in the grsecurity description at
	http://www.gentoo.org/proj/en/hardened/grsecurity.xml
  is, as far as I can tell from a quick look at the code, simply false.

  As for the algorithm itself, it's described at
	http://www.usenix.org/events/usenix99/full_papers/deraadt/deraadt_html/node18.html
  but it's not obvious to me that it'd be hard to cryptanalyze given
  a stream of consecutive IDs.  You need to recover:
  - The n value for each inter-ID gap,
  - The LCRNG state ru_a, ru_x, ru_b,
  - The 15-bit XOR masks ru_seed and ru_seed2, and
  - The discrete log generator ru_j (ru_g = 2^ru_j mod RU_N).
    Which is actually just a multiplier (mod RU_N-1  = 32748) on
    the input to the pmod() operation.

  So the IP ID generation can be summarized as:

  ru_x = (ru_a * ru_x + ru_b) % 31104;	/* Repeated 1..4 times */
  exp = ((ru_x ^ ru_seed2) + ru_j) % 32748;
  return ru_seed ^ pmod(2, exp, 32749);

  Now, if you can guess ru_seed, then the pmod() operation is simply a
  bijection that can be looked up in a table, and then it's just
  a matter of untangling a slightly elaborated LCRNG.

- Changes the sun RPC XID allocation algorithm.
  Note that each connection is already initialized with a secure random
  number; the only change is whether the IDs used are simply incrementing
  from there or randomized each time one is needed.

  First of all and very importantly, obsd_get_random_long() does
  indeed generate a *random* number, which could be the *same* number as
  the last one.  This could be VERY BAD for RPC XIDs, which have to be
  unique so the client can match the reply with the request.  Note that
  Theo de Raadt knows better than do do that:
	http://www.usenix.org/events/usenix99/full_papers/deraadt/deraadt_html/node18.html
  Looking at the OpenBSD code at
	http://www.openbsd.org/cgi-bin/cvsweb/src/sys/nfs/
  you can see that the NFS code in nfs_subs.c:nfsm_rpchead() generates
  a random starting xid and increments it by a random number 1..255
  each time.  The more general RPC code in krpc_subr.c:krpc_call()
  generates a fully random XID, constrained only to differ from the
  previous one.  This is because the call is synchronous and does
  not permit more than one outstanding request at a time.
  
  Anyway, if you wanted to do this, you'd have to add some checking
  to ensure that a request with that ID isn't already on the rq_list.
  Also, there appear to be some retransmit issues that mitigate against
  recycling them too fast (which is why OpenBSD forbids adjacent
  duplicates), but I haven't studied that in detail.


So in summary:
- Random pool: Few security issues, but on the other hand, why bother?
  It's run-time tunable already.
- TCP ISN: Proposed patch increases chance of TPC ISN reuse by breaking
  timer-based design specified in TCP RFC.  It doesn't appear to have
  any more cryptographic security.
- IP ID: Doesn't change the uses where it matters (DF flag clear).
  Doesn't change the fact that the IDs are still consecutive.  What's the
  freaking point?  And all that modular exponentiation that OpenBSD does
  is a pretty dubious security improvement.
- RPC XID: Broken; don't use.  And what's wrong with incrementing from
  a random start?  If an attacker can see your requests, he can generate
  a fake reply no matter what algorithm you use, and if he can't, then
  the random start is all you need to limit his chances.  The only thing
  a fully random sequence prevents against is that if an attacker can
  somehow tell when they've succeeded, an incrementing sequence lets
  them spoof furter replies easily.  You could apply a first level of
  protection by incrementing them by a random odd number rather than 1,
  but even then, why bother?

And, of ocurse, all of this has performance implications.  Linux is
justifiably proud of keeping down performance bloat by not wasting cycles
on fast paths if it can possibly be helped.  If we *do* find something to
improve, we should look at the goals and design the fastest way possible
to achieve that.  It's not at all clear that the current code patch is
the right implementation even if it *did* do something useful.

Before worrying about the small stuff, could we take a good look at the
Big Stuff?


I like to try to be polite to people contributing patches.  It's a lot
of work and I don't want to dishearten someone just starting.  I'd like
to be polite and encouraging when rejecting patches.

But everyone is so busy ignoring the elephant in the kitchen that I
shall have to forego politeness and shout a little.

It doesn't matter what the license is or whether it's against the Linus
tree or -mm or how the functions are names.

	 ********************************************** 
	************************************************
	*****                                      *****
	****  THIS PATCH DOESN'T FREAKING WORK!!!!  ****
	*****                                      *****
	************************************************
	 ********************************************** 

Ignoring all the *implementation* brokenness, it breaks the network
protocols, doesn't do what it claims to do, and what it tries to do
isn't of any benefit over the existing code.  It's not resting, it's not
stunned, and it's not pining for the fjords.  It just plain doesn't work.

If there are any claimed benefits that you want, the first thing to do
is throw it away, go back to square one, and come up with an algorithm
that actually achieves that benefit.

I keep hearing people boast about how the many eyes reviewing open
source code improves the code quality and makes it harder to insert
back doors into the system.  If something this bad can get this many
comments without anyone pointing out the emperor's clothing arrangements,
the situation is pretty pitiful.


There *are* things in OpenBSD, like randomized port assignment (as opposed
to the linear scan in tcp_v4_get_port()) that would be worth emulating.
Maybe worry about that first?
