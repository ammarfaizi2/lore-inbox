Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161035AbWJDFnT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161035AbWJDFnT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 01:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161076AbWJDFnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 01:43:18 -0400
Received: from ns.suse.de ([195.135.220.2]:54660 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161035AbWJDFnS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 01:43:18 -0400
Date: Tue, 3 Oct 2006 22:43:09 -0700
From: Greg KH <gregkh@suse.de>
To: Jarek Poplawski <jarkao2@o2.pl>, "Axel C. Voigt" <Axel.Voigt@qosmotec.com>,
       linux-kernel@vger.kernel.org, David Kubicek <dave@awk.cz>
Subject: Re: Problems with hard irq? (inconsistent lock state)
Message-ID: <20061004054309.GA387@suse.de>
References: <46E81D405FFAC240826E54028B3B02953B13@aixlac.qosmotec.com> <20061004054308.GA994@ff.dom.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061004054308.GA994@ff.dom.local>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2006 at 07:43:08AM +0200, Jarek Poplawski wrote:
> On 29-09-2006 13:45, Axel C. Voigt wrote:
> >  
> > Hello all,
> > 
> > today I received the following stack backtrace using debian-2.6.18 with our communications driver accessing a ACM device. This happened when removing (powering off and/or on) the mobile phone (nokia 6630) at /dev/ttyACMx
> > 
> > Are someone able to get a hint for me?
> > 
> > --schnipp--
> > Sep 29 13:29:53 mcs70 kernel:
> > Sep 29 13:29:53 mcs70 kernel: =================================
> > Sep 29 13:29:53 mcs70 kernel: [ INFO: inconsistent lock state ]
> > Sep 29 13:29:53 mcs70 kernel: ---------------------------------
> > Sep 29 13:29:53 mcs70 kernel: inconsistent {hardirq-on-W} -> {in-hardirq-W} usage.
> > Sep 29 13:29:53 mcs70 kernel: startDV24/3864 [HC1[1]:SC0[0]:HE0:SE1] takes:
> > Sep 29 13:29:53 mcs70 kernel: (&acm->read_lock){++..}, at: [<e08952d8>] acm_read_bulk+0x60/0xde [cdc_acm]
> > Sep 29 13:29:53 mcs70 kernel: {hardirq-on-W} state was registered at:
> > Sep 29 13:29:53 mcs70 kernel: [<c01321f3>] lock_acquire+0x56/0x73
> > Sep 29 13:29:53 mcs70 kernel: [<c02ce42a>] _spin_lock+0x1a/0x25
> > Sep 29 13:29:53 mcs70 kernel: [<e08953a8>] acm_rx_tasklet+0x52/0x2be [cdc_acm]
> > Sep 29 13:29:53 mcs70 kernel: [<c011f868>] tasklet_action+0x6d/0xd7
> > Sep 29 13:29:53 mcs70 kernel: [<c011f526>] __do_softirq+0x79/0xf2
> ...
> > Sep 29 13:29:53 mcs70 kernel: stack backtrace:
> > Sep 29 13:29:53 mcs70 kernel: [<c010376e>] show_trace+0x16/0x18
> > Sep 29 13:29:53 mcs70 kernel: [<c010383c>] dump_stack+0x19/0x1b
> > Sep 29 13:29:53 mcs70 kernel: [<c0130ad8>] print_usage_bug+0x1e1/0x1eb
> > Sep 29 13:29:53 mcs70 kernel: [<c0130b86>] mark_lock+0xa4/0x4d9
> > Sep 29 13:29:53 mcs70 kernel: [<c0131823>] __lock_acquire+0x41a/0x841
> > Sep 29 13:29:53 mcs70 kernel: [<c01321f3>] lock_acquire+0x56/0x73
> > Sep 29 13:29:53 mcs70 kernel: [<c02ce42a>] _spin_lock+0x1a/0x25
> > Sep 29 13:29:53 mcs70 kernel: [<e08952d8>] acm_read_bulk+0x60/0xde [cdc_acm]
> ...
> > Sep 29 13:29:53 mcs70 kernel: [<c0104b26>] do_IRQ+0x4e/0x5f
> > Sep 29 13:29:53 mcs70 kernel: [<c0103339>] common_interrupt+0x25/0x2c
> ... 
> 
> It looks in drivers/usb/class/cdc-acm.c acm_rx_tasklet could be preempted
> with acm->read_lock by acm_read_bulk which uses the same lock from hardirq
> context.
> 
> So probably spin_lock_irqsave is needed.  

Yup.  Care to send a patch?

thanks,

greg k-h
