Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264129AbTEGRMC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 13:12:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264130AbTEGRMC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 13:12:02 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:11167 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S264129AbTEGRL3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 13:11:29 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16057.16684.101916.709412@gargle.gargle.HOWL>
Date: Wed, 7 May 2003 19:23:56 +0200
From: mikpe@csd.uu.se
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Dave Jones <davej@codemonkey.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] restore sysenter MSRs at resume
In-Reply-To: <Pine.LNX.4.44.0305070732010.2019-100000@home.transmeta.com>
References: <16056.53993.774345.897852@gargle.gargle.HOWL>
	<Pine.LNX.4.44.0305070732010.2019-100000@home.transmeta.com>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:
 > 
 > On Wed, 7 May 2003 mikpe@csd.uu.se wrote:
 > > 
 > > The patch below hooks sysenter into the driver model and implements
 > > a resume() method which restores the sysenter MSRs.
 > 
 > This is wrong.
 > 
 > For one thing, you screw up SMP seriously, by not enabling sysenter on all
 > CPU's, only the boot one.

We don't do apm suspend/resume on SMP, so this is no different from the
current situation. I don't know if acpi does it or not.

 > For another, we shouldn't have "device drivers" for the CPU. I certainly
 > agree about restoring the sysenter MSR's, but they should be restored by
 > the CPU-specific code long _before_ we start initializing devices.
 > 
 > So I think we should just make it part of the CPU initialization (which
 > should be in two parts: the low-level asm part for the "core" CPU
 > registers, and then the high-level C part for things like the MSR's, 
 > user-space segment stuff etc).
 > 
 > So why not just add an explicit call to "cpu_resume()" in one of the 
 > "do_magic_resume()" things, instead of playing games with device trees..

Where would cpu_resume() [and cpu_suspend()] live?
arch/i386/kernel/suspend* belong to SOFTWARE_SUSPEND, but I don't
think that approach is desirable when apm mostly works for UP.

I could probably get away with simply having apm.c invoke the C code
in suspend.c, which does restore the SYSENTER MSRs. suspend.c itself
doesn't seem to depend on the SOFTWARE_SUSPEND machinery, but
suspend_asm.S does.

Does that sound reasonable?

 > > The patch has a debug printk() for problematic systems that require
 > > the fix. If it says your machine didn't preserve the MSRs, please
 > > post a note about this to LKML with your machine model, so we can
 > > estimate the scope of the problem.
 > 
 > I really think that it should be done unconditionally - there's no point 
 > in even _expecting_ the BIOS to restore various random MSR's. I can't 
 > imagine that many do.

It does the restore unconditionally, the check is just informational.

/Mikael
