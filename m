Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284497AbRLIWEf>; Sun, 9 Dec 2001 17:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284521AbRLIWEb>; Sun, 9 Dec 2001 17:04:31 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:63760 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S284500AbRLIWER>; Sun, 9 Dec 2001 17:04:17 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Intel I860
Date: 9 Dec 2001 14:03:47 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9v0n43$ok$1@cesium.transmeta.com>
In-Reply-To: <20011127003327.C1546@werewolf.able.es> <200112091201.fB9C1wD158088@saturn.cs.uml.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200112091201.fB9C1wD158088@saturn.cs.uml.edu>
By author:    "Albert D. Cahalan" <acahalan@cs.uml.edu>
In newsgroup: linux.dev.kernel
> 
> It's a RISC chip with the Pentium MMU. To get any speed out of it,
> you have to enable some strange features. First of all, you need
> the double-instruction mode. In every 64-bit chunk of memory you
> place 1 floating-point instruction and 1 integer instruction.
> Second of all, you need to enable pipelined FPU operation. This is
> an exposed pipeline, so watch out! Look what happens:
> 
> a = x + x
> b = a + a     <-- uses old value of "a", not x+x
> nop
> nop
> nop
> c = a + a
> 
> Yep, c!=a after this!  Actually, "c" won't be set until a few
> instructions later because it too is still in the pipeline.
> You need a few dummy operations to push it out.
> 

Nononon... it's much worse than that.

The i860 used a non-self-terminating pipeline, which meant that for
each instruction you had "what to stuff into the pipeline at this
stage" and "what to do with what comes out of the pipeline here",
which means that to compute d = a + b - c you'd have to do something
like:

X = a + b
nop
nop
nop
t = XXX
X = t - c
nop
nop
nop
d = XXX

... where X means don't care.  To compute, say, h = e + f - g in
parallel with this, it would look something like:

X = a + b
X = e + f
nop
nop
t = XXX
u = t - c
X = u - g
nop
nop
d = XXX
h = XXX

Note the instruction u = t - c, even though the left side and right
side don't even belong to the same thread of execution...

     -hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
