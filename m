Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269106AbUJQRfP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269106AbUJQRfP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 13:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269221AbUJQRfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 13:35:14 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:63297 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269106AbUJQRdQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 13:33:16 -0400
DomainKey-Signature: a=rsa-sha1; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=M2AMcPktx0sTELGrq0akje7mJziB6Q4Y15rH6oS3zkANzeeONIsL2BrvQzJgLn6DwvPUhaSKApxn/k3T+ALrfRo2y+JGOjfzwznsG6CxIbtD90Ta8awb5nNsCYdToAz4PmVl46qmKEYbwomhkAFbEjLu4j6gRfvNLqQZDKL5bx4
Message-ID: <5d6b65750410171033d9d83ab@mail.gmail.com>
Date: Sun, 17 Oct 2004 19:33:15 +0200
From: Buddy Lucas <buddy.lucas@gmail.com>
Reply-To: Buddy Lucas <buddy.lucas@gmail.com>
To: Martijn Sipkema <martijn@entmoot.nl>
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Cc: Lars Marowsky-Bree <lmb@suse.de>, David Schwartz <davids@webmaster.com>,
       "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
In-Reply-To: <000801c4b46f$b62034b0$161b14ac@boromir>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041016062512.GA17971@mark.mielke.cc>
	 <MDEHLPKNGKAHNMBLJOLKMEONPAAA.davids@webmaster.com>
	 <20041017133537.GL7468@marowsky-bree.de>
	 <5d6b657504101707175aab0fcb@mail.gmail.com>
	 <20041017150509.GC10280@mark.mielke.cc>
	 <5d6b65750410170840c80c314@mail.gmail.com>
	 <000801c4b46f$b62034b0$161b14ac@boromir>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Oct 2004 18:35:34 +0100, Martijn Sipkema <martijn@entmoot.nl> wrote:
> From: "Buddy Lucas" <buddy.lucas@gmail.com>
> > On Sun, 17 Oct 2004 11:05:09 -0400, Mark Mielke <mark@mark.mielke.cc> wrote:
> > > On Sun, Oct 17, 2004 at 04:17:06PM +0200, Buddy Lucas wrote:
> > > > On Sun, 17 Oct 2004 15:35:37 +0200, Lars Marowsky-Bree <lmb@suse.de> wrote:
> > > > > The SuV spec is actually quite detailed about the options here:
> > > > >         A descriptor shall be considered ready for reading when a call
> > > > >         to an input function with O_NONBLOCK clear would not block,
> > > > >         whether or not the function would transfer data successfully.
> > > > >         (The function might return data, an end-of-file indication, or
> > > > >         an error other than one indicating that it is blocked, and in
> > > > >         each of these cases the descriptor shall be considered ready for
> > > > >         reading.)
> > > > But it says nowhere that the select()/recvmsg() operation is atomic, right?
> > >
> > > This is a distraction. If the call to select() had been substituted
> > > with a call to recvmsg(), it would have blocked. Instead, select() is
> > > returning 'yes, you can read', and then recvmsg() is blocking. The
> > > select() lied. The information is all sitting in the kernel packet
> >
> > No. A million things might happen between select() and recvmsg(), both
> > in kernel and application. For a consistent behaviour throughout all
> > possibilities, you *have* to assume that any read on a blocking fd may
> > block, and that a fd ready for reading at select() time might not be
> > readable once the app gets to recvmsg() -- for whatever reason.
> 
> It is perfectly possible to not have a million things happen between
> select() and recvmsg() and POSIX defines what can happen and what
> can't; it states that a process calling select() on a socket will not block
> on a subsequent recvmsg() on that socket.
> 
> > And indeed, that implies that select() on blocking fds is generally
> > not useful if you expect to bypass the blocking through select().
> > Personally,  I think any application that implements this expectation
> > is broken. (If only because you might have to do a second read() or
> > recvmsg() which will either result in a crappy select() loop or a
> > broken read()/recvmsg() loop).
> 
> The way select() is defined in POSIX effectively means that once an
> application has done a select() on a socket, the data that caused
> select() to return is committed, i.e. it can no longer be dropped and
> should be considered received by the application; this has nothing

That is plainly wrong. Data is never received by an application before
recvmsg() has succeeded.

> to do with UDP being unreliable and being unreliable for the sake
> of it is not what UDP was meant for.
> 
> Whether you think an application that is written to use select() as
> defined in POSIX is broken is not really important. The fact remains
> that Linux currently implements a select() that is _not_ POSIX
> compliant and is so solely for performance reasons. I personally think
> correct behaviour is much more important.

All I'm saying is, that applications that are not correct now, will
probably not be correct even if we change the way Linux handles this
situation. The sanest thing really seems to accept the fact that any
read() on a blocking fd might block, even if the programmer thinks it
really shouldn't.

But then I am one of those who thinks it's sane to check for
EWOULDBLOCK on a nonblocking socket after blocking in select().

Let's just document this and move on to something more important.


Cheers,
Buddy

> --ms
> 
>
