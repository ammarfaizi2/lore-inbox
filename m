Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263861AbTFKBoJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 21:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263945AbTFKBoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 21:44:09 -0400
Received: from 216-42-72-151.ppp.netsville.net ([216.42.72.151]:37294 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id S263861AbTFKBoH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 21:44:07 -0400
Subject: Re: [PATCH] io stalls (was: -rc7   Re: Linux 2.4.21-rc6)
From: Chris Mason <mason@suse.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Nick Piggin <piggin@cyberone.com.au>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Jens Axboe <axboe@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Georg Nikodym <georgn@somanetworks.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Matthias Mueller <matthias.mueller@rz.uni-karlsruhe.de>
In-Reply-To: <20030611010628.GO26270@dualathlon.random>
References: <Pine.LNX.4.55L.0305282019160.321@freak.distro.conectiva>
	 <200306041235.07832.m.c.p@wolk-project.de> <20030604104215.GN4853@suse.de>
	 <200306041246.21636.m.c.p@wolk-project.de>
	 <20030604104825.GR3412@x30.school.suse.de>
	 <3EDDDEBB.4080209@cyberone.com.au>
	 <1055194762.23130.370.camel@tiny.suse.com>
	 <20030611003356.GN26270@dualathlon.random>
	 <1055292839.24111.180.camel@tiny.suse.com>
	 <20030611010628.GO26270@dualathlon.random>
Content-Type: text/plain
Organization: 
Message-Id: <1055296630.23697.195.camel@tiny.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 10 Jun 2003 21:57:11 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-06-10 at 21:06, Andrea Arcangeli wrote:

> And I don't think any of your barriers is needed at all, I mean, we only
> need to be careful to clear it right, we don't need to be careful to set
> or read it right when it transits from 0 to 1. And the above seems
> enough to me to get right the clearing.
> 

The current form of the patch has way too many barriers.  When I first
added them the patch was really different, I left them in because it
seems to be easier to remember to rip them out than add them back ;-)

> > > I'm also unsure what the "waited" logic does, it doesn't seem necessary.
> > 
> > Once a process waits once, they are allowed to ignore the q->full flag. 
> > This way existing waiters can make progress even when q->full is set. 
> > Without the waited check, q->full will never get cleared because the
> > last writer wouldn't proceed until the last writer was gone.  I had to
> > make __get_request for the same reason.
> 
> __get_request makes perfect sense of course and it's needed, this is not
> the issue, my point about the waited check is that the last writer has
> to get the wakeup (and the wakeup has nothing to do with the waited
> check since waited == 0), and after the wakeup it will get the request
> and it won't re-run the loop, so I don't see why waited is needed.
> Furthmore even if for whatever reason it doesn't get the request, it
> will re-set full to 1 and it'll be still the first to get the wakeup,
> and it will definitely get another wakeup if none request was available.

Ok, I see your point, we don't strictly need the waited check.  I had
added it as an optimization at first, so that those who waited once were
not penalized by further queue_full checks. 

-chris


