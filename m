Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270386AbTGMURQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 16:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270398AbTGMURQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 16:17:16 -0400
Received: from mail.webmaster.com ([216.152.64.131]:7645 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S270386AbTGMURP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 16:17:15 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Davide Libenzi" <davidel@xmailserver.org>,
       "Eric Varsanyi" <e0206@foo21.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: [Patch][RFC] epoll and half closed TCP connections
Date: Sun, 13 Jul 2003 13:32:00 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKIEEPEFAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <Pine.LNX.4.55.0307121346140.4720@bigblue.dev.mcafeelabs.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Look this is false for epoll. Given N fds inside the set and M hot/ready
> fds, epoll scale O(M) and not O(N) (like poll/select). There's a huge
> difference, expecially with real loads.
>
> - Davide

	For most real-world loads, M is some fraction of N. The fraction
asymptotically approaches 1 as load increases because under load it takes
you longer to get back to polling, so a higher fraction of the descriptors
will be ready when you do.

	Even if you argue that most real-world loads consists of a few very busy
file descriptors and a lot of idle file descriptors, why would you think
that this ratio changes as the number of connections increase? Say a group
of two servers is handling a bunch of connections. Some of those connections
will be very active and some will be very idle. But surely the *percentage*
of active connections won't change just becase the connections are split
over the servers 50/50 rather than 10/90.

	If a particular protocol and usage sees 10 idle connections for every
active one, then N will be ten times M, and O(M) will be the same as O(N).
It's only if a higher percentage of connections are idle when there are more
connections (which seems an extreme rarity to me) that O(M) is better than
O(N).

	Is there any actual evidence to suggest that epoll scales better than poll
for "real loads"? Tests with increasing numbers of idle file descriptors as
the active count stays constant are not real loads.

	By the way, I'm not arguing against epoll. I believe it will use less
resources than poll in pretty much every conceivable situation. I simply
take issue with the argument that it has better ultimate scalability or
scales at a different order.

	DS


