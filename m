Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129561AbRBWVxg>; Fri, 23 Feb 2001 16:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129696AbRBWVx0>; Fri, 23 Feb 2001 16:53:26 -0500
Received: from cc600749-a.hwrd1.md.home.com ([65.1.217.252]:64952 "EHLO
	entheal.com") by vger.kernel.org with ESMTP id <S129561AbRBWVxN>;
	Fri, 23 Feb 2001 16:53:13 -0500
Message-ID: <3A96DBC6.D02192AA@entheal.com>
Date: Fri, 23 Feb 2001 16:53:10 -0500
From: Jacob L E Blain Christen <dweomer@entheal.com>
Reply-To: jacob.blain.christen@entheal.com
Organization: Entheal LLC
X-Mailer: Mozilla 4.75 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Sourav Ghosh <sourav@cs.cmu.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: creation of sock
In-Reply-To: <3A96C858.5C8FB714@cs.cmu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

im a kernel newbie here so pardon "the blind leading the blind" ...

doing a quick search for all calls to sk_alloc in the entire kernel
sources
yields only one call that sets the "zero out the allocated struct"
boolean
to false and that is:
	net/ipv4/tcp_minisocks.c:tcp_create_openreq_child().
this funtion in turn is only ever called from:
	net/ipv[46]/tcp_ipv[46].c:tcp_v[46]_syn_recv_sock()

the comment above the ipv4 version is (verbatim):

	/* 
	 * The three way handshake has completed - we got a valid synack - 
	 * now create the new socket. 
	 */

so if you need those experimental values of yours zeroed out on socket
creation i suggest replacing this snippet from
net/core/sock.c:sk_alloc()

        if(sk && zero_it) {
                memset(sk, 0, sizeof(struct sock));
                sk->family = family;
                sock_lock_init(sk);
        }

with

        if(  sk  ) {
		/* set your NULL init values here */
		if(  zero_it  ) {
	                memset(sk, 0, sizeof(struct sock));
	                sk->family = family;
	                sock_lock_init(sk);
		}
        }

doh!  i just re-read your mail and realized youre using the 2.2.15
kernel.
my examples are from the 2.4.2 sources...

looking at the 2.2.16 source (i have only 2.2.1[46] and not 2.2.15 for
the
2.2 series) the (roughly) congruent if block of code is:

        if(sk) {
                if (zero_it) 
                        memset(sk, 0, sizeof(struct sock));
                sk->family = family;
        }

and so if you're setting your init values to NULL under the "zero_it"
condition you would get the behavior that you reported.

hope that helps.
