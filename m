Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263850AbRFDUx4>; Mon, 4 Jun 2001 16:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263852AbRFDUxq>; Mon, 4 Jun 2001 16:53:46 -0400
Received: from cuda.sx.nec.com ([207.253.213.164]:16903 "HELO cuda.sx.nec.com")
	by vger.kernel.org with SMTP id <S263850AbRFDUxb>;
	Mon, 4 Jun 2001 16:53:31 -0400
Message-ID: <3B1BF2FA.B74A1B78@ludusdesign.com>
Date: Mon, 04 Jun 2001 16:43:38 -0400
From: Pierre Phaneuf <pp@ludusdesign.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: disk-based fds in select/poll
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Pardon me if some parts of this seem clueless. While I'm no newbie in
userland, kernelspace I don't play in very often...

It's fairly widely-known that select/poll returns immediately when
testing a filesystem-based file descriptor for writability or
readability.

On top of this, even when in non-blocking mode, read() could block if
the pages needed aren't in core. sendfile() behaves in a similar way.

What would be needed to alleviate this?

I am thinking that a read() (or sendfile()) that would block because the
pages aren't in core should instead post a request for the pages to be
loaded (some kind of readahead mecanism?) and return immediately (maybe
having given some data that *was* in core). A subsequent read() could
have the data available, but not necessarily (again, it should give
whatever it has in core, but return immediately).

sendfile() would be a lot more tricky to fix in that way I guess, but
could still be possible (the destination fd would be unwritable for a
while, until the transfer is finished). Also, the complexity would be
higher (instead of simply causing readahead to happen (which might
anyway), it would have to trigger the readahead, then get notification
of when the pages are in core to send over, all the while preventing
data from being written to the destination fd in some way).

In the mean time, I was also wondering if issuing smaller read()
requests in a row might give me a better chance of success. I *know*
read() will block, but if I only ask for, say, a page of data (rather
than asking for the full data and relying on the non-blocking to return
EAGAIN (like it should, IMHO!)), it shouldn't take too long, and could
possibly trigger some readahead to be done by the kernel, right?

Or will the readahead be done "on my own time", read() only returning
after the whole thing (my request + readahead) has been done?

I remember seeing a suggestion by Linus for an event-based I/O
interface, similar to kqueue on FreeBSD but much simpler. I'd just say
"I want it too!", ok? :-)

I know about the mincore() trick with mmap()'d files, but with small
files, mmap()ing might not make sense (could be very often).

SGI's AIO might be a solution here, does it use threads? I'm trying to
avoid context switching as much as possible, to keep the CPU cache as
warm as possible.

Well, I might not have the choice to use threads, after all...

(sorry if this message got in twice, I used an NNTP gateway the previous
time, I don't think it got through)

-- 
Pierre Phaneuf
