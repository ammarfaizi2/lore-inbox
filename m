Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268767AbUIXQIc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268767AbUIXQIc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 12:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268864AbUIXQIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 12:08:32 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:44447 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S268767AbUIXQI3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 12:08:29 -0400
Subject: Re: ldisc writes during tty release_dev() causing problems.
From: Ryan Arnold <rsa@us.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Theodore Ts'o" <tytso@mit.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1096029621.9790.8.camel@localhost.localdomain>
References: <1095273835.3294.278.camel@localhost>
	 <20040915204107.GA26776@thunk.org>
	 <1095988521.3372.240.camel@localhost.localdomain>
	 <1096029621.9790.8.camel@localhost.localdomain>
Content-Type: text/plain
Organization: IBM Linux Technology Center
Message-Id: <1096042734.3355.51.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 24 Sep 2004 11:18:54 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-09-24 at 07:40, Alan Cox wrote:

> > If tty release_dev() is called when write_chan() is blocked awaiting I/O
> > with the driver and tty->count == 1 the final call to driver->close()
> > will clean up the driver without the ldisc knowing that the driver has
> > closed the device.
> 
> That should not be possible. The terminal cannot be both blocking in
> write_chan and executing a close path for the final opener.

Thanks for the reply Alan,

I think I see what you mean.  The ldisc write_chan code is actually
invoked from the terminal process and if this is I/O blocked then the
terminal process cannot invoke release_dev().  So why did I experience
calls to hvc_write() after the final open instance was closed with
release_dev()?

> > Additionally, there doesn't seem to be anything to prevent hangup being
> > called on a tty during the final close operation (this actually happened
> > in hvc_console).
> 
> I had assumed would have to come from the serial side because if the
> last owner is executing close() they can't be executing vhangup on the
> same but given a rapid close/re-open/vhangup on a new fd it might be
> a dangerous assumption. Added to the TODO pile

In hvc_console we don't have a serial side, but I do have the device
side which will invoke a tty_hangup() if an hvc adapter was hotplug
removed.  This doesn't happen for the actual console adapter (hvc0)
because it isn't allowed in firmware.

So my strategy for now is going to be to get rid of the tty->driver_data
= NULL in hvc_close() and simply check the open count in hvc_hangup()
and hvc_write() to verify that these operations are actually relevant.

thanks again Alan,

Ryan S. Arnold
IBM Linux Technology Center

