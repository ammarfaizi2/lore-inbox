Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264015AbUDQT30 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 15:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264021AbUDQT30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 15:29:26 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:7047 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S264015AbUDQT3X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 15:29:23 -0400
Date: Sat, 17 Apr 2004 21:29:17 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.6-rc1 crashes on exec in multithreaded application
Message-ID: <20040417192917.GA11663@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
   recent controlling terminal changes broke exec from multithreaded application
because de_thread was not upgraded to new arrangement. I know that I should not have
LD_PRELOAD library which automatically creates one thread, but it looked like a
cool solution to the problem I had.

Apr 17 17:42:39 192.168.3.253 Unable to handle kernel paging request virtual address a55a5a5e
Apr 17 17:42:39 192.168.3.253  printing eip:
Apr 17 17:42:39 192.168.3.253 c013d7d1
Apr 17 17:42:39 192.168.3.253 *pde = 00000000
Apr 17 17:42:39 192.168.3.253 Oops: 0000 [#1]
Apr 17 17:42:39 192.168.3.253 CPU:    0
Apr 17 17:42:39 192.168.3.253 EIP:    0060:[<c013d7d1>]    Tainted: P
Apr 17 17:42:39 192.168.3.253 EFLAGS: 00213286   (2.6.6-rc1-c1820)
Apr 17 17:42:39 192.168.3.253 EIP is at do_acct_process+0x125/0x29e
Apr 17 17:42:39 192.168.3.253 eax: 00000000   ebx: d25ba000   ecx: a55a5a5a   edx: 00000000
Apr 17 17:42:39 192.168.3.253 esi: 00000000   edi: 00000000   ebp: d25a3318   esp: d25bbf04
Apr 17 17:42:39 192.168.3.253 ds: 007b   es: 007b   ss: 0068
Apr 17 17:42:39 192.168.3.253 Process vmware-vmx (pid: 2306, threadinfo=d25ba000 task=d25a2d90)
Apr 17 17:42:39 192.168.3.253
Apr 17 17:42:39 192.168.3.253 Call Trace:
Apr 17 17:42:39 192.168.3.253  [<c013da26>] acct_process+0xdc/0x218
Apr 17 17:42:39 192.168.3.253  [<c0120e14>] profile_exit_task+0x38/0x53
Apr 17 17:42:39 192.168.3.253  [<c0122e9d>] do_exit+0x7e/0x871
Apr 17 17:42:39 192.168.3.253  [<c01236bd>] next_thread+0x0/0x1e
Apr 17 17:42:39 192.168.3.253  [<c0104567>] syscall_call+0x7/0xb

Simple program below triggers that oopses:
---
#include <pthread.h>
#include <unistd.h>

void* proc(void* dummy) {
	execl("/bin/echo", "/bin/echo", "It worked?! Surprising...", NULL);
	return 0;
}

int main(void) {
	pthread_t id;

	pthread_create(&id, NULL, proc, NULL);
	sleep(1);
	return 0;
}
---

de_thread must copy controlling terminal from old thread group to new one. I'm not sure whether
posix_timers should be copied/moved, or whether INIT_LIST_HEAD() is sufficient, I have no idea
what standard says.

Please apply.
							Thanks,
								Petr Vandrovec


--- linux-2.6.6-rc1/fs/exec.c	2004-04-17 03:18:44.000000000 +0200
+++ linux-2.6.6-rc1/fs/exec.c	2004-04-17 21:09:53.000000000 +0200
@@ -609,7 +609,9 @@
 		newsig->group_stop_count = 0;
 		newsig->curr_target = NULL;
 		init_sigpending(&newsig->shared_pending);
+		INIT_LIST_HEAD(&newsig->posix_timers);
 
+		newsig->tty = oldsig->tty;
 		newsig->pgrp = oldsig->pgrp;
 		newsig->session = oldsig->session;
 		newsig->leader = oldsig->leader;



