Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264801AbTFLLpO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 07:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264809AbTFLLpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 07:45:14 -0400
Received: from 216-42-72-151.ppp.netsville.net ([216.42.72.151]:10933 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id S264801AbTFLLpK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 07:45:10 -0400
Subject: Re: [PATCH] io stalls
From: Chris Mason <mason@suse.com>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Andrea Arcangeli <andrea@suse.de>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Jens Axboe <axboe@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Georg Nikodym <georgn@somanetworks.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Matthias Mueller <matthias.mueller@rz.uni-karlsruhe.de>
In-Reply-To: <3EE7E876.80808@cyberone.com.au>
References: <20030611003356.GN26270@dualathlon.random>
	 <1055292839.24111.180.camel@tiny.suse.com>
	 <20030611010628.GO26270@dualathlon.random>
	 <1055296630.23697.195.camel@tiny.suse.com>
	 <20030611021030.GQ26270@dualathlon.random>
	 <1055353360.23697.235.camel@tiny.suse.com>
	 <20030611181217.GX26270@dualathlon.random>
	 <1055356032.24111.240.camel@tiny.suse.com>
	 <20030611183503.GY26270@dualathlon.random> <3EE7D1AA.30701@cyberone.com.au>
	 <20030612012951.GG1500@dualathlon.random>
	 <1055384547.24111.322.camel@tiny.suse.com> <3EE7E876.80808@cyberone.com.au>
Content-Type: text/plain
Organization: 
Message-Id: <1055419075.24111.337.camel@tiny.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 12 Jun 2003 07:57:56 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-06-11 at 22:41, Nick Piggin wrote:

> >I think the only time we really need to wakeup more than one waiter is
> >when we hit the q->batch_request mark.  After that, each new request
> >that is freed can be matched with a single waiter, and we know that any
> >previously finished requests have probably already been matched to their
> >own waiter.
> >
> >
> Nope. Not even then. Each retiring request should submit
> a wake up, and the process will submit another request.
> So the number of requests will be held at the batch_request
> mark until no more waiters.
> 
> Now that begs the question, why have batch_requests anymore?
> It no longer does anything.
> 

We've got many flavors of the patch discussed in this thread, so this
needs a little qualification.  When get_request_wait_wakeup wakes one of
the waiters (as in the patch I sent yesterday), you want to make sure
that after you wake the first waiter there is a request available for
the proccess he is going to wake up, and so on for each other waiter.  

I did a quick test of this yesterday, and under the 20 proc iozone test,
turning off batch_requests more than doubled the number of context
switches hit during the run, I'm assuming this was from wakeups that
failed to find requests.

I'm doing a few tests with Andrea's new get_request_wait_wakeup ideas
and wake_up_nr.

-chris


