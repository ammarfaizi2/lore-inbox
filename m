Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbTFJNgq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 09:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbTFJNgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 09:36:46 -0400
Received: from chaos.analogic.com ([204.178.40.224]:60544 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261785AbTFJNgo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 09:36:44 -0400
Date: Tue, 10 Jun 2003 09:52:17 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Timothy Miller <miller@techsource.com>
cc: Krzysztof Halasa <khc@pm.waw.pl>, David Schwartz <davids@webmaster.com>,
       linux-kernel@vger.kernel.org
Subject: Re: select for UNIX sockets?
In-Reply-To: <3EE5DE7E.4090800@techsource.com>
Message-ID: <Pine.LNX.4.53.0306100937360.4080@chaos>
References: <MDEHLPKNGKAHNMBLJOLKOEKFDIAA.davids@webmaster.com>
 <m3isredh4e.fsf@defiant.pm.waw.pl> <3EE5DE7E.4090800@techsource.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jun 2003, Timothy Miller wrote:

>
>
> Krzysztof Halasa wrote:
> > "David Schwartz" <davids@webmaster.com> writes:
>
> >>	The kernel does not remember that you got a write hit on 'select'
> >>and use
> >>it to somehow ensure that your next 'write' doesn't block. A 'write' hit
> >>from 'select' is just a hint and not an absolute guarantee that whatever
> >>'write' operation you happen to choose to do won't block.
> >
> >
> > A "write" hit from select() is not a hit - it's exactly nothing and this
> > is the problem.
> > Have you at least looked at the actual code? unix_dgram_sendmsg() and
> > datagram_poll()?
>
>
> I think the issue here is not what it means when select() returns but
> what it means when it DOESN'T return (well, blocks).
>
> In my understanding, one of select()'s purposes is to keep processes
> from having to busy-wait, burning CPU for nothing.  Your guarantee with
> select() is that if it blocks, then the write target(s) definately
> cannot accept data.  The inverse is not true, although the inverse is
> very likely:  if select() does not block, then it's extremely likely
> that the target can accept SOME data.  But it it certainly can't accept
> ALL data you want to give it if you want to give it a lot of data.
>
> If you were to use blocking writes, and you sent too much data, then you
> would block.  If you were to use non-blocking writes, then the socket
> would take as much data as it could, then return from write() with an
> indication of how much data actually got sent.  Then you call select()
> again so as to wait for your next opportunity to send some more of your
> data.
>
> It may be that some operating systems have large or expandable queues
> for UNIX sockets.  As a result, you have been able to send a lot of data
> with a blocking write without it blocking.  I can see how it would be an
> advantage to function that way, up to a certain point, after which you
> start eating too much memory for your queue.  However, what you have
> experienced is not universally guaranteed behavior.  What Linux does is
> canonically correct; it's just a variant that you're not used to.  If
> you were to change your approach to fit the standard, then you would get
> more consistent behavior across multiple platforms.
>
> Up to this point, I believe you have been riding on luck, not guaranteed
> behavior.
>

The behavior of select and poll for read and write must be somewhat
different when it comes to blocking. This is because of the difference
between read() and write().

If I attempt to read() N bytes and there is only one byte available,
read() will immediately return with the one byte. Its return value
will show one byte was received even though the caller "requested"
N bytes. This is the expected behavior. Therefore when select() shows
that data are available, there may be only one byte available.

On a write(), the caller expects that all the bytes being written
will, in fact occur eventually occur. However select() doesn't
know how many bytes the caller expects to write. It only knows that
the caller can write some. This "some" in principle, may be only
one byte. The user of select and write needs to be prepared to
make multiple calls to complete the writing of large buffers.

To do this, one can set the write() file-descriptor to non-blocking
and simply make repeated write() calls, checking the return value
(and errno) each time. However, this wastes CPU cycles. Instead
of this, the caller can still keep a non-blocking file-descriptor,
but sleep in select() or poll() until the kernel has space for
more bytes. The kernel can never guarantee, nor is there a way to
show, space for N bytes. The caller just has to walk up the buffer
and make as many calls as necessary.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

