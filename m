Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267890AbUJGVk4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267890AbUJGVk4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 17:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268079AbUJGVih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 17:38:37 -0400
Received: from ts2-075.twistspace.com ([217.71.122.75]:63160 "EHLO entmoot.nl")
	by vger.kernel.org with ESMTP id S268086AbUJGVgW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 17:36:22 -0400
Message-ID: <015a01c4acbe$2425b070$161b14ac@boromir>
From: "Martijn Sipkema" <martijn@entmoot.nl>
To: <davids@webmaster.com>, <linux-kernel@vger.kernel.org>
References: <MDEHLPKNGKAHNMBLJOLKCEFKONAA.davids@webmaster.com>
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Date: Thu, 7 Oct 2004 23:36:51 +0100
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
> > I have a problem where the sequence of events is as follows:
> >  - application does select() on a UDP socket descriptor
> >  - select returns success with descriptor ready for reading
> >  - application does recvfrom() on this descriptor and this recvfrom()
> >    blocks forever
> 
> POSIX does not require the kernel to predict the future. The only guarantee
> against having a socket operation block is found in non-blocking sockets.

It is one thing to implement select()/recvmsg() in a non POSIX compliant
way; it is another thing to make false claims about that standard. POSIX
_does_ guarantee that a call to recvmsg() does not block after a call
to select().

> > My understanding of POSIX is limited, but it seems to me that a read call
> > must never block after select just said that it's ok to read from the
> > descriptor. So any such behaviour would be a kernel bug.
> 
> Suppose hypothetically that we add a new network protocol that permits the
> sender to 'invalidate' data after it's received by the remote network stack
> and before it's accepted by the remote application. Would you argue that
> 'select'ing must be considered a read in this case? Even though an
> application might 'select' on a socket with no intention to follow up with a
> read? Remember, the 'select' operation is supposed to be protocol neutral.

Consider the data accepted by the remote application at the moment it
calls select().

> > From a brief look at the kernel UDP code, I suspect a problem in
> > net/ipv4/udp.c, udp_recvmsg(): it reads the first available datagram
> > from the queue, then checks the UDP checksum. If the UDP checksum fails at
> > this point, the datagram is discarded and the process blocks
> > until the next
> > datagram arrives.
> 
> You should understand a hit on 'select' to mean that something happened,
> and that it would therefore behoove your application to try the operation it
> wants to perform again. The 'select' operation is not fine-grained enough to
> know what operation you planned, and whether that particular operation would
> block.
> 
> Suppose, for example, that instead of using 'read' you used 'recvmsg', and
> we add an option to 'recvmsg' to allow you to read datagrams with bad
> checksums. What should 'select' do if a datagram is received with a bad
> checksum? It has no idea what flavor of 'recvmsg' you're going to call, so
> it can't know if your operation is going to block or not.

This is all described in detail in the standard.

> > Could someone please help me track this problem?
> > Am I correct in my reasoning that the select() -> recvmsg() sequence must
> > never block?
> 
> No, you are incorrect. Consider, again, a 'recvmsg' flag to allow you to
> receive messages even if they have bad checksums versus one that blocks
> until a message with a valid checksum is received. The 'select' function
> just isn't smart enough.
>
> Consider a 'select' for write on a TCP socket. How does 'select' know how
> many bytes you're going to write? Again, a 'select' hit just indicates
> something relevant has happened, it *cannot* guarantee that a future
> operation won't block both because 'select' has no idea what operation is
> going to take place in the future and because things can change between now
> and then.

You really should read the standard on this..

> > If yes, is it possible that this problem is triggered by a failed UDP
> > checksum in the udp_recvmsg() function?
> > If yes, can we do something to fix this?
> 
> The bug is in your application. The kernel behavior might be considered
> undesirable, but it's your application that is failing to tell the kernel
> that it must not block.

Actually, the application may be correct, but he should change it
anyway since it is unlikely that Linux will follow the standard on select()
anytime soon...

--ms

