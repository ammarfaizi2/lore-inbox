Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262496AbTHUIcK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 04:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262518AbTHUIcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 04:32:10 -0400
Received: from [61.34.11.200] ([61.34.11.200]:59610 "EHLO ns.aratech.co.kr")
	by vger.kernel.org with ESMTP id S262496AbTHUIcI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 04:32:08 -0400
Date: Thu, 21 Aug 2003 17:33:55 +0900
From: TeJun Huh <tejun@aratech.co.kr>
To: linux-kernel@vger.kernel.org
Subject: Possible race in x86 global_irq_lock handling.
Message-ID: <20030821083355.GA29826@atj.dyndns.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 I've been reading x86 interrupt handling code for a couple of days
and encountered something which I believe is a race condition.  It's
betweewn include/asm-i386/hardirq.h:irq_enter() and
arch/i386/kernel/irq.c:get_irqlock().  Lockless synchronization using
memory ordering seems to be used to achieve global irq locking.

 in get_irqlock()

static inline void irq_enter(int cpu, int irq)
{
	++local_irq_count(cpu);

	while (test_bit(0,&global_irq_lock)) {
		cpu_relax();
	}
}

