Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751370AbVJYBPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbVJYBPU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 21:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751406AbVJYBPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 21:15:19 -0400
Received: from ns2.lanforge.com ([66.165.47.211]:13488 "EHLO ns2.lanforge.com")
	by vger.kernel.org with ESMTP id S1751370AbVJYBPS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 21:15:18 -0400
Message-ID: <435D8717.9000107@candelatech.com>
Date: Mon, 24 Oct 2005 18:15:03 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "John W. Linville" <linville@tuxdriver.com>
CC: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [patch 2.6.13 0/5] normalize calculations of rx_dropped
References: <09122005104858.332@bilbo.tuxdriver.com> <4325CEAB.2050600@pobox.com> <20050912191419.GB19644@tuxdriver.com> <435D53AE.3020401@candelatech.com> <20051024215751.GH28212@tuxdriver.com>
In-Reply-To: <20051024215751.GH28212@tuxdriver.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John W. Linville wrote:
> On Mon, Oct 24, 2005 at 02:35:42PM -0700, Ben Greear wrote:
> 
> 
>>It doesn't matter too much to me either way, but I'd like for there to
>>be a precisely documented definition for the various net-stats so that
>>I can correctly show the values to user-space (I can certainly add 
>>rx_discards
>>to rx_errors for a 'total rx errors' value, but I need to know whether
>>rx_discards is already in rx_errors to keep from counting things twice.)
> 
> 
> My opinion is that:
> 
> 	-- rx_errors should count all "on the wire" hardware errors;
> 
> 	-- rx_missed_errors should count frames w/ no "on the wire"
> 	errors that cannot be received by the hardware (generally
> 	due to lack of DMA bufers); and,
> 
> 	-- rx_discards should count frames dropped by the kernel
> 	after successful reception by the hardware.
> 
> I do _not_ think rx_missed_errors should be counted as part of
> rx_errors, but I could be persuaded otherwise.

Well, if we have rx_errors containing any of the other more specific
error counts (reported in the net-stats struct), I don't see a reason
not to include all of them in the counter.  I think my preference would
be to have rx_errors be every conceivable frame that we know was sent to
us but which did not get properly delivered to the software stack.

Each error would also fall into it's more specific counters.

That way, the rx-errors counter can be used for folks who just care
that the packet was not correctly received, and those that care about
the details can look at the individual errors (and sum them up in various
configurations due to personal taste, etc.)

That said, rx-errors would then be duplicate info because we could arrive
at it's value by just adding up all the other error counters....

> It does seem like a netdev stats clarification doc would be
> appropriate.  Does anyone have the beginnings of this?

It's not authoritative, but I scrounged this info from various people,
including Mr Becker some years ago.  I undoubtedly made some of this up
myself, and there could be errors of course:

rx_errors:  Total of all rx errors
rx_dropped:  Dropped on receive, usually due to kernel being over-worked.
rx_length:  Dropped because pkt-length was invalid.
rx_over:  Dropped because we over-ran the NIC's rx buffers.
rx_crc:  Packets received with bad CRC errors.
rx_frame:  Framing errors (errors at the physical layer), usually cable or hardware error.
rx_fifo:  Dropped due to Kernel buffers being full (I guess rx-over could be NIC only, rx-fifo be kernel/driver only.)
rx_missed:  Dropped due to not handling IRQ in time.

tx_abort:  Failed to TX due to driver abort.
tx_carrier:  Failed to TX due to lack of carrier signal.
tx_fifo:  Over-ran the driver/kernel buffer(s).
tx_heartbeat:  Failed to TX due to transceiver heartbeat errors.
tx_window:  Failed to TX due to out-of-window error.

Thanks,
Ben

> 
> John


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

