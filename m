Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbTEMPNT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 11:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261319AbTEMPNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 11:13:18 -0400
Received: from ida.rowland.org ([192.131.102.52]:7172 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S261216AbTEMPNR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 11:13:17 -0400
Date: Tue, 13 May 2003 11:26:02 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Greg KH <greg@kroah.com>
cc: Paul Fulghum <paulkf@microgate.com>, Andrew Morton <akpm@digeo.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Arnd Bergmann <arnd@arndb.de>, <johannes@erdfelt.com>
Subject: Re: 2.5.69 Interrupt Latency
In-Reply-To: <20030512173023.GB28381@kroah.com>
Message-ID: <Pine.LNX.4.44L0.0305131117240.3274-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 May 2003, Greg KH wrote:

> > > This should only happen when your hardware receives a "RESUME" signal
> > > from a USB device AND the host controller is in a global suspend state
> > > at that time.
> > > 
> > > Now I think the wait_ms() call is valid for when this is really
> > > happening, but it sounds like you are having this happen all the time
> > > during normal operation.
> > 
> > It does appear to happen on a regular basis.
> > 
> > Should the 20ms delay be in the ISR though?
> > I thought it was standard practice to move such
> > lengthy operations outside of the ISR so as not to
> > impact interrupt latency for the system.
> 
> This should only happen when the hardware is suspended, and we are being
> woken up by a device.  So this should be a _very_ rare occurance, and
> when it does happen, the latency isn't that big of a deal (we need it to
> wake up the hardware properly.)

Putting in a sanity check for the global suspend state will be very easy.  
But I would like to point out that this "global suspend" does not refer to
the entire system, only the USB bus.  I'm not sure under what
circumstances the bus is placed in global suspend; I think it's just when
there are no devices attached (or the last remaining device is detached).

However, there have been cases on my own system where turning off the only
USB peripheral caused the driver to bounce between suspend_hc() and
wakeup_hc() several times without any apparent explanation -- possibly as
a result of transient electrical signals on the bus (?).  So perhaps
moving that delay out of the ISR isn't such a bad idea.

Alan Stern

