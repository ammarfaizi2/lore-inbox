Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262820AbVEOMIG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262820AbVEOMIG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 08:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262819AbVEOMIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 08:08:06 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:54034 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262820AbVEOMHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 08:07:49 -0400
Date: Sun, 15 May 2005 13:07:42 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andi Kleen <ak@muc.de>
Cc: Dave Jones <davej@redhat.com>, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: tickle nmi watchdog whilst doing serial writes.
Message-ID: <20050515130742.A29619@flint.arm.linux.org.uk>
Mail-Followup-To: Andi Kleen <ak@muc.de>, Dave Jones <davej@redhat.com>,
	akpm@osdl.org, linux-kernel@vger.kernel.org
References: <20050513184806.GA24166@redhat.com> <m1u0l4afdx.fsf@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m1u0l4afdx.fsf@muc.de>; from ak@muc.de on Sun, May 15, 2005 at 01:38:02PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 15, 2005 at 01:38:02PM +0200, Andi Kleen wrote:
> Dave Jones <davej@redhat.com> writes:
> >  
> >  #include <asm/io.h>
> >  #include <asm/irq.h>
> > @@ -2099,8 +2100,10 @@ static inline void wait_for_xmitr(struct
> >  	if (up->port.flags & UPF_CONS_FLOW) {
> >  		tmout = 1000000;
> >  		while (--tmout &&
> > -		       ((serial_in(up, UART_MSR) & UART_MSR_CTS) == 0))
> > +		       ((serial_in(up, UART_MSR) & UART_MSR_CTS) == 0)) {
> >  			udelay(1);
> > +			touch_nmi_watchdog();
> 
> Note that touch_nmi_watchdog is not exported on i386 - Linus vetoed
> that some time ago. The real fix of course is to use schedule_timeout(),
> but that might break printk() with interrupts off :/

Not to mention printk() from atomic contexts and panic().  No,
schedule_timeout() is _not_ a "real fix" but a kludge.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
