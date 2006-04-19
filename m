Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751222AbWDSUJS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbWDSUJS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 16:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbWDSUJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 16:09:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11669 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751137AbWDSUJR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 16:09:17 -0400
Date: Wed, 19 Apr 2006 13:09:08 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Grzegorz Kulewski <kangur@polcom.net>
cc: Diego Calleja <diegocg@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.17-rc2
In-Reply-To: <Pine.LNX.4.63.0604192101050.31989@alpha.polcom.net>
Message-ID: <Pine.LNX.4.64.0604191303050.3701@g5.osdl.org>
References: <Pine.LNX.4.64.0604182013560.3701@g5.osdl.org>
 <20060419200001.fe2385f4.diegocg@gmail.com> <Pine.LNX.4.64.0604191111170.3701@g5.osdl.org>
 <Pine.LNX.4.63.0604192101050.31989@alpha.polcom.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 19 Apr 2006, Grzegorz Kulewski wrote:
> 
> Suppose I am implementing hi performance HTTP (not caching) proxy that reads
> (part of?) HTTP header from A, decides where to send request from it, connects
> to the right host (B), sends (part of) HTTP header it already received and
> then wants to:
> 
> - make all further bytes from A be copied to B without using user space but no
> more than n bytes (n = request size it knows from header) or to the end of
> data (disconnect or something like that),
> 
> - make all bytes from B copied to A without using user space but no more than
> m bytes (m = response size from response header),
> 
> - stop both operations as soon as they copy enough data (assuming both sides
> are still connected) and then use sockets normally - to implement for example
> multiple requests per connection (keepalive).
> 
> Could it be done with splice() or tee() or some other kernel "accelerator"? Or
> should it be done in userspace by plain read and write?

You'd not use "tee()" here, because you never have any data that you want 
to go to two different destinations, but yes, you could use very 
well use splice() for this.

(well, technically you have the header part that you want to duplicate, 
and you _could_ use "tee()" for that, but it would be stupid - since you 
want to see the header in user space _anyway_ to see where to forward 
things, you just want to start out with a MSG_PEEK on the incoming socket 
to see the header, and then use splice, to splice it to the destination 
socket).

> And what if n or m is not known in advance but for example end of request is
> represented by <CR><LF><CR><LF> or something like that (common in some older
> protocols)?

At that point, you need to actually watch the data in user space, and so 
you need to do a real read() system call.

(Of course, the "kernel buffer" notion does allow for a notion of "kernel 
filters" too, but then you get to shades of STREAMS, and that just scares 
the crap out of me, so..)

			Linus
