Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261851AbVDER0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbVDER0u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 13:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261848AbVDERYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 13:24:24 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:57565 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261840AbVDEREf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 13:04:35 -0400
Subject: Re: [Ext2-devel] Re: OOM problems on 2.6.12-rc1 with many fsx tests
From: Mingming Cao <cmm@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: andrea@suse.de, mjbligh@us.ibm.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, sct@redhat.com, janetinc@us.ibm.com
In-Reply-To: <20050404130441.53ab480b.akpm@osdl.org>
References: <20050315204413.GF20253@csail.mit.edu>
	 <20050316003134.GY7699@opteron.random>
	 <20050316040435.39533675.akpm@osdl.org>
	 <20050316183701.GB21597@opteron.random>
	 <1111607584.5786.55.camel@localhost.localdomain>
	 <20050403183544.7c31f85c.akpm@osdl.org>
	 <1112633417.3703.8.camel@dyn318043bld.beaverton.ibm.com>
	 <20050404130441.53ab480b.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 05 Apr 2005 10:04:31 -0700
Message-Id: <1112720671.3522.6.camel@dyn9047017080.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-04-04 at 13:04 -0700, Andrew Morton wrote:
> Mingming Cao <cmm@us.ibm.com> wrote:
> >
> > On Sun, 2005-04-03 at 18:35 -0700, Andrew Morton wrote:
> > > Mingming Cao <cmm@us.ibm.com> wrote:
> > > >
> > > > I run into OOM problem again on 2.6.12-rc1. I run some(20) fsx tests on
> > > >  2.6.12-rc1 kernel(and 2.6.11-mm4) on ext3 filesystem, after about 10
> > > >  hours the system hit OOM, and OOM keep killing processes one by one. I
> > > >  could reproduce this problem very constantly on a 2 way PIII 700MHZ with
> > > >  512MB RAM. Also the problem could be reproduced on running the same test
> > > >  on reiser fs.
> > > > 
> > > >  The fsx command is:
> > > > 
> > > >  ./fsx -c 10 -n -r 4096 -w 4096 /mnt/test/foo1 &
> > > 
> > > 
> > > This ext3 bug goes all the way back to 2.6.6.
> > 
> > > I don't know yet why you saw problems with reiser3 and I'm pretty sure I
> > > saw problems with ext2.  More testing is needed there.
> > > 
> > 
> > We (Janet and I) are chasing this bug as well. Janet is able to
> > reproduce this bug on 2.6.9 but I can't. Glad to know you have nail down
> > this issue on ext3. I am pretty sure I saw this on Reiser3 once, I will
> > double check it.  Will try your patch today.
> 
> There's a second leak, with similar-looking symptoms.  At ~50
> commits/second it has leaked ~10MB in 24 hours, so it's very slow - less
> than a hundredth the rate of the first one.
> 

I run the test(20 instances of fsx) with your patch on 2.6.12-rc1 with
512MB RAM (where I were able to constantly re-create the mem leak and
lead to OOM before). The result is the kernel did not get into OOM after
about 19 hours(before it took about 9 hours or so), system is still
responsive. However I did notice about ~60MB delta between Active
+Inactive and Buffers+cached+Swapcached+Mapped+Slab

Here is the current /proc/meminfo

elm3b92:~ # cat /proc/meminfo
MemTotal:       510400 kB
MemFree:         97004 kB
Buffers:        196772 kB
Cached:          77608 kB
SwapCached:          0 kB
Active:         299064 kB
Inactive:        83140 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       510400 kB
LowFree:         97004 kB
SwapTotal:     1052216 kB
SwapFree:      1052216 kB
Dirty:            1600 kB
Writeback:           0 kB
Mapped:          23256 kB
Slab:            24548 kB
CommitLimit:   1307416 kB
Committed_AS:    73560 kB
PageTables:        532 kB
VmallocTotal:   516024 kB
VmallocUsed:      3700 kB
VmallocChunk:   512320 kB



