Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264506AbTEPRDV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 13:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264508AbTEPRDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 13:03:21 -0400
Received: from ida.rowland.org ([192.131.102.52]:30212 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S264506AbTEPRDT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 13:03:19 -0400
Date: Fri, 16 May 2003 13:16:11 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Paul Fulghum <paulkf@microgate.com>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       <johannes@erdfelt.com>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: Test Patch: 2.5.69 Interrupt Latency
In-Reply-To: <1053101890.2606.5.camel@toshiba>
Message-ID: <Pine.LNX.4.44L0.0305161307390.1171-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 May 2003, Paul Fulghum wrote:

> Gack! I just thought of something else:
> 
> According to the 82371AB datasheet the controller
> itself sets the USBCMD_FGR bit when a global RD is
> detected. So qualifying the wakeup in software won't
> prevent the controller itself from starting the
> wakeup process on a false RD from an OC port. :-(
> 
> Hmmmm.... crap
> Is there a way around this or are we back to
> preventing the suspend?

It might not be that bad.  What will happen is that the controller will 
assert FGR and interrupt the host.  The driver will see the global RD, but 
will also see that it's present only on OC ports, so the driver will never 
leave the SUSPENDED state and will never write a 0 to FGR and EGSM.  Hence 
the controller will never become active -- the wakeup won't finish.

Of course, it's necessary to worry about what happens if one port is OC, 
so the controller is in this permanently-waking-up state, when a device is 
plugged into the other port.  I think this will re-assert global RD and 
generate another interrupt.  This time the driver will see that the RD is 
for real, so it will complete the wakeup sequence.

Neither of us can easily test that, because it requires one port to be 
broken and the other to be working.  But if everything else is okay, I 
think this will work too.

Alan Stern

