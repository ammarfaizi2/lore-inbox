Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318176AbSGWTQ6>; Tue, 23 Jul 2002 15:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318188AbSGWTQ5>; Tue, 23 Jul 2002 15:16:57 -0400
Received: from [195.223.140.120] ([195.223.140.120]:48167 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S318176AbSGWTQ5>; Tue, 23 Jul 2002 15:16:57 -0400
Date: Tue, 23 Jul 2002 21:20:52 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Daniel McNeil <daniel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19rc2aa1 i_size atomic access
Message-ID: <20020723192052.GF1117@dualathlon.random>
References: <20020723174712.GB1117@dualathlon.random> <Pine.GSO.3.96.1020723201042.3586B-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1020723201042.3586B-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2002 at 08:15:48PM +0200, Maciej W. Rozycki wrote:
> On Tue, 23 Jul 2002, Andrea Arcangeli wrote:
> 
> > diff -urNp race/include/asm-i386/system.h race-fix/include/asm-i386/system.h
> > --- race/include/asm-i386/system.h	Tue Jul 23 18:46:44 2002
> > +++ race-fix/include/asm-i386/system.h	Tue Jul 23 18:47:10 2002
> > @@ -143,6 +143,8 @@ struct __xchg_dummy { unsigned long a[10
> >  #define __xg(x) ((struct __xchg_dummy *)(x))
> >  
> >  
> > +#ifdef CONFIG_X86_CMPXCHG
> > +#define __ARCH_HAS_GET_SET_64BIT 1
> >  /*
> >   * The semantics of XCHGCMP8B are a bit strange, this is why
> >   * there is a loop and the loading of %%eax and %%edx has to
> > @@ -167,7 +169,7 @@ static inline void __set_64bit (unsigned
> >  		"lock cmpxchg8b (%0)\n\t"
> >  		"jnz 1b"
> >  		: /* no outputs */
> > -		:	"D"(ptr),
> > +		:	"r"(ptr),
> >  			"b"(low),
> >  			"c"(high)
> >  		:	"ax","dx","memory");
> 
>  The condition is invalid, "cmpxchg" != "cmpxchg8b" and CONFIG_X86_CMPXCHG
> is (correctly) set for the i486 which doesn't support the latter.  You
> probably need a separate option, e.g. CONFIG_X86_CMPXCHG8B, and verify the
> presence of the instruction with the feature flags if the option is set
> (check_config() seems the right place).

the problem with the feature flag check is that I don't want to make it
conditional at runtime, if I start adding branches and checks on the
feature flag (or pointer to functions) I can as well use the ordered
read/writes C version without reading/writing the 64bit atomically. So
the check_config() will be the oops or the not-oops at the first i_size
read/write :).

As for the CONFIG_X86_CMPXCHG8B you're right it's needed, setting
CONFIG_M486=y and CONFIG_SMP=y would generate a kernel that would oops
on a 486 and I don't see any other way to get 486+SMP case right without
checking for the X86_FEATURE_CX8 capability at runtime. Not that I think
486+SMP is high prio but yes, theoretically it's a bug.

Andrea
