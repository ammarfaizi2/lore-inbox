Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264925AbTBLBeX>; Tue, 11 Feb 2003 20:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265094AbTBLBeX>; Tue, 11 Feb 2003 20:34:23 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:31719 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S264925AbTBLBeV>; Tue, 11 Feb 2003 20:34:21 -0500
Date: Tue, 11 Feb 2003 17:35:43 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 350] New: i386 context switch very slow compared to 2.4 due to
 wrmsr (performance) 
Message-ID: <629040000.1045013743@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=350

           Summary: i386 context switch very slow compared to 2.4 due to
                    wrmsr (performance)
    Kernel Version: 2.5.5x (since SYSENTER support went in)
            Status: NEW
          Severity: normal
             Owner: rml@tech9.net
         Submitter: ak@suse.de


Distribution: any
Hardware Environment: especially Intel P4
Software Environment: 
Problem Description:

Since the SYSENTER/vsyscall support went in the 2.5 __switch_to/load_esp0
function does two WRMSRs to rewrite MSR_IA32_SYSENTER_CS and
MSR_IA32_SYSENTER_ESP. This is hidden in processor.h:load_esp0. WRMSR is
very slow (60+ cycles) especially on a Pentium 4 and slows down the context
switch considerably. This is a trade off between faster system calls using
SYSENTER and slower context switches, but the context switches got unduly
hit here.

The reason it rewrites SYSENTER_CS is non obviously vm86 which
doesn't guarantee the MSR stays constant (sigh). I think this would 
be better handled by having a global flag or process flag when any process
uses vm86 and not do it when this flag is not set (as in 99% of all 
normal use cases)

It rewrites SYSENTER_ESP to the stack page of the current process.
Previous implements used an trampoline for that. The reason it was moved to
the context was that an NMI could see the trampoline stack for one
instruction and when it calls current (very unlikely) and references the
stack pointer it  doesn't get a valid task_struct. The obvious solution
would be to somehow check this case (e.g. by looking at esp) in the NMI
slow path.

Steps to reproduce:

Benchmark __switch_to or context switch. Note lmbench is not reliable
(numbers vary wildy); microbenchmarks of WRMSR show the problem clearly.


