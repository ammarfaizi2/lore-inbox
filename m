Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262267AbTFKAfH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 20:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262367AbTFKAfG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 20:35:06 -0400
Received: from dyn-ctb-210-9-246-243.webone.com.au ([210.9.246.243]:52231 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S262267AbTFKAfC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 20:35:02 -0400
Message-ID: <3EE67C57.1000303@cyberone.com.au>
Date: Wed, 11 Jun 2003 10:48:23 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Chris Mason <mason@suse.com>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Jens Axboe <axboe@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Georg Nikodym <georgn@somanetworks.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Matthias Mueller <matthias.mueller@rz.uni-karlsruhe.de>
Subject: Re: [PATCH] io stalls
References: <Pine.LNX.4.55L.0305282019160.321@freak.distro.conectiva> <200306041235.07832.m.c.p@wolk-project.de> <20030604104215.GN4853@suse.de> <200306041246.21636.m.c.p@wolk-project.de> <20030604104825.GR3412@x30.school.suse.de> <3EDDDEBB.4080209@cyberone.com.au> <1055194762.23130.370.camel@tiny.suse.com> <20030611003356.GN26270@dualathlon.random>
In-Reply-To: <20030611003356.GN26270@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrea Arcangeli wrote:

>On Mon, Jun 09, 2003 at 05:39:23PM -0400, Chris Mason wrote:
>
>>+	if (!waitqueue_active(&q->wait_for_requests[rw]))
>>+		clear_queue_full(q, rw);
>>
>
>you've an smp race above, the smp safe implementation is this:
>
>	if (!waitqueue_active(&q->wait_for_requests[rw])) {
>		clear_queue_full(q, rw);
>		mb();
>		if (unlikely(waitqueue_active(&q->wait_for_requests[rw])))
>			wake_up(&q->wait_for_requests[rw]);
>	}
>
>I'm also unsure what the "waited" logic does, it doesn't seem necessary.
>

When a task is woken up, it is quite likely that the
queue is still marked full.

