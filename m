Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132738AbRDINHM>; Mon, 9 Apr 2001 09:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132739AbRDINHC>; Mon, 9 Apr 2001 09:07:02 -0400
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:5907 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S132736AbRDINGn>; Mon, 9 Apr 2001 09:06:43 -0400
From: bsuparna@in.ibm.com
X-Lotus-FromDomain: IBMIN@IBMAU
To: paul.mckenney@us.ibm.com
cc: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org, ak@suse.de,
        dipankar.sarma@in.ibm.com
Message-ID: <CA256A29.0047C346.00@d73mta05.au.ibm.com>
Date: Mon, 9 Apr 2001 18:16:57 +0530
Subject: Re: [Lse-tech] Re: [PATCH for 2.5] preemptible kernel
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>One question:
>isn't it the case that the alternative to using synchronize_kernel()
>is to protect the read side with explicit locks, which will themselves
>suppress preemption?  If so, why not just suppress preemption on the read
>side in preemptible kernels, and thus gain the simpler implementation
>of synchronize_kernel()?  You are not losing any preemption latency
>compared to a kernel that uses traditional locks, in fact, you should
>improve latency a bit since the lock operations are more expensive than
>are simple increments and decrements.  As usual, what am I missing
>here?  ;-)
>...
>...
>I still prefer suppressing preemption on the read side, though I
>suppose one could claim that this is only because I am -really-
>used to it.  ;-)

Since this point has come up , I just wanted to mention that it may still
be nice to be able to do without explicit locks on the read-side. This is
not so much for performance reasons (I agree with your assessment on that
point) as for convinience / flexibility in the kind of situations where
this concept (i.e. synchronize_kernel or read-copy-update) could be used.

For example, consider situations where it is an executable code block that
is being protected. The read side is essentially the execution of that code
block - i.e. every entry/exit into the code block.

This is perhaps the case with module unload races. Having to acquire a
read-lock explicitly before every entry point seems to reduce  the
simplicity of the solution, doesn't it ?

This is also the case with kernel code patching, which I agree, may appear
to be a rather unlikely application of this concept to handle races in
multi-byte code patching on a running kernel, a rather difficult problem,
otherwise.  In this case, the read-side is totally unaware of the
possibility of an updater modifying the code, so it isn't even possible for
a read-lock to be acquired explicitly (if we wish to have the flexibility
of being able to patch any portion of the code).

Have been discussing this with Dipankar last week, so I realize that the
above situations were perhaps not what these locking mechanisms were
intended for, but just thought I'd bring up this perspective.

As you've observed, with the approach of waiting for all pre-empted tasks
to synchronize, the possibility of a task staying pre-empted for a long
time could affect the latency of an update/synchonize (though its hard for
me to judge how likely that is). Besides, as Andi pointed out, there
probably are a lot of situations where the readers are not pre-emptible
anyway, so that waiting for all pre-empted tasks may be superfluos.

Given these possibilities, does it make sense to simply let the
updater/synchronize kernel specify an option indicating whether it would
wait for pre-empted tasks or not ?

Regards
Suparna


  Suparna Bhattacharya
  IBM Software Lab, India
  E-mail : bsuparna@in.ibm.com
  Phone : 91-80-5267117, Extn : 2525


