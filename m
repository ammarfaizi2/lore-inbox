Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280365AbRKNJgY>; Wed, 14 Nov 2001 04:36:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280382AbRKNJgO>; Wed, 14 Nov 2001 04:36:14 -0500
Received: from workplace.tp1.ruhr-uni-bochum.de ([134.147.240.2]:2308 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S280365AbRKNJf4>; Wed, 14 Nov 2001 04:35:56 -0500
Date: Wed, 14 Nov 2001 10:25:29 +0100 (CET)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: <kai@vaio>
To: Thomas Hood <jdthood@mail.com>
cc: Keith Owens <kaos@ocs.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] parport_pc to use pnpbios_register_driver()
In-Reply-To: <1005687707.21561.14.camel@thanatos>
Message-ID: <Pine.LNX.4.33.0111140935350.791-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Nov 2001, Thomas Hood wrote:

> You misunderstand.  Obviously we don't want to force anyone
> to build in isa-pnp or pnpbios support.  What Keith is saying
> is that IF isa-pnp code is enabled in a driver then the isa-pnp
> driver should also be built.  Furthermore if isa-pnp code is
> enabled in an _integral_ (i.e., non-modular) driver, then the
> isa-pnp driver should also be built integrally.  The combination
> of integral-driver-with-isa-pnp-support-enabled and modular
> isa-pnp driver should be disallowed by the configurator.

Well, I understand what Keith is saying, but that just doesn't apply 
currently, or if so, tell me what I got wrong.

"IF isa-pnp code is enabled in a driver,..." What does that mean?  There
is no way to specifically enable isa-pnp code in most (all?) of the
drivers.

As an example, let me take drivers/net/ne.c, though this applies to
basically all drivers that support kernel-level ISAPnP. (parport is a bad
example, as it apparently does not).  If there was a CONFIG_NE2000_ISAPNP
option, then it would make sense to enforce

"CONFIG_NE2000_ISAPNP = m -> enforce CONFIG_ISAPNP != m" and
"CONFIG_NE2000_ISAPNP = y -> enforce CONFIG_ISAPNP = y"

That may be possible in CML2, in CML1 the logic is the other way round, so 
it would need to be:

"CONFIG_ISAPNP = y and CONFIG_NE2000 != n -> ask for CONFIG_NE2000_ISAPNP"
"CONFIG_ISAPNP = m and CONFIG_NE2000 = m  -> ask for CONFIG_NE2000_ISAPNP"
don't ask otherwise

BTW: I think the current logic is useful, as it allows the user to specify 
in the beginning that he doesn't have an ISA/ISAPNP bus and thus gets 
never asked for drivers/features he couldn't possibly use. But that may be 
a matter of taste, and I believe CML2 allows for both.

My point is, there is no CONFIG_NE2000_ISAPNP option, and the decision to
compile in ISAPnP support is based upon CONFIG_ISAPNP{,_MODULE}. Of course
one option is to go through all the drivers, add these additional CONFIG_
variables and conditionally compile ISAPnP depending on them. However, I
doubt that's a good idea, the current scheme seems to have worked fine so
far.

No, if we don't change the config rules, of course it does not make sense
to compile ISAPNP code into a built-in object when ISAPNP is selected as
modular. However, that's what happening in most of the drivers today. It 
doesn't cause problems (unresolved symbols) because the isapnp.h header is 
smart, recognizes this case and replaces the isapnp_* functions with empty 
dummies. But as we've got the #ifdef in the driver anyway, we could as 
well be smart and just drop the calling code, as we do in the 
CONFIG_ISAPNP=n case.

It's just a question of replacing

#if defined(CONFIG_ISAPNP) || defined(CONFIG_ISAPNP_MODULE)

with

#if defined(CONFIG_ISAPNP) || (defined(CONFIG_ISAPNP_MODULE) && defined (MODULE))
a.k.a.
#ifdef __ISAPNP__



Now, let's get back to parport/pnpbios (hope I didn't loose all readers 
yet)

Looking at drivers/pnp/Config.in, it's apparent, that CONFIG_PNPBIOS is 
actually a bool. After reading your patch, which has 
"defined(CONFIG_PNPBIOS_MODULE)", I assumed that it was a tristate. As it 
apparently is not, the problem above doesn't arise at all. (My point still 
stands with regard to ISAPNP, though)

So for your driver, I would just say: delete the references to 
CONFIG_PNPBIOS_MODULE, which is never set.

Some further nitpicking w.r.t to your patch: why not just rename
init_pnp040x() to parport_pc_pnbios_probe(), get rid of the wrapper and
use the standard return values?

--Kai

