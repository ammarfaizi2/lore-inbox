Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319239AbSIKROu>; Wed, 11 Sep 2002 13:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319243AbSIKROu>; Wed, 11 Sep 2002 13:14:50 -0400
Received: from kweetal.tue.nl ([131.155.2.7]:65409 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S319239AbSIKROr>;
	Wed, 11 Sep 2002 13:14:47 -0400
Date: Wed, 11 Sep 2002 19:19:34 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: "Hanumanthu. H" <hanumanthu.hanok@wipro.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pid_max hang again...
Message-ID: <20020911171934.GA12449@win.tue.nl>
References: <Pine.LNX.4.33.0209111428280.20725-100000@ccvsbarc.wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0209111428280.20725-100000@ccvsbarc.wipro.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2002 at 02:29:45PM +0530, Hanumanthu. H wrote:

> >> I don't know what the problem is. The present scheme is very
> >> efficient on the average (since the pid space is very large,
> >> much larger than the number of processes, this scan is hardly
> >> ever done)
> 
> > The scan itself i don't mind. It is the rescan that bothers me
> 
> And most of others too. One thing that strikes some minds
> immediatly after looking at current pid allocation, is the need
> for improvement. Well, even though the proposals are be clumsy,
> in-efficient (really ?) we should not ignore the fact that this
> is an area to improve. Ok, here is my final (more better) proposal
> which fixes the atomicity problem addressed by ManFred.
> 
> 
> Lets us have a structure to represent pid, session, pgrp and tgid.
> 
> struct idobject {
> 	struct idobject	*id_next;
> 	struct idobject *id_prev;
> 	int		value;
> 	atomic_t	users;
> 	task_t		*taskp;
> };

Again. We have 2^30 = 10^9 pids. In reality there are fewer than 10^4
processes. So once in 10^5 pid allocations do we make a scan over
these 10^4 processes, that is: for each pid allocation we look at
0.1 other processes. This 0.1 is a small number. As soon as you start
introducing structures that have to be updated for each fork or exit,
things become at least ten times as expensive as they are now.

Some polishing is possible in that code. I think I once gave a shorter
and more efficient version. The fragment "if(last_pid & ~PID_MASK);
last_pid = 300;" occurs twice, and the correct version has it only once.
The correct version does not have the "goto inside".

But, the code may only become smaller and more beautiful.
Large ugly code can be justified only by the need for efficiency,
and there is no such need here, and indeed, none of the proposals
made things more efficient. Once the number of processes gets
above 10^5 we can invent simpleminded schemes to make this
for_each_task faster.

Andries
