Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261408AbVAXBR1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261408AbVAXBR1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 20:17:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261410AbVAXBR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 20:17:26 -0500
Received: from mx1.redhat.com ([66.187.233.31]:49336 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261408AbVAXBRT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 20:17:19 -0500
Date: Sun, 23 Jan 2005 17:17:06 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: David Brownell <david-b@pacbell.net>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       greg@kroah.com, zaitcev@redhat.com
Subject: Re: usbmon, usb core, ARM
Message-ID: <20050123171706.68a6d717@localhost.localdomain>
In-Reply-To: <200501231534.23583.david-b@pacbell.net>
References: <20050118212033.26e1b6f0@localhost.localdomain>
	<200501202228.31840.david-b@pacbell.net>
	<20050122001237.38596a5b@localhost.localdomain>
	<200501231534.23583.david-b@pacbell.net>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.14; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Jan 2005 15:34:23 -0800, David Brownell <david-b@pacbell.net> wrote:

> > so let me restate it. Simply put, neither dev nor hcd are available 
> > at the time urb->complete is called,
> 
> Completely untrue.  They are at a minimum provided through the URB itself,
> and giveback (which is the only place that call is made!) is passed the HCD
> as a parameter.  Or aren't you talking about 2.6.11 code?

> > and this is what usbmon intercepts. 
> > For one thing, dev is down-counted in usb_unlink_urb().
> 
> I don't see any refcounting calls in that routine.  It couldn't change
> the refcounts, in any case ... the HCD owns the URB until giveback(),
> and all unlinking does is accelerate getting to that giveback().

I am talking about this code (in 2.6.11-rc2):

static void urb_unlink (struct urb *urb)
{
..............
	/* clear all state linking urb to this dev (and hcd) */

	spin_lock_irqsave (&hcd_data_lock, flags);
	list_del_init (&urb->urb_list);
	spin_unlock_irqrestore (&hcd_data_lock, flags);
	usb_put_dev (urb->dev);    <===== What is this, chopped liver?
}

void usb_hcd_giveback_urb (struct usb_hcd *hcd, struct urb *urb, struct pt_regs *regs)
{
	urb_unlink (urb);

	// NOTE:  a generic device/urb monitoring hook would go here.
....................
	/* pass ownership to the completion handler */
	urb->complete (urb, regs);
	atomic_dec (&urb->use_count);
	if (unlikely (urb->reject))
		wake_up (&usb_kill_urb_queue);
	usb_put_urb (urb);
}

Even if urb->dev was possible to dereference in the completion callback,
the hcd was not available.

But like I said, it's a moot point with explicit hooks.

> For example, how does userspace provide a filter to say what URBs
> it's interested in, and what level of information to report?

I do not have plans to do that. In the network space, it's the difference
between BPF (and its spawn LPF), and, say DLPI tap or /dev/nit on SunOS.
By loading rules into kernel BSD programmers hoped to save a few cycles
by reducing the number of packets delivered to tcpdump. As far as I can
tell, nobody has a practical use for it, savings are miniscule...
I think some distros do not even configure LPF into kernels anymore.

However, nothing prevents you from adding another reader type to usbmon,
the one which does filtering. Heck, an ability to replace whole usbmon
is a design parameter. Rusty rewrote netfilter from scractch two times
(ipfwadm, ip-something-which-I-forgot, iptables). I don't think I can do
everything right with usbmon at first pass either. So I expect other
developers to try out ideas and experiment. Build your filter and prove
me wrong.

-- Pete
