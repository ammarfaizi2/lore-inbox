Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262510AbVHDTDB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262510AbVHDTDB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 15:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262627AbVHDTDB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 15:03:01 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:52609 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262510AbVHDTCv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 15:02:51 -0400
Date: Thu, 4 Aug 2005 12:00:24 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Roman Zippel <zippel@linux-m68k.org>, arjan@infradead.org,
       domen@coderock.org, linux-kernel@vger.kernel.org, clucas@rotomalug.org
Subject: [PATCH] add schedule_timeout_{,un}intr() interfaces
Message-ID: <20050804190023.GA4411@us.ibm.com>
References: <Pine.LNX.4.61.0507231911540.3743@scrub.home> <20050723191004.GB4345@us.ibm.com> <Pine.LNX.4.61.0507232151150.3743@scrub.home> <20050727222914.GB3291@us.ibm.com> <Pine.LNX.4.61.0507310046590.3728@scrub.home> <20050801193522.GA24909@us.ibm.com> <Pine.LNX.4.61.0508031419000.3728@scrub.home> <20050804005147.GC4255@us.ibm.com> <Pine.LNX.4.61.0508041123220.3728@scrub.home> <20050804100810.293c9ba6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050804100810.293c9ba6.akpm@osdl.org>
X-Operating-System: Linux 2.6.12 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.08.2005 [10:08:10 -0700], Andrew Morton wrote:
> Roman Zippel <zippel@linux-m68k.org> wrote:
> >
> > Andrew, please drop this patch. 
> 
> Well I was sitting on them with the intention of taking a look later and
> trying to work out what the heck you two have been going on about.

I appreciate that... Good luck figuring out this mess...

> But maybe dropping them means that we'll later get a clear and concise
> description of the problem and its solution, so I'll do that.

I will try and formulate this as well as I can today or tomorrow.

> (This was supposed to be just a simple "consolidate
> set_current_state+schedule_timeout into a single function call" patch. 
> What happened?)

Here's that patch. What happened? I did, to be honest. Trying to fix too
many things at once.

Thanks,
Nish

Description: Add schedule_timeout_{,un}intr() interfaces so that
schedule_timeout() callers don't have to worry about forgetting to add
the set_current_state() call beforehand.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

---

 include/linux/sched.h |    2 ++
 kernel/timer.c        |   14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff -urpN 2.6.13-rc5/include/linux/sched.h 2.6.13-rc5-dev/include/linux/sched.h
--- 2.6.13-rc5/include/linux/sched.h	2005-08-04 11:46:06.000000000 -0700
+++ 2.6.13-rc5-dev/include/linux/sched.h	2005-08-04 11:53:20.000000000 -0700
@@ -183,6 +183,8 @@ extern int in_sched_functions(unsigned l
 
 #define	MAX_SCHEDULE_TIMEOUT	LONG_MAX
 extern signed long FASTCALL(schedule_timeout(signed long timeout));
+extern signed long schedule_timeout_intr(signed long timeout);
+extern signed long schedule_timeout_unintr(signed long timeout);
 asmlinkage void schedule(void);
 
 struct namespace;
diff -urpN 2.6.13-rc5/kernel/timer.c 2.6.13-rc5-dev/kernel/timer.c
--- 2.6.13-rc5/kernel/timer.c	2005-08-04 11:46:06.000000000 -0700
+++ 2.6.13-rc5-dev/kernel/timer.c	2005-08-04 11:52:06.000000000 -0700
@@ -1153,6 +1153,20 @@ fastcall signed long __sched schedule_ti
 
 EXPORT_SYMBOL(schedule_timeout);
 
+signed long __sched schedule_timeout_intr(signed long timeout)
+{
+       set_current_state(TASK_INTERRUPTIBLE);
+       return schedule_timeout(timeout);
+}
+EXPORT_SYMBOL(schedule_timeout_intr);
+
+signed long __sched schedule_timeout_unintr(signed long timeout)
+{
+       set_current_state(TASK_UNINTERRUPTIBLE);
+       return schedule_timeout(timeout);
+}
+EXPORT_SYMBOL(schedule_timeout_unintr);
+
 /* Thread ID - the internal kernel "pid" */
 asmlinkage long sys_gettid(void)
 {
