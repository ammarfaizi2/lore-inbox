Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936542AbWLAUDq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936542AbWLAUDq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 15:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936539AbWLAUDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 15:03:45 -0500
Received: from mga09.intel.com ([134.134.136.24]:17256 "EHLO mga09.intel.com")
	by vger.kernel.org with ESMTP id S936542AbWLAUDo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 15:03:44 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,486,1157353200"; 
   d="scan'208"; a="22061444:sNHT20166993"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Chris Mason'" <chris.mason@oracle.com>
Cc: "'Zach Brown'" <zach.brown@oracle.com>, "Andrew Morton" <akpm@osdl.org>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: RE: [rfc patch] optimize o_direct on block device
Date: Fri, 1 Dec 2006 12:03:44 -0800
Message-ID: <000001c71583$cdfc94d0$ff0da8c0@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AccVXlvQvp9x7IHFRLGpx26rAby/IAAIwEag
In-Reply-To: <20061201153659.GL7888@think.oraclecorp.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason wrote on Friday, December 01, 2006 7:37 AM
> > It benefit from shorter path length. It takes much shorter time to process
> > one I/O request, both in the submit and completion path.  I always think in
> > terms of how many instructions, or clock ticks does it take to convert user
> > request into bio, submit it and in the return path, to process the bio call
> > back function and do the appropriate io completion (sync or async).  The
> > stock 2.6.19 kernel takes about 5.17 micro-seconds to process one 4K aligned
> > DIO (just the submit and completion path, less disk I/O latency).  With the
> > patch, the time is reduced to 4.26 us.
> 
> I'm not completely against a minimal DIO implementation for the block
> device, but right now we get block device QA for free when we test the
> rest of the DIO code.  Splitting the code base makes DIO (already a
> special case) that much harder to test.
> 
> It's obvious there's a lot less code in your patch than fs/direct-io.c,
> but I'm still interested in which part of the fs/direct-io.c path is
> taking the most time.  I would guess it is allocating the dio?
> 
> I don't think we should cut out fs/direct-io.c until we understand
> exactly where the hit is coming from.  I know you've done lots of
> instrumentation already, but can you share some percentages on the hot
> paths?

It's everywhere in the DIO submit and completion path, here is a profile
taken on a recent measurement:

                        Rank   %
__blockdev_direct_IO    9      3.09%
dio_bio_end_io          12     2.13%
dio_bio_complete        19     0.95%
finished_one_bio        34     0.55%
dio_get_page            76     0.22%
dio_bio_submit          96     0.19%
dio_bio_add_page       101     0.17%
dio_complete           115     0.16%
dio_new_bio            125     0.14%
dio_send_cur_page      150     0.10%
dio_bio_end_aio        201     0.06%

The compiler inlines direct_io_worker into __blockdev_direct_IO, so that
function showed up at the top.  The "rank" field indicates hotness of a
function, i.e., rank 1 is the hottest function. The "%" field is % clock
ticks for the respective function.

Looking at this profile, I see that the submit path is clearly heavy
weight. dio_bio_end_io maybe a bit skewed because of wake-up function
called inside spin_lock_irqsave().  The profiler is not capable of
measuring accurate clock ticks with code running inside irq off section.
Everything is accumulated at the time when irq is enabled.

- Ken
