Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263610AbTIBHzl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 03:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263608AbTIBHzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 03:55:40 -0400
Received: from fw.osdl.org ([65.172.181.6]:3818 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263603AbTIBHzj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 03:55:39 -0400
Date: Tue, 2 Sep 2003 00:55:29 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Tejun Huh <tejun@aratech.co.kr>
cc: Ingo Molnar <mingo@elte.hu>, <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH] Race condition in del_timer_sync (2.5)
In-Reply-To: <20030902075423.GA4640@atj.dyndns.org>
Message-ID: <Pine.LNX.4.44.0309020054080.9731-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 2 Sep 2003, Tejun Huh wrote:
> 
>  I'll submit the patch to Linus soon.

I actually already committed it to my tree, since everybody seems to agree 
on it...

		Linus

----
# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1412  -> 1.1413 
#	      kernel/timer.c	1.66    -> 1.67   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/09/02	torvalds@home.osdl.org	1.1413
# Fix del_timer_sync() SMP memory ordering (from Tejun Huh <tejun@aratech.co.kr>)
# 
# From Tejun's posting:
# >
# > This patch fixes a race between del_timer_sync and recursive timers.
# > Current implementation allows the value of timer->base that is used
# > for timer_pending test to be fetched before finishing running_timer
# > test, so it's possible for a recursive time to be pending after
# > del_timer_sync.  Adding smp_rmb before timer_pending removes the race.
# --------------------------------------------
#
diff -Nru a/kernel/timer.c b/kernel/timer.c
--- a/kernel/timer.c	Tue Sep  2 00:55:15 2003
+++ b/kernel/timer.c	Tue Sep  2 00:55:15 2003
@@ -338,6 +338,7 @@
 			break;
 		}
 	}
+	smp_rmb();
 	if (timer_pending(timer))
 		goto del_again;
 

