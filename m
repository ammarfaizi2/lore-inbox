Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264085AbUFKPwF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264085AbUFKPwF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 11:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264096AbUFKPwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 11:52:04 -0400
Received: from gate.crashing.org ([63.228.1.57]:18097 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S264085AbUFKPwC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 11:52:02 -0400
Subject: Re: [PATCH][RFC] Spinlock-timeout
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jake Moilanen <moilanen@austin.ibm.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>,
       Jan-Benedict Glaw <jbglaw@lug-owl.de>
In-Reply-To: <1086962704.3476.53.camel@dyn95394175.austin.ibm.com>
References: <1086467486.20906.59.camel@dhcp-client215.upt.austin.ibm.com>
	 <1086560618.10538.32.camel@gaston>
	 <1086962704.3476.53.camel@dyn95394175.austin.ibm.com>
Content-Type: text/plain
Message-Id: <1086968975.1885.11.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 11 Jun 2004 10:49:36 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Here's a revision to the patch that uses a HAVE_ARCH_GET_TB to allow
> archs use their timebases if they have one, and if they don't, it uses
> jiffies.  time_after_eq() is used to do the jiffy checking.
> 
> I also left all of the arch/*/Kconfig changes in until a debug Kconfig
> is done.  I pretty much added in the spinlock timeout on all archs that
> have CONFIG_DEBUG_SPINLOCK.  If I missed your arch, I'm sorry.    

Nah, that's not how the abstraction should be done. Much simpler in
fact. Just do something like this in the generic code:

#ifndef ARCH_HAS_SPINLOCK_TIMEOUT
#define get_spinlock_timeout() (jiffies + (SPINLOCK_TIMEOUT * HZ))
#define check_spinlock_timeout(timeout) (time_after_eq(jiffies, timeout))
#endif

That's all. Then, any arch who has it's own implementation of these 2
function will #define ARCH_HAS_SPINLOCK_TIMEOUT and implement them the
way it wants. We shouldn't let anything like get_tb() slip into a common
file, it's totally PPC specific. Other archs may have different counters
they can use to impement the same thing. That part should be entirely
self contained in asm-xxx

Ben.


