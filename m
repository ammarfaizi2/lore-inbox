Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261264AbVHAV2c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261264AbVHAV2c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 17:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261220AbVHAV0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 17:26:16 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:38034 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261272AbVHAVZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 17:25:02 -0400
Subject: Re: [PATCH] Real-Time Preemption V0.7.52-07: rt_init_MUTEX_LOCKED
	declaration
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Luca Falavigna <dktrkranz@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050801210324.GA21087@elte.hu>
References: <42EE4D27.8060500@gmail.com>
	 <1122922658.6759.22.camel@localhost.localdomain>
	 <20050801210324.GA21087@elte.hu>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 01 Aug 2005 17:24:57 -0400
Message-Id: <1122931497.6759.47.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-01 at 23:03 +0200, Ingo Molnar wrote:
> * Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > -	struct semaphore stop;
> > +	struct compat_semaphore stop;
> 
> i think it's policy->lock that is the issue here?
> 

I was looking at Luca's original message where he showed the bug of 
-- drivers/char/watchdog/cpu5wdt.c: "cpu5wdt: Unknown symbol
there_is_no_init_MUTEX_LOCKED_for_RT_semaphores") --
Looking into this file the only init_MUTEX_LOCKED that I found was 

static int __devinit cpu5wdt_init(void)
{
	unsigned int val;
	int err;

[...]

	/* watchdog reboot? */
	val = inb(port + CPU5WDT_STATUS_REG);
	val = (val >> 2) & 1;
	if ( !val )
		printk(KERN_INFO PFX "sorry, was my fault\n");

	init_MUTEX_LOCKED(&cpu5wdt_device.stop);
	cpu5wdt_device.queue = 0;

	clear_bit(0, &cpu5wdt_device.inuse);



Here I see that cpu5wdt_device.stop is being initialized with
init_MUTEX_LOCKED, so that is what I went to fix.  I even added the
driver to my config and compiled it before sending it in.  I don't have
the device, but the driver compiled :-)

-- Steve


