Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263449AbRFGWOW>; Thu, 7 Jun 2001 18:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263452AbRFGWOM>; Thu, 7 Jun 2001 18:14:12 -0400
Received: from shell.ca.us.webchat.org ([216.152.64.152]:28898 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S263449AbRFGWOG>; Thu, 7 Jun 2001 18:14:06 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Matthias Urlichs" <smurf@noris.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: PROBLEM: I/O system call never returns if file desc is closed in the
Date: Thu, 7 Jun 2001 15:14:04 -0700
Message-ID: <NCBBLIEPOCNJOAEKBEAKMECAPKAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <p05100310b744a22f02a6@[192.109.102.42]>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> At 22:35 +0100 2001-06-06, Alan Cox wrote:

> >  > This report describes a problem in the usage of file
> >  > descriptors across

> >>  multiple threads. When one thread closes a file descriptor, another
> >>  thread which waits for an I/O on that file descriptor is not notified
> >>  and blocks forever.

> >THe I/O does not block forever, it blocks until completed.

> That's still "forever" if you don't specify a timeout in the select.

	If you don't want to block until an operation completes, then don't ask to!

> >The actual final
> >closure of the object occurs when the last operation on it exits

> Select is defined as to return, with the appropriate bit set, if/when
> a nonblocking read/write on the file descriptor won't block. You'd
> get EBADF in this case, therefore causing the select to return would
> be a Good Thing.

	That is not quite correct. That is a good approximate definition of
'select's behavior, but it is not exact. As for your assertion that a
noblocking read/write wouldn't block, that's not necessarily true. Remember,
the 'close' may not have taken affect yet, since the descriptor is still in
use by virtue of being selected on.

> A related problem is that the second thread my be inside a blocking
> read() instead of a select() call. It'd never continue.  :-(

	Perfect. Doing this is absolutely, positively wrong and the more you are
punished for it, the better. It's as wrong as calling 'free' on a chunk of
memory when another thread may be usign it. It is impossible to make this
work safely, as another thread could open a socket or file and get the same
descriptor write before the call to 'read' is entered. There's no possible
way to do this because there is no 'unlock a mutex and read' operation.

> HOWEVER: IMHO it's bad design to distribute the responsibility for
> file descriptors between threads.

	Why? That's a great design and it's absolutely essential in many cases.
Suppose, for example, I have two descriptors I want to write to. If I assign
one thread to each socket permanently, then I'm 100% guaranteed a context
switch every time I change which socket I'm writing to, so if there's lots
of small bits of data going out both of them, my performance will suck. But
if I assign one thread to both socket descriptors, I'm guaranteed that one
connection will stall if the the application-level send queue for the other
has been swapped out to disk. Not distributing network I/O across threads
dynamically is a recipe for either low performance or bursty performance.

	DS

