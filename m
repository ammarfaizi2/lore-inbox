Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267298AbUJISxv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267298AbUJISxv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 14:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267301AbUJISxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 14:53:51 -0400
Received: from findaloan.ca ([66.11.177.6]:50601 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id S267298AbUJISxq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 14:53:46 -0400
Date: Sat, 9 Oct 2004 14:49:22 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: David Schwartz <davids@webmaster.com>
Cc: martijn@entmoot.nl, linux-kernel@vger.kernel.org
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Message-ID: <20041009184922.GA8032@mark.mielke.cc>
Mail-Followup-To: David Schwartz <davids@webmaster.com>,
	martijn@entmoot.nl, linux-kernel@vger.kernel.org
References: <000801c4ae35$3520ac90$161b14ac@boromir> <MDEHLPKNGKAHNMBLJOLKEEAPOOAA.davids@webmaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKEEAPOOAA.davids@webmaster.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 09, 2004 at 11:28:28AM -0700, David Schwartz wrote:
> > > Where, specifically, does the standard guarantee that a
> > > subsequent call to
> > > 'recvmsg' will not block?
> > When using select() on a socket for reading, select will block until
> > that socket is ready.
> > According to POSIX:
> >   A descriptor shall be considered ready for reading when a call to an
> >   input function with O_NONBLOCK clear would not block, whether or not
> >   the function would transfer data successfully.
> Note that it says *would* not block, not *will* not block. The definition
> of the word "would" is "an expression of probability or likelihood" (or a
> "presumption or expectation"). This is *not* a guarantee.

Are you sure you aren't confusing 'would' with 'should'?

Would and will are the same, except in terms of time.

This is ridiculous. Everybody in this discussion *knows* that the
existing behaviour is broken. As another poster appeared to show, can
be proven to be usable as a denial of service attack against any
application that doesn't use O_NONBLOCK for UDP packets under Linux.

Please - people who don't agree, just ensure that Linux is documented
to not implement select() on sockets without O_NONBLOCK properly. No
more silly excuses. 'Would' vs 'will' meaning 'probably'... sheesh...

> >   If a descriptor refers to a socket, the implied input function is the
> >   recvmsg() function with parameters requesting normal and ancillary data,
> >   such that the presence of either type shall cause the socket to
> >   be marked
> >   as readable. The presence of out-of-band data shall be checked if the
> >   socket option SO_OOBINLINE has been enabled, as out-of-band data is
> >   enqueued with normal data. If the socket is currently listening, then it
> >   shall be marked as readable if an incoming connection request has been
> >   received, and a call to the accept() function shall complete without
> >   blocking.
> > Thus recvmsg() shouldn't in any case block after a select() on a socket.
> I don't draw that conclusion from that paragraph. It does say the presence
> of normal data shall mark the socket readable, but it doesn't require the
> kernel to keep that data available, at least not as far as I can see.

The data was *never* available. select() lied.

> 	As far as I can tell, neither of these two excerpts prohibit an
> implementation from, for example, discarding UDP data (say, to save memory)
> after it triggered a read hit on a 'select' call.

Your reading let's you have a broken system call interface, and declare that
it is acceptable. Why? What is the purpose of this position? Who does it
benefit?

> Yes, the 'recvmsg' call
> would not have blocked, had it been made at the time the data was available.

Wrong. The data was never available. If the select() was replaced by
recvmsg() it most certainly *would* have blocked. Therefore, select()
should not have said 'data is ready'.

If this understanding isn't clear, I begin to seriously worry about
the competency of a few people...

It's ok to say "we chose to leave it broken because we feel O_NONBLOCK
should be mandatory". Nobody with any sort of authority seems to want
to say this. They would prefer to talk about "POSIX compliancy" as if
the issue was theoretical and irrelevant.

It is disconcerting, to say the least.

Cheers,
mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

