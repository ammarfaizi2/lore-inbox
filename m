Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132059AbRBQWqe>; Sat, 17 Feb 2001 17:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132114AbRBQWqY>; Sat, 17 Feb 2001 17:46:24 -0500
Received: from ferret.lmh.ox.ac.uk ([163.1.18.131]:518 "HELO
	ferret.lmh.ox.ac.uk") by vger.kernel.org with SMTP
	id <S132059AbRBQWqV>; Sat, 17 Feb 2001 17:46:21 -0500
Date: Sat, 17 Feb 2001 22:46:19 +0000 (GMT)
From: Chris Evans <chris@scary.beasts.org>
To: <kuznet@ms2.inr.ac.ru>
cc: <linux-kernel@vger.kernel.org>, <davem@redhat.com>
Subject: Re: SO_SNDTIMEO: 2.4 kernel bugs
In-Reply-To: <200102172029.XAA28904@ms2.inr.ac.ru>
Message-ID: <Pine.LNX.4.30.0102172239570.24119-100000@ferret.lmh.ox.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Alexey,

This patch fixes my simple read()/write() tests, nice one. The behaviour
also now matches BSD (someone kindly donated me a FreeBSD shell for
testing).

Unfortunately, I discovered a bug with SO_SNDTIMEO/sendfile():

- Connect an AF_INET, SOCK_STREAM socket to a local listening socket.
- Set 5 seconds SO_SNDTIMEO on the connected socket
- Do a sendfile() from a big file down the connected socket. Make sure the
size is big (e.g. 1Mb) so the call blocks.
--> BUG!! The call blocks indefinitely rather than being interrupted after
5 seconds.

Cheers
Chris

On Sat, 17 Feb 2001 kuznet@ms2.inr.ac.ru wrote:

> Hello!
>
> > Unfortunately, it seems to be very buggy. Here are two buggy scenarios.
>
>
> --- ../vger3-010210/linux/net/ipv4/tcp.c	Sat Feb 10 23:16:51 2001
> +++ linux/net/ipv4/tcp.c	Sat Feb 17 23:27:43 2001
> @@ -691,6 +691,8 @@
>
>  		set_current_state(TASK_INTERRUPTIBLE);
>
> +		if (!timeo)
> +			break;
>  		if (signal_pending(current))
>  			break;
>  		if (tcp_memory_free(sk) && !vm_wait)
> --- ../vger3-010210/linux/net/core/sock.c	Tue Jan 30 21:20:16 2001
> +++ linux/net/core/sock.c	Sat Feb 17 23:27:44 2001
> @@ -727,6 +727,8 @@
>  	clear_bit(SOCK_ASYNC_NOSPACE, &sk->socket->flags);
>  	add_wait_queue(sk->sleep, &wait);
>  	for (;;) {
> +		if (!timeo)
> +			break;
>  		if (signal_pending(current))
>  			break;
>  		set_bit(SOCK_NOSPACE, &sk->socket->flags);
>


