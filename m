Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132807AbRARWV4>; Thu, 18 Jan 2001 17:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135868AbRARWVq>; Thu, 18 Jan 2001 17:21:46 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:28778 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S132807AbRARWVk>; Thu, 18 Jan 2001 17:21:40 -0500
Date: Thu, 18 Jan 2001 23:16:51 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, Rick Jones <raj@cup.hp.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        "David S. Miller" <davem@redhat.com>
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
Message-ID: <20010118231651.L28276@athlon.random>
In-Reply-To: <20010118225432.K28276@athlon.random> <Pine.LNX.4.30.0101182254170.2880-100000@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0101182254170.2880-100000@elte.hu>; from mingo@elte.hu on Thu, Jan 18, 2001 at 10:57:20PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 18, 2001 at 10:57:20PM +0100, Ingo Molnar wrote:
> 
> On Thu, 18 Jan 2001, Andrea Arcangeli wrote:
> 
> > > {
> > >         int val = 1;
> > >         setsockopt(req->sock, IPPROTO_TCP, TCP_CORK,
> > > 			(char *)&val,sizeof(val));
> > >         val = 0;
> > >         setsockopt(req->sock, IPPROTO_TCP, TCP_CORK,
> > > 			(char *)&val,sizeof(val));
> > > }
> > >
> > > differ from what you posted. It does the same in my opinion. Maybe we are
> > > not talking about the same thing?
> >
> > The above is equivalent to SIOCPUSH _only_ if the caller wasn't using either
> > TCP_NODELAY or TCP_CORK.
> 
> why? I can restore whatever state i want, the above is just a mechanizm to

This is a possible slow (but userspace based) implementation of SIOCPUSH:

{
	int was_set_tcp_cork, was_set_tcp_nodelay, val

	getsockopt(TCP_CORK, &was_set_tcp_cork)
	if (was_set_tcp_cork)
		val = 0
	else if (!was_set_tcp_nodelay)
		val = 1
	else
		return
		
	setsockopt(TCP_CORK, &val)
	val = !!val
	setsockopt(TCP_CORK, &val)
}

Your one ins't.

BTW, the simmetry between getsockopt/setsockopt further bias how SIOCPUSH
doesn't fit into the setsockopt options but it fits very well into the ioctl
categorty instead. There's simply no state one can return via getsockopt for
the SIOCPUSH functionality. It's not setting any option, it's just doing one
thing that controls the I/O.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
