Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263502AbTHWFYm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 01:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263496AbTHWFYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 01:24:42 -0400
Received: from ns.aratech.co.kr ([61.34.11.200]:17294 "EHLO ns.aratech.co.kr")
	by vger.kernel.org with ESMTP id S263502AbTHWFYk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 01:24:40 -0400
Date: Sat, 23 Aug 2003 14:26:34 +0900
From: TeJun Huh <tejun@aratech.co.kr>
To: linux-kernel@vger.kernel.org
Subject: Re: Race condition in 2.4 tasklet handling (cli() broken?)
Message-ID: <20030823052633.GA4307@atj.dyndns.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030823025448.GA32547@atj.dyndns.org> <20030823040931.GA3872@atj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030823040931.GA3872@atj.dyndns.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Oops, Sorry.  Only bh handling is relevant.  Softirq and tasklet are
not of concern to cli().

On Sat, Aug 23, 2003 at 01:09:31PM +0900, TeJun Huh wrote:
>  Additional suspicious things.
> 
> 1. tasklet_kill() has similar race condition.  mb() required before
> tasklet_unlock_wait().

Corrected 2.

 global_bh_lock test inside wait_on_irq() suggests that cli() tries to
block not only interrupt handling but also bh handlings of all cpus;
however, current implementation does not guarantee that.

 Because global_bh_lock is acquired in bh_action() <call trace:
handle_IRQ_event()->do_softirq()->tasklet_action()->bh_action()> after
decrementing local_irq_count(), other cpus may happily begin bh
handling while a cpu is still inside cli() - sti() critical section.

 If bh hanlding is not guaranteed to be blocked during cli() - sti()
critical section, global_bh_lock test inside wait_on_irq() is
redundant and if it should be guaranteed, current implmentation seems
broken.

-- 
tejun
