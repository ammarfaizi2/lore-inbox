Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264533AbTFIQvp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 12:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264535AbTFIQvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 12:51:45 -0400
Received: from mail.webmaster.com ([216.152.64.131]:58035 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S264533AbTFIQvl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 12:51:41 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "MarKol" <markol4@wp.pl>, <linux-kernel@vger.kernel.org>
Subject: RE: select for UNIX sockets?
Date: Mon, 9 Jun 2003 10:05:19 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKEEJPDIAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <000c01c32ea6$b3c88e60$010110ac@uran238>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: "David Schwartz" <davids@webmaster.com>

> > Suppose, for example, a machine has two network interfaces. One is
> > very
> > busy, queue full, and one is totally idle, queue empty. What do you
> > think
> > 'select' for write on an unconnected UDP socket should do?

> There is an internal buffer for this UDP socket. Select() should depend
> on it's state.
> I heard that SO_SNDLOWAT i SO_RCVLOWAT might be useful in this approach,
> but it is not implemented in Linux.

	What you are suggesting just can't work for an unconnected socket. The
kernel has no idea where the next packet you send is going to go. It could
be along an uncongested path, it could be along a congested path. If there
were a single buffer, then packets bound for congested paths would block
packets bound for uncongested paths. UDP streaming media programs would
effectively reduce their throughput to that of their slowest local path.

> This quotation is taken from man select:
> "
>        Three independent sets of descriptors are watched.   Those
>        listed  in  readfds  will  be watched to see if characters
>        become available for reading (more precisely, to see if  a
>        read  will not block - in particular, a file descriptor is
>        also ready on end-of-file),  those  in  writefds  will  be
>        watched  to  see  if  a write will not block, and those in
>        exceptfds will be watched for exceptions."
>
> and this from man socket:
> "       Socket creates an endpoint for communication and returns a
>        descriptor. "
>
> I'm aware of the fact that my english is rather poor, but I see that
> socket returns a descriptor, and select is watching descriptors and
> returns descriptors ready for writing if a write operation will not
> block.

	Right, if some arbitrary write operation will not block. There's no
guarantee about a particular future write operation. Consider TCP and a
non-blocking 250Kb write.

> I would agree with you if my program wouldn't work on Solaris or QNX.
> But it works on both and it looks consistent with man!

	I think too much of the context has been lost for me to reply specifically.
I don't remember which specific case you were dealing with. But the
fundamental point I'm trying to make is this -- you cannot guarantee
non-blocking operation with blocking socket calls. You can't make bricks
without straw.

	If you don't ever want to block, you *MUST* communicate this to the kernel
by issuing non-blocking operations. You *CANNOT* rely on 'select' to provide
you accurate information about arbitrary future operations. The kernel
simply cannot, in principle, provide such guarantees.

	I'm providing examples of cases where the 'guarantee' doesn't hold not
because those specific examples are the cases you are hitting. I'm providing
them to show you that you don't have a guarantee.

	DS


