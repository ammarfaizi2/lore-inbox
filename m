Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269217AbUJQR1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269217AbUJQR1Y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 13:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269218AbUJQR1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 13:27:23 -0400
Received: from mail.dif.dk ([193.138.115.101]:5331 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S269217AbUJQR1L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 13:27:11 -0400
Date: Sun, 17 Oct 2004 19:35:03 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Buddy Lucas <buddy.lucas@gmail.com>
Cc: Lars Marowsky-Bree <lmb@suse.de>, David Schwartz <davids@webmaster.com>,
       "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
In-Reply-To: <5d6b65750410170840c80c314@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0410171921440.2952@dragon.hygekrogen.localhost>
References: <20041016062512.GA17971@mark.mielke.cc> 
 <MDEHLPKNGKAHNMBLJOLKMEONPAAA.davids@webmaster.com>  <20041017133537.GL7468@marowsky-bree.de>
  <5d6b657504101707175aab0fcb@mail.gmail.com>  <20041017150509.GC10280@mark.mielke.cc>
 <5d6b65750410170840c80c314@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Oct 2004, Buddy Lucas wrote:

> On Sun, 17 Oct 2004 11:05:09 -0400, Mark Mielke <mark@mark.mielke.cc> wrote:
> > On Sun, Oct 17, 2004 at 04:17:06PM +0200, Buddy Lucas wrote:
> > > On Sun, 17 Oct 2004 15:35:37 +0200, Lars Marowsky-Bree <lmb@suse.de> wrote:
> > > > The SuV spec is actually quite detailed about the options here:
> > > >         A descriptor shall be considered ready for reading when a call
> > > >         to an input function with O_NONBLOCK clear would not block,
> > > >         whether or not the function would transfer data successfully.
> > > >         (The function might return data, an end-of-file indication, or
> > > >         an error other than one indicating that it is blocked, and in
> > > >         each of these cases the descriptor shall be considered ready for
> > > >         reading.)
> > > But it says nowhere that the select()/recvmsg() operation is atomic, right?
> > 
> > This is a distraction. If the call to select() had been substituted
> > with a call to recvmsg(), it would have blocked. Instead, select() is
> > returning 'yes, you can read', and then recvmsg() is blocking. The
> > select() lied. The information is all sitting in the kernel packet
> 
> No. A million things might happen between select() and recvmsg(), both
> in kernel and application. For a consistent behaviour throughout all
> possibilities, you *have* to assume that any read on a blocking fd may
> block, and that a fd ready for reading at select() time might not be
> readable once the app gets to recvmsg() -- for whatever reason.
> 
> And indeed, that implies that select() on blocking fds is generally
> not useful if you expect to bypass the blocking through select().
> Personally,  I think any application that implements this expectation
> is broken. (If only because you might have to do a second read() or
> recvmsg() which will either result in a crappy select() loop or a
> broken read()/recvmsg() loop).
> 
Personally I agree that if you want non blocking sockets that's what you 
should use, but many people expect that if select says a socket is 
readable then attempting to recieve that data will not block. Many people 
refer to Stevens "UNIX Network Programming" to find out how select and 
related networking functions are supposed to behave, and Stevens has this 
to say on page 153 under the heading "Under What Conditions Is a 
Descriptor Ready?" [1] : 

[...]
1. A socket is ready for reading if any of the following four conditions 
is true:

   a. The number of bytes of data in the socker recieve buffer is greater 
      than or equal to the current size of the low-water mark for the 
      socket recieve buffer. A read operation on the socket will not block 
      and will return a value greater than 0 ...

[...]

He's not saying this is specific to either UDP or TCP sockets nor blocking 
or non-blocking sockets, so I suspect that regardless of what POSIX might 
say a lot of people will be reading the above and assume that if select 
says a socket (any type of socket) is ready for reading, then attempting 
to read will not block. 
Using blocking sockets with select in this manner may be silly or 
inefficient, but I think many people expect it to work without the 
subsequent read blocking in any case.


[1] I'm only quoting what I think is relevant to the thread, but I can 
quote the rest if wanted. My copy of the book has ISBN 0-13-490012-X in 
case someone wants to check.


--
Jesper Juhl


