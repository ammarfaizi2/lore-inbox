Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129591AbQLKFdI>; Mon, 11 Dec 2000 00:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129983AbQLKFc7>; Mon, 11 Dec 2000 00:32:59 -0500
Received: from [212.17.18.2] ([212.17.18.2]:58384 "EHLO technoart.net")
	by vger.kernel.org with ESMTP id <S129591AbQLKFcn>;
	Mon, 11 Dec 2000 00:32:43 -0500
Content-Type: text/plain; charset=US-ASCII
From: Denis Perchine <dyp@perchine.com>
To: linux-kernel@vger.kernel.org
Subject: Bad behavior of recv on already closed sockets.
Date: Mon, 11 Dec 2000 11:03:06 +0600
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <0012111103060F.18833@dyp.perchine.com>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

there was a small thread in PostgreSQL list about behavior of recv syscall on 
Linux 2.2.16. Does anyone have similar expirience? Why such things can 
happend? And how to workaround/fix this?

----------  Forwarded Message  ----------
Subject: [HACKERS] Strange behavior of PostgreSQL on Linux
Date: Sun, 10 Dec 2000 12:51:46 +0600
From: Denis Perchine <dyp@perchine.com>
To: pgsql-hackers@postgresql.org


Hello,

I have quite strange problem. It's lsof -i -n -P
postmaste 20018      postgres    6u  IPv4 12241380       TCP
127.0.0.1:5432->127.0.0.1:6651 (CLOSE)

And there is no pair for it.

Backtrace of the backend shows:
(gdb) bt
#0  0x40198ba2 in recv () from /lib/libc.so.6
#1  0x80ab2c5 in pq_recvbuf ()
#2  0x80ab395 in pq_getbytes ()
#3  0x80eaa7c in SocketBackend ()
#4  0x80eab13 in ReadCommand ()
#5  0x80ebb9c in PostgresMain ()
#6  0x80d69a2 in DoBackend ()
#7  0x80d6581 in BackendStartup ()
#8  0x80d593a in ServerLoop ()
#9  0x80d53c4 in PostmasterMain ()
#10 0x80abbb6 in main ()
#11 0x400fe9cb in __libc_start_main () at ../sysdeps/generic/libc-start.c:122

[root@mx /root]# ps axwfl|grep 20018
040   507 20018 21602   0   0 15292    0 tcp_re SW   pts/0      0:00  \_
[postmaster]

[root@mx /root]# uname -a
Linux mx.xxx.com 2.2.16-3 #1 Mon Jun 19 19:11:44 EDT 2000 i686 unknown

Looks like it tries to read on socket which is already closed from other
side. And it seems like recv did not return in this case. Is this OK, or
kernel bug?

On the other side I see entries like this:
httpd      4260          root    4u  IPv4 12173018       TCP
127.0.0.1:3994->127.0.0.1:5432 (CLOSE_WAIT)

And again. There is no any corresponding postmaster process. Does anyone has
such expirience before? And what can be the reason of such strange things.

--
Sincerely Yours,
Denis Perchine

----------------------------------
E-Mail: dyp@perchine.com
HomePage: http://www.perchine.com/dyp/
FidoNet: 2:5000/120.5
----------------------------------

-------------------------------------------------------


----------  Forwarded Message  ----------
Subject: Re: [HACKERS] Strange behavior of PostgreSQL on Linux
Date: Sun, 10 Dec 2000 13:18:17 -0500
From: Tom Lane <tgl@sss.pgh.pa.us>
To: Denis Perchine <dyp@perchine.com>


Denis Perchine <dyp@perchine.com> writes:
> Looks like it tries to read on socket which is already closed from other
> side. And it seems like recv did not return in this case. Is this OK, or
> kernel bug?

Sounds like a kernel bug --- recv() should *always* return immediately
if the socket is known closed.  I'd think the kernel didn't believe the
socket was closed, if not for your lsof evidence.  That's certainly
pointing a finger at the kernel...

We've heard (undetailed) reports before of backends hanging around when
the client was long gone.  I always assumed that the client machine had
failed to disconnect properly, but now I wonder.  A kernel bug might
explain those reports.

			regards, tom lane

-------------------------------------------------------

-- 
Sincerely Yours,
Denis Perchine

----------------------------------
E-Mail: dyp@perchine.com
HomePage: http://www.perchine.com/dyp/
FidoNet: 2:5000/120.5
----------------------------------
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
