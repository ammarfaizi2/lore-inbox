Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129030AbQKEQPy>; Sun, 5 Nov 2000 11:15:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129048AbQKEQPp>; Sun, 5 Nov 2000 11:15:45 -0500
Received: from Badial68.eurotel.sk ([194.154.226.131]:13318 "EHLO
	trillian.eunet.sk") by vger.kernel.org with ESMTP
	id <S129030AbQKEQPf>; Sun, 5 Nov 2000 11:15:35 -0500
Date: Sun, 5 Nov 2000 17:14:10 +0100
From: Stanislav Meduna <stano@trillian.eunet.sk>
To: linux-kernel@vger.kernel.org
Cc: pcg@goof.com, alan@lxorguk.ukuu.org.uk
Subject: Re: select() bug
Message-ID: <20001105171410.A2707@trillian.eunet.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > - If I'm correct that pipes have a 4K kernel buffer, then writing 1 
> > > byte shouldn't cause this situation, as the buffer is well more than 
> > > half empty. Is this still a bug? 
> > 
> > The pipe code uses totally full/empty. Im not sure why that was chosen 
> 
> Just a quick guess: maybe because of the POSIX atomicity guarantees (if 
> select returned, write might have to block which is not what is expected), 
> and maybe this limitation was used not only on write but on read (Although 
> it's not necessary on the read side, AFAIK). 

FWIW: I tried to do some experiments (I was hit by the context
switch 'explosion': the writer writes one byte and then
cannot write another one until the reader wakes up and reads
the single one - for my application this was very bad).

Unfortunately my experiments made the most-used uses slower
and I don't know the kernel internals enough to analyse it :-(

I am repeating here my post from 14. 7. (this was with -test4,
I don't know whether there were any significant changes since then)
under the subject "pipe concurrent r/w performance". Last time
I did not get any replies.

- snip -

I am (again) playing with pipe.c trying to enlarge the
pipe buffer, so the pipe can select for write even when
non-empty (but with more than PIPE_BUF free), aiming
for reducing context switches when two applications
signal something via a pipe without waiting for
an answer. The functionality is (hopefully) OK and
I am testing the performance.

I have written two similar test programs. The
writer side selects the pipe and then writes a byte.
The reader side does either 1) blocking read of one
byte, or 2) selects the pipe for reading and then
reads a byte.

To my surprise the case 1) is slower than the original
version by 20% and there is actually more context switches.
Case 2) is at least 30% faster than the original version
and the number of context switches is dramatically reduced.

The difference probably is, that the reader is faster
than the writer and in the case 1) it nearly always
blocks in the pipe_wait call inside pipe_read.
It seems like as soon as the writer writes something
in the pipe, the reader immediately gets the CPU
instead of allowing the writer to continue.

In the case 2) it blocks in poll_wait inside pipe_poll.

I don't quite understand all the semantics behind
synchronisation primitives, but it seems like the
current code is not optimal for the concurrent
presence of reader and writer in pipe_read/pipe_write.
The code in pipe_poll excluded such possibility.
Could someone understanding these things better
take a look?

My patch and the test programs are available at
http://www.penguin.cz/~stano/code/kernelpipe.tar.gz
The patch is against 2.4.0-test4, my machine is
a SMP one (maybe the situation differs on UP).

- snip -

Regards
-- 
				Stano



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
