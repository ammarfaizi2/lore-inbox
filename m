Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264815AbUGGC3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264815AbUGGC3l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 22:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264850AbUGGC3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 22:29:41 -0400
Received: from smtp107.mail.sc5.yahoo.com ([66.163.169.227]:47221 "HELO
	smtp107.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264815AbUGGC3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 22:29:39 -0400
Message-ID: <40EB600C.8020603@yahoo.com.au>
Date: Wed, 07 Jul 2004 12:29:32 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: William Lee Irwin III <wli@holomorphy.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-mm6
References: <20040705023120.34f7772b.akpm@osdl.org>	<20040706125438.GS21066@holomorphy.com>	<20040706233618.GW21066@holomorphy.com> <20040706170247.5bca760c.davem@redhat.com>
In-Reply-To: <20040706170247.5bca760c.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> On Tue, 6 Jul 2004 16:36:18 -0700
> William Lee Irwin III <wli@holomorphy.com> wrote:
> 
> 
>>I have it isolated down to the sched-clean-init-idle.patch and
>>sched-clean-fork.patch. sched-clean-init-idle.patch fails to build without
>>the second of those two applied, so I didn't do any work to narrow it down
>>further.
> 
> 
> One thing to note is that we don't currently call the
> wake_up_forked_process() thing in our SMP idle bootup
> dispatcher in arch/sparc64/kernel/smp.c
> 
> Perhaps that is somehow related to the problems.
> In that case the culprit would be the first patch,
> sched-clean-init-idle.patch
> 

Yes, I missed sparc64 due to the lack of wake_up_forked_process. Dang.

Well, what used to happen is that wake_up_forked_process would put the
idle task on the runqueue like a regular process, then init_idle would
take it off again.

However after the patch, init_idle simply does all the work itself,
and doesn't have to deal with removal from the runqueue. Now sparc64
uses "kernel_thread" to clone its idle tasks, which *does* put the
process onto the runqueue. init_idle then also makes it the idle task.
This is probably why it blows up.

I guess another small function to remove the task from the runqueue
before calling init_idle for those arches that want it would be the
way to go.

Sorry, this is my fault. Got to run now, but I'll send a patch to try
in a few hours if someone hasn't already.
