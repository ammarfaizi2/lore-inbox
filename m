Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261928AbUEEEbU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbUEEEbU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 00:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262100AbUEEEbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 00:31:20 -0400
Received: from web12823.mail.yahoo.com ([216.136.174.204]:26725 "HELO
	web12823.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261928AbUEEEbQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 00:31:16 -0400
Message-ID: <20040505043115.92441.qmail@web12823.mail.yahoo.com>
Date: Tue, 4 May 2004 21:31:15 -0700 (PDT)
From: Shantanu Goel <sgoel01@yahoo.com>
Subject: Re: [VM PATCH 2.6.6-rc3-bk5] Dirty balancing in the presence of mapped pages
To: Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>
Cc: sgoel01@yahoo.com, linux-kernel@vger.kernel.org
In-Reply-To: <20040504195753.0a9e4a54.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Andrew Morton <akpm@osdl.org> wrote:
> > > And what were the effects of this patch?

Below are some results of an iozone run on
ext3 with ordered data mode.  The machine is 2xXeon
with HT and 1.25GB of memory and a 15000rpm SCSI disk.

iozone was run with the following parameters:
  iozone -c -B -R -i 0 -r <record length> -s 1944978

The file size is 50% more than the amount of RAM.

2.6.6-rc3-bk5 stock (all KBytes):

        record        write        re-write
             4       110752           19143
             8       109818           17726
            16       112165           17053
            32       109824           17096

2.6.6-rc3-bk5 patched (all KBytes):

        record        write        re-write
             4       114284           17467
             8       117902           17149
            16       117835           18742
            32       118102           18961

Difference from stock (%):

        record        write        re-write
             4         +3.0             -8.7
             8         +7.3             -3.2
            16         +5.0             +9.9
            32         +7.5            +10.9

It seems this patch helps writes a bit but hurts
re-writes for smaller record sizes.  My guess is the
larger block size enables this patch to reduce the #
I/O requests.  I'll investigate this further and also
run the random write test when I get a chance.

> In this case, given that we have an actively mapped
> MAP_SHARED pagecache
> page, marking it dirty will cause it to be written
> by pdflush.  Even though
> we're not about to reclaim it, and even though the
> process which is mapping
> the page may well modify it again.  This patch will
> cause additional I/O.
> 

True, but is that really very different from normal
file I/O where we actively balance # dirty pages? 
Also, the I/O will only happen if the dirty thresholds
are exceeded.  It probably makes sense though to skip
SwapCache pages to more closely mimic file I/O
behaviour.

> So we need to understand why it was written, and
> what effects were
> observed, with what workload, and all that good
> stuff.
> 

My motivation was the NFS/WRITEPAGE_ACTIVATE
discussion and gobs of mmap'ed sequential writes.  If
we can detect dirty pages before they need to be
reclaimed and submit them for writeback, the NFS layer
will be hopefully be able to combine them into bigger
requests thereby reducing # RPCs.  This works well in
the file I/O case so I figured it might work equally
well in the mmap case.  The results are still pending
though.  I posted the patch to get feedback on whether
people see any fundamental flaw in this approach.

> > It doesn't do the wakeup_bdflush thing, but that
> sounds
> > like a good idea. What does wakeup_bdflush(-1)
> mean?
> 
> It appears that it will cause pdflush to write out
> down to
> dirty_background_ratio.

Yup, the idea is to mimic the balance_dirty_pages()
behaviour but not to force writes unless required by
the dirty ratios.

Thanks,
Shantanu



	
		
__________________________________
Do you Yahoo!?
Win a $20,000 Career Makeover at Yahoo! HotJobs  
http://hotjobs.sweepstakes.yahoo.com/careermakeover 
