Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263640AbUGICpU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263640AbUGICpU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 22:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263664AbUGICpU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 22:45:20 -0400
Received: from smtp017.mail.yahoo.com ([216.136.174.114]:20103 "HELO
	smtp017.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263640AbUGICpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 22:45:10 -0400
Message-ID: <40EE06B1.1090202@yahoo.com.au>
Date: Fri, 09 Jul 2004 12:45:05 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: Ingo Molnar <mingo@elte.hu>, wli@holomorphy.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-mm6
References: <20040705023120.34f7772b.akpm@osdl.org>	<20040706125438.GS21066@holomorphy.com>	<20040706233618.GW21066@holomorphy.com>	<20040706170247.5bca760c.davem@redhat.com>	<20040707073510.GA27609@elte.hu> <20040707140249.2bfe0a4b.davem@redhat.com>
In-Reply-To: <20040707140249.2bfe0a4b.davem@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------080007090004060802080407"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080007090004060802080407
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

David S. Miller wrote:
> On Wed, 7 Jul 2004 09:35:10 +0200
> Ingo Molnar <mingo@elte.hu> wrote:
> 
> 
>>the patch below should solve this. Is it safe on sparc to do a
>>fork_by_hand() like this?
> 
> 
> If the regs are garbage, copy_thread() will explode as it tries
> to interpret the stack pointer in that regs value.
> 
> The parent's regs (stored in current_thread_info() at trap time,
> and also needed by copy_thread() processing) will also be garbage
> since we're avoiding the fork syscall trap.
> 
> In short, this won't work :)
> 
> This is why I use kernel_thread().  Why is that so bad?
> 

We could make CLONE_IDLETASK clones not do the wakeup?

Ingo? I guess an alternative is to have the arch explicitly
make a call to dequeue it.

--------------080007090004060802080407
Content-Type: text/x-patch;
 name="kernelthread-idle-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kernelthread-idle-fix.patch"




---

 linux-2.6-npiggin/kernel/fork.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff -puN kernel/fork.c~kernelthread-idle-fix kernel/fork.c
--- linux-2.6/kernel/fork.c~kernelthread-idle-fix	2004-07-09 12:42:02.000000000 +1000
+++ linux-2.6-npiggin/kernel/fork.c	2004-07-09 12:43:11.000000000 +1000
@@ -1215,11 +1215,13 @@ long do_fork(unsigned long clone_flags,
 			set_tsk_thread_flag(p, TIF_SIGPENDING);
 		}
 
-		if (!(clone_flags & CLONE_STOPPED))
-			wake_up_new_task(p, clone_flags);
-		else
-			p->state = TASK_STOPPED;
-		++total_forks;
+		if (likely(!(clone_flags & CLONE_IDLETASK))) {
+			if (!(clone_flags & CLONE_STOPPED))
+				wake_up_new_task(p, clone_flags);
+			else
+				p->state = TASK_STOPPED;
+			++total_forks;
+		}
 
 		if (unlikely (trace)) {
 			current->ptrace_message = pid;

_

--------------080007090004060802080407--
