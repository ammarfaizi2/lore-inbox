Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266435AbTBLEPF>; Tue, 11 Feb 2003 23:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266645AbTBLEPF>; Tue, 11 Feb 2003 23:15:05 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:17169 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266435AbTBLEPD>; Tue, 11 Feb 2003 23:15:03 -0500
Date: Tue, 11 Feb 2003 20:21:02 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Roland McGrath <roland@redhat.com>
cc: Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: another subtle signals issue
In-Reply-To: <200302120350.h1C3ofQ19892@magilla.sf.frob.com>
Message-ID: <Pine.LNX.4.44.0302111955460.3490-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 11 Feb 2003, Roland McGrath wrote:
> 
> I'm not talking about reading from pipes, that was your example.

The reason I harp on pipes is that I remember something like that breaking 
real programs in the past, which is a lot more important.

(Thinking about it, it can't have been pipe reading, it must have been
writing. Reading a pipe always returns partial results early if it is
successful.  Writing doesn't. Trivial test-case appended, see what happens
when you ^Z it.  And realize that more programs care about this than about
timed semaphore operations).

>								  I was
> talking about calls with timeouts, like semop, whose interface do not
> permit partial results.

And I have multiple times said that as far as Linux is concerned, ^Z is, 
has always been, and certainly for the 2.6.x timeframe _will_ be a signal 
that the kernel considers "caught".

Another way of saying it: just leave the system calls alone. If they
aren't restartable, they have to return -EINTR. And if you think that
disagrees with POSIX, and if RH really wants certification, then you
should advice RH to document the difference as just that - a difference.  
And push it through as such.

Anyway, try out the following test-program in an xterm. Resize the xterm 
and see what happens. Press ^Z and see what happens. I'm saying that the 
^Z behaviour is something Linux always has done (and as such not something 
you should worry about overmuch), while the SIGWINCH behaviour is new with 
the new signal handling code and _is_ worrysome, since that can break old 
programs (but I think your patch fixes it, so I'm not worried).

To recap:
 - common functions are a lot more important than uncommon ones (which is 
   why the pipe thing is interesting)
 - old behaviour is a lot more important than POSIX (existing binaries 
   have all been tested with old behaviour).

Considering that the SIGCHLD:SIG_IGN change to child reaping apparently 
broke at least one existing program, I hope you can see my point. At some 
point it just doesn't _matter_ what POSIX says. 

		Linus

---
#include <signal.h>
#include <stdio.h>

#define SIZE 131072

int main(void)
{
	char buffer[SIZE];
	int fd[2];

	pipe(fd);
	write(fd[1], buffer, SIZE);
}

