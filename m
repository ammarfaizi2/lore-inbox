Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262524AbTHZEJk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 00:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262537AbTHZEJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 00:09:40 -0400
Received: from twinlark.arctic.org ([168.75.98.6]:23780 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP id S262524AbTHZEJi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 00:09:38 -0400
Date: Mon, 25 Aug 2003 21:09:33 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
cc: "Barry K. Nathan" <barryn@pobox.com>, Mikael Pettersson <mikpe@csd.uu.se>,
       linux-kernel@vger.kernel.org, lkml@kcore.org
Subject: Re: Pentium-M?
In-Reply-To: <Pine.LNX.4.53.0308231418070.15935@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.53.0308252054480.15337@twinlark.arctic.org>
References: <200308231236.h7NCaMl0018383@harpo.it.uu.se>
 <Pine.LNX.4.53.0308230901200.15935@montezuma.fsmlabs.com>
 <20030823180338.GA3562@ip68-4-255-84.oc.oc.cox.net>
 <Pine.LNX.4.53.0308231418070.15935@montezuma.fsmlabs.com>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Aug 2003, Zwane Mwaikambo wrote:

> On Sat, 23 Aug 2003, Barry K. Nathan wrote:
>
> > On Sat, Aug 23, 2003 at 09:03:17AM -0400, Zwane Mwaikambo wrote:
> > > That's interesting, intel compiler recommends P4 type optimisations,
> > > also worth noting that the P-M has hardware prefetch.
> >
> > I'm pretty sure the "Tualatin" Pentium III's also have hardware prefetch.
> > So it's not something specific to the P4 or P-M.

yeah tualatin has hw prefetch.  p-m can handle more streams than tualatin.


> Someone else (in concordance with Mikael) also pointed out that the
> cacheline size is also the same as the PIII and not P4. So it's best
> going for PIII optimisations. It's best ignoring my previous comment then.

P-M has a 64-byte L1 dcacheline size same as P4 -- p3 has only 32 bytes.
see <http://sandpile.org/impl/pm.htm> for example.  (it's possible to
prove it experimentally if you want :)  but i thought kernel cacheline
size stuff was only important for SMP locking alignments?

there's details regarding the differences between P-M and P4 in the latest
"P4 optimisation guide", which was document id 24896609 at
developer.intel.com last time i fetched it, it might have been rev'd since
then.

basically the main disadvantage to selecting P4 for kernel compiling on a
centrino is that P-M has the same complex-simple-simple (4-1-1) uop
decoding machinery as the entire P6 family line... whereas P4's trace
cache somewhat offsets the P4's decoder's quirks.  so stuff scheduled for
p4 may not produce the best complex-simple-simple sequence that a p6
family processor wants to see.  i'm not really sure how well gcc does in
either case though... (whereas icc does a stellar job.)

i bet intel is saying "optimise for p4" for two reasons:

(a) the reality is way too complex to describe
(b) p4 is their long-term bet and they'd rather code be targetted to it
    specifically

however, if/when gcc picks up some of the more wacked p4 optimisations,
such as turning multiplication by 32 into:

	add eax,eax
	add eax,eax
	add eax,eax
	add eax,eax
	add eax,eax

then you'll start to see penalties on p6 cores ... the p4 does not like
shifts or lea.  the above runs in 2.5 cycles on a p4 (double-pumped ALUs)
whereas a shift or lea would be 4 clocks.

-dean
