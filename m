Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262371AbTFGAA7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 20:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262386AbTFGAA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 20:00:59 -0400
Received: from mail.webmaster.com ([216.152.64.131]:968 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S262371AbTFGAA6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 20:00:58 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "MarKol" <markol4@wp.pl>, <linux-kernel@vger.kernel.org>
Subject: RE: select for UNIX sockets?
Date: Fri, 6 Jun 2003 17:14:33 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKMEOBDHAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
In-Reply-To: <002f01c32c26$18c85f30$010110ac@uran238>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Since I was an initiator of this topic on one of the Polish Linux groups
> I'd like to explain some issues. We've been porting some larger piece of
> software from Solaris to Linux and problem has arisen. Below is
> corrected
> example (with errors checking after function calls), where isolated
> problem
> is presented. I hope this will cut off any suggestions that some of
> function
> calls return errors which aren't detected and handled.
>
> An experiment shows that there is no error occurrences while running
> these
> examples on Linux and sender blocks on sendto() (after sending
> _successfully_
> some datagrams to the receiver) when select() returns with ready to
> write descriptor.
>
> The same example works _correct_ on Solaris and QNX (sender blocks on
> select() call and _never_ on sendto() ).
>
> Question is:
> Am I doing something wrong or maybe there is a bug in select() function
> under Linux?

	You are doing something wrong. You are using 'select' along with blocking
I/O operations. You can't make bricks without clay. If you don't want to
block, you must use non-blocking socket operations. End of story.

	Just because 'select' indicates a write hit, you are not assured that some
particular write at a later time will not block. Past performance does not
guarantee future results.

	Suppose, for example, a machine has two network interfaces. One is very
busy, queue full, and one is totally idle, queue empty. What do you think
'select' for write on an unconnected UDP socket should do? If you say it
should block, then it can block forever even if there's plenty of buffer
space on the network card you were going to send to. So, it can't block, it
must indicate writability.

	Now, tell me what a blocking UDP write should do if the buffer is full.
Should it return success but drop the packet silently? Does that seem right
to you?

	You have any number of sane choices. My suggestion is that you make the
socket non-blocking and treat an EWOULDBLOCK return as equivalent to
success. You can additionally take it as a hint that the packet will be as
if it was dropped.

	DS


