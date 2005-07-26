Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261842AbVGZSxA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261842AbVGZSxA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 14:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261843AbVGZStp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 14:49:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:46736 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262018AbVGZSt1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 14:49:27 -0400
Date: Tue, 26 Jul 2005 11:48:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Memory pressure handling with iSCSI
Message-Id: <20050726114824.136d3dad.akpm@osdl.org>
In-Reply-To: <1122403152.6433.39.camel@dyn9047017102.beaverton.ibm.com>
References: <1122399331.6433.29.camel@dyn9047017102.beaverton.ibm.com>
	<20050726111110.6b9db241.akpm@osdl.org>
	<1122403152.6433.39.camel@dyn9047017102.beaverton.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
> On Tue, 2005-07-26 at 11:11 -0700, Andrew Morton wrote:
> > Badari Pulavarty <pbadari@us.ibm.com> wrote:
> > >
> > > After KS & OLS discussions about memory pressure, I wanted to re-do
> > >  iSCSI testing with "dd"s to see if we are throttling writes.  
> > > 
> > >  I created 50 10-GB ext3 filesystems on iSCSI luns. Test is simple
> > >  50 dds (one per filesystem). System seems to throttle memory properly
> > >  and making progress. (Machine doesn't respond very well for anything
> > >  else, but my vmstat keeps running - 100% sys time).
> > 
> > It's important to monitor /proc/meminfo too - the amount of dirty/writeback
> > pages, etc.
> > 
> > btw, 100% system time is quite appalling.  Are you sure vmstat is telling
> > the truth?  If so, where's it all being spent?
> > 
> > 
> 
> Well, profile doesn't show any time in "default_idle". So
> I believe, vmstat is telling the truth.
> 
> # cat /proc/meminfo
> MemTotal:      7143628 kB
> MemFree:         43252 kB
> Buffers:         16736 kB
> Cached:        6683348 kB
> SwapCached:       5336 kB
> Active:          14460 kB
> Inactive:      6686928 kB
> HighTotal:           0 kB
> HighFree:            0 kB
> LowTotal:      7143628 kB
> LowFree:         43252 kB
> SwapTotal:     1048784 kB
> SwapFree:      1017920 kB
> Dirty:         6225664 kB
> Writeback:      447272 kB
> Mapped:          10460 kB
> Slab:           362136 kB
> CommitLimit:   4620596 kB
> Committed_AS:   168616 kB
> PageTables:       2452 kB
> VmallocTotal: 34359738367 kB
> VmallocUsed:      9888 kB
> VmallocChunk: 34359728447 kB
> HugePages_Total:     0
> HugePages_Free:      0
> Hugepagesize:     2048 kB
> 

That is extremely wrong.  dirty memory is *way* too high.

> 
> # echo 2 > /proc/profile; sleep 5;  readprofile -
> m /usr/src/*12.3/System.map | sort -nr
> 1634737 total                                      0.5464
> 1468569 shrink_zone                              390.5769
>  21203 unlock_page                              331.2969
>  19497 release_pages                             46.8678
>  19061 __wake_up_bit                            397.1042
>  17936 page_referenced                           53.3810
>  10679 lru_add_drain                            133.4875

And so page reclaim has gone crazy.

We need to work out why the dirty memory levels are so high.

Can you please reduce the number of filesystems, see if that reduces the
dirty levels?

