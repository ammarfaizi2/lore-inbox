Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965165AbWI0Uua@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965165AbWI0Uua (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 16:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965164AbWI0Uu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 16:50:29 -0400
Received: from ns2.suse.de ([195.135.220.15]:49340 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965162AbWI0Uu1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 16:50:27 -0400
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [BUG] Oops on boot (probably ACPI related)
Date: Wed, 27 Sep 2006 22:50:21 +0200
User-Agent: KMail/1.9.3
Cc: Kyle McMartin <kyle@parisc-linux.org>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org, akpm@osdl.org, jbeulich@novell.com
References: <200609271424.47824.eike-kernel@sf-tec.de> <Pine.LNX.4.64.0609271320580.3952@g5.osdl.org> <Pine.LNX.4.64.0609271329080.3952@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609271329080.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609272250.21925.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 27 September 2006 22:35, Linus Torvalds wrote:
> 
> On Wed, 27 Sep 2006, Linus Torvalds wrote:
> > 
> > On Wed, 27 Sep 2006, Andi Kleen wrote:
> > > 
> > > I expect this patch to fix it.
> > 
> > Andrew, Kyle, can you verify?
> 
> Not that it really matters. Andi sure as hell pinpointed a real problem 
> with the new and broken inline asm. That's almost certainly the bug that 
> crept in during the recent rewrite.
> 
> HOWEVER, now that I look more closely at the rewrite, I'm really wondering 
> whether the rewrite was worth it at all. It generates smaller code, but at 
> the expense of
> 
>  - the actual cache-footprint is bigger
>  - the branch will now be mis-predicted by default

It doesn't matter much because these days this stuff is all out of lined
anyways and in a single function. And the dynamic branch predictor
in all modern CPUs will usually cache the decision (unlocked) there.

(Actually there is something dumb  left -- on a non preempt kernel
spin_unlock caller is larger than doing it inline. But that is left
for fixing later)
 
> The fact that rewinders have problems is fairly immaterial. Maybe we 
> should just take this as a hint that all the stupid rewinding code was 
> wrong in the first place, and we should stop doing that? We can go back 
> to just printing out our stacktrace guesse

> 
> 		Linus
> 
s, that has worked for us for a 
> long time, and the stack unwinding simply looks _fundamentally_ flawed.

Unfortunately Linux is a lot more complex than it was in the early days.
 
> So I have a real urge to just revert that change anyway.
> 
> Are there any _real_ advantages to this broken unwinding code that has had 
> more bugs that Windows XP?

I thought for a long time we didn't need it either, but these days with all 
these callbacks in some parts of the kernel (driver model, others) and you 
get a oops with 60+ entries it is just too much trouble to figure it out manually.

I admit when I took the code I didn't realize that dwarf2 has these
problems (not supporting out of line sections is clearly a spec
bug and would even hit gcc generated code). But we don't have 
that many out of line sections anyways, so it's not that big an issue. 

And all the people who process a lot of oopses (e.g. Andrew, Ingo, others) tend
to use frame pointers by default anyways. They already voted with their feet.
And the unwinder certainly gives better code than frame pointers. The mispredicted
branches you're worrying about are nothing against frame pointers 
(e.g. on K8 FP tends to stall the CPU on each function call slightly)

Anyways, in theory it would be possible to keep the out of line sections
and define some own dwarf2 extension that allows us to express them.
Jan might have some thoughts on it. But I didn't think it was worth
it for these cases due to the reasons above.

-Andi
