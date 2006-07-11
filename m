Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751115AbWGKSb7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbWGKSb7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 14:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbWGKSb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 14:31:58 -0400
Received: from javad.com ([216.122.176.236]:48394 "EHLO javad.com")
	by vger.kernel.org with ESMTP id S1751115AbWGKSb6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 14:31:58 -0400
From: Sergei Organov <osv@javad.com>
To: Andy Gay <andy@andynet.net>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH] Airprime driver improvements to allow full speed EvDO
	transfers
References: <1151646482.3285.410.camel@tahini.andynet.net>
Date: Tue, 11 Jul 2006 22:31:34 +0400
In-Reply-To: <1151646482.3285.410.camel@tahini.andynet.net> (Andy Gay's
	message of "Fri, 30 Jun 2006 01:48:02 -0400")
Message-ID: <874pxof0xl.fsf@javad.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Gay <andy@andynet.net> writes:
> Adapted from an earlier patch by Greg KH <gregkh@suse.de>.
> That patch added multiple read urbs and larger transfer buffers to allow
> data transfers at full EvDO speed.

Below are two more problems with the patch, one of which existed in the
original Greg's patch resulting in return with "Message too long"
(EMSGSIZE) from driver's open() function.

[...]

> +		/* something happened, so free up the memory for this urb /*

There should be '*/' at the end of this line, not '/*', otherwise the
driver even doesn't compile.

[...]
> +static int airprime_open(struct usb_serial_port *port, struct file *filp)
> +{
[...]
> +		usb_fill_bulk_urb(urb, serial->dev,
> +				  usb_rcvbulkpipe(serial->dev,
> +						  port->bulk_out_endpointAddress),

Here, it should obviously be port->bulk_in_endpointAddress, not
port->bulk_out_endpointAddress, otherwise devices that have endpoints
numeration like, say 0x01-out, 0x82-in (unlike more usual usual
0x01-out, 0x81-in), won't work returning -EMSGSIZE from open().

After these fixes, I've been able to run the driver with my own USB
device and achieved about 320 Kbytes/s read speed. That's still not very
exciting as I have another driver here in development that seems to be
able to do about 650 Kbytes/s with the same device.

-- 
Sergei.
