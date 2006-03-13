Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932290AbWCMACi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbWCMACi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 19:02:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932292AbWCMACi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 19:02:38 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:49935 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932290AbWCMACi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 19:02:38 -0500
Date: Mon, 13 Mar 2006 00:02:31 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: Richard Purdie <rpurdie@rpsys.net>,
       kernel list <linux-kernel@vger.kernel.org>, lenz@cs.wisc.edu
Subject: Re: [rfc] separate sharpsl_pm initialization from sysfs code
Message-ID: <20060313000231.GA6555@flint.arm.linux.org.uk>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>,
	Richard Purdie <rpurdie@rpsys.net>,
	kernel list <linux-kernel@vger.kernel.org>, lenz@cs.wisc.edu
References: <20060309124237.GA3794@elf.ucw.cz> <1141911202.10107.54.camel@localhost.localdomain> <20060310180719.GD8018@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060310180719.GD8018@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2006 at 07:07:20PM +0100, Pavel Machek wrote:
> 	/* Register interrupt handler. */
> 	if ((err = request_irq(COLLIE_IRQ_GPIO_AC_IN, sharpsl_ac_isr, SA_INTERRUPT,
> 			       "ACIN", sharpsl_ac_isr))) {
> 		printk("Could not get irq %d.\n", COLLIE_IRQ_GPIO_AC_IN);
> 		return;
> 	}
> 	if ((err = request_irq(COLLIE_IRQ_GPIO_CO, sharpsl_chrg_full_isr, SA_INTERRUPT,
> 			       "CO", sharpsl_chrg_full_isr))) {
> 		free_irq(COLLIE_IRQ_GPIO_AC_IN, sharpsl_ac_isr);
> 		printk("Could not get irq %d.\n", COLLIE_IRQ_GPIO_CO);
> 		return;
> 	}

Shouldn't these be ucb1x00_hook_irq()'s?

Shouldn't you only enable the ADC when you need to use it?

This driver makes no calls to ucb1x00_enable() and ucb1x00_disable().
They're part of power management, and if your driver doesn't appear to
require them to work, that means some other code is buggy (or you're
keeping the ADC always enabled.)

In order to get maximum power savings, you should ensure that drivers
only call ucb1x00_enable() when they need to and ucb1x00_disable() as
soon as they can complete the operation.  Ditto for ucb1x00_adc_enable()
and ucb1x00_adc_disable() - don't use ucb1x00_enable() and
ucb1x00_adc_enable() from a probe/initialisation function and then
leave it alone.  Unless you want to needlessly waste power.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
