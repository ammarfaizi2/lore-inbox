Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261286AbUKFAca@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261286AbUKFAca (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 19:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261289AbUKFAca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 19:32:30 -0500
Received: from fw.osdl.org ([65.172.181.6]:28649 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261286AbUKFAc0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 19:32:26 -0500
Date: Fri, 5 Nov 2004 16:32:21 -0800
From: Chris Wright <chrisw@osdl.org>
To: levon@movementarian.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, cliffw@osdl.org
Subject: [PATCH][OPROFILE] disable preempt when calling smp_processor_id()
Message-ID: <20041105163221.J14339@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oprofile is hitting many of the below BUG messages.

BUG: using smp_processor_id() in preemptible [00000001] code: sleep/4892
caller is task_exit_notify+0x9/0x17
Call Trace: <ffffffff802ac70f>{smp_processor_id+191}
	    <ffffffff803ff219>{task_exit_notify+9}
	    <ffffffff8014a930>{notifier_call_chain+32}
	    <ffffffff8013d181>{profile_task_exit+49}
	    <ffffffff8013eb22>{do_exit+34}
	    <ffffffff80146490>{process_timeout+0}
	    <ffffffff8013f8c8>{do_group_exit+264}
	    <ffffffff801106b6>{system_call+126}

smp_processor_id() is called w/out preempt disabled.  Use
get_cpu()/put_cpu() instead.  Should this be put_cpu_no_resched()?

Signed-off-by: Chris Wright <chrisw@osdl.org>

--- linux-2.6.10-rc1-mm3-smp_processor_id/drivers/oprofile/buffer_sync.c~orig	2004-11-05 15:21:21.551984200 -0800
+++ linux-2.6.10-rc1-mm3-smp_processor_id/drivers/oprofile/buffer_sync.c	2004-11-05 15:23:29.000000000 -0800
@@ -62,7 +62,8 @@
 	/* To avoid latency problems, we only process the current CPU,
 	 * hoping that most samples for the task are on this CPU
 	 */
-	sync_buffer(smp_processor_id());
+	sync_buffer(get_cpu());
+	put_cpu();
   	return 0;
 }
 
@@ -86,7 +87,8 @@
 		/* To avoid latency problems, we only process the current CPU,
 		 * hoping that most samples for the task are on this CPU
 		 */
-		sync_buffer(smp_processor_id());
+		sync_buffer(get_cpu());
+		put_cpu();
 		return 0;
 	}
 
