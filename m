Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268739AbUHTUo0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268739AbUHTUo0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 16:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268731AbUHTUls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 16:41:48 -0400
Received: from dh138.citi.umich.edu ([141.211.133.138]:29880 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S268734AbUHTUkW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 16:40:22 -0400
Subject: Re: Strange NFS client behavior on 2.6.6 and higher {Scanned}
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: rettw@rtwnetwork.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <32995.172.20.32.77.1093032267.squirrel@172.20.32.77>
References: <32995.172.20.32.77.1093032267.squirrel@172.20.32.77>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1093034419.17122.49.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 20 Aug 2004 16:40:20 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På fr , 20/08/2004 klokka 16:04, skreiv Rett D. Walters:

> Using a 2.4 client, the file slowly counts up as data is
> written when pushing to a 2.4 server.  Using 2.6.6 against
> a 2.6 server the file is written in large multi-megabyte
> clumps instead.

Probably. The VM decides when to push out data in 2.6.x. In 2.4.x we had
artificial hard limits on the number of dirty pages that were allowed to
exist, now all that is controlled by the VM.

>   However using a 2.6.6 client against a
> 2.4 server acts just like it used to, with a "trickle"
> write.

Huh?

>   A tcpdump trace of the 2.6.6 client against a 2.6
> server show no traffic being transmitted and then suddenly
> a burst of 20,000 packets sent then nothing, until the
> next burst.

See above. Note that this is pretty much the way block devices work
too...

> It appears to me that the 2.6.6 client against a 2.6
> server scenario that the 2.6.6 client is caching the data
> then writing it in these large clumps.  As a data comm
> engineer by profession, this seems a little strange. 
> Sending 20000 packets in large, very fast bursts will
> increase the likelyhood of causing congestion at the
> receiver which could lead to packet loss.

That's why we have added TCP support as well as congestion control
algorithms for UDP. I've seen no signs of new congestion issues with
2.6.x in tests on a clean network. Rather I've seen vastly improved
write performance against faster servers precisely because the new
VM-driven stuff allows us to cache more data both on the client and the
server side.

> I am using NFS v3 over UDP, and have tried using async and sync, and
> setting the rsize/wsize to 8k etc to no avail.

It sounds to me as if you really want to be using O_SYNC or (better
still) O_DIRECT writes. You basically want to stream the data to the
server immediately without any caching right?

The "sync" mount option should also give you similar behaviour.

Cheers,
  Trond
