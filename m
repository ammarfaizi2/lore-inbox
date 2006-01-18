Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751329AbWARB5I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbWARB5I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 20:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbWARB5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 20:57:07 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:44474 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751329AbWARB5G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 20:57:06 -0500
Date: Tue, 17 Jan 2006 20:56:49 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Fernando Luis Vazquez Cao <fernando@intellilink.co.jp>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, ak@suse.de,
       linux-kernel@vger.kernel.org, fastboot@lists.osdl.org
Subject: Re: [PATCH 0/5] stack overflow safe kdump (2.6.15-i386)
Message-ID: <20060118015649.GE23143@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <1137417795.2256.83.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137417795.2256.83.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2006 at 10:23:15PM +0900, Fernando Luis Vazquez Cao wrote:
> Hi,
> 
> The following set of patches aims at making kdump robust against stack
> overflows. 
> 
> In this new version I tried to incorporate all the ideas received after
> a previous post. However, there is still room for further improvements
> some of which I point out below (see "->"). I would appreciate your
> comments before I start working on them.
> 
> This patch set does the following:
> 
> * Substitute "smp_processor_id" with the stack overflow-safe
> "safe_smp_processor_id" in the reboot path to the second kernel.
> 
> * Use a private 4K stack for the NMI handler (if CONFIG_4KSTACKS
> enabled).
> 
> * On the event of a system crash:
>    - Replace NMI trap vector with "crash_nmi".
>    - Replace NMI handler with "do_crash_nmi".
> 
> List of patches (the last two should be applied in the order of
> appearance):
> 
> [1/5] safe_smp_processor_id: Stack overflow safe implementation of
> smp_processor_id.
> 
> [2/5] use_safe_smp_processor_id: Replace smp_processor_id with
> safe_smp_processor_id in arch/i386/kernel/crash.c.
> 
> [3/5] fault: Take stack overflows into account in do_page_fault.
> 
> [4/5] nmi_vector: In the nmi path, we have the problem that both nmi_enter and
> nmi_exit in do_nmi (see code below) make heavy use of "current" indirectly
> (specially through the kernel preemption code). To avoid this execution path the
> nmi trap handler is substituted with a stack overflow safe replacement.
> 
>    -> Regarding the implementation, I have some doubts:
>       - Should the NMI vector replaced atomically?
>       - Should the NMI watchdog be stopped? Should NMIs be disabled in the crash
>         path of each CPU?
>       This is important because after replacing the nmi handler the NMI
>       watchdog will continue generating interrupts that need to be handled
>       properly. If we can avoid this a kdump-specific nmi vector handler
>       (ENTRY(crash_nmi)) could be safely used.

Can we have something like per cpu flag which will be set if NMI is received
after crash (after replacing the trap vector). If another NMI occurs on 
the same cpu and if flag is set, return and don't process it further.

>       - In ENTRY(crash_nmi) we should only do the checks strictly necessary. That
>         is why I got rid of the sysentry and debug stack checks. Is there any case
>         in which these checks would be desirable in a crash scenario?
> 
> [5/5] nmi_stack: When 4KSTACKS is set use a private 4K stack for the nmi handler so
> that we do not have to worry about stack overflows. Besides, replace
> smp_processor_id with safe_smp_processor_id.
> 
>    -> If we want to be really robust we should also:
>       - [crashing CPU] Switch to a new stack as soon the system crash is detected
>       - [other CPUs] and do not use the stack at all in ENTRY(crash_nmi).
> 
> I am looking forward to your comments and suggestions.
> 
> Regards,
> 
> Fernando
> 
