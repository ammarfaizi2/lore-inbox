Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318857AbSH1Ozl>; Wed, 28 Aug 2002 10:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318859AbSH1Ozl>; Wed, 28 Aug 2002 10:55:41 -0400
Received: from tolkor.SGI.COM ([192.48.180.13]:36829 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S318857AbSH1Ozk>;
	Wed, 28 Aug 2002 10:55:40 -0400
From: Dean Nelson <dcn@sgi.com>
Message-Id: <200208281459.JAA83371@cyan.americas.sgi.com>
Subject: Re: atomic64_t proposal
To: schwab@suse.de (Andreas Schwab)
Date: Wed, 28 Aug 2002 09:59:54 -0500 (CDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <je1y8kgjda.fsf@sykes.suse.de> from "Andreas Schwab" at Aug 27, 2002 10:02:57 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Schwab writes:
> 
> Dean Nelson <dcn@sgi.com> writes:
> 
> |> +#define ia64_atomic_add(i,v)						\
> |> +({									\
> |> +	__typeof__((v)->counter) _old, _new;				\
> |> +	CMPXCHG_BUGCHECK_DECL						\
> |> +									\
> |> +	do {								\
> |> +		CMPXCHG_BUGCHECK(v);					\
> |> +		_old = atomic_read(v);					\
> |> +		_new = _old + (i);					\
> |> +	} while (ia64_cmpxchg("acq", (v), _old, _new, sizeof(*(v))) != _old); \
> |> +	(__typeof__((v)->counter)) _new;	/* return new value */	\
> 
> What's the purpose of the cast here? The type of _new is already the
> right one.

You're right, the cast is meaningless and should be removed. It's an artifact
of a macro that had several iterations of development.

> |>  #define atomic_add_return(i,v)						\
> |>  	((__builtin_constant_p(i) &&					\
> |>  	  (   (i ==  1) || (i ==  4) || (i ==  8) || (i ==  16)		\
> |>  	   || (i == -1) || (i == -4) || (i == -8) || (i == -16)))	\
> |>  	 ? ia64_fetch_and_add(i, &(v)->counter)				\
> |> -	 : ia64_atomic_add(i, v))
> |> +	 : ia64_atomic_add((i), (v)))
> 
> The extra parens are useless.

Yep, they're useless. I had introduced them merely to be consistent with
how the other macros in asm-ia64/atomic.h were done (macros that I didn't
modify). But the parentheses can be removed.

Thanks for the corrections.
Dean

