Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310288AbSCLEdH>; Mon, 11 Mar 2002 23:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310280AbSCLEc5>; Mon, 11 Mar 2002 23:32:57 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:47879 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S310201AbSCLEck>; Mon, 11 Mar 2002 23:32:40 -0500
Date: Mon, 11 Mar 2002 20:31:28 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] My AMD IDE driver, v2.7
In-Reply-To: <Pine.LNX.4.33.0203111944090.18649-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0203112023410.18739-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 11 Mar 2002, Linus Torvalds wrote:
> 
>  - attach to one or more request queue(s). Notice that you should not have
>    _one_ module that handles all request queues, because the filter module
>    obviously has to be different for an ATA disk than for a SCSI disk, and
>    in fact it might be different for an IBM ATA disk than for a Maxtor ATA
>    disk, for example.

Btw, to tie this back to the other IDE thread, namely the suspend/resume 
thing, I think things like that should also just push commands down the 
request list. In particular, instead of waiting until the handler is NULL, 
it should do something like

 - create a "sync" request
 - do the equivalent of

	DECLARE_COMPLETION(wait);
	rq->waiting = &wait;
	q->elevator.elevator_add_req_fn(q, rq, queue_head);
	wait_for_completion(&wait);

which automatically synchronizes with any outstanding requests (simply 
by virtue of the elevator knowing not to re-order/merge special requests, 
so when the sync command in finished, we know all other commands have 
finished too).

Note that this should be the same code as for a shutdown as well - we
should finish with a flush buffers request and wait for it to have
completed.

I'd like a _lot_ of stuff to stop using "do_xxx_command()", and move toa 
higher layer so that more code can be shared between different subsystems 
(all of these "sync" issues are really completely generic, and should 
_not_ be duplicated across drivers or subsystems).

		Linus

