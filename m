Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262035AbUDPCyW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 22:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262043AbUDPCyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 22:54:22 -0400
Received: from adsl-207-214-87-84.dsl.snfc21.pacbell.net ([207.214.87.84]:27797
	"EHLO lade.trondhjem.org") by vger.kernel.org with ESMTP
	id S262035AbUDPCyL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 22:54:11 -0400
Subject: Re: NFS and kernel 2.6.x
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andrew Morton <akpm@osdl.org>
Cc: shannon@widomaker.com, linux-kernel@vger.kernel.org
In-Reply-To: <20040415185355.1674115b.akpm@osdl.org>
References: <20040416011401.GD18329@widomaker.com>
	 <1082079061.7141.85.camel@lade.trondhjem.org>
	 <20040415185355.1674115b.akpm@osdl.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1082084048.7141.142.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 15 Apr 2004 19:54:08 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På to , 15/04/2004 klokka 18:53, skreiv Andrew Morton:
> But Charles was seeing good performance with 2.4-based clients.  When he
> went to 2.6 everything fell apart.
> 
> Do we know why this regression occurred?

What regression??? You have a statistic of 1 person whose 3 clients
changed from what was an apparently working setup to what has *always*
been the usual scenario for most people that tried to use the same
broken hardware/software combination whether it be in 2.2.x, 2.4.x or
2.6.x. 

The whole problem is that UDP provides unreliable transport... It offers
NO guarantees that the packet will arrive at the destination.
If only 1 fragment out of the 22 that it takes to send a single
wsize=32k write request to the Sun server gets lost on the way, the
Sun's networking layer will ignore that entire packet, and so the whole
write has to time out and get resent.
Switches can usually cache a few fragments if the clients on the 100Mbit
network are sending requests at a rate that almost matches the 10Mbit
bandwidth that the Sun server supports, but if the network is swamped so
that the switch runs out of cache, then it will start to drop packets.

This is the whole reason why Sun set TCP to be their default mount
option when the changed their servers to use 32k read/write.

My biggest suspect for why this particular setup changed in 2.6.x would
therefore be the changes to the way in which writes are scheduled on the
wire. We cache them for longer, and so overall the bandwidth usage goes
down, but at the expense of more "burstiness" when the user closes the
file or does some other fsync()-like operation.



So in fact you have 2 possible workarounds:

  - Use the TCP mount option (by far the better option, since TCP *does*
provide reliable transport).
  - Keep UDP, but use the wsize mount option to explicitly override the
server's choice of write sizes. That works by reducing the number of
fragments per write, and so improving performance by reducing the amount
of data that need to be resent per fragment lost.


Cheers,
  Trond
