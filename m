Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270430AbTGMWu4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 18:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270431AbTGMWu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 18:50:56 -0400
Received: from mail.webmaster.com ([216.152.64.131]:26337 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S270430AbTGMWuy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 18:50:54 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Jamie Lokier" <jamie@shareable.org>
Cc: "Davide Libenzi" <davidel@xmailserver.org>,
       "Eric Varsanyi" <e0206@foo21.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: [Patch][RFC] epoll and half closed TCP connections
Date: Sun, 13 Jul 2003 16:05:38 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKEEFKEFAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <20030713211045.GD21612@mail.jlokier.co.uk>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




> David Schwartz wrote:

> > 	For most real-world loads, M is some fraction of N. The fraction
> > asymptotically approaches 1 as load increases because under
> > load it takes
> > you longer to get back to polling, so a higher fraction of the
> > descriptors
> > will be ready when you do.

> Ah, but as the fraction approaches 1, you'll find that you are
> asymptotically approaching the point where you can't handle the load
> _regardless_ of epoll overhead.

	This has not been my experience. On pretty much every OS except Linux, my
experience has been that as you are spending more time doing work, each call
to 'poll' discovers more file descriptors ready. Further, the number of
bytes you can send/receive is greater (because it took you longer to get
back to the same connection), so again, the amount of work you do, per call
to 'poll' goes way up. I think most of the problem is just that Linux's
'poll' is extremely expensive and not due to any inherent API benefit of
'epoll'.

> > 	By the way, I'm not arguing against epoll. I believe it
> > will use less
> > resources than poll in pretty much every conceivable situation. I simply
> > take issue with the argument that it has better ultimate scalability or
> > scales at a different order.

> It scales according to the amount of work pending, which means that it
> doesn't take any _more_ time than actually doing the pending work.
> (This assumes you use epoll appropriately; there are many ways to use
> epoll which don't have this property).

	But so does 'poll'. If you double the number of active and inactive
connections, 'poll' takes twice as long. But you do twice as much per call
to 'poll'. You will both discover more connections ready to do work on and
move more bytes per connection as the load increases.

> That was always the complaint about select() and poll(): they dominate
> the run time for large numbers of connections.  epoll, on the other
> hand, will always be in the noise relative to other work.

	I think this is largely true for Linux because of bad implementation of
'poll' and therefore 'select'.

> If you want a formula for slides :), time_polling/time_working is O(1)
> with epoll, but O(N) with poll() & select().

	It's not O(N) with 'poll' and 'select'. Twice as many file descriptors
means twice as many active file descriptors which means twice as many
discovered per call to 'poll'. If the calls to 'poll' are further apart
(because of the additional real work done in-between calls) it means more
than twice as many discovered per call to 'poll'. Add to this that you will
find more bytes ready to read or more space in the send queue per call to
'poll' as the load goes up.

	DS


