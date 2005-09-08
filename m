Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964901AbVIHRhV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964901AbVIHRhV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 13:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964904AbVIHRhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 13:37:21 -0400
Received: from S01060013104bd78e.vc.shawcable.net ([24.85.145.160]:37609 "EHLO
	r3000.fsmlabs.com") by vger.kernel.org with ESMTP id S964901AbVIHRhT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 13:37:19 -0400
Date: Thu, 8 Sep 2005 10:37:20 -0700 (PDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Jan Beulich <JBeulich@novell.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix i386 interrupt re-enabling in die()
In-Reply-To: <4320718A0200007800024476@emea1-mh.id2.novell.com>
Message-ID: <Pine.LNX.4.63.0509081036110.8052@r3000.fsmlabs.com>
References: <4320718A0200007800024476@emea1-mh.id2.novell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Sep 2005, Jan Beulich wrote:

> diff -Npru 2.6.13/arch/i386/kernel/traps.c
> 2.6.13-i386-die-irq/arch/i386/kernel/traps.c
> --- 2.6.13/arch/i386/kernel/traps.c	2005-08-29 01:41:01.000000000
> +0200
> +++ 2.6.13-i386-die-irq/arch/i386/kernel/traps.c	2005-09-07
> 11:39:40.000000000 +0200
> @@ -304,6 +304,7 @@ void die(const char * str, struct pt_reg
>  		spinlock_t lock;
>  		u32 lock_owner;
>  		int lock_owner_depth;
> +		unsigned long flags;
>  	} die = {
>  		.lock =			SPIN_LOCK_UNLOCKED,
>  		.lock_owner =		-1,
> @@ -313,7 +314,7 @@ void die(const char * str, struct pt_reg
>  
>  	if (die.lock_owner != raw_smp_processor_id()) {
>  		console_verbose();
> -		spin_lock_irq(&die.lock);
> +		spin_lock_irqsave(&die.lock, die.flags);

This corrupts flags on contention, use a stack variable.
