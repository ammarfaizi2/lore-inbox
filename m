Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030474AbWALQq3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030474AbWALQq3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 11:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030473AbWALQq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 11:46:29 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:29197 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1030474AbWALQq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 11:46:28 -0500
Date: Thu, 12 Jan 2006 16:46:21 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       oliver@neukum.org
Subject: Re: need for packed attribute
Message-ID: <20060112164621.GA9288@flint.arm.linux.org.uk>
Mail-Followup-To: Mikael Pettersson <mikpe@csd.uu.se>,
	linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
	oliver@neukum.org
References: <200601121227.k0CCRCB8016162@alkaid.it.uu.se> <20060112134729.GB5700@flint.arm.linux.org.uk> <17350.33811.433595.750615@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17350.33811.433595.750615@alkaid.it.uu.se>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2006 at 05:30:11PM +0100, Mikael Pettersson wrote:
> OK, thanks for this info. It means that GCC is the definitive authority
> on calling conventions and data layouts, not the AAPCS; I wasn't aware of
> that before.

BTW, it's worth noting that the new EABI stuff has it's own set of
problems.  We have r0 to r6 to pass 32-bit or 64-bit arguments.
With EABI, 64-bit arguments will be aligned to an _even_ numbered
register.  Hence:

long sys_foo(int a, long long b, int c, long long d);

will result in the following register layouts:

	EABI				Current
r0	a				a
r1	unused				\_ b
r2	\_ b				/
r3	/				c
r4	c				\_ d
r5					/
r6	... out of space for 'd'	... room for one other int.
r7	syscall number

and as such will be uncallable with this argument ordering for EABI.

We've already had to sanitise sys_fadvise64_64() because of this.

So, I forsee more problems appearing with EABI, not less. ;(

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
