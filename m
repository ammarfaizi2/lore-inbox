Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262010AbULMDiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262010AbULMDiM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 22:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262020AbULMDiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 22:38:12 -0500
Received: from colo.lackof.org ([198.49.126.79]:50339 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S262010AbULMDiF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 22:38:05 -0500
Date: Sun, 12 Dec 2004 20:36:55 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: frahm@irsamc.ups-tlse.fr
Cc: grundler@parisc-linux.org, linux-kernel@vger.kernel.org, jgarzik@pobox.org
Subject: Re: [Fwd: 2.6.10-rc3: tulip-driver: tulip_stop_rxtx() failed]
Message-ID: <20041213033655.GA26501@colo.lackof.org>
References: <20041212214803.GB22514@colo.lackof.org> <200412130219.iBD2JKF4001537@albireo.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412130219.iBD2JKF4001537@albireo.free.fr>
User-Agent: Mutt/1.3.28i
X-Home-Page: http://www.parisc-linux.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2004 at 03:19:20AM +0100, frahm@irsamc.ups-tlse.fr wrote:
> Dear Grant, 
> 
> I am happy to help and to see my feedback was indeed useful.

yes, indeed.

>  First I
> would like to add to my first message, that I have observed a kind of
> freezing for several seconds (5-10 seconds) of Firefox with one
> particular web-page which heavily uses a flashplayer- and jave-plugin.
> This does not appear in exactly the same form up to 2.6.10-rc2 but the
> web-page under consideration is always kind of "heavy" and difficult to
> load even with a high-speed connection. 

Sorry - while this sounds like a pre-emption/scheduling problem,
I'm not much help in dealing with it. And I'm no friend of flash player
though I understand why corporate types like it (form of DRM).
But I don't like flash as it tends to take over the user session.

...
> Dec 13 02:42:57 albireo kernel: Linux Tulip driver version 1.1.13 (May 11, 2002)

Oh..that reminds me to ask for the "date" to either be updated or removed.

...
> The values of CSR5 and CSR6 are reproduceable
> but different for activation and deactivation:
> 
>   activation: (CSR5 0xfc664010 CSR6 0xff972113)
> deactivation: (CSR5 0xfc06c012 CSR6 0xff970111)

Yes - I agree with you summary - Thanks!

The bits in CSR5 that I care about are TS (22:20) and RS (19:17).
For activation, TS is 6 and for deactivation it's 0. That's correct.
For activation and deactivation, RS is 3, and that's wrong.

TS
0 == Stopped--RESET command or STOP COMMAND issued, or transmit jabber expired
6 == Suspended--Transmit FIFO underflow, or an unavailable transmit descriptor

RS
3 == Running, waiting for RX packet

And in CSR6, I only care about ST (bit 13) and SR (bit 1).
For activation ST is 1 and deactivation it's 0.
But SR is always 1. Again, that's wrong but agrees with "CSR5.RS".

ST = Start/Stop transmission
SR = Start/Stop Receive

To summarize, the CSR5 and CSR6 values agree.
It looks like this chip does not implement shutting down the RX engine
*or* it just lies about the state of the machine.

My advice is do NOT ifdown the NIC once you bring it up as I'm inclined
to believe the former. If the RX machine really isn't stopped, it will
continue to DMA and corrupt memory. One would either need a PCI bus
analyzer or hack the code to monitor the RX descriptors and associated
buffers  *after* tulip_stop_rxtx() had been called to see if they
get modified.

> I have also joined the output of /proc/pci for the network card in case
> it may contain some useful information:
> 
>   Bus  0, device  14, function  0:
>     Ethernet controller: Linksys NC100 Network Everywhere Fast Ethernet 10/100 (rev 17).
>       IRQ 10.
>       Master Capable.  Latency=32.  Min Gnt=255.Max Lat=255.
>       I/O at 0xa400 [0xa4ff].
>       Non-prefetchable 32 bit memory at 0xe0000000 [0xe00003ff].

Nothing unusual here. Just good to document the defect.

thanks!
grant
