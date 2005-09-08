Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751330AbVIHHjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbVIHHjv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 03:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbVIHHju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 03:39:50 -0400
Received: from zproxy.gmail.com ([64.233.162.201]:50510 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751330AbVIHHju (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 03:39:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:subject:date:user-agent:mime-version:content-disposition:to:content-type:content-transfer-encoding:message-id;
        b=tMfxz7wOupuEpq2PYmbEAiPBRAHy1xlBp5AQUkyDYtI5uedY+2Nd6IfQufP1XJ9M5/ZHYIbX/AgXbQ0KG/LaZyyHcbDBjWoaf5AJRWoIuFdX/1NVJfWJMV3UTqzHj64XWJiOHioYs5kZD3Kka5TYET6RQACF4oRjYQNyAf8EAsI=
From: Giancarlo Formicuccia <giancarlo.formicuccia@gmail.com>
Subject: [2.6.13] task_struct->fs_excl, kernel_thread and jffs2
Date: Thu, 8 Sep 2005 09:47:58 +0200
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Disposition: inline
To: linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200509080947.58155.giancarlo.formicuccia@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
[please CC me in any reply]
I'm not sure that dup_task_struct() must copy the fs_excl field. This can leads to
problems if do_fork() is somehow called while fs_excl!=0.
For example, the jffs2 code creates a kernel thread (jffs2_garbage_collect_thread)
in a path where lock_super() is held (i.e. by do_remount_sb, during -o remount,rw).
When the new thread expires, a badness happens (kernel/exit.c:787). This problem
was observed by a couple of people and can be easily reproduced:
http://lists.infradead.org/pipermail/linux-mtd/2005-August/013487.html
http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel/2005-September/031109.html

At first glance, I'd simply set fs_excl to 0 for every new thread in dup_task_struct:

--- linux-2.6.13/kernel/fork.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.13-new/kernel/fork.c	2005-09-07 17:06:23.000000000 +0200
@@ -173,6 +173,7 @@ static struct task_struct *dup_task_stru
 	*tsk = *orig;
 	tsk->thread_info = ti;
 	ti->task = tsk;
+	atomic_set(&tsk->fs_excl, 0);
 
 	/* One for us, one for whoever does the "release_task()" (usually parent) */
 	atomic_set(&tsk->usage,2);

but I've a doubt about the WARN_ON in exit.c being actually here to report these 
kernel_thread() users (like jffs2)...

Any comment/suggestion?

Thanks,

Giancarlo

