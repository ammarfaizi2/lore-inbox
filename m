Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264257AbUDSDeX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 23:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264273AbUDSDeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 23:34:23 -0400
Received: from smtp107.mail.sc5.yahoo.com ([66.163.169.227]:25497 "HELO
	smtp107.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264257AbUDSDeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 23:34:21 -0400
Message-ID: <408348B6.7020606@yahoo.com.au>
Date: Mon, 19 Apr 2004 13:34:14 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: vatsa@in.ibm.com
CC: rusty@au1.ibm.com, Ingo Molnar <mingo@elte.hu>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, lhcs-devel@lists.sourceforge.net
Subject: Re: CPU Hotplug broken -mm5 onwards
References: <20040418170613.GA21769@in.ibm.com>
In-Reply-To: <20040418170613.GA21769@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri wrote:
> Hi,
> 	I found that I can't boot with CONFIG_HOTPLUG_CPU defined in both
> mm5 and mm6. Debugging this revealed it to be because exec path can now require 
> cpu hotplug sem (sched_migrate_task) and this has lead to a deadlock between 
> flush_workqueue and __call_usermodehelper. 
> 
> flush_workqueue takes cpu hotplug sem and blocks until workqueue is flushed.
> __call_usermodehelper, one of the queued work function, blocks because it
> also needs cpu hotplug sem during exec.  As of result of this, exec does not 
> progress and system does not boot.
> 
> I feel we can fix this by converting cpucontrol to a reader-writer semaphore or 
> big-reader-lock(?). One problem with reader-writer semaphore is there does not
> seem to be any down_write_interruptible, which is needed by cpu_down/up.
> 
> Comments?
> 

You are right, but it wasn't introduced in -mm or sched-domains
patches. However, one of Ingo's recent patches does balance on
exec for SMP, not just NUMA so it will make this more common.

So, Rusty has to fix it ;)

I think a rwsem might be a good idea anyway, because
sched_migrate_task can end up being called pretty often with
balance on exec and balance on clone. The semaphore could easily
place undue serialisation on that path.

> BTW, I think a cpu_is_offline check is needed in sched_migrate_task, since
> dest_cpu could have been downed by the time it has acquired the semaphore. 
> In which case, we could end up adding the task to dead cpu's runqueue?
> An alternate solution would be to put the same check in __migrate_task.
> 

Yes you are correct.

Can we arrange some of these checks to disappear when HOTPLUG_CPU
is not set? For example, make cpu_is_offline only valid to call for
CPUs that have been online sometime, and can evaluate to 0 if
HOTPLUG_CPU is not set?
