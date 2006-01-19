Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932548AbWASGIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932548AbWASGIM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 01:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932554AbWASGIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 01:08:12 -0500
Received: from ns.intellilink.co.jp ([61.115.5.249]:15818 "EHLO
	mail.intellilink.co.jp") by vger.kernel.org with ESMTP
	id S932548AbWASGIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 01:08:11 -0500
Subject: Re: [PATCH 0/5] stack overflow safe kdump (2.6.15-i386)
From: Fernando Luis Vazquez Cao <fernando@intellilink.co.jp>
To: vgoyal@in.ibm.com
Cc: linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>,
       ak@suse.de, fastboot@lists.osdl.org
In-Reply-To: <20060118015649.GE23143@in.ibm.com>
References: <1137417795.2256.83.camel@localhost.localdomain>
	 <20060118015649.GE23143@in.ibm.com>
Content-Type: text/plain
Organization: =?UTF-8?Q?NTT=E3=83=87=E3=83=BC=E3=82=BF=E5=85=88=E7=AB=AF=E6=8A=80?=
	=?UTF-8?Q?=E8=A1=93=E6=A0=AA=E5=BC=8F=E4=BC=9A=E7=A4=BE?=
Date: Thu, 19 Jan 2006 15:07:55 +0900
Message-Id: <1137650875.2985.39.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-17 at 20:56 -0500, Vivek Goyal wrote:
> On Mon, Jan 16, 2006 at 10:23:15PM +0900, Fernando Luis Vazquez Cao wrote:
> > Hi,
> > 
> > The following set of patches aims at making kdump robust against stack
> > overflows. 
> > 
> > In this new version I tried to incorporate all the ideas received after
> > a previous post. However, there is still room for further improvements
> > some of which I point out below (see "->"). I would appreciate your
> > comments before I start working on them.
> > 
> > This patch set does the following:
> > 
> > * Substitute "smp_processor_id" with the stack overflow-safe
> > "safe_smp_processor_id" in the reboot path to the second kernel.
> > 
> > * Use a private 4K stack for the NMI handler (if CONFIG_4KSTACKS
> > enabled).
> > 
> > * On the event of a system crash:
> >    - Replace NMI trap vector with "crash_nmi".
> >    - Replace NMI handler with "do_crash_nmi".
> > 
> > List of patches (the last two should be applied in the order of
> > appearance):
> > 
> > [1/5] safe_smp_processor_id: Stack overflow safe implementation of
> > smp_processor_id.
> > 
> > [2/5] use_safe_smp_processor_id: Replace smp_processor_id with
> > safe_smp_processor_id in arch/i386/kernel/crash.c.
> > 
> > [3/5] fault: Take stack overflows into account in do_page_fault.
> > 
> > [4/5] nmi_vector: In the nmi path, we have the problem that both nmi_enter and
> > nmi_exit in do_nmi (see code below) make heavy use of "current" indirectly
> > (specially through the kernel preemption code). To avoid this execution path the
> > nmi trap handler is substituted with a stack overflow safe replacement.
> > 
> >    -> Regarding the implementation, I have some doubts:
> >       - Should the NMI vector replaced atomically?
> >       - Should the NMI watchdog be stopped? Should NMIs be disabled in the crash
> >         path of each CPU?
> >       This is important because after replacing the nmi handler the NMI
> >       watchdog will continue generating interrupts that need to be handled
> >       properly. If we can avoid this a kdump-specific nmi vector handler
> >       (ENTRY(crash_nmi)) could be safely used.
> 
> Can we have something like per cpu flag which will be set if NMI is received
> after crash (after replacing the trap vector). If another NMI occurs on 
> the same cpu and if flag is set, return and don't process it further.
The problem is that when one CPU crashes in a SMP system and the NMI
watchdog is enabled, the others will continue receiving NMI from the
watchdog and will eventually also receive the NMI from the crashing CPU.
The NMI handler has to be able to process both adequately if we cannot
stop the NMI watchdog atomically. Even if we used such a flag we would
need to figure out the originator of the NMI.

Regards,

Fernando

