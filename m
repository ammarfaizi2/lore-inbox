Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262737AbTDUXo5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 19:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262739AbTDUXo5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 19:44:57 -0400
Received: from zero.aec.at ([193.170.194.10]:4105 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S262737AbTDUXo4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 19:44:56 -0400
Date: Tue, 22 Apr 2003 01:56:54 +0200
From: Andi Kleen <ak@muc.de>
To: Andi Kleen <ak@muc.de>
Cc: Jamie Lokier <jamie@shareable.org>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Runtime memory barrier patching II
Message-ID: <20030421235654.GA15229@averell>
References: <20030421192734.GA1542@averell> <Pine.LNX.4.44.0304211254190.17221-100000@home.transmeta.com> <20030421205333.GA13883@averell> <20030421233557.GB17595@mail.jlokier.co.uk> <20030421234611.GA15191@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030421234611.GA15191@averell>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 22, 2003 at 01:46:11AM +0200, Andi Kleen wrote:
> On Tue, Apr 22, 2003 at 01:35:57AM +0200, Jamie Lokier wrote:
> > Andi Kleen wrote:
> > > The patching code is quite generic and could be used to patch other
> > > instructions
> > 
> > Such as removing the lock prefix when running non-SMP?
> 
> Yes, could work. But you need a new variant of alternative()

Thinking about it will need more work, making it much harder:

- you need to move it after the CPU detection because before
you don't know how many CPUs are there or not.

- you need to define a new pseudo X86 feature bit for SMP active

- you can't easily put an assembly "i" argument into the LOCK_PREFIX
macro, so you have to hardcode the feature bit in there 
(not difficult, but ugly)

First part is somewhat nasty which makes it look not too attractive.
Before doing the necessary changes for that someone (= not me) 
should probably do some benchmarks first to see if it's worth it
at all. I suspect it is on the P4.

But: all the distributions I'm aware of install separate SMP 
and UP kernels. So it wouldn't be a big improvement for them.
And the other users likely compile a custom kernel anyways.

> or eat worse code. The current alternative() can only handle
> constant sized original instructions, which requires that you
> use a constant sized constraint (e.g. (%0) ... "r" (ptr)) etc.)
> "m" is unfortunately variable size.

Actually that was a bit too strict. It can deal with longer
code (the patch code will transparently nop that), just not with shorter
paths.

-Andi
