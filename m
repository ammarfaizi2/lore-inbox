Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265399AbTIJRpq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 13:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265401AbTIJRpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 13:45:46 -0400
Received: from www.erfrakon.de ([193.197.159.57]:59910 "EHLO www.erfrakon.de")
	by vger.kernel.org with ESMTP id S265399AbTIJRpo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 13:45:44 -0400
From: Martin Konold <martin.konold@erfrakon.de>
Organization: erfrakon
To: Andrea Arcangeli <andrea@suse.de>,
       Luca Veraldi <luca.veraldi@katamail.com>
Subject: Re: Efficient IPC mechanism on Linux
Date: Wed, 10 Sep 2003 19:39:17 +0200
User-Agent: KMail/kroupware-RC2
References: <00f201c376f8$231d5e00$beae7450@wssupremo> <20030910165944.GL21086@dualathlon.random>
In-Reply-To: <20030910165944.GL21086@dualathlon.random>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200309101939.17967.martin.konold@erfrakon.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Wednesday 10 September 2003 06:59 pm schrieb Andrea Arcangeli:

Hi,

> design that I'm suggesting. Obviously lots of apps are already using
> this design and there's no userspace API simply because that's not
> needed.

HPC people have investigated High performance IPC many times basically it 
boils down to:

1. Userspace is much more efficient than kernel space. So efficient 
implementions avoid kernel space even for message transfers over networks 
(e.g. DMA directly to userspace). 

2. The optimal protocol to use and the number of copies to do is depending on 
the message size.

Small messages are most efficiently handled with a single/dual copy (short 
protocol / eager protocol) and large messages are more efficient with 
single/zero copy techniques (get protocol) depending if a network is involved 
or not.

Traditionally in a networked environment single copy means PIO and zero copy 
means DMA when using network hardware.

The idea is while DMA has much higher bandwidth than PIO DMA is more expensive 
to initiate than PIO. So DMA is only useful for large messages.

In the local SMP case there do exist userspace APIs like MPI which can do 
single copy Message passing at memory speed in pure userspace since many 
years.

The following PDF documents a measurement where the communication between two 
processes running on different CPUs in an SMP system is exactly the memcpy 
bandwidth for large messages using a single copy get protocol.

	http://ipdps.eece.unm.edu/1999/pc-now/takahash.pdf

Numbers from a Dual P-II-333, Intel 440LX (100MB/s memcpy)

					eager 	get
min. Latency µs		8.62		9.98
max Bandwidth MB/s	48.03	100.02
half bandwith point KB	0.3		2.5

You can easily see that the eager has better latency for very short messages 
and that the get has a max bandwidth beeing equivalent of a memcpy (single 
copy).

True zero copy has unlimited (sigh!) bandwidth within an SMP and does not 
really make sense in contrast to a network.

Regards,
-- martin

Dipl.-Phys. Martin Konold
e r f r a k o n
Erlewein, Frank, Konold & Partner - Beratende Ingenieure und Physiker
Nobelstrasse 15, 70569 Stuttgart, Germany
fon: 0711 67400963, fax: 0711 67400959
email: martin.konold@erfrakon.de
