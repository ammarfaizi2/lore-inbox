Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262089AbVADFRr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262089AbVADFRr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 00:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbVADFRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 00:17:42 -0500
Received: from orb.pobox.com ([207.8.226.5]:60133 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S262042AbVADFPp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 00:15:45 -0500
Date: Mon, 3 Jan 2005 21:15:30 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Barry K. Nathan" <barryn@pobox.com>, lindqvist@netstar.se, edi@gmx.de,
       john@hjsoft.com, linux-kernel@vger.kernel.org, akpm@osdl.org,
       torvalds@osdl.org
Subject: Re: [PATCH] swsusp: properly suspend and resume *all* devices
Message-ID: <20050104051529.GA4465@ip68-4-98-123.oc.oc.cox.net>
References: <20050101172344.GA1355@elf.ucw.cz> <20050102055753.GB7406@ip68-4-98-123.oc.oc.cox.net> <20050102184239.GA21322@butterfly.hjsoft.com> <1104696556.2478.12.camel@pefyra> <20050103051018.GA4413@ip68-4-98-123.oc.oc.cox.net> <20050103084713.GB2099@elf.ucw.cz> <20050103101423.GA4441@ip68-4-98-123.oc.oc.cox.net> <20050103150505.GA4120@ip68-4-98-123.oc.oc.cox.net> <20050103170807.GA8163@elf.ucw.cz> <20050103183317.GA1353@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050103183317.GA1353@elf.ucw.cz>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2005 at 07:33:18PM +0100, Pavel Machek wrote:
> > Ack. [I have similar patch in my tree, but yours is better in error
> > checking area. Please push it to akpm.]
> 
> Actually you missed second half: same code should be added around
> swsusp_arch_resume. It is not too critical there, but its right thing
> to do.

Hmmm... I'm not sure how necessary it is, and I think it slows down
resume a tiny bit. However, the more I think about it the more correct it
seems, so here's the follow-up patch. (Andrew, even if this patch is
rejected, please commit my first one to the next -mm release. That patch
alone is still an improvement over the current code.)

Signed-off-by: Barry K. Nathan <barryn@pobox.com>

--- linux-2.6.10-mm1-bkn3/kernel/power/swsusp.c	2005-01-03 06:27:07.753344731 -0800
+++ linux-2.6.10-mm1-bkn4/kernel/power/swsusp.c	2005-01-03 20:19:06.737439106 -0800
@@ -878,6 +878,7 @@
 {
 	int error;
 	local_irq_disable();
+	device_power_down(PM_SUSPEND_DISK);
 	/* We'll ignore saved state, but this gets preempt count (etc) right */
 	save_processor_state();
 	error = swsusp_arch_resume();
@@ -887,6 +888,7 @@
 	BUG_ON(!error);
 	restore_processor_state();
 	restore_highmem();
+	device_power_up();
 	local_irq_enable();
 	return error;
 }
