Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267345AbUIARc0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267345AbUIARc0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 13:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266730AbUIAR3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 13:29:41 -0400
Received: from holomorphy.com ([207.189.100.168]:58566 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267345AbUIAR2q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 13:28:46 -0400
Date: Wed, 1 Sep 2004 10:28:39 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Kirill Korotaev <kksx@mail.ru>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [2/7] make do_each_task_pid()/while_each_task_pid() require a semicolon following them
Message-ID: <20040901172839.GF5492@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Kirill Korotaev <kksx@mail.ru>, akpm@osdl.org, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <E1C2TZ1-000JZr-00.kksx-mail-ru@f7.mail.ru> <20040901153624.GA5492@holomorphy.com> <20040901165808.GD5492@holomorphy.com> <20040901172710.GE5492@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040901172710.GE5492@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2004 at 10:27:10AM -0700, William Lee Irwin III wrote:
> list_empty(&task->pids[type].hash_list) does not successfully typecheck;
> while this does not correct its semantics, it at least restores
> typechecking long enough for the code to be examined.

do { ... } while () -like constructs require semicolons to follow them.
This patch arranges for do_each_task_pid() { ... } while_each_task_pid()
to do likewise.


Index: kirill-2.6.9-rc1-mm2/include/linux/pid.h
===================================================================
--- kirill-2.6.9-rc1-mm2.orig/include/linux/pid.h	2004-09-01 08:49:14.584737520 -0700
+++ kirill-2.6.9-rc1-mm2/include/linux/pid.h	2004-09-01 09:01:13.653422464 -0700
@@ -41,6 +41,7 @@
 extern void switch_exec_pids(struct task_struct *leader, struct task_struct *thread);
 
 #define do_each_task_pid(who, type, task)				\
+do {									\
 	if ((task = find_task_by_pid_type(type, who))) {		\
 		prefetch(task->pids[type].pid_list.next);		\
 		do {
@@ -49,7 +50,8 @@
 			task = pid_task(task->pids[type].pid_list.next,	\
 						type);			\
 			prefetch(task->pids[type].pid_list.next);	\
-		} while (task->pids[type].hash_list.next);	\
-	}
+		} while (task->pids[type].hash_list.next);		\
+	}								\
+} while (0)
 
 #endif /* _LINUX_PID_H */
