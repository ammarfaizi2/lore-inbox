Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264032AbTH1Paj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 11:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264037AbTH1Paj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 11:30:39 -0400
Received: from postman1.arcor-online.net ([151.189.0.187]:31112 "EHLO
	postman.arcor.de") by vger.kernel.org with ESMTP id S264032AbTH1Pah
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 11:30:37 -0400
Date: Thu, 28 Aug 2003 17:29:34 +0200
From: Juergen Quade <quade@hsnr.de>
To: Nagendra Singh Tomar <nagendra_tomar@adaptec.com>
Cc: linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru,
       Werner Almesberger <wa@almesberger.net>
Subject: Re: tasklet_kill will always hang for recursive tasklets on a UP
Message-ID: <20030828152934.GA7924@hsnr.de>
References: <20030827182149.GA23439@hsnr.de> <Pine.LNX.4.44.0308272259120.13148-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308272259120.13148-100000@localhost.localdomain>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 27, 2003 at 11:16:52PM +0530, Nagendra Singh Tomar wrote:
> Juergen,
> 	The whole tasklet_kill function is a big confusion. It is a big 
> misnomer as Werner rightly said. For non-recursive tasklets this  
> function does not do anything. Its just an expensive "nop". If you simply 
> call tasklet_schedule after tasklet_kill, it will execute as nothing had
> happened. 
> If we remove the line 
> 
> clear_bit(TASKLET_STATE_SCHED, &t->state);
> 
> from tasklet_kill then tasklet_kill will have the desired effect of 
> "killing" the tasklet, tasklet_schedule() after tasklet_kill in that case, 
> will not call __tasklet_kill and hence it will not be queued to the CPU
> queue and hence it will not run (desired effect).

Here we have it! In my opintion, the line

	clear_bit(TASKLET_STATE_SCHED, &t->state);

is just a _BUG_. The programmer _wanted_ to write

	set_bit(TASKLET_STATE_SCHED, &t->state);

In this case the function tasklet_kill _makes sense_ (beside
the problem of not working with recursive taskets)!
It will mostly be called in the cleanup function of a module 
and - yes - it would be useful.

So in my opintion
1. we should fix the bug (very easy)
2. we should find some means to make it usable for recursive tasklets.

	Juergen.
