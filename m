Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbUDSWz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbUDSWz3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 18:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbUDSWz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 18:55:29 -0400
Received: from smtp105.mail.sc5.yahoo.com ([66.163.169.225]:2481 "HELO
	smtp105.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261156AbUDSWz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 18:55:27 -0400
Message-ID: <408458D5.5030208@yahoo.com.au>
Date: Tue, 20 Apr 2004 08:55:17 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: vatsa@in.ibm.com
CC: rusty@au1.ibm.com, Ingo Molnar <mingo@elte.hu>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, lhcs-devel@lists.sourceforge.net
Subject: Re: [lhcs-devel] Re: CPU Hotplug broken -mm5 onwards
References: <20040418170613.GA21769@in.ibm.com> <408348B6.7020606@yahoo.com.au> <20040419125853.GB6835@in.ibm.com>
In-Reply-To: <20040419125853.GB6835@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri wrote:
> On Mon, Apr 19, 2004 at 01:34:14PM +1000, Nick Piggin wrote:
> 
>>I think a rwsem might be a good idea anyway, because
>>sched_migrate_task can end up being called pretty often with
>>balance on exec and balance on clone. The semaphore could easily
>>place undue serialisation on that path.
> 
> 
> I found that r/w sem does not help here ..It can still lead to deadlocks.
> One example I hit is :
> 
> cpu_up takes write lock, sends out CPU_UP_PREPARE notification. As part
> of it, many do kthread_create, which uses workqueue. The work function
> is never processed because keventd would be blocked on a previous 
> work function, waiting for hotplug sem in exec path.
> 
> So, as Rusty said, I think we really need to consider removing
> lock_cpu_hotplug from sched_migrate_task. AFAICS that lock
> was needed to prevent adding tasks to dead cpus. The same 
> can be accomplished by removing lock_cpu_hotplug from sched_migrate_task
> and adding a cpu_is_offline check in __migrate_task.
> This will eliminate all the deadlocks I have been hitting.
> 

Yes this would be a better idea. Care to send Andrew a patch
against -mm?

> 
> 
>>Can we arrange some of these checks to disappear when HOTPLUG_CPU
>>is not set? For example, make cpu_is_offline only valid to call for
>>CPUs that have been online sometime, and can evaluate to 0 if
>>HOTPLUG_CPU is not set?
> 
> 
> I think this is already being done in include/linux/cpu.h
> 

Yes I see. I didn't realise the first one was under an ifdef :P
Sorry.
