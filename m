Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262470AbTIPUbe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 16:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262472AbTIPUbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 16:31:34 -0400
Received: from chaos.analogic.com ([204.178.40.224]:47751 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262470AbTIPUbb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 16:31:31 -0400
Date: Tue, 16 Sep 2003 16:34:31 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Vishwas Raman <vishwas@eternal-systems.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Incremental update of TCP Checksum
In-Reply-To: <3F6770CE.8040802@eternal-systems.com>
Message-ID: <Pine.LNX.4.53.0309161628400.31431@chaos>
References: <3F3C07E2.3000305@eternal-systems.com> <20030821134924.GJ7611@naboo>
 <3F675B68.8000109@eternal-systems.com> <Pine.LNX.4.53.0309161533030.30081@chaos>
 <3F6770CE.8040802@eternal-systems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Sep 2003, Vishwas Raman wrote:

>
> Richard B. Johnson wrote:
> > On Tue, 16 Sep 2003, Vishwas Raman wrote:
> >
> >
> >>Hi all,
> >>
> >>I have a very simple question, which a lot of you would have solved. I
> >>am intercepting a TCP packet, which I would like to change slightly.
> >>
> >>Let's say, I change the doff field of the tcp-header (for eg: increase
> >>it by 1). I know it is wrong just to change the doff field without
> >>increasing the packet length, but lets say I do it just as a test. Since
> >>I changed a portion of the tcp header, I have to update the tcp checksum
> >>too right!!! If so, what is the best way to do so, without having to
> >>recalculate the entire tcp checksum (I know how to recalculate the
> >>checksum from scratch).
> >>
> >>Can anyone out there tell me the algorithm to update the checksum
> >>without having to recalculate it.
> >>
> >>I tried the following algorithm but it didnt work. The packet got
> >>rejected as a packet with bad cksum.
> >>
> >>void changePacket(struct sk_buff* skb)
> >>{
> >>     struct tcphdr *tcpHdr = skb->h.th;
> >>     // Verifying the tcp checksum works here...
> >>     tcpHeader->doff += 1;
> >>     long cksum = (~(tcpHdr->check))&0xffff;
> >>     cksum += 1;
> >>     while (cksum >> 16)
> >>     {
> >>         cksum = (cksum & 0xffff) + (cksum >> 16);
> >>     }
> >>     tcpHeader->check = ~cksum;
> >>     // Verifying tcp checksum here fails with bad cksum
> >>}
> >>
> >>Any pointers/help in this regard will be highly appreciated...
> >
> >
> > The TCP/IP checksum is a WORD sum (unsigned short) in which
> > any overflow out of the word causes the word to be incremented.
> > The final sum is then inverted to become the checksum. Note that
> > many algorithms sum into a long then fold-back the bits. It's
> > the same thing, different method.
> >
> > Therefore:
> > 	Given an existing checksum of 0xffff, if the
> > 	next word to be summed is 0x0001, the result
> > 	will be 0x0001 because adding 1 to 0xffff makes
> > 	it 0, causing an overflow which propagates to
> > 	become 0x0001.
> > So:
> > 	Clearly, information is lost because one doesn't
> > 	know how the 0x0001 was obtained.
> >
> > If I were to modify a low byte somewhere by subtracting 1,
> > would I know that the new checksum, excluding the inversion,
> > was 0x0000? No. It could be 0xffff.
> >
> > This presents a problem when trying to modify existing checksums.
> > It's certainly easier to set the existing checksum to 0, then
> > re-checksum the whole packet. It's probably faster than some
> > looping algorithm that attempts to unwind a previous checksum.
>
> Are you then suggesting that instead of trying to do an incremental
> update of the tcp checksum, I set it to 0 and recalculate it from
> scratch? But I thought that doing that was a big performance hit.
> Isn't it?
>

I would just do it. No TCP/IP checksum is a "big performance hit".
An ordinary 'C' procedure does it in about 1.3 CPU clocks/byte.
The ASM checksum routine does it in about 0.54 CPU clocks/byte.
This is basically the time necessary to access memory.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (794.73 BogoMips).
            Note 96.31% of all statistics are fiction.


