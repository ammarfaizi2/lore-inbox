Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932140AbWF3Ixd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbWF3Ixd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 04:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbWF3Ixd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 04:53:33 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17803 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932140AbWF3Ixd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 04:53:33 -0400
Date: Fri, 30 Jun 2006 01:52:51 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: andy@andynet.net, gregkh@suse.de, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, zaitcev@redhat.com
Subject: Re: [PATCH] Airprime driver improvements to allow full speed EvDO
 transfers
Message-Id: <20060630015251.e6a4e526.zaitcev@redhat.com>
In-Reply-To: <20060630001021.2b49d4bd.akpm@osdl.org>
References: <1151646482.3285.410.camel@tahini.andynet.net>
	<20060630001021.2b49d4bd.akpm@osdl.org>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.17; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jun 2006 00:10:21 -0700, Andrew Morton <akpm@osdl.org> wrote:

> > +static void airprime_read_bulk_callback(struct urb *urb, struct pt_regs *regs)
>.......
> > +	/* should this use GFP_KERNEL? */
> > +	result = usb_submit_urb(urb, GFP_ATOMIC);
> 
> If possible, yep.

You can't be serious. It's a callback function we're discussing here,
and you even quoted it.

> > +	/* free up private structure? */
> 
> Yes please ;)

+1

> Is usb_serial_driver.write() really called in a context in which it is
> forced to use GFP_ATOMIC?

There are cases when it is. It happens when a line discipline does it.
The n_tty does it if the line is in cooked mode, which is the default.
n_hdlc does it always, though I have no idea if this is applicable
to airprime. I think PPP writes from a tasklet as well.

The idea to allocate a URB for every little user write bothers me as
well. It was a dirty code thrown together quickly by someone who could
not be bothered to use a circular buffer and two URBs. It was fine
for the visor.c, but the Airprime is a higher performance card, and it
can be used in a home gateway with a low-power CPU. I'm not happy.

-- Pete
