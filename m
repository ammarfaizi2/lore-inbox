Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129030AbQJ3HDr>; Mon, 30 Oct 2000 02:03:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129045AbQJ3HDj>; Mon, 30 Oct 2000 02:03:39 -0500
Received: from chiara.elte.hu ([157.181.150.200]:36102 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S129030AbQJ3HDP>;
	Mon, 30 Oct 2000 02:03:15 -0500
Date: Mon, 30 Oct 2000 09:13:02 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: mingo@elte.hu
To: Rik van Riel <riel@conectiva.com.br>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
        netdev <netdev@oss.sgi.com>
Subject: Re: tcp.c::wait_for_tcp_memory() buggy ?
In-Reply-To: <Pine.LNX.4.21.0010290122050.4224-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0010300905320.1270-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 29 Oct 2000, Rik van Riel wrote:

> I can't quite put my finger on what wait_for_tcp_memory() is supposed
> to do, [...]

it's waiting for TCP output packets to be processed. This is a TCP
protocol detail and is not connected to VM issues. The function name might
be a bit misleading, it could be 'tcp_write_possible()', or
'tcp_wmem_free()'.

> [...] but the code looks EXTREMELY suspect and I've had a report of
> somebody looping in the for(;;) loop in that function without ever
> exiting and getting his TCP connection stuck there...

as far as i understand, this can happen if another host (for whatever
reason) does not process the TCP output packets this host has sent.

> Also, the locking inside the loop seems fragile, to say the
> least.
> 
> from tcp.c:
> 
>   865         if (tcp_memory_free(sk) && !vm_wait)
>   866                 break;
> 
>   880         release_sock(sk);
>   881         if (!tcp_memory_free(sk) || vm_wait)
>   882                 current_timeo = schedule_timeout(current_timeo);
>   883         lock_sock(sk);
> 
> Here we hold the lock for the entire loop (meaning that
> other people cannot make the exit condition on line 865
> come true.

we do not keep the lock for the entire loop, we schedule away on line 882
with the socket lock dropped. This is a pretty standard (and safe) locking
technique.

> Except for doing a test on tcp_memory_free(sk), where we
> do NOT hold the lock we're so dutifully clinging to during
> the rest of the loop...

well, thats the point of the socket lock - we can access socket data
structures almost only via the socket lock.

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
