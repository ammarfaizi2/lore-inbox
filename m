Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262227AbVAOGnp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262227AbVAOGnp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 01:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262231AbVAOGno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 01:43:44 -0500
Received: from mail.suse.de ([195.135.220.2]:31953 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262227AbVAOGnW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 01:43:22 -0500
Date: Sat, 15 Jan 2005 07:43:15 +0100
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>, rusty@rustcorp.com.au, manpreet@fabric7.com,
       linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: [PATCH] i386/x86-64: Fix timer SMP bootup race
Message-ID: <20050115064315.GF22863@wotan.suse.de>
References: <20050115040951.GC13525@wotan.suse.de> <20050114222841.5edf7812.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050114222841.5edf7812.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2005 at 10:28:41PM -0800, Andrew Morton wrote:
> Andi Kleen <ak@suse.de> wrote:
> >
> > This fixes a long standing race in 2.6 i386/x86-64 SMP boot.
> >  The per CPU timers would only get initialized after an secondary
> >  CPU was running. But during initialization the secondary CPU would
> >  already enable interrupts to compute the jiffies. When a per 
> >  CPU timer fired in this window it would run into a BUG in timer.c
> >  because the timer heap for that CPU wasn't fully initialized.
> 
> Why don't we just not call calibrate_delay() on the secondaries?  It
> doesn't seem to do anything.  That way we can leave local interrupts
> disabled.

It's used for the "accumulative bogomips". To quote Alan: 

    /*
     * Allow the user to impress friends.
     */

But taking it away doesn't help because the timer startup on the BP
and the secondaries going into the idle loop isn't synchronized.
You could add a synchronization step, but it would be far more
complicated than fixing the ordering like I did.

-Andi
