Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031406AbWKUUuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031406AbWKUUuP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 15:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031320AbWKUUuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 15:50:15 -0500
Received: from gw.goop.org ([64.81.55.164]:55464 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1031406AbWKUUuN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 15:50:13 -0500
Message-ID: <4563667B.2060209@goop.org>
Date: Tue, 21 Nov 2006 12:50:03 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: Avi Kivity <avi@qumranet.com>, Arnd Bergmann <arnd@arndb.de>,
       kvm-devel@lists.sourceforge.net, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [kvm-devel] [PATCH] KVM: Avoid using vmx instruction directly
References: <20061109110852.A6B712500F7@cleopatra.q> <200611091429.42040.arnd@arndb.de> <45532EE3.4000104@qumranet.com> <200611091542.31101.arnd@arndb.de> <455340B8.2080206@qumranet.com> <4553BC18.6090207@goop.org> <45634704.8020407@zytor.com>
In-Reply-To: <45634704.8020407@zytor.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> I think you're wrong about that; in particular, I'm pretty sure "asm
> volatiles" are ordered among themselves.  What the "volatile" means is
> "this has side effects you (the compiler) don't understand", and gcc
> can't assume that it can reorder such side effects. 
That's not how I read the manual (quoted below).  "asm volatile" is much
weaker than people seem to think it is; the "volatile" puts fewer
constraints on the compiler than it would for a variable.  While the
manual doesn't say that "asm volatiles" could be reordered with respect
to each other, it doesn't say that they won't, and I don't see anything
in this description which could be read to imply it (indeed "can be
moved relative to other code" includes other asm volatiles).

Like "volatile" variables, I think "asm volatile" is probably overused. 
If you want to guarantee specific ordering of asms, it's probably better
to add an explicit dependency between them rather than rely on asm
volatile; this could either be a "memory" clobber, or something more
fine-grained.  For example:

    /* need never be instansiated; never actually referenced */
    extern int spin_sequencer;

    /* %0 never referenced */
    asm("take spinlock" : "+m" (spin_sequencer)...);

    ...

    /* again, %0 never referenced */
    asm("release spinlock" : "+m" (spin_sequencer)...);

This is example is a bit contrived since a real spinlock would also have
to have a memory clobber - or some other barrier - but you get the
idea.  It has the nice property of allowing you to define precise
dependencies between various asm()s, without having to set up
unnecessary dependencies between unrelated asms; and by making use of
in/out/inout asm parameters, you can express different kinds of
dependencies which give gcc a better chance of understanding what's
going on.

The relevent bit of the manual:

    The `volatile' keyword indicates that the instruction has important
    side-effects.  GCC will not delete a volatile `asm' if it is reachable.
    (The instruction can still be deleted if GCC can prove that
    control-flow will never reach the location of the instruction.)  Note
    that even a volatile `asm' instruction can be moved relative to other
    code, including across jump instructions.  For example, on many targets
    there is a system register which can be set to control the rounding
    mode of floating point operations.  You might try setting it with a
    volatile `asm', like this PowerPC example:

                asm volatile("mtfsf 255,%0" : : "f" (fpenv));
                sum = x + y;

    This will not work reliably, as the compiler may move the addition back
    before the volatile `asm'.  To make it work you need to add an
    artificial dependency to the `asm' referencing a variable in the code
    you don't want moved, for example:

             asm volatile ("mtfsf 255,%1" : "=X"(sum): "f"(fpenv));
             sum = x + y;

     Similarly, you can't expect a sequence of volatile `asm' instructions
    to remain perfectly consecutive.  If you want consecutive output, use a
    single `asm'.  Also, GCC will perform some optimizations across a
    volatile `asm' instruction; GCC does not "forget everything" when it
    encounters a volatile `asm' instruction the way some other compilers do.

     An `asm' instruction without any output operands will be treated
    identically to a volatile `asm' instruction.


