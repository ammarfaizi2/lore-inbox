Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266724AbUGLHFw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266724AbUGLHFw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 03:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266745AbUGLHFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 03:05:52 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:54481 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S266724AbUGLHFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 03:05:47 -0400
Date: Mon, 12 Jul 2004 03:08:41 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       linux-audio-dev@music.columbia.edu
Subject: Re: [announce] [patch] Voluntary Kernel Preemption Patch
In-Reply-To: <20040711105936.GA13956@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.58.0407120300200.23212@montezuma.fsmlabs.com>
References: <20040709182638.GA11310@elte.hu> <20040710222510.0593f4a4.akpm@osdl.org>
 <20040711093209.GA17095@elte.hu> <20040711024518.7fd508e0.akpm@osdl.org>
 <20040711095039.GA22391@elte.hu> <20040711025855.08afbca1.akpm@osdl.org>
 <20040711103020.GA24797@elte.hu> <20040711034258.796f8c6a.akpm@osdl.org>
 <20040711105936.GA13956@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Jul 2004, Arjan van de Ven wrote:

> On Sun, Jul 11, 2004 at 03:42:58AM -0700, Andrew Morton wrote:
> > > We do not want to enable preempt for Fedora yet because it
> > > breaks just too much stuff
> >
> > What stuff?

Looks like some of the voluntary preemption changes might need some
eyeballing too. This appears to be a use after free, probably since we
unlocked j_{list,state}_lock.

Unable to handle kernel paging request at virtual address d90ccfa0
 printing eip:
c01e667f
*pde = 00066067
Oops: 0000 [#1]
PREEMPT SMP DEBUG_PAGEALLOC
Modules linked in:
CPU:    1
EIP:    0060:[<c01e667f>]    Not tainted
EFLAGS: 00010202   (2.6.7-bk20-ck5)
EIP is at __journal_clean_checkpoint_list+0x3f/0x1d0
eax: 00000001   ebx: 00000000   ecx: df34bdf8   edx: d90ccf78
esi: df34be0c   edi: df34bedc   ebp: de893dac   esp: de893d88
ds: 007b   es: 007b   ss: 0068
Process kjournald (pid: 36, threadinfo=de892000 task=deea8a50)
Stack: de892000 d23fa7e4 00000172 d91a9f78 c7da0f78 d90ccf78 de892000 df34bdf8
       df34be7c de893f50 c01e3956 df34bdf8 c014cc71 dffb1200 c4cccf60 00000046
       de892000 df34bedc df1d1e18 c4cccf60 d8b0efb0 df34be0c 00000000 00000000
Call Trace:
 [<c0107775>] show_stack+0x75/0x90
 [<c01078d5>] show_registers+0x125/0x180
 [<c0107a67>] die+0xa7/0x170
 [<c011ad08>] do_page_fault+0x1e8/0x57d
 [<c01073cd>] error_code+0x2d/0x40
 [<c01e3956>] journal_commit_transaction+0x316/0x1aa0
 [<c01e7994>] kjournald+0x114/0x3b0
 [<c01042a5>] kernel_thread_helper+0x5/0x10
Code: 8b 72 28 85 f6 74 58 8b 4e 2c b8 00 e0 ff ff 89 4d e0 89 f7
 <6>note: kjournald[36] exited with preempt_count 2

(gdb) list *0xc01e667f
0xc01e667f is in __journal_clean_checkpoint_list (fs/jbd/checkpoint.c:485).
480                     struct journal_head *jh;
481
482                     transaction = next_transaction;
483                     next_transaction = transaction->t_cpnext;
484     retry:
485                     jh = transaction->t_checkpoint_list;
486                     if (jh) {
487                             struct journal_head *last_jh = jh->b_cpprev;
488                             struct journal_head *next_jh = jh;
489
