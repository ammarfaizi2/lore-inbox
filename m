Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265582AbUFDE1W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265582AbUFDE1W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 00:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265580AbUFDE1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 00:27:21 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:26664 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S265582AbUFDE04 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 00:26:56 -0400
Date: Thu, 3 Jun 2004 21:31:19 -0700
From: Paul Jackson <pj@sgi.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@muc.de,
       ashok.raj@intel.com, hch@infradead.org, jbarnes@sgi.com,
       joe.korty@ccur.com, manfred@colorfullife.com, colpatch@us.ibm.com,
       mikpe@csd.uu.se, nickpiggin@yahoo.com.au, Simon.Derr@bull.net,
       wli@holomorphy.com
Subject: Re: [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based
 implementation
Message-Id: <20040603213119.06d2d97c.pj@sgi.com>
In-Reply-To: <1086313667.29381.897.camel@bach>
References: <20040603094339.03ddfd42.pj@sgi.com>
	<20040603101010.4b15734a.pj@sgi.com>
	<1086313667.29381.897.camel@bach>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty wrote:
> > +/* No static inline type checking - see Subtlety (1) above. */
> > +#define cpu_isset(cpu, cpumask) test_bit((cpu), (cpumask).bits)
> 
> How about something really grungy like:
> 
> #define cpu_isset(cpu, cpumask)			\
> 	({ __typeof__(cpumask) __cpumask;		\
> 	   (void)(&__cpumask) == (cpumask_t *)0);	\
> 	   test_bit((cpu), (cpumask).bits); })

Well ... we agree on the "grungy" part ... ;).

Your flavor has the same problem as I saw with the static inline nested
inside a #define macro flavor.  On i386, SMP, gcc 3.3.2, when the
cpu_isset() is part of a for-loop control, both the normal and 'grungy'
flavors cost one extra jump instruction, whereas the flavor I ended up
using places one chunk of code more optimally, saving a hard jump
instruction.

This saves 196 bytes of kernel text space.

If you can show me a type checked cpu_isset() that generates code
as tight as what I ended up using, let me know.

Or if you would prefer I spend the 196 bytes to get this type checked,
that's worthy of consideration as well.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
