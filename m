Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964865AbWIFWja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964865AbWIFWja (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 18:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964778AbWIFWiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 18:38:54 -0400
Received: from taganka54-host.corbina.net ([213.234.233.54]:57226 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S964787AbWIFWij
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 18:38:39 -0400
Date: Thu, 7 Sep 2006 02:38:38 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Jean Delvare <jdelvare@suse.de>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       linux-kernel@vger.kernel.org, ak@suse.de
Subject: [PATCH] proc-readdir-race-fix-take-3-fix-3
Message-ID: <20060906223838.GA198@oleg>
References: <20060825182943.697d9d81.kamezawa.hiroyu@jp.fujitsu.com> <m1ac5e2woe.fsf_-_@ebiederm.dsl.xmission.com> <200609061101.11544.jdelvare@suse.de> <200609062312.57774.jdelvare@suse.de> <20060906222556.GA168@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060906222556.GA168@oleg>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07, Oleg Nesterov wrote:
>
> On 09/06, Jean Delvare wrote:
> >
> > On Wednesday 6 September 2006 11:01, Jean Delvare wrote:
> > > Eric, Kame, thanks a lot for working on this. I'll be giving some good
> > > testing to this patch today, and will return back to you when I'm done.
> > 
> > The original issue is indeed fixed, but there's a problem with the patch. 
> > When stressing /proc (to verify the bug was fixed), my test machine ended 
> > up crashing. Here are the 2 traces I found in the logs:
> > 
> > Sep  6 12:06:00 arrakis kernel: BUG: warning at 
> > kernel/fork.c:113/__put_task_struct()
> > Sep  6 12:06:00 arrakis kernel:  [<c0115f93>] __put_task_struct+0xf3/0x100
> > Sep  6 12:06:00 arrakis kernel:  [<c019666a>] proc_pid_readdir+0x13a/0x150
> > Sep  6 12:06:00 arrakis kernel:  [<c01745f0>] vfs_readdir+0x80/0xa0
> > Sep  6 12:06:00 arrakis kernel:  [<c0174750>] filldir+0x0/0xd0
> > Sep  6 12:06:00 arrakis kernel:  [<c017488c>] sys_getdents+0x6c/0xb0
> > Sep  6 12:06:00 arrakis kernel:  [<c0174750>] filldir+0x0/0xd0
> > Sep  6 12:06:00 arrakis kernel:  [<c0102fb7>] syscall_call+0x7/0xb
> 
> If the task found is not a group leader, we go to retry, but
> the task != NULL.
> 
> Now, if find_ge_pid(tgid) returns NULL, we return that wrong
> task, and it was not get_task_struct()'ed.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- t/fs/proc/base.c~	2006-09-07 02:33:26.000000000 +0400
+++ t/fs/proc/base.c	2006-09-07 02:34:19.000000000 +0400
@@ -2149,9 +2149,9 @@ static struct task_struct *next_tgid(uns
 	struct task_struct *task;
 	struct pid *pid;
 
-	task = NULL;
 	rcu_read_lock();
 retry:
+	task = NULL;
 	pid = find_ge_pid(tgid);
 	if (pid) {
 		tgid = pid->nr + 1;

