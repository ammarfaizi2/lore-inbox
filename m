Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269474AbUICCdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269474AbUICCdY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 22:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269447AbUICALz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 20:11:55 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:21492 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S269401AbUIBX5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 19:57:50 -0400
Date: Thu, 2 Sep 2004 20:02:12 -0400 (EDT)
From: Zwane Mwaikambo <zwane@fsmlabs.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Matt Mackall <mpm@selenic.com>,
       William Lee Irwin III <wli@holomorphy.com>, Keith Owens <kaos@sgi.com>
Subject: [PATCH][0/8] Arch agnostic completely out of line locks
Message-ID: <Pine.LNX.4.58.0409020905540.4481@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch achieves out of line spinlocks by creating kernel/spinlock.c
and using the _raw_* inline locking functions. Now, as much as this is
supposed to be arch agnostic, there was still a fair amount of rummaging
about in archs, mostly for the cases where the arch already has out of
line locks and i wanted to avoid the extra call, saving that extra call
also makes lock profiling easier. PPC32/64 was an example of such an arch
and i have added the necessary profile_pc() function as an example.

Size differences are with CONFIG_PREEMPT enabled since we wanted to
determine how much could be saved by moving that lot out of line too.

ppc64 = 259897 bytes:
   text    data     bss     dec     hex filename
5489808 1962724  709064 8161596  7c893c vmlinux-after
5749577 1962852  709064 8421493  808075 vmlinux-before

sparc64 = 193368 bytes:
  text    data     bss     dec     hex filename
3472037  633712  308920 4414669  435ccd vmlinux-after
3665285  633832  308920 4608037  465025 vmlinux-before

i386 = 524115 bytes
   text    data     bss     dec     hex filename
5695619  870906  328112 6894637  69342d vmlinux-after
6221254  870634  326864 7418752  713380 vmlinux-before

x86-64 = 282446 bytes
   text    data     bss     dec     hex filename
4598025 1450644  523632 6572301  64490d vmlinux-after
4881679 1449436  523632 6854747  68985b vmlinux-before

It has been compile tested (UP, SMP, PREEMPT) on i386, x86-64, sparc,
sparc64, ppc64, ppc32 and runtime tested on i386 and x86-64. I still have
to get benchmarks done (most probably i386). The patch is currently
against 2.6.9-rc1-mm1 because we'd have to back out the i386/x86_64 out of
line lock patches since this does it in a different way, i can merge later
on.

Thanks,
	Zwane
