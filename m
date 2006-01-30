Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932299AbWA3O7S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbWA3O7S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 09:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbWA3O7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 09:59:18 -0500
Received: from mx1.redhat.com ([66.187.233.31]:57746 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932299AbWA3O7N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 09:59:13 -0500
Date: Mon, 30 Jan 2006 09:58:50 -0500
From: Dave Jones <davej@redhat.com>
To: Jan Beulich <JBeulich@novell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] prevent nested panic from soft lockup detection
Message-ID: <20060130145850.GB9752@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jan Beulich <JBeulich@novell.com>, linux-kernel@vger.kernel.org
References: <43DDE5A1.76F0.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43DDE5A1.76F0.0078.0@novell.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2006 at 10:08:33AM +0100, Jan Beulich wrote:

 > From: Jan Beulich <jbeulich@novell.com>
 > 
 > Suppress triggering a nested panic due to soft lockup detection.
 > 
 > Signed-Off-By: Jan Beulich <jbeulich@novell.com>
 > 
 > diff -Npru /home/jbeulich/tmp/linux-2.6.16-rc1/kernel/panic.c 2.6.16-rc1-panic-softlockup/kernel/panic.c
 > --- /home/jbeulich/tmp/linux-2.6.16-rc1/kernel/panic.c	2006-01-27 15:10:49.000000000 +0100
 > +++ 2.6.16-rc1-panic-softlockup/kernel/panic.c	2006-01-25 09:55:53.000000000 +0100
 > @@ -107,6 +107,7 @@ NORET_TYPE void panic(const char * fmt, 
 >  		printk(KERN_EMERG "Rebooting in %d seconds..",panic_timeout);
 >  		for (i = 0; i < panic_timeout*1000; ) {
 >  			touch_nmi_watchdog();
 > +			touch_softlockup_watchdog();
 >  			i += panic_blink(i);
 >  			mdelay(1);
 >  			i++;
 > @@ -130,6 +131,7 @@ NORET_TYPE void panic(const char * fmt, 
 >  #endif
 >  	local_irq_enable();
 >  	for (i = 0;;) {
 > +		touch_softlockup_watchdog();
 >  		i += panic_blink(i);
 >  		mdelay(1);
 >  		i++;

I've been wondering for a while why we don't just make touch_nmi_watchdog
do an implicit call to touch_softlockup_watchdog.  I can't think of a situation
where we'd want to do one but not the other, and adding patches like this
seems to be an uphill battle (I know at least two other places that need
this off the top of my head).

		Dave
