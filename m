Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264212AbRFMCHc>; Tue, 12 Jun 2001 22:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264278AbRFMCHW>; Tue, 12 Jun 2001 22:07:22 -0400
Received: from shell.ca.us.webchat.org ([216.152.64.152]:13450 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S264212AbRFMCHN>; Tue, 12 Jun 2001 22:07:13 -0400
From: "David Schwartz" <davids@webmaster.com>
To: <eg_nth@sinocdn.com>, <linux-kernel@vger.kernel.org>
Cc: <dicky@sinocdn.com>
Subject: RE: CLOSE_WAIT bug?
Date: Tue, 12 Jun 2001 19:07:09 -0700
Message-ID: <NCBBLIEPOCNJOAEKBEAKMEAEPNAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <Pine.LNX.4.21.0106130037330.10007-200000@sinocdn.com>
x-mimeole: Produced By Microsoft MimeOLE V6.00.2462.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> One server socket created and listening, blocking on select(),
> once a client connect to that port, there is another thread in server
> side issues a close() to the new connection.
> After the client close the connection. The connection in server side will
> stuck on CLOSE_WAIT forever until the program being killed.

	This isn't something you should ever do. There is no way the kernel can
guarantee a sane reaction to this since the 'close' could occur _before_ you
even enter 'select'.

	There is no atomic 'release mutex and select' function so you can never
know for sure whether the 'close' will occur before or after the other
thread enters 'select'. There's also the possibility that another thread
will open a new connection onto the same descriptor before the thread
blocked in 'select' gets a chance to notice that the descriptor is being
closed.

	It's also not clear what the 'close' does in this case. An attempt to close
a descriptor is not supposed to close the underlying connection unless it
closes the last reference. It's not clear whether 'select' represents a
reference or not, and it's not clear what should happen if the descriptor
table changes before the 'select' thread gets woken up even if the 'close'
call schedules it.

	One can argue that 'select' should return because a 'read' or 'write' to
the connection wouldn't block. But that's only true after 'select' returns.
While the endpoint is in use (and 'select' is using it), 'close' shouldn't
necessarily close the underlying connection. So this argument require
bootstrapping.

	For TCP, use 'shutdown'. Don't 'close' the descriptor until you are sure no
thread is using it. This is as serious an error as 'free'ing memory that
another thread is using.

	So your code is buggy. So long as the kernel doesn't lose track of the
resources entirely, it's behavior is (at least to me) acceptable. In fact, I
wish it would punish errors like this more severely, as this would reduce
the amount of code out there that has them.

	DS

