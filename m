Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261168AbVCAA6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbVCAA6P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 19:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261157AbVCAA4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 19:56:45 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:2257 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261168AbVCAAzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 19:55:54 -0500
From: kernel-stuff@comcast.net (Parag Warudkar)
To: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2.6.11-rc4] oom_kill.c: Kill obvious processes first
Date: Tue, 01 Mar 2005 00:55:52 +0000
Message-Id: <030120050055.16865.4223BD980005FDFD000041E1220700320100009A9B9CD3040A029D0A05@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Dec 17 2004)
X-Authenticated-Sender: a2VybmVsLXN0dWZmQGNvbWNhc3QubmV0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One person pointed out (rightly so) that this patch might end up killing a Oracle process for example since it occupies more than 60% memory - which is not good. While that may be case for a server, I think for a desktop this patch is right - it allows the user to gain control on the machine which has gone OOM.

> Thank you for the patch, I'm in agreement with the idea, and I'll give 
> it a try after I look at the code a bit. The current code frequently 
> seems bit... non-deterministic.
> 
> -- 
>     -bill davidsen (davidsen@tmr.com)
> "The secret to procrastination is to put things off until the
>   last possible moment - but no longer"  -me

I think oom_kill.c needs more intelligence and customizability. It should evaluate the per process rate of memory allocation for example. With that, it can determine if a process has had a steady VM size and give it less badness since there is a good possibility that some other process(es) might have gone bad  doing fork bombs or leaking memory. In short less badness for processes behaving well for a long time and not taking all the memory and not asking for more.

OTOH we need more configurability - Desktop settings might depict A)Dont kill X B) Don't kill KDE for example. Then OOM killer then can spare those processes to see if killing other processes is going to benefit. (If X / KDE went bad and gobbled up memory, may be it might still kill it - again rate of allocation matters.) Server admins might specify no killing of a database process until unless it is occupying all memory etc..


Parag


> Parag Warudkar wrote:
> > oom_kill.c misses very obvious targets - For example, a process occupying > 
> > 80% memory, not superuser and not having hardware access gets ignored by it. 
> > Logically, such a process, if killed , is going to make things return to 
> > normal thereby eliminating the need for oom killer to further scan for more 
> > processes.
> > 
> > This patch calculates the approximate integer percentage of memory occupied by 
> > the process by looking at num_physpages and p->mm->total_vm. If this process 
> > is not super user and doesn't have hardware access, and the percentage of 
> > occupied memory is more than 60%, it immediately selects this process for 
> > killing by returning unusually high points from badness().
> > 
> > Without this patch, when KDevelop running as non root user gobbles up 90% 
> > memory, the OOM killer kills many other irrelevant processes but not KDevelop 
> > And machine never recovers.. (Pls see LKML for my previous message with 
> > subject "2.6.11-rc4 OOM Killer - Kill the Innocent".) 
> > 
> > With this patch OOM killer immediately kills kdevelop and machine recovers.
> 
