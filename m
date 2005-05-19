Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262416AbVESAYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262416AbVESAYn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 20:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262420AbVESAYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 20:24:42 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:14835 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262421AbVESAYj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 20:24:39 -0400
Message-ID: <428BDCAD.2090307@mvista.com>
Date: Wed, 18 May 2005 17:24:13 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: Dave Jones <davej@redhat.com>, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: tickle nmi watchdog whilst doing serial writes.
References: <20050513184806.GA24166@redhat.com> <m1u0l4afdx.fsf@muc.de>	<20050515130742.A29619@flint.arm.linux.org.uk> <m1ekc8adfl.fsf@muc.de>
In-Reply-To: <m1ekc8adfl.fsf@muc.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Russell King <rmk+lkml@arm.linux.org.uk> writes:
> 
> 
>>On Sun, May 15, 2005 at 01:38:02PM +0200, Andi Kleen wrote:
>>
>>>Dave Jones <davej@redhat.com> writes:
>>>
>>>> 
>>>> #include <asm/io.h>
>>>> #include <asm/irq.h>
>>>>@@ -2099,8 +2100,10 @@ static inline void wait_for_xmitr(struct
>>>> 	if (up->port.flags & UPF_CONS_FLOW) {
>>>> 		tmout = 1000000;
>>>> 		while (--tmout &&
>>>>-		       ((serial_in(up, UART_MSR) & UART_MSR_CTS) == 0))
>>>>+		       ((serial_in(up, UART_MSR) & UART_MSR_CTS) == 0)) {
>>>> 			udelay(1);
>>>>+			touch_nmi_watchdog();
>>>
>>>Note that touch_nmi_watchdog is not exported on i386 - Linus vetoed
>>>that some time ago. The real fix of course is to use schedule_timeout(),
>>>but that might break printk() with interrupts off :/
>>
>>Not to mention printk() from atomic contexts and panic().  No,
>>schedule_timeout() is _not_ a "real fix" but a kludge.

Um... I would think the real fix is to set the UART up to generate the modem 
status interrupt and eliminate the pole loop.  Why can't this be done?  I, for 
one, don't want my cpu looping in the serial driver, even more so with the 
interrupt system off.  This, in my mind, is a real bug in the serial driver and 
should be so handled.


-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
