Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265055AbUEYTas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265055AbUEYTas (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 15:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265064AbUEYTas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 15:30:48 -0400
Received: from waste.org ([209.173.204.2]:15073 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S265055AbUEYTam (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 15:30:42 -0400
Date: Tue, 25 May 2004 14:30:20 -0500
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: [PATCH] Put irq stacks in .bss.page_aligned section
Message-ID: <20040525193020.GR28735@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that my vmlinux BSS had grown from 17k to 45k between 2.6.5
and 2.6.6. 8k was moving a pair of objects in head.S from the text
section to bss, 8k was the introduction of IRQ stacks, while the
remainder (12k) was page alignment slop, some of it spurious. The
following patch brings BSS down to the expected 33k.


Throw the IRQ stacks into the page aligned section to avoided wasted
BSS space. While we'd expect this to save up to 4k, this saves over
10k of BSS here due to gcc3.3 spuriously aligning other objects in the
vicinity.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: tiny/arch/i386/kernel/irq.c
===================================================================
--- tiny.orig/arch/i386/kernel/irq.c	2004-05-09 14:23:03.000000000 -0500
+++ tiny/arch/i386/kernel/irq.c	2004-05-25 14:20:24.000000000 -0500
@@ -1125,8 +1125,8 @@
 
 
 #ifdef CONFIG_4KSTACKS
-static char softirq_stack[NR_CPUS * THREAD_SIZE]  __attribute__((__aligned__(THREAD_SIZE)));
-static char hardirq_stack[NR_CPUS * THREAD_SIZE]  __attribute__((__aligned__(THREAD_SIZE)));
+static char softirq_stack[NR_CPUS * THREAD_SIZE]  __attribute__((__aligned__(THREAD_SIZE), __section__(".bss.page_aligned")));
+static char hardirq_stack[NR_CPUS * THREAD_SIZE]  __attribute__((__aligned__(THREAD_SIZE), __section__(".bss.page_aligned")));
 
 /*
  * allocate per-cpu stacks for hardirq and for softirq processing


-- 
Mathematics is the supreme nostalgia of our time.
