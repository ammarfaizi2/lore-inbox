Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262796AbUJ1FwA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262796AbUJ1FwA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 01:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262792AbUJ1Fv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 01:51:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:54234 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262787AbUJ1FuH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 01:50:07 -0400
Date: Wed, 27 Oct 2004 22:48:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] cputime: introduce cputime.
Message-Id: <20041027224805.31f5747b.akpm@osdl.org>
In-Reply-To: <20041027142139.GB3405@mschwid3.boeblingen.de.ibm.com>
References: <20041027142139.GB3405@mschwid3.boeblingen.de.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:
>
> This patch introduces the concept of (virtual) cputime.

I'm not sure that we need virtual cputime when we're only getting two
second uptimes...


Unable to handle kernel NULL pointer dereference at virtual address 00000080
 printing eip:                                                              
c01185f6      
*pde = 00000000
Oops: 0000 [#1]
SMP            
Modules linked in:
CPU:    1         
EIP:    0060:[<c01185f6>]    Not tainted VLI
EFLAGS: 00010002   (2.6.10-rc1-mm2)         
EIP is at account_system_time+0x4e/0x138
eax: 00000000   ebx: 00000001   ecx: 00c7cf60   edx: c058ed00
esi: c120bc60   edi: c19a6a20   ebp: c19a7ecc   esp: c19a7ebc
ds: 007b   es: 007b   ss: 0068                               
Process khelper (pid: 352, threadinfo=c19a7000 task=c19a6a20)
Stack: 00000001 c058e48c 00000000 c120c020 c19a7ef0 c01256ee c19a6a20 00010000 
       00000001 00000004 c058e48c c058e488 c19a7f28 c19a7f28 c0112709 00000000 
       c19a6a20 c19a6a20 c19a6eec 00000160 00000000 00000000 00000000 00000000 
Call Trace:                                                                    
 [<c0106b27>] show_stack+0x7b/0x88
 [<c0106c66>] show_registers+0x112/0x188
 [<c0106e4f>] die+0xe7/0x170            
 [<c011589b>] do_page_fault+0x413/0x57b
 [<c01067a1>] error_code+0x2d/0x38     
 [<c01256ee>] update_process_times+0x36/0xf0
 [<c0112709>] smp_apic_timer_interrupt+0xd1/0xe4
 [<c0106726>] apic_timer_interrupt+0x1a/0x20    
 [<c011e080>] release_task+0xdc/0x138       
 [<c011f234>] exit_notify+0x6fc/0x710
 [<c011f6e6>] do_exit+0x49e/0x4cc    
 [<c012baff>] ____call_usermodehelper+0xb3/0xb4
 [<c010428d>] kernel_thread_helper+0x5/0xc     
Code: c0 01 c8 89 45 fc 8b 45 10 ba 00 ed 58 c0 8b 9f 5c 01 00 00 03 87 60 01 00 00 89 87 60 01 00 00 01 c3 8b 87 7c 



- kernel threads may have null p->signal

- remove some deoptimising inlines

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/kernel/sched.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff -puN kernel/sched.c~cputime-introduce-cputime-fix kernel/sched.c
--- 25/kernel/sched.c~cputime-introduce-cputime-fix	2004-10-27 22:41:31.311696984 -0700
+++ 25-akpm/kernel/sched.c	2004-10-27 22:42:14.757092280 -0700
@@ -2275,7 +2275,7 @@ static inline void account_it_virt(struc
  * @p: the process that the cpu time gets accounted to
  * @cputime: the cpu time spent in user and kernel space since the last update
  */
-static inline void account_it_prof(struct task_struct *p, cputime_t cputime)
+static void account_it_prof(struct task_struct *p, cputime_t cputime)
 {
 	cputime_t it_prof = p->it_prof_value;
 
@@ -2296,7 +2296,7 @@ static inline void account_it_prof(struc
  * @p: the process that the cpu time gets accounted to
  * @cputime: the cpu time spent in user and kernel space since the last update
  */
-static inline void check_rlimit(struct task_struct *p, cputime_t cputime)
+static void check_rlimit(struct task_struct *p, cputime_t cputime)
 {
 	cputime_t total, tmp;
 
@@ -2328,7 +2328,8 @@ void account_user_time(struct task_struc
 	p->utime = cputime_add(p->utime, cputime);
 
 	/* Check for signals (SIGVTALRM, SIGPROF, SIGXCPU & SIGKILL). */
-	check_rlimit(p, cputime);
+	if (likely(p->signal))
+		check_rlimit(p, cputime);
 	account_it_virt(p, cputime);
 	account_it_prof(p, cputime);
 
@@ -2356,7 +2357,8 @@ void account_system_time(struct task_str
 	p->stime = cputime_add(p->stime, cputime);
 
 	/* Check for signals (SIGPROF, SIGXCPU & SIGKILL). */
-	check_rlimit(p, cputime);
+	if (likely(p->signal))
+		check_rlimit(p, cputime);
 	account_it_prof(p, cputime);
 
 	/* Add system time to cpustat. */
_

