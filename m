Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277282AbRJNTdN>; Sun, 14 Oct 2001 15:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277281AbRJNTcF>; Sun, 14 Oct 2001 15:32:05 -0400
Received: from cs181088.pp.htv.fi ([213.243.181.88]:33920 "EHLO
	cs181088.pp.htv.fi") by vger.kernel.org with ESMTP
	id <S277275AbRJNTbs>; Sun, 14 Oct 2001 15:31:48 -0400
Message-ID: <3BC9E830.9F33F893@welho.com>
Date: Sun, 14 Oct 2001 22:32:00 +0300
From: Mika Liljeberg <Mika.Liljeberg@welho.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10-ac10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kuznet@ms2.inr.ac.ru
CC: ak@muc.de, davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: TCP acking too fast
In-Reply-To: <200110141912.XAA06706@ms2.inr.ac.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kuznet@ms2.inr.ac.ru wrote:
> 
> Hello!
> 
> > > But sending ACK on buffer drain at least for short
> > > packets is real demand, which cannot be relaxed.
> >
> > Why? This one has me stumped.
> 
> To remove sick delays with nagling transfers (1) and to remove
> deadlocks due to starvation on rcvbuf (2) at receiver and on sndbuf
> at sender (3).
> 
> Actually, (2) is solved nowadays with compressing queue. (3) can be solved
> acking each other segment. But (1) remains.
> 
> Actually, any alternative idea how to solve this could be very useful.

And why (1) is a problem is precisely what I don't understand. Nagle is
*supposed* to prevent you from sending multiple remnants. If you don't
like it, you disable it in the sender! However:

The only awkward Nagle-related delay I know of appears with e.g. HTTP,
when the last undersized segment cannot be sent before everything else
is acked. This can be solved using an idea from Greg Minshall, which I
thought was quite cool.

The normal Nagle rule goes:

 - You cannot send a remnant if there are any unacknowledged segments
outstanding

Minshall's version goes:

 - You cannot send a remnant if there is already one unacknowledged
remnant outstanding

This fixes the trailing remnant problem with HTTP and similar
request-reply protocols, while adherring to the spirit of Nagle. There
was even an I-D at some point but for some reason it has not been
updated.

> Alexey

Regards,

	MikaL
