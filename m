Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263590AbUJ2X6e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263590AbUJ2X6e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 19:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263700AbUJ2Xo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 19:44:58 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:42805 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S263696AbUJ2XlP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 19:41:15 -0400
Subject: Re: [BUG][2.6.8.1] serial driver hangs SMP kernel, but not the UP
	kernel
From: Paul Fulghum <paulkf@microgate.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Tim_T_Murphy@Dell.com, Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20041029212029.I31627@flint.arm.linux.org.uk>
References: <4B0A1C17AA88F94289B0704CFABEF1AB0B4CC4@ausx2kmps304.aus.amer.dell.com>
	 <20041029212029.I31627@flint.arm.linux.org.uk>
Content-Type: text/plain
Message-Id: <1099093258.5965.41.camel@at2.pipehead.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 29 Oct 2004 18:40:58 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-29 at 15:20, Russell King wrote:
> At a guess, you've enabled "low latency" setting on this port ?

Would it make sense to do something like (in tty_io.c) the following?

void tty_flip_buffer_push(struct tty_struct *tty)
{
	if (tty->low_latency) {
		if (in_interrupt()) {
			printk(KERN_ERR "tty_flip_buffer_push called with low latency from interrupt!\n");
			dump_stack();
			schedule_delayed_work(&tty->flip.work, 1);
		}
		else
			flush_to_ldisc((void *) tty);
	}
	else
		schedule_delayed_work(&tty->flip.work, 1);
}

-- 
Paul Fulghum
paulkf@microgate.com


