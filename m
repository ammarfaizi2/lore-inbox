Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129706AbQKCBOD>; Thu, 2 Nov 2000 20:14:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130020AbQKCBNx>; Thu, 2 Nov 2000 20:13:53 -0500
Received: from chaos.analogic.com ([204.178.40.224]:13061 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129706AbQKCBNp>; Thu, 2 Nov 2000 20:13:45 -0500
Date: Thu, 2 Nov 2000 19:53:04 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Paul Marquis <pmarquis@iname.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: select() bug
In-Reply-To: <3A01F191.10652E1F@iname.com>
Message-ID: <Pine.LNX.3.95.1001102195118.19271A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Nov 2000, Paul Marquis wrote:

> In the code sample, there is a loop that is run four times.  During
> each iteration, a call to select() and write() is done, while every
> other iteration does a read().  Between the 1st and 2nd calls to
> write(), as well as the 3rd and 4th, select() fails, but all write()'s
> and read()'s succeed.  There is no code bug.

Not as I see it. This is clearly a code bug. Look:
iteration 1
select says pipe is writable
write succeeded - 1 bytes written
iteration 2
select returned 0 -- pipe not writable

      for (i = 0; i < 4; i++)
      {
         printf("iteration %d\n", i + 1);

         status = 0;

         /* do select */
         FD_ZERO(&write_fds);
         FD_SET(fd[1], &write_fds);
         tv.tv_sec = 0;
         tv.tv_usec = 0;
         switch (select(fd[1] + 1, NULL, &write_fds, NULL, &tv))
         {
            case -1:
               /* should probably check for EINTR and/or EWOULDBLOCK */
               printf("select error - %s\n", strerror(errno));
               break;
            case 0:
               /* no I/O */
               puts("select returned 0 -- pipe not writable");
               break;

            The BREAK breaks out of the switch-statement ---
                                                           |
|-----------------------------------------------------------
|
|            default:
|               /* make sure our fd is writable */
|               if (FD_ISSET(fd[1], &write_fds))
|               {
|                  puts("select says pipe is writable");
|                  status = 1;
|               }
|               else
|                  puts("select says pipe is not writable");
|               break;
|         }
|
|         /* do write */
|------->  n = write(fd[1], buf + (i % 2), 1);

Then you write it anyway!

write succeeded - 1 bytes written
select bug




Cheers,
Dick Johnson

Penguin : Linux version 2.2.17 on an i686 machine (801.18 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
