Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268816AbUIHAfe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268816AbUIHAfe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 20:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268817AbUIHAfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 20:35:34 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:24303 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S268816AbUIHAfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 20:35:30 -0400
Date: Tue, 7 Sep 2004 20:39:59 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: Oops in __journal_clean_checkpoint_list
Message-ID: <Pine.LNX.4.53.0409072036120.15087@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got this in 2.6.9-rc1-mm3 and never managed to reproduce it again, i 
decided to send it in anyway. Plus i swear i've run into it before 
(lock breaking?) ...

Unable to handle kernel paging request at virtual address 6b6b6b93
 printing eip:
c0262d0b
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP DEBUG_PAGEALLOC
Modules linked in:
CPU:    0
EIP:    0060:[<c0262d0b>]    Not tainted VLI
EFLAGS: 00010202   (2.6.9-rc1-mm3)
EIP is at __journal_clean_checkpoint_list+0x14b/0x1b0
eax: f7518888   ebx: 6b6b6b6b   ecx: 00000000   edx: f6d68000
esi: f6d68000   edi: e3fc4cd0   ebp: f6d69da0   esp: f6d69d78
ds: 007b   es: 007b   ss: 0068
Process kjournald (pid: 798, threadinfo=f6d68000 task=f6d2ba90)
Stack: e3fc4cd0 f6d68000 e3fc4cd0 000000ff f7518914 f6da5888 f7518888 00000000
       f6d68000 00000001 f6d69f4c c025fb31 f6e51df8 f6da5888 00000003 00000d36
       f6d69dc0 f6e51edc f6e51e8c f6d69dc0 00000000 f6da58e0 00000001 f6da794c
Call Trace:
 [<c010852f>] show_stack+0x7f/0xa0
 [<c01086df>] show_registers+0x15f/0x1d0
 [<c0108933>] die+0x123/0x220
 [<c011ef05>] do_page_fault+0x255/0x5f2
 [<c01080a9>] error_code+0x2d/0x38
 [<c025fb31>] journal_commit_transaction+0x3a1/0x1d60
 [<c0264240>] kjournald+0x120/0x3d0
 [<c0105395>] kernel_thread_helper+0x5/0x10
Code: b6 82 e4 00 00 00 84 c0 7f 4c 8b 45 08 c6 80 e4 00 00 00 01 8b 55 dc 8b 42 08 ff 4a 14 a8 08 75 2e 8b 45 f0 8b 58 28 85 db 74 09 <8b> 43 28 8b 55 f0 89 42 28 8b 45 08 8b 40 40 85 c0 89 45 f0 74

(gdb) list *__journal_clean_checkpoint_list+0x14b
0xc0262d0b is in __journal_clean_checkpoint_list (fs/jbd/checkpoint.c:509).
504                              * transaction's buffer list and the checkpoint list to
505                              * try to avoid quadratic behaviour.
506                              */
507                             jh = transaction->t_checkpoint_list;
508                             if (jh)
509                                     transaction->t_checkpoint_list = jh->b_cpnext;
510
511                             transaction = journal->j_checkpoint_transactions;
