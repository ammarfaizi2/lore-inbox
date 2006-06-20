Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751400AbWFTQ11@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbWFTQ11 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 12:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbWFTQ11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 12:27:27 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:17839 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751392AbWFTQ1Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 12:27:25 -0400
Date: Tue, 20 Jun 2006 11:27:06 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au
Subject: Re: [PATCH] kthread: convert stop_machine into a kthread
Message-ID: <20060620162706.GB21542@sergelap.austin.ibm.com>
References: <20060615144331.GB16046@sergelap.austin.ibm.com> <20060619201450.3434f72f.akpm@osdl.org> <20060620082745.GA28092@sergelap> <20060620014027.eba58cb7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060620014027.eba58cb7.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andrew Morton (akpm@osdl.org):
> On Tue, 20 Jun 2006 03:27:45 -0500
> "Serge E. Hallyn" <serue@us.ibm.com> wrote:
> 
> > Ah, like so?
> 
> Nope.  kthread_bind() is supposed to be called by the thread creator,
> before the thread is started.
> 
> The documentation for kthread_bind() is irritatingly hidden in the header
> file.

Oh, I see - then it makes more sense that it gets away with being so
much simpler than set_cpus_allowed().

So here's another attempt.  However I'm not sure now whether
the first round of synchronization around stopmachine_thread_ack
is necessary anymore.  If any threads fail, we'll find out from the
kthread_create() return value, right?

Still I'm not sure about that, so first things first:

thanks,
-serge

From: Serge E. Hallyn <serue@us.ibm.com>
Date: Tue, 20 Jun 2006 11:01:08 -0500
Subject: [PATCH] kthread: update stop_machine to use kthread_bind

Update stop_machine to use the more efficient kthread_bind()
before running task in place of set_cpus_allowed() after.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>

---

 kernel/stop_machine.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

e25a88e3d60f3f139f10cc8cd894d87622033a16
diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index 2dd5a48..593d8e4 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -86,7 +86,8 @@ static void stopmachine_set_state(enum s
 
 static int stop_machine(void)
 {
-	int i, ret = 0;
+	int ret = 0;
+	unsigned int i;
 	struct sched_param param = { .sched_priority = MAX_RT_PRIO-1 };
 
 	/* One high-prio thread per cpu.  We'll do this one. */
@@ -100,11 +101,13 @@ static int stop_machine(void)
 		struct task_struct *tsk;
 		if (i == raw_smp_processor_id())
 			continue;
-		tsk = kthread_run(stopmachine, (void *)(long)i, "stopmachine");
+		tsk = kthread_create(stopmachine, NULL, "stopmachine");
 		if (IS_ERR(tsk)) {
 			ret = PTR_ERR(tsk);
 			break;
 		}
+		kthread_bind(tsk, i);
+		wake_up_process(tsk);
 		stopmachine_num_threads++;
 	}
 
-- 
1.3.3

