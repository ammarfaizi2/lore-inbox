Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264083AbRFUCnf>; Wed, 20 Jun 2001 22:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264715AbRFUCnQ>; Wed, 20 Jun 2001 22:43:16 -0400
Received: from shell.ca.us.webchat.org ([216.152.64.152]:49381 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S264083AbRFUCnN>; Wed, 20 Jun 2001 22:43:13 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Davide Libenzi" <davidel@xmailserver.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Why use threads ( was: Alan Cox quote?)
Date: Wed, 20 Jun 2001 19:43:09 -0700
Message-ID: <NCBBLIEPOCNJOAEKBEAKCEPBPPAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <XFMail.20010620192245.davidel@xmailserver.org>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2479.0005
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Just to summarize :

> 1) You said to handle 16000 sessions with 10 threads

> 2) I said: "Humm, you've to select() about 1600 fds ..."

> 3) You said : "Who said anything about 'select'?"

	You can use any I/O model you want. I've suggested several.

> The stuff above looks like select() to me.

	I'm not sure what that has to do with anything.

> About the scale factor of select()/poll() my agreement is only partial.
> Have You ecer observed that Your processes tend to become a bit
> CPU bound when
> stocking a lot of fds inside a poll ?

	Okay, let's compare two servers.

	Server one is handling 10 file descriptors. The cost of a single call to
poll is 3 microseconds. Assume that the server is coded to get back to
'poll' as quickly as it can, but due to load the code manages to call 'poll'
every 100 microseconds, so the overhead of poll is 3% of the available CPU.

	Now server two, with identical hardware and software, is handling 10,000
file descriptors. The cost of a single call to poll is now 3,000
microseconds (assuming 'poll' scales linearly, it actually scales slightly
better than linearly). Since this code is 1,000 times busier, assume it gets
around to calling 'poll' every 100,000 microseconds. Note that, percentage
wise, the overhead of poll is the same, 3%.

	It is actually even better than this. For one thing, in the second case,
the less-frequent calls to poll mean that you do more I/O per poll call per
connection, because there is more time in between calls to 'recv' for data
to go into the buffers. This also means more 'full reads' and fewer 'partial
reads' which improves your buffer handling signifantly. Same is true for
your 'write' calls, the less often you call 'write' the more often
(percentage wise) you'll write all you tried to write.


	Now this assumes no clever tricks to improve poll's scalability. This
doesn't even consider the fact that calling 'poll' less often means that a
higher percentage of sockets will be discovered per call to poll.

	Again, the problems with select/poll are not about scalability, they're
about performance (in terms of absolute CPU consumption) at low load levels
with large numbers of file descriptors.

	In contrast, if you had 1,600 execution vehicles instead of 10, you would
suffer more context switches, more memory overhead for stacks, and you would
incur one kernel/user transition for each socket discovered instead of far
fewer. In addition, a much higher percentage of your I/O operations would
block, and blocking operations are more expensive than those that don't
result in a block.

	DS

