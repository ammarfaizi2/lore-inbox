Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261897AbUK0G1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261897AbUK0G1M (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 01:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbUK0G1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 01:27:09 -0500
Received: from zeus.kernel.org ([204.152.189.113]:49599 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261962AbUKZTMk (ORCPT
	<rfc822;Linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:12:40 -0500
From: David Brownell <david-b@pacbell.net>
To: Colin Leroy <colin.lkml@colino.net>
Subject: Re: [linux-usb-devel] [PATCH] Ohci-hcd: fix endless loop (second take)
Date: Fri, 26 Nov 2004 09:57:52 -0800
User-Agent: KMail/1.7.1
Cc: linux-usb-devel@lists.sourceforge.net, Colin Leroy <colin@colino.net>,
       Linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>
References: <20041126113021.135e79df@pirandello> <200411260928.18135.david-b@pacbell.net> <20041126183749.1a230af9@jack.colino.net>
In-Reply-To: <20041126183749.1a230af9@jack.colino.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411260957.52971.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 26 November 2004 09:37, Colin Leroy wrote:
> On 26 Nov 2004 at 09h11, David Brownell wrote:
> > This isn't a good patch either... maybe your best
> > bet would be to find out why the IRQs stopped getting
> > delivered.
> 
> It's probably a linux-wlan-ng issue... 

I suspect PPC resume issues myself.


> What do you think  
> of these logs ?
> 
> #resume logs... 
> #disconnecting the stick:
> usb 4-1: USB disconnect, address 2
> ohci_hcd 0001:10:1b.1: IRQ INTR_SF lossage

That does seem to be the first problem; fixing
it (that is, making sure IRQs arrive again!)
should make the rest go away.


> hfa384x_usbin_callback: Fatal, failed to resubmit rx_urb. error=-19
> hfa384x_dorrid: ctlx failure=REQ_TIMEOUT
> prism2sta_mlmerequest: Failed to read eth1 statistics: error=-5

Those look like plausible ways for that driver to
behave.  "-19" == "-ENODEV" for device-gone (you
unplugged it!), though the rest (timeout, EIO)
suggest that WLAN code fault recovery is wierd.


> #reconnecting the stick:
> usb 4-1: new full speed USB device using address 3
> usb 4-1: control timeout on ep0out

As expected, if IRQs aren't arriving.  Though you
may not be using the latest kernel; it's supposed
to give warnings about IRQ delivery problems after
resume too, not just on initial startup.


> maybe the lwlan driver should catch these and kill the urbs or
> something? 

The only obvious "looks wrong" thing from that WLAN
code is discarding the non-recoverable ENODEV status
in favor of reporting a usually-recoverable (timeout)
then maybe-recoverable (EIO) error.  But that's not
necessarily troublesome here.


> Thanks for your help, I'm not an expert at all in the usb world...

Most people aren't... :)

I'm not expert in PPC IRQ delivery, which is where the
root cause of this problem seems to live.  We all have
places where we need help!

- Dave

