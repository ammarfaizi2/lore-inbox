Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262222AbVAOG3Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262222AbVAOG3Z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 01:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262223AbVAOG3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 01:29:25 -0500
Received: from fw.osdl.org ([65.172.181.6]:12179 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262222AbVAOG3X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 01:29:23 -0500
Date: Fri, 14 Jan 2005 22:28:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: rusty@rustcorp.com.au, manpreet@fabric7.com, linux-kernel@vger.kernel.org,
       discuss@x86-64.org
Subject: Re: [PATCH] i386/x86-64: Fix timer SMP bootup race
Message-Id: <20050114222841.5edf7812.akpm@osdl.org>
In-Reply-To: <20050115040951.GC13525@wotan.suse.de>
References: <20050115040951.GC13525@wotan.suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
> This fixes a long standing race in 2.6 i386/x86-64 SMP boot.
>  The per CPU timers would only get initialized after an secondary
>  CPU was running. But during initialization the secondary CPU would
>  already enable interrupts to compute the jiffies. When a per 
>  CPU timer fired in this window it would run into a BUG in timer.c
>  because the timer heap for that CPU wasn't fully initialized.

Why don't we just not call calibrate_delay() on the secondaries?  It
doesn't seem to do anything.  That way we can leave local interrupts
disabled.

If for some reason we still want the bogomips printk, call
calibrate_delay() from the CPU_UP_PREPARE handler?
