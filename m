Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273890AbRIRUCi>; Tue, 18 Sep 2001 16:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273891AbRIRUC3>; Tue, 18 Sep 2001 16:02:29 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:2062 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S273890AbRIRUCN>; Tue, 18 Sep 2001 16:02:13 -0400
Message-ID: <3BA7A853.4EC44195@zip.com.au>
Date: Tue, 18 Sep 2001 13:02:27 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10-pre11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Stephan von Krawczynski <skraw@ithnet.com>, jogi@planetzork.ping.de,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.10-pre11: alsaplayer skiping during kernel build (-pre10 did 
 not)
In-Reply-To: <20010918171416.A6540@planetzork.spacenet> <20010918172500.F19092@athlon.random> <20010918173515.B6698@planetzork.spacenet> <20010918174434.I19092@athlon.random> <20010918175104.D6698@planetzork.spacenet> <20010918212856.50cd5b87.skraw@ithnet.com>,
		<20010918212856.50cd5b87.skraw@ithnet.com>; from skraw@ithnet.com on Tue, Sep 18, 2001 at 09:28:56PM +0200 <20010918214152.A720@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> I now have an update ready for Linus to merge that should fix the few
> leftovers I had in the very first release of the vm rewrite but of
> course I will be interested to hear about any regression/progression
> about those changes, I'll post them in a few minutes in CC to l-k.
> 

Please include Andi's likely()/unlikely() change - it's nice.

I can't measure any obviously new causes of latency in your
VM.  It's nice that you've paid attention to this in various
places.

The main culprits now are the file IO and dirty buffer writeout paths:
up to fifty milliseconds in each.

I suggest you stick scheduling points in generic_file_read(),
generic_file_write() and write_locked_buffers() and then dispose
of the copy-user-latency patch from -aa kernels.

With the above fixed, the main source of latency is
/proc/meminfo->si_swapinfo(). It's about five milliseconds per gig
of swap, which isn't too bad.  But it's directly invokable by
userspace (ie: /usr/bin/top) and really should be made less dumb.
