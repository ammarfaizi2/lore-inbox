Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318156AbSGWSMR>; Tue, 23 Jul 2002 14:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318162AbSGWSMR>; Tue, 23 Jul 2002 14:12:17 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:54726 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S318156AbSGWSMQ>; Tue, 23 Jul 2002 14:12:16 -0400
Date: Tue, 23 Jul 2002 20:15:48 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Andrea Arcangeli <andrea@suse.de>
cc: Daniel McNeil <daniel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19rc2aa1 i_size atomic access
In-Reply-To: <20020723174712.GB1117@dualathlon.random>
Message-ID: <Pine.GSO.3.96.1020723201042.3586B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jul 2002, Andrea Arcangeli wrote:

> diff -urNp race/include/asm-i386/system.h race-fix/include/asm-i386/system.h
> --- race/include/asm-i386/system.h	Tue Jul 23 18:46:44 2002
> +++ race-fix/include/asm-i386/system.h	Tue Jul 23 18:47:10 2002
> @@ -143,6 +143,8 @@ struct __xchg_dummy { unsigned long a[10
>  #define __xg(x) ((struct __xchg_dummy *)(x))
>  
>  
> +#ifdef CONFIG_X86_CMPXCHG
> +#define __ARCH_HAS_GET_SET_64BIT 1
>  /*
>   * The semantics of XCHGCMP8B are a bit strange, this is why
>   * there is a loop and the loading of %%eax and %%edx has to
> @@ -167,7 +169,7 @@ static inline void __set_64bit (unsigned
>  		"lock cmpxchg8b (%0)\n\t"
>  		"jnz 1b"
>  		: /* no outputs */
> -		:	"D"(ptr),
> +		:	"r"(ptr),
>  			"b"(low),
>  			"c"(high)
>  		:	"ax","dx","memory");

 The condition is invalid, "cmpxchg" != "cmpxchg8b" and CONFIG_X86_CMPXCHG
is (correctly) set for the i486 which doesn't support the latter.  You
probably need a separate option, e.g. CONFIG_X86_CMPXCHG8B, and verify the
presence of the instruction with the feature flags if the option is set
(check_config() seems the right place).

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

