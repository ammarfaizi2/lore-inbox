Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267921AbUJGTff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267921AbUJGTff (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 15:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267841AbUJGTdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 15:33:32 -0400
Received: from mail1.webmaster.com ([216.152.64.168]:15114 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S267620AbUJGTbt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 15:31:49 -0400
From: "David Schwartz" <davids@webmaster.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: UDP recvmsg blocks after select(), 2.6 bug?
Date: Thu, 7 Oct 2004 12:31:38 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKCEFKONAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <Pine.LNX.4.58.0410061616420.22221@eljakim.netsystem.nl>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Thu, 07 Oct 2004 12:08:30 -0700
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Thu, 07 Oct 2004 12:08:31 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I have a problem where the sequence of events is as follows:
>  - application does select() on a UDP socket descriptor
>  - select returns success with descriptor ready for reading
>  - application does recvfrom() on this descriptor and this recvfrom()
>    blocks forever

	POSIX does not require the kernel to predict the future. The only guarantee
against having a socket operation block is found in non-blocking sockets.

> My understanding of POSIX is limited, but it seems to me that a read call
> must never block after select just said that it's ok to read from the
> descriptor. So any such behaviour would be a kernel bug.

	Suppose hypothetically that we add a new network protocol that permits the
sender to 'invalidate' data after it's received by the remote network stack
and before it's accepted by the remote application. Would you argue that
'select'ing must be considered a read in this case? Even though an
application might 'select' on a socket with no intention to follow up with a
read? Remember, the 'select' operation is supposed to be protocol neutral.

> From a brief look at the kernel UDP code, I suspect a problem in
> net/ipv4/udp.c, udp_recvmsg(): it reads the first available datagram
> from the queue, then checks the UDP checksum. If the UDP checksum fails at
> this point, the datagram is discarded and the process blocks
> until the next
> datagram arrives.

	You should understand a hit on 'select' to mean that something happened,
and that it would therefore behoove your application to try the operation it
wants to perform again. The 'select' operation is not fine-grained enough to
know what operation you planned, and whether that particular operation would
block.

	Suppose, for example, that instead of using 'read' you used 'recvmsg', and
we add an option to 'recvmsg' to allow you to read datagrams with bad
checksums. What should 'select' do if a datagram is received with a bad
checksum? It has no idea what flavor of 'recvmsg' you're going to call, so
it can't know if your operation is going to block or not.

> Could someone please help me track this problem?
> Am I correct in my reasoning that the select() -> recvmsg() sequence must
> never block?

	No, you are incorrect. Consider, again, a 'recvmsg' flag to allow you to
receive messages even if they have bad checksums versus one that blocks
until a message with a valid checksum is received. The 'select' function
just isn't smart enough.

	Consider a 'select' for write on a TCP socket. How does 'select' know how
many bytes you're going to write? Again, a 'select' hit just indicates
something relevant has happened, it *cannot* guarantee that a future
operation won't block both because 'select' has no idea what operation is
going to take place in the future and because things can change between now
and then.

> If yes, is it possible that this problem is triggered by a failed UDP
> checksum in the udp_recvmsg() function?
> If yes, can we do something to fix this?

	The bug is in your application. The kernel behavior might be considered
undesirable, but it's your application that is failing to tell the kernel
that it must not block.

	DS


