Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267368AbUIARg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267368AbUIARg2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 13:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267377AbUIARdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 13:33:24 -0400
Received: from holomorphy.com ([207.189.100.168]:61126 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266730AbUIARc1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 13:32:27 -0400
Date: Wed, 1 Sep 2004 10:32:18 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Kirill Korotaev <kksx@mail.ru>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [4/7] fix loop termination condition in do_each_task_pid()/while_each_task_pid()
Message-ID: <20040901173218.GH5492@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Kirill Korotaev <kksx@mail.ru>, akpm@osdl.org, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <E1C2TZ1-000JZr-00.kksx-mail-ru@f7.mail.ru> <20040901153624.GA5492@holomorphy.com> <20040901165808.GD5492@holomorphy.com> <20040901172710.GE5492@holomorphy.com> <20040901172839.GF5492@holomorphy.com> <20040901173027.GG5492@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040901173027.GG5492@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2004 at 10:30:27AM -0700, William Lee Irwin III wrote:
> Macros must parenthesize their arguments when they appear as
> expressions not surrounded by other bracketing symbols. This patch
> parenthesizes the task argument to do_each_task_pid() and
> while_each_task_pid() where needed. This kind of iteration macro
> doesn't need multiple evaluation fixes.

Now that the basic syntactic issues with the macros have been dealt
with, the semantic issue of properly terminating the list iteration
remains. The following patch introduces a local variable __list__ in
do_each_task_pid() to store the virtual address of the list head of the
leader of the collision chain so that the iteration may be properly
terminated.


Index: kirill-2.6.9-rc1-mm2/include/linux/pid.h
===================================================================
--- kirill-2.6.9-rc1-mm2.orig/include/linux/pid.h	2004-09-01 09:07:48.266432168 -0700
+++ kirill-2.6.9-rc1-mm2/include/linux/pid.h	2004-09-01 09:12:08.394886632 -0700
@@ -42,7 +42,9 @@
 
 #define do_each_task_pid(who, type, task)				\
 do {									\
+	struct list_head *__list__;					\
 	if ((task = find_task_by_pid_type(type, who))) {		\
+		__list__ = &(task)->pids[type].pid_list;		\
 		prefetch((task)->pids[type].pid_list.next);		\
 		do {
 
@@ -50,7 +52,7 @@
 			task = pid_task((task)->pids[type].pid_list.next,\
 						type);			\
 			prefetch((task)->pids[type].pid_list.next);	\
-		} while ((task)->pids[type].hash_list.next);		\
+		} while ((task)->pids[type].pid_list.next != __list__);	\
 	}								\
 } while (0)
 
