Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267049AbSLDUB3>; Wed, 4 Dec 2002 15:01:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267057AbSLDUB3>; Wed, 4 Dec 2002 15:01:29 -0500
Received: from ns.suse.de ([213.95.15.193]:19987 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S267049AbSLDUB2>;
	Wed, 4 Dec 2002 15:01:28 -0500
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NMI notifiers for 2.5
References: <1039027142.20387.11.camel@dell_ss3.pdx.osdl.net.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 04 Dec 2002 21:08:59 +0100
In-Reply-To: Stephen Hemminger's message of "4 Dec 2002 19:46:37 +0100"
Message-ID: <p731y4xtulg.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger <shemminger@osdl.org> writes:

> The following generalizes the NMI callback's needed by things like crash
> dump and debuggers in the same way that panic has notifiers. 
> 
> Please apply this since it makes writing and maintaining RAS extensions
> easier. Since there is already a panic_notifier callback, this follows
> the same model. 

> +			
> +			notifier_call_chain(&nmi_notifier_list, 0, regs);
> +

Most debuggers/crash dumpers etc. need a way to veto normal processing of NMIs 
and other exceptions. For NMI the usual case is to turn off the nmi watchdog 
while you do something slow with interrupts disabled, that requires
doing the hook very early. Without veta NMI notification is not very useful.

You want something like:

	if (notifier_call_chain(&nmi_notifier_list, 0, regs) == NOTIFY_BAD)
		goto ignore;

For a more comprehensive variant see include/asm-x86_64/kdebug.h	
The x86-64 variant cannot be 1:1 copied because it's still incomplete
and e.g. does not implement veto for all places where it's needed.


-Andi
