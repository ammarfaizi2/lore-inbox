Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266267AbUFPMii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266267AbUFPMii (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 08:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266268AbUFPMii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 08:38:38 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:46224 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S266267AbUFPMiB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 08:38:01 -0400
Date: Wed, 16 Jun 2004 21:39:17 +0900
From: Takao Indoh <indou.takao@soft.fujitsu.com>
Subject: [PATCH 0/4][Diskdump]Update patches
To: linux-kernel@vger.kernel.org
Message-id: <BEC4539EF0098Dindou.takao@soft.fujitsu.com>
MIME-version: 1.0
X-Mailer: TuruKame 3.55
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I fixed diskdump patches except timer problem.

- Fix some codes which Arjan van de Ven pointed out
- Replace dev_t with block_device

Source code of tool(diskdumptuils) can be downloaded from
 http://sourceforge.net/projects/lkdump

Regarding timer problem, please see previous mail I sent.
 http://marc.theaimsgroup.com/?l=linux-kernel&m=108722344204595&w=2
In short, Timer problem is as follows.
> What is a problem?  Scsi driver uses timer/tasklet to complete I/O.
> But, diskdump disables interrupt, so timer/taslket doesn't work!

There are three ways to solve this problem so far.

(1) Redefine timer/taslket routines. This method was adopted in the
    first patch.

+#if defined(CONFIG_DISKDUMP) || defined(CONFIG_DISKDUMP_MODULE)
+#undef  add_timer
+#define add_timer       diskdump_add_timer
+#undef  del_timer_sync
+#define del_timer_sync  diskdump_del_timer
+#undef  del_timer
+#define del_timer       diskdump_del_timer
+#undef  mod_timer
+#define mod_timer       diskdump_mod_timer
+
+#define tasklet_schedule        diskdump_tasklet_schedule
+#endif


(2) Add new code into the timer/taslket routines themselves.

 static inline void add_timer(struct timer_list * timer)
 {
-	__mod_timer(timer, timer->expires);
+	if(crashdump_mode())
+		diskdump_add_timer(timer);
+	else
+		__mod_timer(timer, timer->expires);
 }


 int del_timer_sync(struct timer_list *timer)
 {
 	tvec_base_t *base;
 	int i, ret = 0;

+	if(crashdump_mode()) {
+		diskdump_del_timer(timer);
+		return 0;
+	}
+
 	check_timer(timer);


 int mod_timer(struct timer_list *timer, unsigned long expires)
 {
 	BUG_ON(!timer->function);
 
+	if(crashdump_mode()) {
+		diskdump_mod_timer(timer, expires);
+		return 0;
+	}
+
 	check_timer(timer);


 static inline void tasklet_schedule(struct tasklet_struct *t)
 {
+	if(crashdump_mode()) {
+		diskdump_tasklet_schedule(t);
+		return;
+	}
+
 	if (!test_and_set_bit(TASKLET_STATE_SCHED, &t->state))
 		__tasklet_schedule(t);
 }


(3) Change polling handler of driver not to use timer/tasklet.


The method (1) was already rejected because of its ugliness. The
method (3) needs many extra codes and makes handler of driver too big
and complex. I think the method (2) is the simplest though it make
common codes dirty.

Please feel free to comment.

Best Regards,
Takao Indoh
