Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264274AbUEXULK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264274AbUEXULK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 16:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264585AbUEXULK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 16:11:10 -0400
Received: from mail.kroah.org ([65.200.24.183]:9682 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264274AbUEXULE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 16:11:04 -0400
Date: Mon, 24 May 2004 13:06:11 -0700
From: Greg KH <greg@kroah.com>
To: nardelli <jnardelli@infosciences.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [PATCH] visor: Fix Oops on disconnect
Message-ID: <20040524200611.GC4558@kroah.com>
References: <40AD3A88.2000002@infosciences.com> <20040521043032.GA31113@kroah.com> <40AE5DBB.6030003@infosciences.com> <20040521204430.GA5875@kroah.com> <40AE7829.9060105@infosciences.com> <40AE7CFE.5060805@infosciences.com> <20040521223024.GA7399@kroah.com> <40B22EED.4080808@infosciences.com> <40B24F52.8050805@infosciences.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40B24F52.8050805@infosciences.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2004 at 03:38:58PM -0400, nardelli wrote:
> nardelli wrote:
> >
> >One more question - my system does not really like it when I redirect 
> >/dev/urandom
> >to either the first or second port.  I know that it obviosuly makes no 
> >sense to
> >do such a thing, but is it expected that there should be no problems 
> >associated
> >with this.  I'm not finished testing, so I'm not sure how severe a problem 
> >develops.
> >I'll report in when I know more about this.
> >
> 
> Here's some preliminary info:
> 
> 1) Whether writing to the 1st or 2nd port, the machine hangs pretty badly
> after catting /dev/urandom for more than 1 second or two.  This continues
> even after catting has stopped, and the device has been disconnected.  This
> smells like some type of resource leak, probably memory, to me.

Which machine dies?  The pilot or the Linux box?

> 2) I've included an Oops when writing to the 1st serial port, showing some
> difficulty allocating memory.

So we ran out of memory?  Not good.

> 3) After looking at visor_write(), I was a bit surprised to see it
> allocating its own urb and buffer, while I thought it would be using
> the ones that were allocated in usb-serial.usb_serial_probe().  After
> looking at other serial devices that use usb_submit_urb() in their
> write() functions, I found that the following used the buffers/urb
> allocated for them:
> 
> cyberjack, digi_acceleport, generic, io_ti, ipaq, ir-usb, keyspan_pda,
> kobil_sct, mct_u232, omninet, pl2303, safe_serial
> 
> while I found that the following created their own (some for each write):
> 
> empeg, ftdi_sio, keyspan, kl5kusb105, visor, whiteheat
> 
> I'm not so sure about:
> io_edgeport

It uses it's own buffers from what I remember.

> Is this expected behavior, or am I just missing something here?

Expected, not all of the usb-serial drivers have to do the same thing,
as they operate on very different types of hardware.

> It would seem like reusing the buffer and urb would be advantageous,
> but there may be more issues here than I am aware of.

Reusing the buffer and urb is _slow_.  The visor driver creates a new
buffer for every call to write.  It is entirely possible that you can
starve the kernel of memory by sending it the output of a raw device
node, as that data comes faster than the USB data can be sent.

But this is a different problem from the one you originally set out to
fix, how about sending a new patch for the treo disconnect problem, and
then we can work on the next issues.

thanks,

greg k-h
