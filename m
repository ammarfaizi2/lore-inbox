Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266052AbUBCTxI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 14:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266085AbUBCTxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 14:53:08 -0500
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:32015 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S266052AbUBCTxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 14:53:03 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
Date: Tue, 3 Feb 2004 22:29:50 +0300
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: rc3-mm1: oops in keventd_stop_kthread
Message-ID: <20040203192950.GA3249@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Single CPU, SMP kernel, preemption enabled.
I get reproducible oops when starting ALSA services:

Feb  3 22:10:24 localhost sudo:      bor : TTY=pts/1 ; PWD=/home/bor ;
USER=root ; COMMAND=/sbin/service alsa start
Unable to handle kernel paging request at virtual address c14bdab8
printing eip:
c014343c
*pde = 00005063
*pte = 014bd000
Oops: 0000 [#1]
PREEMPT SMP DEBUG_PAGEALLOC
CPU:    0
EIP:    0060:[<c014343c>]    Not tainted VLI
EFLAGS: 00010203
EIP is at keventd_stop_kthread+0x16c/0x270   
eax: c14bda20   ebx: ffffffff   ecx: 00000c5c   edx: cd995f1c
esi: cfeeff08   edi: 00000007   ebp: cfeeff38   esp: cfeefee8
ds: 007b   es: 007b   ss: 0068
Process events/0 (pid: 4, threadinfo=cfeee000 task=cff17a20)
Stack: 0000000f c14bda20 00000000 cfeee000 00000c5c cfeee000 c12b8f60 c1283c00
00000000 00000000 00000000 00000286 00010000 00000000 00000286 c14bda20
cd995efc cfeee000 cd995edc cd995ee0 cfeeffc0 c013ebb6 cd995f1c cfeeff74
Call Trace:
[<c013ebb6>] worker_thread+0x1f6/0x340
[<c01432d0>] keventd_stop_kthread+0x0/0x270
[<c0124100>] default_wake_function+0x0/0x20
[<c0124100>] default_wake_function+0x0/0x20
[<c0143757>] kthread+0x87/0xa4
[<c013e9c0>] worker_thread+0x0/0x340
[<c01436d0>] kthread+0x0/0xa4
[<c0109005>] kernel_thread_helper+0x5/0x10
Code: ff ff ff ff 89 f1 ba 00 00 00 40 cd 80 8 9 45 c0 83 f8 82 76 0e c7 45 c0 ff ff ff ff f7 d8 a3 d0 0c 3f c0 8b 55 08 8b 4d c0 8b 02 <3b> 88 98 00 00 00 75 bd 0f b6 45 d1 8d 5d d4 f7 d8 89 42 04 89


then it deadlocks in modprobe:

modprobe      D C14AED88  3163   3142 (NOTLB)
cd995e68 00200086 00000002 c14aed88 c14c7a20 00000000 00000000 c1283c00
00000001 00000001 cd994000 00000000 c1283c00 00000000 9fcd99c0 000f4223
c14c7a20 c14c7a20 c14c7bf0 00000000 cd995eb8 00200086 cd995f24 cd995f28
Call Trace:
[<c01253e0>] wait_for_completion+0xe0/0x220
[<c0124100>] default_wake_function+0x0/0x20
[<c0124100>] default_wake_function+0x0/0x20
[<c0122cca>] preempt_schedule+0x2a/0x50
[<c01432c5>] kthread_stop+0x75/0x80
[<c01432d0>] keventd_stop_kthread+0x0/0x270
[<c0148cce>] sys_delete_module+0x21e/0x230
[<c0163ff9>] sys_munmap+0x59/0x80
[<c02fc03a>] sysenter_past_esp+0x43/0x65


