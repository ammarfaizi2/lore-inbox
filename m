Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbTHWEHp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 00:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbTHWEHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 00:07:45 -0400
Received: from ns.aratech.co.kr ([61.34.11.200]:41606 "EHLO ns.aratech.co.kr")
	by vger.kernel.org with ESMTP id S261360AbTHWEHo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 00:07:44 -0400
Date: Sat, 23 Aug 2003 13:09:31 +0900
From: TeJun Huh <tejun@aratech.co.kr>
To: linux-kernel@vger.kernel.org
Subject: Re: Race condition in 2.4 tasklet handling (cli() broken?)
Message-ID: <20030823040931.GA3872@atj.dyndns.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030823025448.GA32547@atj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030823025448.GA32547@atj.dyndns.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Additional suspicious things.

1. tasklet_kill() has similar race condition.  mb() required before
tasklet_unlock_wait().

2. local_bh_count() and global_bh_lock tests inside wait_on_irq()
suggests that cli() tries to block not only interrupt handling but all
softirq handlings of all cpus; however, current implementation does
not guarantee that.

 Because local_bh_count is adjusted in do_softirq() _after_
decrementing local_irq_count(), other cpus may happily begin
softirq/tasklet/bh handling while a cpu is inside cli() - sti()
critical section.

 If softirq handling is not guaranteed to be blocked during cli() -
sti() critical section, local_bh_count() and global_bh_lock tests
inside wait_on_irq() are redundant, and if it should be guranteed,
current implementation seems broken.

-- 
tejun
