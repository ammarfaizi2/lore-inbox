Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274758AbRIZAvs>; Tue, 25 Sep 2001 20:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274759AbRIZAvj>; Tue, 25 Sep 2001 20:51:39 -0400
Received: from barry.mail.mindspring.net ([207.69.200.25]:20520 "EHLO
	barry.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S274758AbRIZAv3>; Tue, 25 Sep 2001 20:51:29 -0400
Subject: Re: [PATCH][RFC] Allow net devices to contribute to /dev/random
From: Robert Love <rml@ufl.edu>
To: David Wagner <daw@mozart.cs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9or70g$i59$1@abraham.cs.berkeley.edu>
In-Reply-To: <1001461026.9352.156.camel@phantasy> 
	<9or70g$i59$1@abraham.cs.berkeley.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.14.99+cvs.2001.09.24.08.08 (Preview Release)
Date: 25 Sep 2001 20:52:09 -0400
Message-Id: <1001465531.10701.61.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2001-09-25 at 20:20, David Wagner wrote:
> I'm worried about the language in the configuration documentation:
>   +  Some people, however, feel that network devices should not contribute to
>   +  /dev/random because an external attacker could observe incoming packets
>   +  in an attempt to learn the entropy pool's state. Note this is completely
>   +  theoretical. 
> Incrementing the entropy counter based on externally observable
> values is dangerous.  Calling this risk 'completely theoretical'
> is, I believe, a misrepresentation, unless I've missed something.

First, I agree the wording is too `kind' and I will change it.

However, the actual end result -- that the output of /dev/random can be
predicted -- is theoretical, because of the fact the output is one-way
hashed.  I do not want to get into another full discussion of this, but
a thread exists about a month back that discussed it.

To summarize: the patch is a risk if and only if: SHA-1 is cracked, an
attacker can observe the state of network packets, and it contributes
enough to the pool that enough of its state is learned.

Some diskless machines really have _zero_ entropy.  This patch does them
good.  If you don't want net devices to contribute, don't enable them.

Hell, without this patch, some network devices do contribute!  It
actually standardizes the whole thing.

> A failed RNG is one of the most likely -- and most devastating
> -- failure modes possible for modern cryptosystems, and as such
> it pays to be careful here.  Are you proposing this for inclusion
> in the mainline Linux kernel?  If so, I'm concerned that this patch
> could put security at risk.  What am I missing?

I would like to see it in the kernel, for 2.5.

I agree a poor RNG is a risk.  I also put forth that this patch is
configurable and that WITHOUT it you actually have a few NIC drivers
that contribute to /dev/random!

If you are on a diskless system and need some seed for whatever, say SSH
or just something dinky, this patch may be a requirement.  Even on my
workstation, sometimes SSH blocks for some seconds waiting for
/dev/random to fill up.

> Here is my reasoning.  I'd like to quote drivers/char/random.c:
>   * add_interrupt_randomness() uses the inter-interrupt timing as random
>   * inputs to the entropy pool.  Note that not all interrupts are good
>   * sources of randomness!  For example, the timer interrupts is not a
>   * good choice, because the periodicity of the interrupts is too
>   * regular, and hence predictable to an attacker.  Disk interrupts are
>   * a better measure, since the timing of the disk interrupts are more
>   * unpredictable.
>   * 
>   * All of these routines try to estimate how many bits of randomness a
>   * particular randomness source.  They do this by keeping track of the
>   * first and second order deltas of the event timings.

Obviously the timer interrupt would be the worst idea ever.  Its the
same value (HZ) on almost all versions of Linux (Alpha being on example
where it is not the same).

> This suggests that add_interrupt_randomness() should not be called
> on all interrupts without discrimination.  Would it be fair to say
> that your patch enables randomness collection on almost all interrupts?
> If so, why is this safe to do?

No, it enables them on the interrupt for your NIC, if you enable the
config setting.  If you don't enable the config, then your NIC won't
contribute.

If you don't use the patch, then it is unknown what your NIC will do
without looking at the source.  A few drivers currently do set
SA_SAMPLE_RANDOM.

> I hope you agree that making this configurable does not obviate our
> responsibility to make sure that the default configuration is reasonable.

The default is off.

> This stuff is subtle, and changing it is not something I'd recommend
> without a careful analysis of the impact on security.  Moreover, the
> comments about 'completely theoretical' leave me concerned that any
> analysis that has been done on this patch may be based on misconceptions
> about cryptographic security.  Can you tell us anything about what
> security analysis you've done so far?

This patch has been around, and a consensus has been reached.  I also
understand the mathematics here.

Again:
Yes, network traffic can be observed (or even influenced) and this could
allow an attacker to learn something of the state of your entropy pool. 
Note this would be hard due to clock skews and the such, but yes it is
entirely possible.

Yes, if your pool has little other entropy, the attacker now knows of a
good deal of the state of the pool.

Yes, assuming SHA-1 is at risk, the attacker can know for SURE the
output of /dev/random.

Yes, this is completely theoretical.  Is this a risk? Sure. But it
defaults to off.  Sitting on my home network and knowing the strength of
SHA-1, I don't fear any of this.  Or maybe I am desperate for entropy
since I have no disks or user interaction on this system.  The patch was
written out of a discussion for it, even.

Thus, the patch defaults to off.  By all means, keep it off.  I agree
the wording should be made more intimidating.  However, without this
patch, your NIC could be contributing -- the patch actually institutes a
policy.

That is all this is.  Having a clearly defined policy, and letting it be
configurable.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

