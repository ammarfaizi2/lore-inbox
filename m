Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281957AbRKUTrV>; Wed, 21 Nov 2001 14:47:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281961AbRKUTrL>; Wed, 21 Nov 2001 14:47:11 -0500
Received: from amsfep11-int.chello.nl ([213.46.243.19]:45840 "EHLO
	amsfep11-int.chello.nl") by vger.kernel.org with ESMTP
	id <S281960AbRKUTrG>; Wed, 21 Nov 2001 14:47:06 -0500
Date: Wed, 21 Nov 2001 20:46:59 +0100
From: Jeroen Vreeken <pe1rxq@amsat.org>
To: linux-kernel@vger.kernel.org
Cc: linux-hams <linux-hams@vger.kernel.org>, tomi.manninen@hut.fi,
        dg2fef@afthd.tu-darmstadt.de
Subject: Re: [PATCH] Using sock_orphan in ax25 and netrom
Message-ID: <20011121204659.C1187@jeroen.pe1rxq.ampr.org>
In-Reply-To: <20011120154610.A189@jeroen.pe1rxq.ampr.org> <20011121194223.A1187@jeroen.pe1rxq.ampr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20011121194223.A1187@jeroen.pe1rxq.ampr.org>; from pe1rxq@amsat.org on Wed, Nov 21, 2001 at 19:42:23 +0100
X-Mailer: Balsa 1.1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2001.11.21 19:42:23 +0100 Jeroen Vreeken wrote:
> Appearantly my patch from yesterday was a bit premature...
> 
> It looks like the ax25 and netrom stack do some magic with the dead
> sockets
> that is not compatible with sock_orphan. I will try and see if I can
> track
> them down.

Found the cause in datagram_poll() in datagram.c:


        if (sock_writeable(sk))
                mask |= POLLOUT | POLLWRNORM | POLLWRBAND;
        else
                set_bit(SOCK_ASYNC_NOSPACE, &sk->socket->flags);

Since our socket is dead its not writeable and the code tries to set
sk->socket->flags
However sk->socket has been set to NULL by sock_orphan()
Adding a check for this solves the problem:

        if (sock_writeable(sk))
                mask |= POLLOUT | POLLWRNORM | POLLWRBAND;
        else
                if (sk->socket)
                        set_bit(SOCK_ASYNC_NOSPACE, &sk->socket->flags);

Is there a reason datagram_poll() should not check this? (Or another place
to do it)
If not I will make a new patch including this change.

Jeroen


