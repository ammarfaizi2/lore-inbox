Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263967AbRFHOjs>; Fri, 8 Jun 2001 10:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263991AbRFHOji>; Fri, 8 Jun 2001 10:39:38 -0400
Received: from pcow035o.blueyonder.co.uk ([195.188.53.121]:17930 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S263967AbRFHOjV>;
	Fri, 8 Jun 2001 10:39:21 -0400
From: "Eric Barton" <eric@bartonsoftware.com>
To: <linux-kernel@vger.kernel.org>
Subject: tcp_recvmsg() in 2.4.4
Date: Thu, 7 Jun 2001 18:59:06 +0100
Message-ID: <000e01c0ef7b$8b3a8d20$0281a8c0@ebpc>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2173.0
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If there are no packets on sk->recieve_queue, and nothing has been copied
to userland yet, it seems to me there is a redundant test of sk->done.

About line 1461 in net/ipv4/tcp.c:

		/* Well, if we have backlog, try to process it now yet. */

		if (copied >= target && sk->backlog.tail == NULL)
			break;

		if (copied) {
			if (sk->err ||
			    sk->state == TCP_CLOSE ||
			    (sk->shutdown & RCV_SHUTDOWN) ||
			    !timeo ||
			    (flags & MSG_PEEK))
				break;
		} else {
			if (sk->done)
				break;

			if (sk->err) {
				copied = sock_error(sk);
				break;
			}

			if (sk->shutdown & RCV_SHUTDOWN)
				break;

			if (sk->state == TCP_CLOSE) {
				if (!sk->done) {
					/* This occurs when user tries to read
					 * from never connected socket.
					 */
					copied = -ENOTCONN;
					break;
				}
				break;
			}

			if (!timeo) {
				copied = -EAGAIN;
				break;
			}
		}

When it get to if(sk->state == TCP_CLOSE), surely sk->done has already been
tested (and the socket is locked), so -ENOTCONN could be returned
immediately.

Actually I'd really appreciate it if someone could explain the order of
tests for sk->done, sk->err, sk->shutdown and sk->state...

--

                Cheers,
                        Eric

----------------------------------------------------
|Eric Barton        Barton Software                |
|9 York Gardens     Tel:    +44 (117) 923 9831     |
|Clifton            Mobile: +44 (7909) 680 356     |
|Bristol BS8 4LL    Fax:    call first             |
|United Kingdom     E-Mail: eric@bartonsoftware.com|
----------------------------------------------------

