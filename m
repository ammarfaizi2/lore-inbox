Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262445AbTFJCAN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 22:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262459AbTFJCAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 22:00:13 -0400
Received: from 216-42-72-151.ppp.netsville.net ([216.42.72.151]:10409 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id S262445AbTFJCAJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 22:00:09 -0400
Subject: RE: [PATCH] io stalls
From: Chris Mason <mason@suse.com>
To: Robert White <rwhite@casabyte.com>
Cc: Nick Piggin <piggin@cyberone.com.au>, Andrea Arcangeli <andrea@suse.de>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Jens Axboe <axboe@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Georg Nikodym <georgn@somanetworks.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Matthias Mueller <matthias.mueller@rz.uni-karlsruhe.de>
In-Reply-To: <PEEPIDHAKMCGHDBJLHKGKEACCPAA.rwhite@casabyte.com>
References: <PEEPIDHAKMCGHDBJLHKGKEACCPAA.rwhite@casabyte.com>
Content-Type: text/plain
Organization: 
Message-Id: <1055211186.23126.422.camel@tiny.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 09 Jun 2003 22:13:07 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-06-09 at 21:48, Robert White wrote:
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Nick Piggin
> 
> > Chris Mason wrote:
> 
> > >The major difference from Nick's patch is that once the queue is marked
> > >full, I don't clear the full flag until the wait queue is empty.  This
> > >means new io can't steal available requests until every existing waiter
> > >has been granted a request.
> 
> > Yes, this is probably a good idea.
> 
> 
> Err... wouldn't this subvert the spirit, if not the warrant, of real time
> scheduling and time-critical applications?
> 

[ lots of interesting points ]

Heh, I didn't really make my goals for the patch clear.  They go:

1) quantify the stalls people are seeing with real numbers so we can
point at a section of code causing bad performance.

2) Provide a somewhat obvious patch that makes the current
__get_request_wait call significantly more fair, in hopes of either
blaming it for the stalls or removing it from the list of candidates

3) fix the stalls

Most of your suggestions are 2.5 discussion material, where real
experimental work is going on.  The 2.4 io request wait queue isn't
working on priorities, the current one tries to be fair to everyone and
provide good throughput to everyone at the same time.  It's failing on
at least one of those, and until we can fix that I don't even want to
think about more complex issues.

Current users of the vanilla 2.4 tree will hopefully benefit from a
lower latency io request wait queue. The next best thing to real time is
a consistently small wait, which is what my patch is trying for.

-chris


