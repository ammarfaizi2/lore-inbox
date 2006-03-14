Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751846AbWCNIOa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751846AbWCNIOa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 03:14:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751854AbWCNIOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 03:14:30 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:52951 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751846AbWCNIO3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 03:14:29 -0500
Date: Tue, 14 Mar 2006 09:12:12 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.16-rc6-rt1
Message-ID: <20060314081212.GD13662@elte.hu>
References: <Pine.LNX.4.44L0.0603131130460.25211-100000@lifa01.phys.au.dk> <Pine.LNX.4.44L0.0603140037000.1291-100000@lifa01.phys.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0603140037000.1291-100000@lifa01.phys.au.dk>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Esben Nielsen <simlo@phys.au.dk> wrote:

> Well, I got my TestRTMutex compiled and it was successfull: It found 
> bugs.

great!

I forgot to announce Thomas' great new rt-tester framework, which allows 
easy testing of the kernel's PI implementation, via userspace scripts.
You can enable it via CONFIG_RT_MUTEX_TESTER, and the userspace scripts
are at:

 http://people.redhat.com/mingo/realtime-preempt/testing/rt-tester.tar.bz2

Thomas' testing method has the advantage that it utilizes the kernel's 
PI mechanism directly, hence it is easy to keep it uptodate without 
having to port the kernel's PI code to userspace. We should add the 
testcases for the bugs you just found.

> 1) Boosting nested locks simply doesn't work:

> This is easily fixed by

thanks, applied. [NOTE: had to apply it by hand because the patch was 
whitespace damaged, it had all tabs converted to spaces.]

> 2) There is a spinlock deadlock when doing the following test on SMP:
> 
> threads:   1            2
>          lock 1         +
>           +          lock 2
> test:   lockcount 1   lockcount 1
> 
>          lock 2      lock 1            <- spin deadlocks here
>           -             -
> test:   lockcount 1   lockcount 1
> 
> This happens because both tasks tries to lock both tasks's pi_lock but 
> in opposit order.  I don't have fix for that one yet.

well, this is a circular dependency deadlock - which is illegal in the 
kernel, and which we detect for futex locks too - so it shouldnt happen.  
Or did you see it happen for real?

	Ingo
