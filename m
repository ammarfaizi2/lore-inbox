Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964914AbVL1VXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964914AbVL1VXh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 16:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964916AbVL1VXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 16:23:37 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:54977 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964914AbVL1VXg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 16:23:36 -0500
Date: Wed, 28 Dec 2005 22:23:13 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Matt Mackall <mpm@selenic.com>
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
Message-ID: <20051228212313.GA4388@elte.hu>
References: <20051228114637.GA3003@elte.hu> <Pine.LNX.4.64.0512281111080.14098@g5.osdl.org> <1135798495.2935.29.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.9 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.9 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> On Wed, 28 Dec 2005, Arjan van de Ven wrote:
> > 
> > yup that's why the patch only does it for gcc4, in which the inlining
> > heuristics finally got rewritten to something that seems to resemble
> > sanity...
> 
> Is that actually true of all gcc4 versions? I seem to remember gcc-4.0 
> being a real stinker.

all my tests were with gcc 4.0.2.

> > > Also, the inlining patch apparently makes code larger in some cases, 
> > > so it's not even a unconditional win.
> > 
> > .... as long as you give the inlining algorithm enough information. 
> > -fno-unit-at-a-time prevents gcc from having the information, and the 
> > decisions it makes are then less optimal...
> > 
> > (unit-at-a-time allows gcc to look at the entire .c file, eg things like
> > number of callers etc etc, disabling that tells gcc to do the .c file as
> > single pass top-to-bottom only)
> 
> I'd still prefer to see numbers with -funit-at-a-time only. I think 
> it's an independent knob, and I'd be much less worried about that, 
> because we do know that unit-at-a-time has been enabled on x86-64 for 
> a long time ("forever"). So that's less of a change, I feel.

the two patches are completely independent, and the only reason i did 
them together was because i was looking at .text size in general and 
these were the two things that made a difference. Also, the inlining was 
a loss in one of the .config's, unless combined with the wider-scope 
unit-at-a-time optimization.

(there's a third thing that i was also playing with, -ffunction-sections 
and -fdata-sections, but those dont seem to be reliable on the binutils 
side yet.)

here are the isolated unit-at-a-time numbers as well:

   text    data     bss     dec     hex filename
  3286166  869852  387260 4543278  45532e vmlinux-orig
  3259928  833176  387748 4480852  445f54 vmlinux-units         -0.8%
  3194123  955168  387260 4536551  4538e7 vmlinux-inline        -2.9%
  3119495  884960  387748 4392203  43050b vmlinux-inline+units  -5.3%

so both inlining and unit-at-a-time is a win independently [although 
inlining alone does bloat .data], but applied together they bring an 
additional 1.6% of .text savings. All builds done with:

   gcc version 4.0.2 20051109 (Red Hat 4.0.2-6)

how about giving the inlining stuff some more exposure in -mm (if it's 
fine with Andrew), to check for any regressions? I'd suggest the same 
for the unit-at-a-time thing too, in any case.

	Ingo
