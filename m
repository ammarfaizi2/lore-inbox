Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310298AbSCPMNH>; Sat, 16 Mar 2002 07:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310299AbSCPMM5>; Sat, 16 Mar 2002 07:12:57 -0500
Received: from petkele.almamedia.fi ([194.215.205.158]:42658 "HELO
	petkele.almamedia.fi") by vger.kernel.org with SMTP
	id <S310298AbSCPMMr>; Sat, 16 Mar 2002 07:12:47 -0500
Message-ID: <3C9336A4.7757FD1E@pp.inet.fi>
Date: Sat, 16 Mar 2002 14:12:20 +0200
From: Jari Ruusu <jari.ruusu@pp.inet.fi>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.2.20aa1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Herbert Valerio Riedel <hvr@hvrlab.org>
CC: Andrea Arcangeli <andrea@suse.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org, linux-crypto@nl.linux.org
Subject: Re: 2.4.19pre3aa2
In-Reply-To: <20020314032801.C1273@dualathlon.random> 
			<3C912ACF.AF3EE6F0@pp.inet.fi>
			<1016194785.5713.200.camel@janus.txd.hvrlab.org> 
			<3C923120.B3AF105E@pp.inet.fi> <1016217396.5595.279.camel@janus.txd.hvrlab.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Valerio Riedel wrote:
> On Fri, 2002-03-15 at 18:36, Jari Ruusu wrote:
> > Not changing IV parameter type in 2.4 kernels is important. Break that in
> > 2.5/2.6 kernels, but not in stable 2.4, ok?
> 
> if you look closely at the typedef above, you'll notice that it doesn't
> introduce a _new_ type, but only a synonym for the 'int' type, which
> happens to be the type used in 2.4 kernels...

A synonym that does not exist on older kernels.

> typedef int (* transfer_proc_t)(struct loop_device *, int cmd,
>                                 char *raw_buf, char *loop_buf, int size,
>                                 int real_block);
                                  ^^^
That function prototype _must_ _not_ change in 2.4 kernels. That 'int'
better be there on newer 2.4 kernels.

> > Older 2.4 kernels dont't have
> > loop_iv_t, and being able to compile _existing_ modules for them is
> > important.
> as older kernels will likely have the variable-IV-metric, they'll have
> to be patched anyway (loop.[ch]), and after having patched them, the
> problem vanishes...

If you haven't noticed, loop-AES compiles and works fine on older kernels
without changing anything in kernel sources.

> > So the choice here is either break (or at least cause need to modify) all
> > other implementations or cryptoapi implementation.
> actually it's just -- either make my life harder w/ cryptoapi or not, as
> it doesn't affect other implementations;

Transfer function prototype change does affect other implementations. I
would have to add workaround to compile loop-AES on older kernels. If
cryptoapi got one parameter wrong, I don't see why other implementations
should bend over because of that.

Herbert, if you need some special types and/or macros in cryptoapi, just
define them in cryptoapi include files. Please don't mess with code that
other implementations depend on.

> > Herbert, if this loop_iv_t type goes into mainline kernel, I will have to
> > reverse that on loop-AES patches for backward compatibility.
> I don't see why... loop_iv_t is just a 'reviced-declarator-type-list
> int', i.e. it is is type compatible w/ an 'int'... so you won't even
> notice the difference when compiling loop-AES against it...

What I do notice is having to add workaround. See, loop-AES only creates
patched-loop.c (but not patched-loop.h), and under some circumstances
patched-loop.c may come from newer code than loop.h. So it needs a
workaround if transfer function prototype is changed.

> > Dependency on above mentioned #define's/typedef on kernel include files is
> > silly, as cryptoapi can define them on any of its own include files.
> yeah, sure... at the expense of having to redundantly keep track (ugly
> #ifdef's) of which kernel version is being used...

If IV parameter type is changed from 32 bits to 64 bits, you will need new
code and #ifdef's to handle that anyway. And that is 2.5/2.6 thing anyway.

Regards,
Jari Ruusu <jari.ruusu@pp.inet.fi>
