Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262231AbVAOGz5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262231AbVAOGz5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 01:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262242AbVAOGz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 01:55:57 -0500
Received: from fw.osdl.org ([65.172.181.6]:26535 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262231AbVAOGzu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 01:55:50 -0500
Date: Fri, 14 Jan 2005 22:54:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: ak@suse.de, rusty@rustcorp.com.au, manpreet@fabric7.com,
       linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: [PATCH] i386/x86-64: Fix timer SMP bootup race
Message-Id: <20050114225457.611cea19.akpm@osdl.org>
In-Reply-To: <20050115064315.GF22863@wotan.suse.de>
References: <20050115040951.GC13525@wotan.suse.de>
	<20050114222841.5edf7812.akpm@osdl.org>
	<20050115064315.GF22863@wotan.suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
> On Fri, Jan 14, 2005 at 10:28:41PM -0800, Andrew Morton wrote:
> > Andi Kleen <ak@suse.de> wrote:
> > >
> > > This fixes a long standing race in 2.6 i386/x86-64 SMP boot.
> > >  The per CPU timers would only get initialized after an secondary
> > >  CPU was running. But during initialization the secondary CPU would
> > >  already enable interrupts to compute the jiffies. When a per 
> > >  CPU timer fired in this window it would run into a BUG in timer.c
> > >  because the timer heap for that CPU wasn't fully initialized.
> > 
> > Why don't we just not call calibrate_delay() on the secondaries?  It
> > doesn't seem to do anything.  That way we can leave local interrupts
> > disabled.
> 
> It's used for the "accumulative bogomips". To quote Alan: 
> 
>     /*
>      * Allow the user to impress friends.
>      */
> 
> But taking it away doesn't help because the timer startup on the BP
> and the secondaries going into the idle loop isn't synchronized.
> You could add a synchronization step, but it would be far more
> complicated than fixing the ordering like I did.

I don't get it.  By the time the secondaries enter the idle loop, they've
already run init_timers_cpu() anyway.  You patch doesn't address a
secondary taking a timer interrupt prior to the BP having run
init_timers(), does it?
