Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261945AbULVCZa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261945AbULVCZa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 21:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbULVCZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 21:25:30 -0500
Received: from mx1.redhat.com ([66.187.233.31]:27265 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261944AbULVCZW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 21:25:22 -0500
Date: Tue, 21 Dec 2004 18:25:14 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       <laforge@gnumonks.org>, greg@kroah.com
Subject: Re: My vision of usbmon
Message-ID: <20041221182514.5ed935e2@lembas.zaitcev.lan>
In-Reply-To: <200412201525.52149.oliver@neukum.org>
References: <20041219230454.5b7f83e3@lembas.zaitcev.lan>
	<200412201525.52149.oliver@neukum.org>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.14; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Dec 2004 15:25:52 +0100, Oliver Neukum <oliver@neukum.org> wrote:

> Am Montag, 20. Dezember 2004 08:04 schrieb Pete Zaitcev:
> > +               memcpy(&mbus->shim_ops, ubus->op, sizeof(struct usb_operations));
> > +               mbus->shim_ops.submit_urb = mon_submit;
> > +               mbus->saved_op = ubus->op;
> > +               ubus->op = &mbus->shim_ops;
> > +               ubus->monitored = 1;
> 
> I think you need smp_wmb() here to make sure that an irq taken
> on another CPU sees the manipulations in the correct order.

Hmm, it seems you are right. I forgot about reordering issues. I relied on
op being atomic, but if it points at an uninitialized shim, this will end
badly. How about this?

                memcpy(&mbus->shim_ops, ubus->op, sizeof(struct usb_operations));
                mbus->shim_ops.submit_urb = mon_submit;
                mbus->saved_op = ubus->op;
                smp_mb();       /* ubus->op is not protected by spinlocks */
                ubus->op = &mbus->shim_ops;
                ubus->monitored = 1;

Generally, the type of coding which requires a use of memory barriers in drivers
is a bug or a latent bug, so I am sorry for the above. It was a sacrifice to
make usbmon invisible if it's not actively monitoring. Sorry about that.

-- Pete
