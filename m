Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317012AbSF1Qks>; Fri, 28 Jun 2002 12:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317457AbSF1Qkr>; Fri, 28 Jun 2002 12:40:47 -0400
Received: from mailrelay2.lanl.gov ([128.165.4.103]:3723 "EHLO
	mailrelay2.lanl.gov") by vger.kernel.org with ESMTP
	id <S317012AbSF1Qkq>; Fri, 28 Jun 2002 12:40:46 -0400
Date: Fri, 28 Jun 2002 10:43:06 -0600 (MDT)
From: "Hurwitz Justin W." <hurwitz@lanl.gov>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: zero-copy networking & a performance drop
In-Reply-To: <20020628113310.D647@nightmaster.csn.tu-chemnitz.de>
Message-ID: <Pine.LNX.4.44.0206281021160.12596-100000@alvie-mail.lanl.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jun 2002, Ingo Oeser wrote:

> Jupp, I think this is really true. Look at all the checking alone. 
> 
> Remember: We accept data from an untrusted source (network) which
>    has lots of control information encoded with many of them
>    being optional.
> 
>    -> This involves a lot of "parsing" (for binary streams,
>       decoding might be better) of a complex language (TCP/IP ;-))
>       with many optional elements (read: lots of branches in the
>       language tree).
>       
> On sending data, we have all the information trusted, because we
> checked that already, as the user sets it. With sendfile, we have
> even trusted and mapped data (because we just paged it in before).
> 
> If we take this into account, rx MUST be always slower, or tx
> isn't really optimized yet.

Indeed, the above does make sense. But, what about when the receive side
is trustable, too. This is obviously not the normal case; but with
quadrics I think that it is. Since quadrics is a shared memory
architecture, with all of the processing taken care of on the cards, we
should be able to reliably trust the receive side as much as the send
side. Unless I'm misunderstanding your use of trust?

If I am right on this, how much of an overhaul would it be to implement, 
for instance, a NETIF_RX_TRUSTED flag in the net_device struct to force a 
receive side fast path? I don't expect this to bring the receive side even 
with the transmit side, but right now we (and I have heard the same from 
others) are running at ~70% of the transmit side on the receive side, 
which seems to leave a good margin for improvement. 

This seems like it could be useful not just for the special case of 
quadrics (and other shared mamory architectures)- if, for instance, cards 
begin to do more TCP processing in hardware (or we modify the firmware to 
do this for us, ala AceNIC), it would be nice to bypass it in the kernel. 
This is, of course, a quick idea that's just popped into my head, and 
probably is inherently impossible or foolish :)

--Gus

