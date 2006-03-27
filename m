Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbWC0It2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbWC0It2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 03:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWC0It2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 03:49:28 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:8209 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750810AbWC0It1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 03:49:27 -0500
Date: Mon, 27 Mar 2006 10:49:36 +0200
From: Jens Axboe <axboe@suse.de>
To: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [cfq] sched_idle process stalled for 1 minute; strange ioprio too
Message-ID: <20060327084936.GF8186@suse.de>
References: <E1FMnkx-0003aE-08@approximate.corpus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1FMnkx-0003aE-08@approximate.corpus.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24 2006, Sanjoy Mahajan wrote:
> I'm trying the cfq io scheduler (in vanilla 2.6.16-rc5, TP 600X, Debian
> testing/unstable) and noticed that a massive 'apt-get upgrade' (300MB
> downloaded, 266 packages to upgrade) stalled at the 'Setting up sed'
> line below, for about 1 minute.  The machine was otherwise idle (top
> showed no processes chewing CPU), and no disk activity was going on --
> strange since an 'apt-get upgrade' usually makes 'dpkg' chew on the
> disk.
> 
> <snip>
> (Reading database ... 184123 files and directories currently installed.)
> Preparing to replace sed 4.1.2-8 (using .../archives/sed_4.1.4-5_i386.deb) ...
> Unpacking replacement sed ...
> Setting up sed (4.1.4-5) ...
> <stalls here for about 1 minute>
> <snip>
> 
> I had ioniced the shell to SCHED_IDLE with
> 
>   ionice -p$$ -c3
> 
> Then I ran the 'apt-get upgrade' so that the setting would be inherited.
> After the minute-long stall, it continued as if nothing had gone wrong.
> Maybe nothing is wrong, and it's something strange about dpkg needing a
> lock and having too low a priority to get one (but who would it fight
> with)?
> 
> While the dpkg was stalled, I did 'ps x' in another root window and
> these were the interesting ones:
> 
>  4823 pts/7    S+     0:04 apt-get upgrade
>  5228 ?        D      0:00 [pdflush]
>  5261 pts/7    S+     0:01 /usr/bin/dpkg --status-fd 29 --unpack /var/cache/apt/
>  5267 ?        S      0:00 [pdflush]
>  5268 pts/7    D+     0:00 /usr/bin/dpkg --status-fd 29 --unpack /var/cache/apt/

Are you sure no other disk activity was going on at that time? Just a
single writeout or read from the disk will stall your idle prio task. If
you expect things to finish within a bounded time, then you should not
use idle :-)

> produced these entries for some of the processes above:
> 
>   pid=4733, 24583
>   idle: prio 7
> 
>   pid=4823, 24583
>   idle: prio 7
> 
>   pid=5228, 0
>   none: prio 0
> 
>   pid=5261, 24583
>   idle: prio 7
> 
>   pid=5268, 24583
>   idle: prio 7
> 
> I don't understand the ", 24583" in the pid lines.  In ionice.c it comes
> from this code:
>
> 
> 		ioprio = ioprio_get(IOPRIO_WHO_PROCESS, pid);
> 		printf("pid=%d, %d\n", pid, ioprio);
> 
> So ioprio_get is returning a strange value -- or is 24583 correct?

It's a raw display of the priority, it would probably make more sense in
hex. 24583 is 0x6007 - lower bits the priority, here 7. Shift it down by
13 (IOPRIO_CLASS_SHIFT) and you have the class - that would be 11b, or 3
decimal, which is IOPRIO_CLASS_IDLE. So 24583 is the idle io class,
fixed priority of 7.

-- 
Jens Axboe

