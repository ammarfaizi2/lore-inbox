Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262226AbVAOFJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262226AbVAOFJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 00:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262227AbVAOFJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 00:09:59 -0500
Received: from ozlabs.org ([203.10.76.45]:63876 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262226AbVAOFJm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 00:09:42 -0500
Subject: Re: [PATCH] i386/x86-64: Fix timer SMP bootup race
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, manpreet@fabric7.com,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       discuss@x86-64.org
In-Reply-To: <20050115040951.GC13525@wotan.suse.de>
References: <20050115040951.GC13525@wotan.suse.de>
Content-Type: text/plain
Date: Sat, 15 Jan 2005 16:09:19 +1100
Message-Id: <1105765760.12263.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-01-15 at 05:09 +0100, Andi Kleen wrote:
> Fix boot up SMP race in timer setup on i386/x86-64.
> 
> This fixes a long standing race in 2.6 i386/x86-64 SMP boot.
> The per CPU timers would only get initialized after an secondary
> CPU was running. But during initialization the secondary CPU would
> already enable interrupts to compute the jiffies. When a per 
> CPU timer fired in this window it would run into a BUG in timer.c
> because the timer heap for that CPU wasn't fully initialized.
> 
> The race only happens when a CPU takes a long time to boot
> (e.g. very slow console output with debugging enabled).
> 
> To fix I added a new cpu notifier notifier command CPU_UP_PREPARE_EARLY
> that is called before the secondary CPU is started. timer.c
> uses that now to initialize the per CPU timers early before
> the other CPU runs any Linux code.

Andi, that's horrible.  I suspect you know it's horrible and were hoping
someone would fix it properly.  The semantics of CPU_UP_PREPARE are
supposed to do this already.

The cause of this bug is that (1) i386 and x86_64 actually bring the
secondary CPUs up at boot before the core code officially brings them up
using cpu_up(), after the appropriate callbacks, and (2) they call into
core code tp process timer interrupts before they've been officially
brought up.

The former is because I just added a shim rather than rewriting the x86
boot process, because it would have broken too much.  The fix is do the
boot process properly, or to suppress the call to do_timer before the
CPU is actually "up".

Sorry,
Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

