Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751746AbWGZVxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751746AbWGZVxT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 17:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751780AbWGZVxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 17:53:19 -0400
Received: from twinlark.arctic.org ([207.7.145.18]:50665 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP
	id S1751746AbWGZVxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 17:53:18 -0400
Date: Wed, 26 Jul 2006 14:53:17 -0700 (PDT)
From: dean gaudet <dean@arctic.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Jan Kasprzak <kas@fi.muni.cz>, linux-kernel@vger.kernel.org
Subject: Re: 3ware disk latency?
In-Reply-To: <1153946249.13509.29.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0607261440470.4568@twinlark.arctic.org>
References: <20060710141315.GA5753@fi.muni.cz> 
 <Pine.LNX.4.64.0607260942110.22242@twinlark.arctic.org>
 <1153946249.13509.29.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jul 2006, Alan Cox wrote:

> Ar Mer, 2006-07-26 am 09:52 -0700, ysgrifennodd dean gaudet:
> > On Mon, 10 Jul 2006, Jan Kasprzak wrote:
> > 
> > > 	Does anybody experience the similar latency problems with
> > > 3ware 95xx controllers? Thanks,
> > 
> > i think the 95xx is really bad at sharing its cache fairly amongst 
> > multiple devices... i have a 9550sx-8lp with 3 exported units: a raid1, a 
> > raid10 and a jbod.  i was zeroing the jbod with dd and it absolutely 
> > destroyed the latency of the other two units.
> 
> Even on the older 3ware I found it neccessary to bump up the queue sizes
> for the 3ware. There's a thread from about 6 months ago (maybe a bit
> more) with Jeff Merkey included where it made a huge difference to his
> performance playing with the parameters. Might be worth a scan through
> the archive.

yeah i've done some experiments with a multithreaded random O_DIRECT i/o 
generator where i showed the 9550sx peaking at around 192 threads... where 
"peak" means the latency was still reasonable (measured by iostat).  
obviously when going past 128 threads i found it necessary to increase 
nr_requests to see an improvement in io/s.  there was some magic number 
past 256 where i found the 3ware must have choked its own intnernal queue 
and latency became awful (istr it being 384ish but it probably depends on 
the io workload).

unfortunately when i did the experiment i neglected to perform 
simultaneous tests on more than one 3ware unit on the same controller.  i 
got great results from a raid1 or from a raid10 (even a raid5)... but 
never i only tested one unit at a time.

my production config has a raid1 and a raid10 unit on the same controller 
-- with 2 spare ports.  i popped a disk into one of the spare ports, told 
3ware it was JBOD and then proceeded to "dd if=/dev/zero of=/dev/sdX 
bs=1M"... and wham my system load avg shot up to 80+ (from ~4), all in D 
state.

i tried a bunch of things... lowering and raising nr_requests on all the 
devices, changing between cfq, deadline, etc.  the only solution i found 
to be effective in retaining acceptable latencies on the raid1/raid10 was 
to use "oflag=direct" for dd, and tell the 3ware to not use nvram for the 
jbod disk.

my suspicion is the 3ware lacks any sort of "fairness" in its sharing of 
buffer space between multiple units on the same controller.  and by 
disabling the write caching it limits the amount of controller memory that 
the busy disk can consume.

-dean
