Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265334AbUEZHaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265334AbUEZHaW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 03:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265335AbUEZHaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 03:30:22 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:52950 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S265334AbUEZHaO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 03:30:14 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: Zwane Mwaikambo <zwane@fsmlabs.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.6-mm] i386: enable interrupts on contention in spin_lock_irq 
In-reply-to: Your message of "Wed, 26 May 2004 03:11:07 -0400."
             <Pine.LNX.4.58.0405260250310.1794@montezuma.fsmlabs.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 26 May 2004 17:29:46 +1000
Message-ID: <14280.1085556586@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 May 2004 03:11:07 -0400 (EDT), 
Zwane Mwaikambo <zwane@fsmlabs.com> wrote:
>This little bit was missing from the previous patch. It will enable
>interrupts whilst a cpu is spinning on a lock in spin_lock_irq as well as
>spin_lock_irqsave. UP/SMP compile and runtime/stress tested on i386,
>UP/SMP compile tested on amd64.
>
>+#define _raw_spin_lock_irq(lock)	_raw_spin_lock_flags(lock, X86_EFLAGS_IF)

You are assuming that all uses of spin_lock_irq() are done when
interrupts are already enabled.  This _should_ be true, because the
matching spin_unlock_irq() will unconditionally reenable interrupts.
However I have seen buggy code where spin_lock_irq() was issued with
interrupts disabled.  By unconditionally passing X86_EFLAGS_IF, that
buggy code can now run in one of two states :-

state 1
Enter with interrupts disabled
Do some work
spin_lock_irq()
No lock contention, do not enable interrupts
Do some more work
spin_unlock_irq()

state 2
Enter with interrupts disabled
Do some work
spin_lock_irq()
Lock contention, enable interrupts, get lock, disable interrupts
Do some more work
spin_unlock_irq()

Your patch opens a window where data that was protected by the disabled
interrupt on entry becomes unprotected while waiting for the lock and
can therefore change.

It could be that I am worrying unnecessarily, after all any code that
calls spin_lock_irq() with interrupts already disabled is probably
wrong to start off with.  But it does need to be considered as a
possible failure mode.

