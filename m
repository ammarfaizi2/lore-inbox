Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132932AbQLHVbE>; Fri, 8 Dec 2000 16:31:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132931AbQLHVay>; Fri, 8 Dec 2000 16:30:54 -0500
Received: from hermes.mixx.net ([212.84.196.2]:22285 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S132604AbQLHVar>;
	Fri, 8 Dec 2000 16:30:47 -0500
From: Daniel Phillips <phillips@innominate.de>
To: Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>
Subject: Re: [PATCH] Re: kernel BUG at buffer.c:827 in test12-pre6 and 7
Date: Fri, 8 Dec 2000 20:50:41 +0100
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
Cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10012081125580.11302-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.10.10012081125580.11302-100000@penguin.transmeta.com>
MIME-Version: 1.0
Message-Id: <00120821583804.00491@gimli>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Dec 2000, Linus Torvalds wrote:
> Btw, I also think that the dirty buffer flushing should get the page lock.
> Right now it touches the buffer list without holding the lock on the page
> that the buffer is on, which means that there is really nothign that
> prevents it from racing with the page-based writeout. I don't like that:
> it does hold the LRU list lock, so the list state itself is ok, but it
> does actually touch part of the buffer state that is not really protected
> by the lock.
> 
> I think it ends up being ok because ll_rw_block will ignore buffers that
> get output twice, and the rest of the state is handled with atomic
> operations (b_count and b_flags), but it's not really proper. If
> flush_dirty_buffers() got the page lock, everything would be protected
> properly. Thoughts?

This is great when you have buffersize==pagesize.  When there are
multiple buffers per page it means that some of the buffers might have
to wait for flushing just because bdflush started IO on some other
buffer on the same page.  Oh well.  The common case improves in terms
being proveably correct and the uncommon case gets worse a tiny bit. 
It sounds like a win.

We are moving steadily away from buffer oriented I/O anyway, and I
think we can optimize the case of buffersize!=pagesize in 2.5 by being a
little more careful about how getblk hands out buffers.  Getblk
could force all buffers on the same page to be on the same
major/minor, or even better, to be physically close together.  Or
more simply, flush_dirty_buffers could check for other dirty buffers on
the same page and initiate I/O at the same time.  Or both strategies.

This is by way of buttressing an argument in favor of simplicity
and reliabilty, i.e., being religious about taking the page lock, even
when there's a slight cost in the short term.

-- 
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
