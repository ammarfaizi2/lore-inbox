Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283582AbRLIQQO>; Sun, 9 Dec 2001 11:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283586AbRLIQQF>; Sun, 9 Dec 2001 11:16:05 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:44047 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S283582AbRLIQPz>; Sun, 9 Dec 2001 11:15:55 -0500
Subject: Re: Linux 2.4.17-pre5
To: davidel@xmailserver.org (Davide Libenzi)
Date: Sun, 9 Dec 2001 16:24:59 +0000 (GMT)
Cc: rusty@rustcorp.com.au (Rusty Russell), alan@lxorguk.ukuu.org.uk (Alan Cox),
        anton@samba.org, davej@suse.de, marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org (lkml),
        torvalds@transmeta.com (Linus Torvalds)
In-Reply-To: <Pine.LNX.4.40.0112081824210.1019-100000@blue1.dev.mcafeelabs.com> from "Davide Libenzi" at Dec 08, 2001 06:35:28 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16D6l9-00073R-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Using the scheduler i'm working on and setting a trigger load level of 2,
> as soon as the idle is scheduled it'll go to grab the task waiting on the
> other cpu and it'll make it running.

That rapidly gets you thrashing around as I suspect you've found.

I'm currently using the following rule in wake up

	if(current->mm->runnable > 0)	/* One already running ? */
		cpu = current->mm->last_cpu;
	else
		cpu = idle_cpu();
	else
		cpu = cpu_num[fast_fl1(runnable_set)]

that is
	If we are running threads with this mm on a cpu throw them at the
		same core
	If there is an idle CPU use it
	Take the mask of currently executing priority levels, find the last
	set bit (lowest pri) being executed, and look up a cpu running at
	that priority

Then the idle stealing code will do the rest of the balancing, but at least
it converges towards each mm living on one cpu core.

Alan
