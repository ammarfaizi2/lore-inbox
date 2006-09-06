Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751790AbWIFXAP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751790AbWIFXAP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 19:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751792AbWIFXAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 19:00:15 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:2218 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751790AbWIFXAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 19:00:13 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Jean Delvare <jdelvare@suse.de>, Andrew Morton <akpm@osdl.org>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [PATCH] proc-readdir-race-fix-take-3-fix-3
References: <20060825182943.697d9d81.kamezawa.hiroyu@jp.fujitsu.com>
	<m1ac5e2woe.fsf_-_@ebiederm.dsl.xmission.com>
	<200609061101.11544.jdelvare@suse.de>
	<200609062312.57774.jdelvare@suse.de> <20060906222556.GA168@oleg>
	<20060906223838.GA198@oleg>
Date: Wed, 06 Sep 2006 16:59:12 -0600
In-Reply-To: <20060906223838.GA198@oleg> (Oleg Nesterov's message of "Thu, 7
	Sep 2006 02:38:38 +0400")
Message-ID: <m1r6yotxdr.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> writes:

> On 09/07, Oleg Nesterov wrote:
>>
>> On 09/06, Jean Delvare wrote:
>> >
>> > On Wednesday 6 September 2006 11:01, Jean Delvare wrote:
>> > > Eric, Kame, thanks a lot for working on this. I'll be giving some good
>> > > testing to this patch today, and will return back to you when I'm done.
>> > 
>> > The original issue is indeed fixed, but there's a problem with the patch. 
>> > When stressing /proc (to verify the bug was fixed), my test machine ended 
>> > up crashing. Here are the 2 traces I found in the logs:
>> > 
>> > Sep  6 12:06:00 arrakis kernel: BUG: warning at 
>> > kernel/fork.c:113/__put_task_struct()
>> > Sep  6 12:06:00 arrakis kernel:  [<c0115f93>] __put_task_struct+0xf3/0x100
>> > Sep  6 12:06:00 arrakis kernel:  [<c019666a>] proc_pid_readdir+0x13a/0x150
>> > Sep  6 12:06:00 arrakis kernel:  [<c01745f0>] vfs_readdir+0x80/0xa0
>> > Sep  6 12:06:00 arrakis kernel:  [<c0174750>] filldir+0x0/0xd0
>> > Sep  6 12:06:00 arrakis kernel:  [<c017488c>] sys_getdents+0x6c/0xb0
>> > Sep  6 12:06:00 arrakis kernel:  [<c0174750>] filldir+0x0/0xd0
>> > Sep  6 12:06:00 arrakis kernel:  [<c0102fb7>] syscall_call+0x7/0xb
>> 
>> If the task found is not a group leader, we go to retry, but
>> the task != NULL.
>> 
>> Now, if find_ge_pid(tgid) returns NULL, we return that wrong
>> task, and it was not get_task_struct()'ed.

Yep.  That would do it.  And of course having written the
code it was very hard for me to step back far enough to see that.

The other two failure modes still don't make sense to me but
they may have been a side effect of this.

And it would have taken a thread being the highest pid in the
system that exits while we are calling filldir to trigger this.
Wow.  That was a good stress test.


Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>

> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>
>
> --- t/fs/proc/base.c~	2006-09-07 02:33:26.000000000 +0400
> +++ t/fs/proc/base.c	2006-09-07 02:34:19.000000000 +0400
> @@ -2149,9 +2149,9 @@ static struct task_struct *next_tgid(uns
>  	struct task_struct *task;
>  	struct pid *pid;
>  
> -	task = NULL;
>  	rcu_read_lock();
>  retry:
> +	task = NULL;
>  	pid = find_ge_pid(tgid);
>  	if (pid) {
>  		tgid = pid->nr + 1;
