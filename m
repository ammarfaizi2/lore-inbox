Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261395AbVAGRwl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261395AbVAGRwl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 12:52:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261381AbVAGRwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 12:52:14 -0500
Received: from fw.osdl.org ([65.172.181.6]:37055 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261382AbVAGRsd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 12:48:33 -0500
Date: Fri, 7 Jan 2005 09:48:23 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Oleg Nesterov <oleg@tv-sign.ru>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Make pipe data structure be a circular list of pages, rather
 than
In-Reply-To: <Pine.LNX.4.58.0501070923590.2272@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0501070936500.2272@ppc970.osdl.org>
References: <41DE9D10.B33ED5E4@tv-sign.ru>  <Pine.LNX.4.58.0501070735000.2272@ppc970.osdl.org>
 <1105113998.24187.361.camel@localhost.localdomain>
 <Pine.LNX.4.58.0501070923590.2272@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 7 Jan 2005, Linus Torvalds wrote:
> 
> So the "standard behaviour" (aka just plain read/write on the pipe) is all
> the same copies that it used to be.

I want to highlight this again. The increase in throughput did _not_ come
from avoiding a copy. It came purely from the fact that we have multiple
buffers, and thus a throughput-intensive load gets to do several bigger
chunks before it needs to wait for the recipient. So the increase in
throughput comes from fewer synchronization points (scheduling and
locking), not from anything else.

Another way of saying the same thing: pipes actually used to have clearly
_lower_ bandwidth than UNIX domain sockets, even though clearly pipes are
simpler and should thus be able to be faster. The reason? UNIX domain
sockets allow multiple packets in flight, and pipes only used to have a
single buffer. With the new setup, pipes get roughly comparable
performance to UNIX domain sockets for me.

Sockets can still outperform pipes, truth be told - there's been more
work on socket locking than on pipe locking. For example, the new pipe
code should conceptually really allow one CPU to empty one pipe buffer
while another CPU fills another pipe buffer, but because I kept the
locking structure the same as it used to be, right now read/write
serialize over the whole pipe rather than anything else.

This is the main reason why I want to avoid coalescing if possible: if you
never coalesce, then each "pipe_buffer" is complete in itself, and that
simplifies locking enormously.

(The other reason to potentially avoid coalescing is that I think it might
be useful to allow the "sendmsg()/recvmsg()" interfaces that honour packet
boundaries. The new pipe code _is_ internally "packetized" after all).

				Linus
