Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263952AbTGOGss (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 02:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263997AbTGOGss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 02:48:48 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:700
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263952AbTGOGsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 02:48:46 -0400
Date: Tue, 15 Jul 2003 09:03:14 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Chris Mason <mason@suse.com>,
       marcelo@conectiva.com.br, linux-kernel@vger.kernel.org, sct@redhat.com,
       alan@lxorguk.ukuu.org.uk, jgarzik@pobox.com, akpm@digeo.com,
       viro@math.psu.edu
Subject: Re: RFC on io-stalls patch
Message-ID: <20030715070314.GD30537@dualathlon.random>
References: <Pine.LNX.4.55L.0307141708210.8994@freak.distro.conectiva> <20030714202434.GS16313@dualathlon.random> <1058214881.13313.291.camel@tiny.suse.com> <20030714224528.GU16313@dualathlon.random> <1058229360.13317.364.camel@tiny.suse.com> <20030714175238.3eaddd9a.akpm@osdl.org> <20030715020706.GC16313@dualathlon.random> <20030715054551.GD833@suse.de> <20030715060101.GB30537@dualathlon.random> <20030715060857.GG833@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030715060857.GG833@suse.de>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 15, 2003 at 08:08:57AM +0200, Jens Axboe wrote:
> I don't see the 31% slowdown. We complete less tar loads, but only
> because there's less time to complete them in. Well almost, as you list

I see, so I agree the writer wrote at almost the same speed.

> I see tar making progress, how could it be stopped?

I didn't know the load was stopped after 249 seconds, I could imagine it,
sorry. I was probably obfuscated by the two severe problems the code had
that could lead to what I was expecting with more readers running
simultanously.

So those numbers sounds perfectly reproducible with a fixed patch too.

At the light of this latest info you convinced me you were right, I
probably understimated the value of the separated queues when I dropped
it to simplify the code.

I guess waiting the batch_sectors before getting a request for a read
was allowing another writer to get it first because the other writer was
already queued in the FIFO waitqueue when the writer got in. that might
explain the difference, the reserved requests avoid the reader to wait
for batch_sectors twice (that translates in 1/4 of the queue less to
wait at every I/O plus the obvious minor saving in less schedules and
waitqueue registration).

It'll be great to give another boost to the elevator-lowlatency thanks
to this feature.

thanks,

Andrea
