Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268102AbTG0JMS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 05:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269144AbTG0JMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 05:12:18 -0400
Received: from pop.gmx.de ([213.165.64.20]:18906 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S268102AbTG0JMR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 05:12:17 -0400
Message-Id: <5.2.1.1.2.20030727103907.01bbd0d8@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Sun, 27 Jul 2003 11:31:43 +0200
To: Guillaume Chazarain <gfc@altern.org>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [patch] sched-2.6.0-test1-G3, interactivity changes, audio
  latency
Cc: Ingo Molnar <mingo@elte.hu>, Davide Libenzi <davidel@xmailserver.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <VRC7KGZX0573CW1TPN65C3Y312IC.3f22a7b7@monpc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

At 06:09 PM 7/26/2003 +0200, Guillaume Chazarain wrote:

> > - include scheduling latency in sleep bonus calculation. This change
> >
> >   extends the sleep-average calculation to the period of time a task
> >   spends on the runqueue but doesnt get scheduled yet, right after
> >   wakeup. Note that tasks that were preempted (ie. not woken up) and are
> >   still on the runqueue do not get this benefit. This change closes one
> >   of the last hole in the dynamic priority estimation, it should result
> >   in interactive tasks getting more priority under heavy load. This
> >   change also fixes the test-starve.c testcase from David Mosberger.
>
>Right, it solves test-starve.c, but not irman2.c.  With sched-G4, when irman2
>is launched, a kernel compile could take ages, I tried it.  After 3 hours it
>was still with the first file (scripts/fixdep.c), it produced no .o file.
>With the patch at the end a kernel compile takes one hour (with -j1 and -j16)
>versus five minutes when nothing else runs (config: allnoconfig).
>
>The idea in the patch is to keep a list of the tasks on the runqueue, without
>the one currently running, and sorted by insertion date.  Before 
>reinserting an
>interactive task in the active array, we check that no task has waited too
>long on this list.  Davide, does it implement the interactivity throttle 
>you had
>in mind?
>
>It's very similar to EXPIRED_STARVING(), but it has the advantage of 
>considering
>all tasks, not only the expired. It seems that with irman2, tasks don't even
>have the time to expire.

True, irman2 is a very nasty little bugger.

Your method works well here.  With your patch in test1+G4, I can run irman2 
and still have a quite usable system.  It could possibly use a little 
refinement though.  If xmms happens to run out of slice at a time when you 
determine that starvation is in progress, it'll nail the innocent xmms (or 
other very light task).

I went a different route in tackling irman2 to avoid the pain of expiring X 
(glitch), but really there's no difference between X and xmms... they 
should both be run RR if you want 100% glitch free operation (and thus 
would be exempted from punishment under your method, and mine as well)

         -Mike 

