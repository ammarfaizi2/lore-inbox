Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261647AbVBXCKf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261647AbVBXCKf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 21:10:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261759AbVBXCJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 21:09:37 -0500
Received: from mx1.redhat.com ([66.187.233.31]:2512 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261647AbVBXCHI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 21:07:08 -0500
Date: Wed, 23 Feb 2005 18:07:02 -0800
Message-Id: <200502240207.j1O272Yx010694@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Jeremy Fitzhardinge <jeremy@goop.org>
X-Fcc: ~/Mail/linus
Cc: Chris Wright <chrisw@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] show RLIMIT_SIGPENDING usage in /proc/PID/status
In-Reply-To: Jeremy Fitzhardinge's message of  Wednesday, 23 February 2005 15:09:51 -0800 <421D0D3F.40902@goop.org>
X-Zippy-Says: ..  he dominates the DECADENT SUBWAY SCENE.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy mentioned the aggravation of not being able to tell when your
processes are using up signal queue entries and hitting the
RLIMIT_SIGPENDING limit.  This patch adds a line to /proc/PID/status
showing how many queue items are in use, and allowed, for your uid.

I can certainly see the appeal of having a display of the number of queued
items specific to each process, and even the items within the process
broken down per signal number.  However, those are not things that are
directly counted, and ascertaining them requires iterating through the
queue.  This patch instead gives what can be readily determined in constant
time using the accounting already done.  I'm not sure something more
complex is warranted just to facilitate one particular debugging need.
With this, you can see quickly that this particular problem has come up.
Then examination of each process's SigPnd/ShdPnd lines ought to give you an
indication of which processes have any queued RT signals sitting around for
a long time, and you can then attack those programs directly, though there
is no way after the fact to determine how many queued signals with the same
number a given process has (short of killing it and seeing the usage drop).

Note you may still have a mystery if the leaking programs are not leaving
pending RT signals queued, but rather preallocating queue items via
timer_create.  That usage is not readily apparent in any /proc information.


Signed-off-by: Roland McGrath <roland@redhat.com>

--- linux-2.6/fs/proc/array.c
+++ linux-2.6/fs/proc/array.c
@@ -239,6 +239,7 @@ static inline char * task_sig(struct tas
 {
 	sigset_t pending, shpending, blocked, ignored, caught;
 	int num_threads = 0;
+	unsigned long qsize = 0, qlim = 0;
 
 	sigemptyset(&pending);
 	sigemptyset(&shpending);
@@ -255,11 +256,14 @@ static inline char * task_sig(struct tas
 		blocked = p->blocked;
 		collect_sigign_sigcatch(p, &ignored, &caught);
 		num_threads = atomic_read(&p->signal->count);
+		qsize = atomic_read(&p->user->sigpending);
+		qlim = p->signal->rlim[RLIMIT_SIGPENDING].rlim_cur;
 		spin_unlock_irq(&p->sighand->siglock);
 	}
 	read_unlock(&tasklist_lock);
 
 	buffer += sprintf(buffer, "Threads:\t%d\n", num_threads);
+	buffer += sprintf(buffer, "SigQ:\t%lu/%lu\n", qsize, qlim);
 
 	/* render them all */
 	buffer = render_sigset_t("SigPnd:\t", &pending, buffer);
