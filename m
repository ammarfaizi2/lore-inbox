Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131051AbRCFSXN>; Tue, 6 Mar 2001 13:23:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131052AbRCFSWx>; Tue, 6 Mar 2001 13:22:53 -0500
Received: from s057.dhcp212-109.cybercable.fr ([212.198.109.57]:28420 "EHLO
	s057.dhcp212-109.cybercable.fr") by vger.kernel.org with ESMTP
	id <S131051AbRCFSWm>; Tue, 6 Mar 2001 13:22:42 -0500
Message-ID: <3AA52916.5FD87258@baretta.com>
Date: Tue, 06 Mar 2001 19:14:46 +0100
From: Alessandro Baretta <alex@baretta.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: it, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Inadequate documentation: sockets
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everybody!

I am a newbie in this list, so please accept my apologies for not
being adeqately informed on many technical issues many a kernel
programmer might consider banal.

I wish to bring your attention to the documentation available on
the topic of of the _disconnection_ of stream oriented sockets.
I'm writing a user space program that uses TCP sockets. I need to
know if and when a given connection is broken, and more
specifically if and when _one_ direction of the stream is shut
down by the peer. The following documentation seems to apply to my
case:

1) man poll:
The manual specifies the following flag to be returned by the
kernel
> #define POLLHUP     0x0010    /* Hung up */

Hanging up is ambiguous. Does it mean that the client is dead,
that he closed his end of the socket, or that he shut down one or
both directions of the data flow? The following man page clears
this up, but I think the following information would best be
placed in man poll.

2) man 7 socket
> The user can then wait for
> various events via poll(2) or select(2).

      
+-----------+-----------+--------------------------------------------+
       |Read       | POLLHUP   | A disconnection request has been
initiated |
       |           |           | by the other
end.                          |
      
+-----------+-----------+--------------------------------------------+
       |Read       | POLLHUP   | A connection is broken (only 
for  connec­ |
       |           |           | tion-oriented protocols).  When
the socket |
       |           |           | is writen SIGPIPE is also
sent.            |
      
+-----------+-----------+--------------------------------------------+
      
+-----------+-----------+--------------------------------------------+
       |Read/Write | POLLHUP   | The other end has shut down one
direction. |
      
+-----------+-----------+--------------------------------------------+

This means that I get a POLLHUP in all the time, but it does not
allow me to distinguish among the three different relevant cases:
a) the client shutting down reads only, b) the client shutting
down writes only, c) the client going down entirely.

I figured the following documentation might help, but it did not.
3) man 2 send
>ERRORS
>       EPIPE  The  local  end  has been shut down on a connection
>              oriented socket.  In this  case  the  process  will
>              also  receive a SIGPIPE unless MSG_NOSIGNAL is set.
4) man recv
>       The flags argument to a recv call is formed by OR'ing  one
>       or more of the following values:
>       MSG_NOSIGNAL
>              This flag turns off raising of  SIGPIPE  on  stream
>              sockets when the other end disappears.
Yet, although the manpage mentions an MSG_NOSIGNAL flag, it never
mentions either raising a SIGPIPE when the socket is disconnected,
nor setting errno to EPIPE upon execution of recv on a socket
closed by the peer. This is very ambiguous. I would be very
greatful to anyone who clear up this point.

Finally I'm left with my original problem: how am I supposed to
detect a close or a shutdown from the peer? Once again, I thank in
advance anyone who will lend me a hand by explaining this to me or
by addressing me to more adequate documentation.

Thanks for your kind interest.

Alex Baretta
