Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262853AbTDREgD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 00:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262856AbTDREgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 00:36:03 -0400
Received: from granite.he.net ([216.218.226.66]:3852 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S262853AbTDREgC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 00:36:02 -0400
Date: Thu, 17 Apr 2003 21:50:06 -0700
From: Greg KH <greg@kroah.com>
To: davidm@hpl.hp.com, David Brownell <david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org, linux-ia64@linuxia64.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: USB deadlock in v2.5.67
Message-ID: <20030418045006.GB1813@kroah.com>
References: <200304180202.h3I227mw032608@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304180202.h3I227mw032608@napali.hpl.hp.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 17, 2003 at 07:02:07PM -0700, David Mosberger wrote:
> So my 2.5.67 kernel was humming along nicely when I got the idea to
> unplug a USB keyboard.  Instant deadlock.  The backtrace shows this:

Ah, I just got this too, but you have the better debug trace.

> 
> Call Trace:
>  [<e0000000048c4260>] hcd_free_dev+0x140/0x240
>  [<e0000000048b96e0>] usb_release_dev+0x100/0x140
>  [<e000000004743420>] device_release+0x80/0xa0
>  [<e000000004697600>] kobject_cleanup+0x100/0x120
>  [<e0000000048c34d0>] urb_unlink+0x110/0x1a0
>  [<e0000000048c4390>] usb_hcd_giveback_urb+0x30/0x1a0
>  [<e0000000048da730>] dl_done_list+0x230/0x2a0
>  [<e0000000048dbfd0>] ohci_irq+0x290/0x340
>  [<e0000000048c4580>] usb_hcd_irq+0x80/0x100
>  [<e000000004414e00>] handle_IRQ_event+0xa0/0x120
>  [<e0000000044155e0>] do_IRQ+0x360/0x460
>  [<e0000000044174b0>] ia64_handle_irq+0x70/0x140
>  [<e000000004411e40>] ia64_leave_kernel+0x0/0x240
> 
> <hcd_free_dev+0x140> translates into line 1249 in hcd.c, where it
> does:
> 
> 	spin_lock_irqsave (&hcd_data_lock, flags);
> 
> The deadlock is pretty obvious: the same lock has already been
> acquired urb_unlink(), 4 levels up in the call-chain.
> 
> Anybody have a fix for this?

David (Brownell, that is), does this help with the trace I sent you a
few hours ago?

thanks,

greg k-h
