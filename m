Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262508AbVDLSHt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262508AbVDLSHt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 14:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262202AbVDLKc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 06:32:29 -0400
Received: from fire.osdl.org ([65.172.181.4]:61639 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262112AbVDLKbC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:31:02 -0400
Message-Id: <200504121030.j3CAUslx005175@shell0.pdx.osdl.net>
Subject: [patch 016/198] oom-killer disable for iscsi/lvm2/multipath userland critical sections
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, andrea@suse.de
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:30:48 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Andrea Arcangeli <andrea@suse.de>

iscsi/lvm2/multipath needs guaranteed protection from the oom-killer, so
make the magical value of -17 in /proc/<pid>/oom_adj defeat the oom-killer
altogether.

(akpm: we still need to document oom_adj and friends in
Documentation/filesystems/proc.txt!)

Signed-off-by: Andrea Arcangeli <andrea@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/fs/proc/base.c     |    2 +-
 25-akpm/include/linux/mm.h |    3 +++
 25-akpm/mm/oom_kill.c      |    2 +-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff -puN fs/proc/base.c~oom-killer-disable-for-iscsi-lvm2-multipath-userland-critical-sections fs/proc/base.c
--- 25/fs/proc/base.c~oom-killer-disable-for-iscsi-lvm2-multipath-userland-critical-sections	2005-04-12 03:21:07.242035944 -0700
+++ 25-akpm/fs/proc/base.c	2005-04-12 03:21:07.249034880 -0700
@@ -751,7 +751,7 @@ static ssize_t oom_adjust_write(struct f
 	if (copy_from_user(buffer, buf, count))
 		return -EFAULT;
 	oom_adjust = simple_strtol(buffer, &end, 0);
-	if (oom_adjust < -16 || oom_adjust > 15)
+	if ((oom_adjust < -16 || oom_adjust > 15) && oom_adjust != OOM_DISABLE)
 		return -EINVAL;
 	if (*end == '\n')
 		end++;
diff -puN include/linux/mm.h~oom-killer-disable-for-iscsi-lvm2-multipath-userland-critical-sections include/linux/mm.h
--- 25/include/linux/mm.h~oom-killer-disable-for-iscsi-lvm2-multipath-userland-critical-sections	2005-04-12 03:21:07.243035792 -0700
+++ 25-akpm/include/linux/mm.h	2005-04-12 03:21:07.250034728 -0700
@@ -857,5 +857,8 @@ int in_gate_area_no_task(unsigned long a
 #define in_gate_area(task, addr) ({(void)task; in_gate_area_no_task(addr);})
 #endif	/* __HAVE_ARCH_GATE_AREA */
 
+/* /proc/<pid>/oom_adj set to -17 protects from the oom-killer */
+#define OOM_DISABLE -17
+
 #endif /* __KERNEL__ */
 #endif /* _LINUX_MM_H */
diff -puN mm/oom_kill.c~oom-killer-disable-for-iscsi-lvm2-multipath-userland-critical-sections mm/oom_kill.c
--- 25/mm/oom_kill.c~oom-killer-disable-for-iscsi-lvm2-multipath-userland-critical-sections	2005-04-12 03:21:07.245035488 -0700
+++ 25-akpm/mm/oom_kill.c	2005-04-12 03:21:07.251034576 -0700
@@ -145,7 +145,7 @@ static struct task_struct * select_bad_p
 	do_posix_clock_monotonic_gettime(&uptime);
 	do_each_thread(g, p)
 		/* skip the init task with pid == 1 */
-		if (p->pid > 1) {
+		if (p->pid > 1 && p->oomkilladj != OOM_DISABLE) {
 			unsigned long points;
 
 			/*
_
