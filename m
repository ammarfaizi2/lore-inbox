Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264616AbRFPL46>; Sat, 16 Jun 2001 07:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264618AbRFPL4s>; Sat, 16 Jun 2001 07:56:48 -0400
Received: from smtp-server2.cfl.rr.com ([65.32.2.69]:58577 "EHLO
	smtp-server2.tampabay.rr.com") by vger.kernel.org with ESMTP
	id <S264616AbRFPL4a>; Sat, 16 Jun 2001 07:56:30 -0400
Message-ID: <002501c0f65b$4faa6dc0$b6562341@cfl.rr.com>
From: "Mike Black" <mblack@csihq.com>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <200106151829.f5FITGp162144@saturn.cs.uml.edu>
Subject: Re: Client receives TCP packets but does not ACK
Date: Sat, 16 Jun 2001 07:55:59 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2462.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK guys -- how much money are you willing to be that TCP is guaranteed??
Since you don't want to talk OSI that's OK -- that's just to educate some
people.

Try this: (this is what I ran into years ago and had to argue to death).

#1 Client1 has tcp connection to Server1.  Both machines are setup to retry
connections if they fail.
#2 Server1 has power outage (note that Client1 has absolutely NO idea what
happens until Server1 is back up again no RST -- no nothin').
#3 Client1 finally times out and is able to reconnect to Server1 and thinks
everything is OK (as do all the programmers at our customer who think TCP is
a guaranteed protocol).
#4 Analysis shows numerous transacations have been lost (complete panic by
the customer).

Here's the big question.  Who's fault is it?  Our customer tried to claim
that the TCP stack was at fault on our server (a Windows 3.1 box) because it
"dropped packets" and didn't know about it.  Then they thought that the TCP
stack on their client was at fault because it never showed an error trying
to write to the socket.

After much argument I finally was able to show them (from the author of TCP
whom I emailed for support) that TCP is NOT guaranteed -- it's up to what
you guys are calling the "API" layer (OSI Layer 7) to ENSURE that data
ACTUALLY gets to it's intended target.  I was brought in late on this
contract but I never would've implemented the brain-dead protocol (or
actually complete lack of one) for sending transactions across a socket.

You're right in that TCP will work just fine AS LONG AS THERE ARE NO
PROBLEMS!!!!

You can write a program that just opens a socket and blasts data to the
recipient without an error.  And as long as your protocol is session
oriented you'll be fine.  If the session aborts you just resend the whole
thing.

But that does NOT make a robust solution for a transaction oriented protocol
(like the one that started this thread) (contrary to what many people think
AND code up).
P.S. My reference to TCP being at OSI layer 5 is because that's what the API
is for sockets -- Session Layer -- and that's all that people generally
think is needed.  Big mistake if you're transaction-oriented.

