Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424392AbWKPT6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424392AbWKPT6N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 14:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424381AbWKPT6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 14:58:13 -0500
Received: from mail.timesys.com ([65.117.135.102]:41905 "EHLO
	postfix.timesys.com") by vger.kernel.org with ESMTP
	id S1424392AbWKPT6M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 14:58:12 -0500
Subject: BUG: cpufreq notification broken
From: Thomas Gleixner <tglx@timesys.com>
Reply-To: tglx@timesys.com
To: Alan Stern <stern@rowland.harvard.edu>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       john stultz <johnstul@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       David Miller <davem@davemloft.net>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>
Content-Type: text/plain
Date: Thu, 16 Nov 2006 21:00:50 +0100
Message-Id: <1163707250.10333.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] cpufreq: make the transition_notifier chain use SRCU
(b4dfdbb3c707474a2254c5b4d7e62be31a4b7da9)

breaks cpu frequency notification users, which register the callback on
core_init level. Interestingly enough the registration survives the
uninitialized head, but the registered user is lost by:

static int __init init_cpufreq_transition_notifier_list(void)
{
	srcu_init_notifier_head(&cpufreq_transition_notifier_list);
	return 0;
}
core_initcall(init_cpufreq_transition_notifier_list);

This affects i386, x86_64 and sparc64 AFAICT, which call
register_notifier early in the arch code.

> The head of the notifier chain needs to be initialized before use;
> this is done by an __init routine at core_initcall time. If this turns
> out not to be a good choice, it can easily be changed.

Hmm, there are no static initializers for srcu and the only way to fix
this up is to move the arch calls to postcore_init.

	tglx


