Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129428AbRBXQbe>; Sat, 24 Feb 2001 11:31:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129429AbRBXQbY>; Sat, 24 Feb 2001 11:31:24 -0500
Received: from UX4.SP.CS.CMU.EDU ([128.2.198.104]:32610 "HELO
	ux4.sp.cs.cmu.edu") by vger.kernel.org with SMTP id <S129428AbRBXQbF>;
	Sat, 24 Feb 2001 11:31:05 -0500
Subject: Re: creation of sock
To: jacob.blain.christen@entheal.com
Date: Sat, 24 Feb 2001 11:30:19 -0500 (EST)
From: Sourav Ghosh <sourav@ux4.sp.cs.cmu.edu>
Cc: sourav@cs.cmu.edu, linux-kernel@vger.kernel.org
In-Reply-To: <3A96DBC6.D02192AA@entheal.com> from "Jacob L E Blain Christen" at Feb 23, 2001 04:53:10 pm
Reply-To: sourav@cs.cmu.edu
X-Mailer: ELM [version 2.4 PL25-40]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20010224163115Z129428-28373+225@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

It seems like linux replaces sock with tcp_tw_bucket structure in the
sock list in order to "work around the memory consumption problems for
the heavilly loaded server". 

The header file tcp.h  has some comments before declaring
"tcp_tw_bucket" structure. It is done in tcp_input.c.

But anyway, tcp_tw_bucket is never identical to sock structure. This
is a serious hack and I'm suprised no linux kernel documentation talks
about it.

I just wanted to let others know so that no one else faces this
problem.

-- 
Sourav






















> 
> im a kernel newbie here so pardon "the blind leading the blind" ...
> 
> doing a quick search for all calls to sk_alloc in the entire kernel
> sources
> yields only one call that sets the "zero out the allocated struct"
> boolean
> to false and that is:
> 	net/ipv4/tcp_minisocks.c:tcp_create_openreq_child().
> this funtion in turn is only ever called from:
> 	net/ipv[46]/tcp_ipv[46].c:tcp_v[46]_syn_recv_sock()
> 
> the comment above the ipv4 version is (verbatim):
> 
> 	/* 
> 	 * The three way handshake has completed - we got a valid synack - 
> 	 * now create the new socket. 
> 	 */
> 
> so if you need those experimental values of yours zeroed out on socket
> creation i suggest replacing this snippet from
> net/core/sock.c:sk_alloc()
> 
>         if(sk && zero_it) {
>                 memset(sk, 0, sizeof(struct sock));
>                 sk->family = family;
>                 sock_lock_init(sk);
>         }
> 
> with
> 
>         if(  sk  ) {
> 		/* set your NULL init values here */
> 		if(  zero_it  ) {
> 	                memset(sk, 0, sizeof(struct sock));
> 	                sk->family = family;
> 	                sock_lock_init(sk);
> 		}
>         }
> 
> doh!  i just re-read your mail and realized youre using the 2.2.15
> kernel.
> my examples are from the 2.4.2 sources...
> 
> looking at the 2.2.16 source (i have only 2.2.1[46] and not 2.2.15 for
> the
> 2.2 series) the (roughly) congruent if block of code is:
> 
>         if(sk) {
>                 if (zero_it) 
>                         memset(sk, 0, sizeof(struct sock));
>                 sk->family = family;
>         }
> 
> and so if you're setting your init values to NULL under the "zero_it"
> condition you would get the behavior that you reported.
> 
> hope that helps.









