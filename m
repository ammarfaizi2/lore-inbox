Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129034AbQKCFAs>; Fri, 3 Nov 2000 00:00:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129080AbQKCFA3>; Fri, 3 Nov 2000 00:00:29 -0500
Received: from smtp02.mrf.mail.rcn.net ([207.172.4.61]:48026 "EHLO
	smtp02.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S129034AbQKCFAT>; Fri, 3 Nov 2000 00:00:19 -0500
Message-ID: <3A024665.32AFD93@iname.com>
Date: Fri, 03 Nov 2000 00:00:21 -0500
From: Paul Marquis <pmarquis@iname.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: select() bug
In-Reply-To: <Pine.LNX.3.95.1001102195118.19271A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It shows that even though select() says a file descriptor is not
writable, a write() can still succeed.  This code is not used anywhere
in the real world, or at least my real world :-P.  It just demonstrates
"the bug".

Richard B. Johnson" wrote:
> Not as I see it. This is clearly a code bug. Look:
> iteration 1
> select says pipe is writable
> write succeeded - 1 bytes written
> iteration 2
> select returned 0 -- pipe not writable
> 
>       for (i = 0; i < 4; i++)
>       {
>          printf("iteration %d\n", i + 1);
> 
>          status = 0;
> 
>          /* do select */
>          FD_ZERO(&write_fds);
>          FD_SET(fd[1], &write_fds);
>          tv.tv_sec = 0;
>          tv.tv_usec = 0;
>          switch (select(fd[1] + 1, NULL, &write_fds, NULL, &tv))
>          {
>             case -1:
>                /* should probably check for EINTR and/or EWOULDBLOCK */
>                printf("select error - %s\n", strerror(errno));
>                break;
>             case 0:
>                /* no I/O */
>                puts("select returned 0 -- pipe not writable");
>                break;
> 
>             The BREAK breaks out of the switch-statement ---
>                                                            |
> |-----------------------------------------------------------
> |
> |            default:
> |               /* make sure our fd is writable */
> |               if (FD_ISSET(fd[1], &write_fds))
> |               {
> |                  puts("select says pipe is writable");
> |                  status = 1;
> |               }
> |               else
> |                  puts("select says pipe is not writable");
> |               break;
> |         }
> |
> |         /* do write */
> |------->  n = write(fd[1], buf + (i % 2), 1);
> 
> Then you write it anyway!
> 
> write succeeded - 1 bytes written
> select bug
> 
> Cheers,
> Dick Johnson
> 
> Penguin : Linux version 2.2.17 on an i686 machine (801.18 BogoMips).
> 
> "Memory is like gasoline. You use it up when you are running. Of
> course you get it all back when you reboot..."; Actual explanation
> obtained from the Micro$oft help desk.

--
Paul Marquis
pmarquis@iname.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
