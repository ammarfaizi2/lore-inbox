Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268447AbUJQTcU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268447AbUJQTcU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 15:32:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269267AbUJQTcU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 15:32:20 -0400
Received: from ts2-075.twistspace.com ([217.71.122.75]:29148 "EHLO entmoot.nl")
	by vger.kernel.org with ESMTP id S268447AbUJQTcR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 15:32:17 -0400
Message-ID: <003501c4b488$6ccc0b40$161b14ac@boromir>
From: "Martijn Sipkema" <martijn@entmoot.nl>
To: <davids@webmaster.com>,
       "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
References: <MDEHLPKNGKAHNMBLJOLKMEBNPBAA.davids@webmaster.com>
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Date: Sun, 17 Oct 2004 21:32:30 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "David Schwartz" <davids@webmaster.com>
> > It is perfectly possible to not have a million things happen between
> > select() and recvmsg() and POSIX defines what can happen and what
> > can't; it states that a process calling select() on a socket will
> > not block
> > on a subsequent recvmsg() on that socket.
> 
> I'm sorry, that's an absolutely preposterous view. For one thing, Linux
> violates this by allowing processes and threads to share file descriptors
> (since another process can steal the data before the call to 'recvmsg'). Oh
> well, I guess we'll have to take that out if we want to comply with POSIX on
> 'select' semantics.

I don't think this is comparable, see below.

> > The way select() is defined in POSIX effectively means that once an
> > application has done a select() on a socket, the data that caused
> > select() to return is committed, i.e. it can no longer be dropped and
> > should be considered received by the application; this has nothing
> > to do with UDP being unreliable and being unreliable for the sake
> > of it is not what UDP was meant for.
> 
> Again, I think this is an absurd reading of the standard. No other status
> function provides a future guarantee. And it's semantically ugly to have
> 'select' change the status of network data when it's purely intended to be a
> 'get status' function.

It not about a future guarantee; the information as to whether the data
is corrupt or not is available at the time when select() is called and POSIX
requires it to be.

You _chose_ to implement your select() in a way that is not POSIX
compliant.

> > Whether you think an application that is written to use select() as
> > defined in POSIX is broken is not really important. The fact remains
> > that Linux currently implements a select() that is _not_ POSIX
> > compliant and is so solely for performance reasons. I personally think
> > correct behaviour is much more important.
> 
> This is only because you interpret the standard as providing a future
> guarantee that it is literally impossible for any modern operating system to
> provide.

Hardly so.

> I certainly don't interpret the standard that way. Look up the word
> 'would' in the dictionary.

would is meant here as "if you were to call recvmsg(), then" and not as
"may or may not..".

Your interpretation of select() is that it merely provides a hint that the
socket may be ready; that may be convenient for you, but it is not what
POSIX describes.

> Linux does in fact make the decision to discard the data *after* the call
> to 'select'. This is not in any way different from another process that
> shared the file descriptor consuming the data after the call to 'select'.

I think it is different. The first recvmsg() from one of these processes
doesn't block; it is the recvmsg() on that file descriptor that select()
guarantees will not block.


--ms


