Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbWAYGvb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbWAYGvb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 01:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbWAYGvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 01:51:31 -0500
Received: from ns.intellilink.co.jp ([61.115.5.249]:36511 "EHLO
	mail.intellilink.co.jp") by vger.kernel.org with ESMTP
	id S1750714AbWAYGva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 01:51:30 -0500
Subject: [PATCH 0/5] stack overflow safe kdump (2.6.16-rc1-i386)
From: Fernando Luis Vazquez Cao <fernando@intellilink.co.jp>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: akpm@osdl.org, ak@suse.de, vgoyal@in.ibm.com, linux-kernel@vger.kernel.org,
       fastboot@lists.osdl.org
Content-Type: text/plain
Organization: =?UTF-8?Q?NTT=E3=83=87=E3=83=BC=E3=82=BF=E5=85=88=E7=AB=AF=E6=8A=80?=
	=?UTF-8?Q?=E8=A1=93=E6=A0=AA=E5=BC=8F=E4=BC=9A=E7=A4=BE?=
Date: Wed, 25 Jan 2006 15:50:31 +0900
Message-Id: <1138171831.2370.61.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a new posting of the patch-set aiming at making kdump
more robust against stack overflows. This time I have signed off all
the patches and checked that they are not word-wrapped ().

I tried to incorporate all the ideas received after
a previous post. However, there is still room for further improvements
some of which I point out below (see "->"). I would appreciate your
comments before I start working on them.

This patch set does the following:

* Substitute "smp_processor_id" with the stack overflow-safe
"safe_smp_processor_id" in the reboot path to the second kernel.

* Use a private 4K stack for the NMI handler (if CONFIG_4KSTACKS
enabled).

* On the event of a system crash:
   - Replace NMI trap vector with "crash_nmi".
   - Replace NMI handler with "do_crash_nmi".

List of patches (the last two should be applied in the order of
appearance):

[1/5] safe_smp_processor_id: Stack overflow safe implementation of
smp_processor_id.

[2/5] use_safe_smp_processor_id: Replace smp_processor_id with
safe_smp_processor_id in arch/i386/kernel/crash.c.

[3/5] fault: Take stack overflows into account in do_page_fault.

[4/5] nmi_vector: In the nmi path, we have the problem that both nmi_enter and
nmi_exit in do_nmi (see code below) make heavy use of "current" indirectly
(specially through the kernel preemption code). To avoid this execution path the
nmi trap handler is substituted with a stack overflow safe replacement.

   -> Regarding the implementation, I have some doubts:
      - Should the NMI vector replaced atomically?
      - Should the NMI watchdog be stopped? Should NMIs be disabled in the crash
        path of each CPU?
      This is important because after replacing the nmi handler the NMI
      watchdog will continue generating interrupts that need to be handled
      properly. If we can avoid this a kdump-specific nmi vector handler
      (ENTRY(crash_nmi)) could be safely used.
      - In ENTRY(crash_nmi) we should only do the checks strictly necessary. That
        is why I got rid of the sysentry and debug stack checks. Is there any case
        in which these checks would be desirable in a crash scenario?

[5/5] nmi_stack: When 4KSTACKS is set use a private 4K stack for the nmi handler so
that we do not have to worry about stack overflows. Besides, replace
smp_processor_id with safe_smp_processor_id.

   -> If we want to be really robust we should also:
      - [crashing CPU] Switch to a new stack as soon the system crash is detected
      - [other CPUs] and do not use the stack at all in ENTRY(crash_nmi).

I am looking forward to your comments and suggestions.

Regards,

Fernando

