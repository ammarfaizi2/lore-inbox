Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263588AbUJ2XxD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263588AbUJ2XxD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 19:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263550AbUJ2Xwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 19:52:38 -0400
Received: from twinlark.arctic.org ([168.75.98.6]:48592 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP id S263643AbUJ2Xui
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 19:50:38 -0400
Date: Fri, 29 Oct 2004 16:50:38 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Andreas Steinmetz <ast@domdv.de>
cc: Linus Torvalds <torvalds@osdl.org>, linux-os@analogic.com,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Richard Henderson <rth@redhat.com>, Andi Kleen <ak@muc.de>,
       Andrew Morton <akpm@osdl.org>, Jan Hubicka <jh@suse.cz>
Subject: Re: Semaphore assembly-code bug
In-Reply-To: <41829C91.5030709@domdv.de>
Message-ID: <Pine.LNX.4.61.0410291639430.8616@twinlark.arctic.org>
References: <Pine.LNX.4.58.0410181540080.2287@ppc970.osdl.org> 
 <417550FB.8020404@drdos.com>  <1098218286.8675.82.camel@mentorng.gurulabs.com>
  <41757478.4090402@drdos.com>  <20041020034524.GD10638@michonline.com> 
 <1098245904.23628.84.camel@krustophenia.net> <1098247307.23628.91.camel@krustophenia.net>
 <Pine.LNX.4.61.0410200744310.10521@chaos.analogic.com>
 <Pine.LNX.4.61.0410290805570.11823@chaos.analogic.com>
 <Pine.LNX.4.58.0410290740120.28839@ppc970.osdl.org> <41826A7E.6020801@domdv.de>
 <Pine.LNX.4.61.0410291255400.17270@chaos.analogic.com>
 <Pine.LNX.4.58.0410291103000.28839@ppc970.osdl.org> <418292C7.2090707@domdv.de>
 <Pine.LNX.4.58.0410291212350.28839@ppc970.osdl.org> <41829C91.5030709@domdv.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 29 Oct 2004, Andreas Steinmetz wrote:

> > On Fri, 29 Oct 2004, Andreas Steinmetz wrote:
> > > Sample quote from said manual (P/N 248966-05):
> > > "Use the lea instruction and the full range of addressing modes to do
> > > address calculation"
...
> Some more data from said manual (lea is better on P3 and the same as add on
> P4):

you really need to understand intel optimisation guides.  it helps to diff 
them over time to see the types of things that go in and out of fashion.

> I don't know about P4 internals but let me make some guess:
> There's lot of software around that needs to run on older processors where lea
> has quite some performance advantage. Thus I would guess that the P4 design
> respects this by handling lea x(esp),esp efficiently.

your guess is generally wrong... try measuring it.

for p4 model 0 through 2 it was faster to avoid lea and shl and generate 
code like:

	add %ebx,%ebx
	add %ebx,%ebx
	add %ebx,%ebx
	add %ebx,%ebx

which would complete in 2 cycles, compared to 4 cycles for lea or a shift.  
but that crap doesn't apply to any other x86 (except efficeon which 
notices this crud and converts it to its own optimal sequence).

p4 model 2 is probably way more common than p4 model 3 still.

you also need to be aware of k7/k8.  AMD has their own optimisation guide 
(i'm too lazy to find url/#).  but the important point for lea and AMD is 
that it is a 2 cycle latency operation, and add is 1 cycle.

but you know what?  we can talk about what the optimization guides say 
until we're blue... the only thing which matters is experience.  go 
measure it.  (i've measured a bazillion things like this.)

use pop, don't use lea to modify esp.

-dean
