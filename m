Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261593AbTBJEfa>; Sun, 9 Feb 2003 23:35:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261615AbTBJEfa>; Sun, 9 Feb 2003 23:35:30 -0500
Received: from 3-157.ctame701-1.telepar.net.br ([200.193.161.157]:4243 "EHLO
	3-157.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S261593AbTBJEf2>; Sun, 9 Feb 2003 23:35:28 -0500
Date: Mon, 10 Feb 2003 02:44:59 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrea Arcangeli <andrea@suse.de>
cc: Con Kolivas <ckolivas@yahoo.com.au>, lkml <linux-kernel@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK]
 2.4.20-ck3 / aa / rmap with contest]
In-Reply-To: <Pine.LNX.4.50L.0302100127250.12742-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.50L.0302100231440.12742-100000@imladris.surriel.com>
References: <20030209133013.41763.qmail@web41404.mail.yahoo.com>
 <20030209144622.GB31401@dualathlon.random>
 <Pine.LNX.4.50L.0302100127250.12742-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Feb 2003, Rik van Riel wrote:
> On Sun, 9 Feb 2003, Andrea Arcangeli wrote:
>
> > The only way to get the minimal possible latency and maximal fariness is
> > my new stochastic fair queueing idea.
>
> "The only way" ?   That sounds like a lack of fantasy ;))

Took about 30 minutes, but here is an alternative algorithm.
One that doesn't suffer from SFQ's "temporary unfairness due
to unlucky hashing" problem, which can be made worse with SQF's
"rehashing once every N seconds" policy, where N is too big
for the user, say 30 seconds.

It requires 2 extra fields in the struct files_struct:
	->last_request and
	->request_priority

where ->last_request is the time (jiffies value) when a
process associated with this files_struct last submitted
an IO request and ->request_priority is a floating average
of the time between IO requests, which can be directly used
to determine the request priority.

The floating priority is kept over (1 << RQ_PRIO_SHIFT) requests,
maybe 32 would be a good value to start ?  Maybe 128 ?

The request priority of the files_struct used by the current
process can be calculated in a simple O(1) way every time a
request is submitted:

{
	struct files_struct *files = current->files;
	unsigned long interval = jiffies - files->last_request;

	files->request_priority -= (files->request_priority >> RQ_SHIFT_PRIO);
	files->request_priority += interval;
}

The request_priority gets assigned as the priority of the
currently submitted request (or the request gets submitted
in the queue belonging to this priority range).  We don't
change the priority of already submitted requests, except
maybe when merging requests.

This idea should adapt faster to changing IO usage of tasks
and is O(1) scalable.  Dunno if it'll be better than SFQ in
practice too, but it just shows that SFQ isn't the only way. ;)

have fun,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://guru.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>
