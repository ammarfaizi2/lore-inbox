Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270816AbUJUT5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270816AbUJUT5n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 15:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270911AbUJUTsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 15:48:18 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:64609 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S270910AbUJUTot
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 15:44:49 -0400
Subject: Re: belkin usb serial converter (mct_u232), break not working
From: Paul Fulghum <paulkf@microgate.com>
To: Thomas Stewart <thomas@stewarts.org.uk>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1098362487.2815.9.camel@deimos.microgate.com>
References: <200410201946.35514.thomas@stewarts.org.uk>
	 <200410202308.02624.thomas@stewarts.org.uk>
	 <1098311228.6006.3.camel@at2.pipehead.org>
	 <200410210004.13214.thomas@stewarts.org.uk>
	 <1098326278.6017.19.camel@at2.pipehead.org> <20041021100637.GA7003@diamond>
	 <1098362487.2815.9.camel@deimos.microgate.com>
Content-Type: text/plain
Message-Id: <1098387861.3288.51.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 21 Oct 2004 14:44:22 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-21 at 07:41, Paul Fulghum wrote:
> On Thu, 2004-10-21 at 05:06, Thomas Stewart wrote:
> > As you can see, this time there is the correct pause. However
> > it still does not send the break.
> > 
> > To add the mix, I dug about and found a differnt type of USB serial
> > converter, a no-brand one that uses the pl2303 module. Both minicom
> > and porttest with either stock 2.6.8.1 or 2.6.8.1 with your patch
> > send the break fine with this different converter.
> > 
> > This makes me think it is a problem with the mct_u232 driver?
> 
> OK. This problem has multiple parts.
> 
> The change to tty_io.c is necessary to get the proper delay
> between setting and clearing break. I will submit that
> patch for inclusion.
> 
> Now it is a matter of figuring why the device is not
> sending the break. The device break_ctl() gets called,
> and the URB to set the line control is sent successfully.
> 
> Maybe the comments are wrong on the line control bits
> or possibly the Belkin device requires some other setup
> to send breaks.

I looked at mct_232.h and noticed the comment:

"There seem to be two bugs in the Win98 driver:
the break does not work (bit 6 is not asserted) and the
stick parity bit is not cleared when set once."
The driver was reverse engineered from the Win98 driver.

Even though the LCR for this device is similar to
the LCR of a 16550 UART, some bits work differently.

This suggests to me that either the device does not
properly support break, or that the break is
controlled through a different USB request and not
through MCT_U232_SET_LINE_CTRL_REQUEST

The Linux and FreeBSD drivers do the same thing
for setting break, so no new info there.
I don't have access to the device or manufacturer docs.

The only thing I can suggest is if you have
access to a Windows 2000/XP machine, try and generate
a break with the manufacturer provided drivers.
If you can't, then the device does not support break.
If you can, then maybe you can use USB sniffer
software to look at the USB requests going to the device.

-- 
Paul Fulghum
paulkf@microgate.com

