Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbTFJWvX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 18:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261624AbTFJWvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 18:51:23 -0400
Received: from mail.casabyte.com ([209.63.254.226]:1804 "EHLO
	mail.1casabyte.com") by vger.kernel.org with ESMTP id S261669AbTFJWvS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 18:51:18 -0400
From: "Robert White" <rwhite@casabyte.com>
To: "Chris Mason" <mason@suse.com>
Cc: "Nick Piggin" <piggin@cyberone.com.au>,
       "Andrea Arcangeli" <andrea@suse.de>,
       "Marc-Christian Petersen" <m.c.p@wolk-project.de>,
       "Jens Axboe" <axboe@suse.de>,
       "Marcelo Tosatti" <marcelo@conectiva.com.br>,
       "Georg Nikodym" <georgn@somanetworks.com>,
       "lkml" <linux-kernel@vger.kernel.org>,
       "Matthias Mueller" <matthias.mueller@rz.uni-karlsruhe.de>
Subject: RE: [PATCH] io stalls
Date: Tue, 10 Jun 2003 16:04:47 -0700
Message-ID: <PEEPIDHAKMCGHDBJLHKGMECMCPAA.rwhite@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <1055211186.23126.422.camel@tiny.suse.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4920.2300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Mason [mailto:mason@suse.com]
Sent: Monday, June 09, 2003 7:13 PM

> 2) Provide a somewhat obvious patch that makes the current
> __get_request_wait call significantly more fair, in hopes of either
> blaming it for the stalls or removing it from the list of candidates

Without the a_w_q_exclusive() on add_wait_queue the FIFO effect is lost when
all the members of the wait queue compete for their timeslice in the
scheduler.  For all intents and purposes the fairness goes up some (you stop
having the one guy sorted to the un-happy end of the disk) but low priority
tasks will still always end up stalled on the dirty end of the stick.
Basically each new round at the queue-empty moment is a mob rush for the
door.

With the a_w_q_exclusive(), you get past fair and well into anti-optimal.
Your FIFO becomes essentially mandatory with no regard for anything but the
order things hit the wait queue.  (Particularly on an SMP machine, however)
"new requestors" may/will jump to the head of the line because they were
never *in* the wait queue.  So you have only achieved "fairness" with
respect to requests that come in to a io queue that was full-at-the-time of
the initial entry into the driver.  This becomes exactly like the experience
of waiting patiently on line to get off the highway and watching all the
rude people driving by you only to cut over and nose into the queue just at
the exit sign.

So you need the _exclusive if you want any kind of predictable fairness
(without getting into anything obscure) but it is still only "fair" for
those that were unfortunate enough to end up on the wait queue originally.
There is a small window for tasks to butt in freely.

> 3) fix the stalls

Without the _exclusive() you can't have fixed the stalls, you can only have
moved the locus-of-blame to the scheduler which may (or may not) have some
way to compensate and "fake fairness" built in by coincidence.

The thing I suggest in my other email, where you use the non-exclusive
version of the routine but temporarily bump the process priority each time a
request gets foisted off on the wait_queue instead of the IO queue, actually
has semantic fairness built in.  This basically builds a fairness elevator
that functions both over time-in-queue and original process priority (when
built into your basic patch).

It's also quite space/time efficient and fairly clear to reader and
implementer alike.

Rob.

