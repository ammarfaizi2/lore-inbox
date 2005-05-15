Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262823AbVEOMUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262823AbVEOMUV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 08:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262822AbVEOMUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 08:20:21 -0400
Received: from one.firstfloor.org ([213.235.205.2]:8833 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S262823AbVEOMUP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 08:20:15 -0400
To: Dave Jones <davej@redhat.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: tickle nmi watchdog whilst doing serial writes.
References: <20050513184806.GA24166@redhat.com> <m1u0l4afdx.fsf@muc.de>
	<20050515130742.A29619@flint.arm.linux.org.uk>
From: Andi Kleen <ak@muc.de>
Date: Sun, 15 May 2005 14:20:14 +0200
In-Reply-To: <20050515130742.A29619@flint.arm.linux.org.uk> (Russell King's
 message of "Sun, 15 May 2005 13:07:42 +0100")
Message-ID: <m1ekc8adfl.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> writes:

> On Sun, May 15, 2005 at 01:38:02PM +0200, Andi Kleen wrote:
>> Dave Jones <davej@redhat.com> writes:
>> >  
>> >  #include <asm/io.h>
>> >  #include <asm/irq.h>
>> > @@ -2099,8 +2100,10 @@ static inline void wait_for_xmitr(struct
>> >  	if (up->port.flags & UPF_CONS_FLOW) {
>> >  		tmout = 1000000;
>> >  		while (--tmout &&
>> > -		       ((serial_in(up, UART_MSR) & UART_MSR_CTS) == 0))
>> > +		       ((serial_in(up, UART_MSR) & UART_MSR_CTS) == 0)) {
>> >  			udelay(1);
>> > +			touch_nmi_watchdog();
>> 
>> Note that touch_nmi_watchdog is not exported on i386 - Linus vetoed
>> that some time ago. The real fix of course is to use schedule_timeout(),
>> but that might break printk() with interrupts off :/
>
> Not to mention printk() from atomic contexts and panic().  No,
> schedule_timeout() is _not_ a "real fix" but a kludge.

Then someone needs to convince Linus to export touch_nmi_watchdog
again. 

Or how about checking if interrupts are off here (iirc we have 
a generic function for that now) and then using
a smaller timeout and otherwise schedule_timeout() ?

-Andi
