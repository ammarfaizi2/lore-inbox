Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291317AbSBMCc7>; Tue, 12 Feb 2002 21:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291316AbSBMCct>; Tue, 12 Feb 2002 21:32:49 -0500
Received: from femail16.sdc1.sfba.home.com ([24.0.95.143]:35507 "EHLO
	femail16.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S291311AbSBMCck>; Tue, 12 Feb 2002 21:32:40 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Olaf Dietsche <olaf.dietsche--list.linux-kernel@exmail.de>
Subject: Re: What is a livelock? (was: [patch] sys_sync livelock fix)
Date: Tue, 12 Feb 2002 21:33:31 -0500
X-Mailer: KMail [version 1.3.1]
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <3C69A18A.501BAD42@zip.com.au> <87y9hyw4b6.fsf@tigram.bogus.local>
In-Reply-To: <87y9hyw4b6.fsf@tigram.bogus.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020213023239.VYPK4956.femail16.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 12 February 2002 08:36 pm, Olaf Dietsche wrote:
> Andrew Morton <akpm@zip.com.au> writes:
> > The get_request fairness patch exposed a livelock
> > in the buffer layer.  write_unlocked_buffers() will
> > not terminate while other tasks are generating write traffic.
>
> The subject says it: what is a livelock? How is it different
> from a deadlock?

A deadlock is when two or more processes sleep forever, each waiting for 
something the other has to release.  In a deadlock situation, the dead 
processes are not using CPU time.

In a livelock, at least one of the processes is active, and the other process 
can only continue if the active one stops.  (Sometimes they're both active, 
but can never finish what they're doing.)

The sync thing is a good example: sync tries to flush all dirty blocks to 
disk and exits when there are no more dirty blocks.  But if the system is a 
busy server that's constantly generating dirty blocks as fast as they can be 
written to disk and keeping the write buffer full, then sync never manages to 
empty the buffer completely, and it can be flushing for hours before getting 
a lucky break where it can declare victory and exit.  A script that calls 
"sync" in the middle can get completely blocked, and something else waiting 
for that to finish...

Process priority is another common cause of livelocks.  One mainframe at MIT 
was decomissioned in the early 70's and they found a "run only when idle" 
task that had been started around seven years earlier and still hadn't gotten 
any time slices because the server had never been completely idle.  (The 
pathfinder mars probe kept rebooting for a similar reason: a vital system 
task was getting starved while it held a semaphore that other stuff needed, 
and not scheduling before timeouts caused a reboot.  Look up the "priority 
inversion" problem...)

This is why even the lowest priority tasks in modern operating systems still 
occasionally are guaranteed timeslices and will even pre-empt pretty high 
priority stuff if they've been starved long enough.  Otherwise, they might 
grab some vital resource other higher-priority programs need (sempahore, file 
lock, etc) and block with it, and the rest of the system will never be 
TOTALLY idle so they can keep important stuff waiting for a very long time.

> Thanks, Olaf.

Rob
