Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133023AbRDUXOr>; Sat, 21 Apr 2001 19:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133025AbRDUXOi>; Sat, 21 Apr 2001 19:14:38 -0400
Received: from pop.gmx.net ([194.221.183.20]:46380 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S133023AbRDUXO0>;
	Sat, 21 Apr 2001 19:14:26 -0400
Message-ID: <3AE10741.FA4E40BD@gmx.de>
Date: Sat, 21 Apr 2001 06:06:25 +0200
From: Edgar Toernig <froese@gmx.de>
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: fd allocation [was: light weight user level semaphores]
In-Reply-To: <E14qHRp-0007Yc-00@the-village.bc.nu> <Pine.LNX.4.31.0104190944090.4074-100000@penguin.transmeta.com> <E14qXEU-0005xo-00@g212.hadiko.de> <9bqgvi$63q$1@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
>         pid = fork();
>         if (!pid) {
>                 close(0);
>                 close(1);
>                 dup(pipe[0]);   /* input pipe */
>                 dup(pipe[1]);   /* output pipe */
>                 execve("child");
>                 exit(1);
>         }
> 
> The above is absolutely _standard_ behaviour. It's required to work.
> 
> And btw, it's _still_ required to work even if there happens to be a
> "malloc()" in between the close() and the dup() calls.

Right.  This is expected (and defined) behaviour.  But do you have
_any_ example where this is used for fds > 2?  I can't remember.
And IMHO that would be pretty fragile too.  Shell scripts sometimes
open temporary fds > 2 and these are passed to called programs.  I.e.

#!/bin/sh
exec 3>log
echo >&3 "script started"
ls /proc/self/fd              # gets fd3 already opened
ls /proc/self/fd 4</dev/null  # now 3 and 4 already in use...
# or look into any configure script...

So, IMHO as long as some library does not mess with fds 0, 1, and 2
it should be ok [1].  Yes, it would be against the standard but I
still have to find some code where this semantic is used for fds > 2.

Ciao, ET.


PS: I would prefer to keep the standard semantics but the reasons
for that are pretty weak ... ;-)

PPS: Even your sample code is fragile.  It breaks if I start it
with  ./a.out <&-  ;-)  (the close(0) is likely to close one end
of the pipe)

[1] Unintentionally setting the controlling tty may be a problem.

