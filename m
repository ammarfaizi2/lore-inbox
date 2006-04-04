Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932436AbWDDJqc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbWDDJqc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 05:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932439AbWDDJqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 05:46:31 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:62109 "EHLO
	mailout2.samsung.com") by vger.kernel.org with ESMTP
	id S932436AbWDDJqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 05:46:31 -0400
Date: Tue, 04 Apr 2006 18:46:45 +0900
From: "Hyok S. Choi" <hyok.choi@samsung.com>
Subject: Re: [PATCH 2.6.17-rc1] [SERIAL] DCC(JTAG) serial and the console
 emulation support(revised#2)
In-reply-to: <20060404082005.GB8573@flint.arm.linux.org.uk>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Message-id: <200604041846.46366.hyok.choi@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.8.3
References: <20060403112410.14105.55427.stgit@hyoklinux.sec.samsung.com>
 <200604041127.07290.hyok.choi@samsung.com>
 <20060404082005.GB8573@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 04 April 2006 05:20 pm, Russell King wrote:
> On Tue, Apr 04, 2006 at 11:27:06AM +0900, Hyok S. Choi wrote:
> > On Tuesday 04 April 2006 04:44 am, Russell King wrote:
> > > On Mon, Apr 03, 2006 at 08:24:10PM +0900, Hyok S. Choi wrote:
> > > 
> > > > +static void dcc_shutdown(struct uart_port *port)
> > > > +{
> > > > +#ifdef DCC_IRQ_USED /* real IRQ used */
> > > > +	free_irq(port->irq, port);
> > > > +#else
> > > > +	spin_lock(&port->lock);
> > > > +	cancel_rearming_delayed_work(&dcc_poll_task);
> > > 
> > > cancel_rearming_delayed_work() might sleep due to it calling
> > > flush_workqueue.  Therefore, you must not be holding a spinlock.
> > 
> > Thus, I've just revised the code to lock around a counter variable
> > operation, which is used for life control of the polling task.
> > I've just posted the revised #3. :-)
> 
> Why do you think you need such complexity?
> 
> cancel_rearming_delayed_work() will wait until the poll task has
> completed and has been removed from the system.  It's explicitly
> designed for work handlers which self-rearm.

Hmm.. Maybe you're right, because dcc_shutdown and dcc_startup, which
are the only functions that initiate or stop the work, will never be
called concurrently by different callers?

-- 
Hyok
ARM Linux 2.6 MPU/noMMU Project http://opensrc.sec.samsung.com/
