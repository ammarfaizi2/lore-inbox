Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262492AbSKHWg6>; Fri, 8 Nov 2002 17:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262506AbSKHWg6>; Fri, 8 Nov 2002 17:36:58 -0500
Received: from bart.one-2-one.net ([217.115.142.76]:12807 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id <S262492AbSKHWgz>; Fri, 8 Nov 2002 17:36:55 -0500
Date: Fri, 8 Nov 2002 23:34:18 +0100 (CET)
From: Martin Diehl <lists@mdiehl.de>
X-X-Sender: martin@notebook.home.mdiehl.de
To: Jean Tourrilhes <jt@bougret.hpl.hp.com>
cc: rmk@arm.linux.org.uk,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [Serial 2.5]: packet drop problem (FE ?)
In-Reply-To: <20021108024058.GA1266@bougret.hpl.hp.com>
Message-ID: <Pine.LNX.4.44.0211081308190.1320-100000@notebook.home.mdiehl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Nov 2002, Jean Tourrilhes wrote:

> 	So, clearly it depend on the traffic pattern. And the move
> from 2.4.X to 2.5.X bring FE/drop in case where there was none,
> i.e. 2.5.X make it worse.
> 	And I'm wondering if it's just a case a crappy hardware, but
> there seems to be more.
> 
> 	From your description of what FE is, I don't understand how
> changing the kernel/driver/traffic pattern would make this number
> change. Puzzling...

Do you think it could be some kind of IR noise? Three points why I 
believe it might:

* FE indicates the UART fetched L instead of H when it expected to see the 
STOP bit. With SIR encoding L means IR-pulse and H means no IR-pulse, i.e. 
we've received an IR pulse at the very moment when we expected to see
silent media.

* Normally, I'm only getting very few of this, much less than 1 FE per MB 
traffic. However, if I'm starting placing objects (fingers f.e. ;-) close 
to any end into the IR-link I'm suddenly getting hundreds of this (within 
about a second). Using a CDR disc as IR mirror has a similar effect.

* Even without any IrDA activity I can trigger the FE's using some 
remote control as IR source directed to the dongle. (this is also 
causing BRK's, but I think this is due to particular remote control 
encoding).

The next to know is whether irtty_receive_buf() reports any "Framing or 
parity error"? IIRC with IGNPAR set we should neither get parity nor 
framing errors reported and it seems this is how serial8250_change_speed()
deals with ignore_status_mask. But wait - yes, 8250's receive_chars() 
seems to accept the character, but set TTY_FRAME anyway.

Hence irtty_receive_buf() finds it when scanning the fp-array. And here we 
have a difference between old and new irtty: the old one skipped the 
flagged byte but continued with the rest of the cp-chunk while the new one 
discards all bytes from this chunk. The idea was to avoid unwrapping and 
crc'ing data we already know being corrupted. But yes, it appears I was a 
bit too pessimistic there.

I'm just starting to wonder why we would like to check for flagged 
characters at all? Not doing so shouldn't cause any harm because we are 
sitting below the checksum handling and SIR unwrap - which has the frame 
state for better recovery. Sure, we could save handling corrupted data, 
but irtty has no good strategy to recover.

Ok, I think what might happen is you are receiving some kind of IR-noise 
(maybe environment, maybe reflected, maybe dongle echo) causing bytes with 
framing errors to get passed to and handled by irtty in one go with the 
beginning of the first byte(s) from the next incoming frame. Thus we 
discard the BOF and the whole frame is missed :-(

Could you try to disable the fp-scanning in irtty_receive_buf() to see if 
this helps wrt. to dropped frames?

If it does, I'd say we should do it, i.e. completely ignore the fp-array.
Note this is not identical to old irtty either, because we don't remove 
the flagged chars. But at this point we don't know whether they are really 
bogus or it's just an IR-spike making invalid STOP bit. IMHO wrapper+crc
will detect this - do you have any objections? 

Martin

