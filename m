Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129763AbRAZUnb>; Fri, 26 Jan 2001 15:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130855AbRAZUnV>; Fri, 26 Jan 2001 15:43:21 -0500
Received: from cs.columbia.edu ([128.59.16.20]:64668 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S129763AbRAZUnG>;
	Fri, 26 Jan 2001 15:43:06 -0500
Date: Fri, 26 Jan 2001 12:43:02 -0800 (PST)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: "David S. Miller" <davem@redhat.com>
cc: <kuznet@ms2.inr.ac.ru>, <linux-kernel@vger.kernel.org>
Subject: Re: [UPDATE] Zerocopy patches, against 2.4.1-pre10
In-Reply-To: <14961.30709.761096.910725@pizda.ninka.net>
Message-ID: <Pine.LNX.4.30.0101261217260.20615-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jan 2001, David S. Miller wrote:

> Firstly, I would not configure the card to drop packets with bad
> checksums.  If you do this, the errors do not propagate into the
> correct ipv4 snmp tables, which is bad.  Also consider the case where
> the card has some bug and it erroneously verifies rx checksums in some
> strange cases, we would be hard pressed to find out with how you are
> configuring it in this way.

Ok. Makes sense. Consider it done.

> Next, please remove the unconditional:
>
> +				printk(KERN_DEBUG "sf: checksum_hw, status2 = %x\n", np->rx_done_q[np->rx_done].status2);
>
> or at the very least make it print out netdev->name instead of the
> cryptic "sf: " prefix.

I'll change the prefix, but I want to leave it there, because it never
triggered in my testing. And I'd really like it to annoy people so much
when it does trigger, that they report it back. :-)

> Finally, what are the listed distribution terms of this firmware?
> I want to make sure it is legal to distribute it.

Hmm, that's a very good question. I got the two firmware files from
Adaptec's Netware driver, and there is nothing in the archive or in those
files even remotely similar to a license or distribution terms. I guess
the best way to go about it would be to get an official answer from
Adaptec. Is there anybody out there with some Adaptec contacts who is
willing to step in and help with this?

In any case, I have the architecture description and instruction set of
the frame processor, so in the worst case I could simply reimplement the
code. It wouldn't be much different than the Adaptec aic7xxx sequencer
case.

Besides, I've done some more testing last night, and there are some
problems. The FP doesn't seem to like tinygrams too much, every once in a
while (but *not* always) it decides to send one with a bad checksum. I'm
talking especially about telnet tinygrams, where the second fragment is 1
byte. What's worse, it will also resend it with a bad checksum,
effectively killing the connection.

Could this be a bug in the upper layers, instead? How would I go about to
verify this? The only way I can think of is to verify that the checksum
field is zero initially, correct?

Also, after putting some more stress on the card, I managed to get it to
generate an abnormal interrupt (the "Something Wicked happened" thing),
and the error code translates to "GFP unable to calculate the checksum
(???) or not responding for 16 transmit cycles". And, since the reset
procedure is not implemented in the driver, this is quite deadly.

So I want to try and switch the transmit descriptor to the one used by
Netware, maybe the firmware was only tested with that descriptor. It also
fits the new Linux model a bit better, as it has one descriptor per
packet, not one per fragment (like the current implementation).

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
