Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131214AbRARTpq>; Thu, 18 Jan 2001 14:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132643AbRARTpg>; Thu, 18 Jan 2001 14:45:36 -0500
Received: from Cantor.suse.de ([194.112.123.193]:5643 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S131398AbRARTpW>;
	Thu, 18 Jan 2001 14:45:22 -0500
Date: Thu, 18 Jan 2001 20:45:13 +0100
From: Andi Kleen <ak@suse.de>
To: Rick Jones <raj@cup.hp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
Message-ID: <20010118204513.A32521@gruyere.muc.suse.de>
In-Reply-To: <Pine.LNX.4.10.10101171259470.10031-100000@penguin.transmeta.com> <3A661A00.E3344A18@cup.hp.com> <20010118103414.A18205@gruyere.muc.suse.de> <3A6733E0.6286A388@cup.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A6733E0.6286A388@cup.hp.com>; from raj@cup.hp.com on Thu, Jan 18, 2001 at 10:20:16AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 18, 2001 at 10:20:16AM -0800, Rick Jones wrote:
> Andi Kleen wrote:
> > 
> > On Wed, Jan 17, 2001 at 02:17:36PM -0800, Rick Jones wrote:
> > > How does CORKing interact with ACK generation? In particular how it
> > > might interact with (or rather possibly induce) standalone ACKs?
> > 
> > It doesn't change the ACK generation. If your cork'ed packets gets sent
> > before the delayed ack triggers it is piggy backed, if not it is send
> > individually. When the delayed ack triggers depends; Linux has dynamic
> > delack based on the rtt and also a special quickack mode to speed up slow
> > start.
> 
> So if I understand  all this correctly...
> 
> The difference in ACK generation would be that with nagle it is a race
> between the standalone ack heuristic and the first byte of response
> data, with cork, the race is between the standalone ack heuristic and
> the last byte of response data and an uncork call, or the MSSth byte
> whichever comes first.

For the case of the cork'ed packet being at the beginning of the connection
(as http/1.0) then cork will not help much, because quickack will send an
ack immediately, but the write only occurs after the process got woken up.

For later cases it depends on the ack state -- 2.4 added more complicated
ack state (e.g "pingpong mode") to fix a few performance problems with the 
normal delack in uncommon situations.  In pingpong mode ack happens very
quickly, too fast for cork. 

I suspect at least persistent HTTP will be always affected by one of these
and generate more acks.




-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
