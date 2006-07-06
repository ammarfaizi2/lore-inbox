Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965172AbWGFEaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965172AbWGFEaL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 00:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965174AbWGFEaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 00:30:11 -0400
Received: from mga03.intel.com ([143.182.124.21]:49696 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S965172AbWGFEaJ convert rfc822-to-8bit (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 00:30:09 -0400
X-IronPort-AV: i="4.06,211,1149490800"; 
   d="scan'208"; a="61887925:sNHT26249923"
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5
Subject: RE: [PATCH] mm: moving dirty pages balancing to pdfludh entirely
Date: Thu, 6 Jul 2006 08:30:02 +0400
Message-ID: <B41635854730A14CA71C92B36EC22AAC06CFE8@mssmsx411>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] mm: moving dirty pages balancing to pdfludh entirely
Thread-Index: AcagbyCtOkEEx08dTIKCpwZ662oWkAAO1EsQ
From: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
To: "Nikita Danilov" <nikita@clusterfs.com>
Cc: "Bret Towe" <magnade@gmail.com>,
       "Linux Kernel Mailing List" <Linux-Kernel@vger.kernel.org>
X-OriginalArrivalTime: 06 Jul 2006 04:30:07.0979 (UTC) FILETIME=[DC7413B0:01C6A0B4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov writes:
> Some people do, should they suffer? :-)
You - yes. You have used that example as an argument incorrectly.

> Not _all_, only nr_to_write of them
	Yes. User thread writes all dirty pages in the system calling
writeback_inodes() and after it tests
			if (pages_written >= write_chunk)
	or have the user thread wrote more than 32+32/2 pages?

> In current design each thread is responsible for write-out.
	Casual thread performs common system work; casual thread is
throttled or frozen by this work.
	That is why a constant write_chunk==32+32/2 is used but too
late.
	Infinite number of pdflush may be created in current design and
only after extra pdflush thread is exited because other pdflush
processes the device. I have seen 6 pdflush threads during benchmarking
while I have 1 disk only. That is why MAX_PDFLUSH_THREADS is needed in
current design. The patch adds testing to keep off extra pdflush threads
creating.

Summary:
Nikita Danilov writes:
> Wouldn't this interfere with current->backing_dev_info logic?
	Proved: the patch does not break that logic.
> Intent of this is to throttle writers, and reduce risk of running oom
	Proved: a generator of dirty pages is throttled after patching
too.
	The extra throttling is removed. It and parallelism make
performance benefit.
Nikita Danilov writes that in current pdflush thread
> performs page-out even if queue is congested
	Proved: New pdflush does the same.
> With your patch, this work is done from pdflush, and won't be
throttled
	Proved: pdflush is throttled by device congestion.
> when direct reclaim skips writing dirty pages from tail of the
inactive list
	Proved: direct reclaim does not skip inactive list in proposed
design.
> You propose to limit write-out concurrency by MAX_PDFLUSH_THREADS
	Proved: the patch adds the line which keeps off creating of
infinite number of pdflush thread. The max limit could be removed in a
next patch.

Leonid

-----Original Message-----
From: Nikita Danilov [mailto:nikita@clusterfs.com] 
Sent: Thursday, July 06, 2006 12:06 AM
To: Ananiev, Leonid I
Cc: Bret Towe; Linux Kernel Mailing List
Subject: Re: [PATCH] mm: moving dirty pages balancing to pdfludh
entirely

Ananiev, Leonid I writes:
 > Nikita Danilov writes:
 > > Exactly to the contrary: as I explained to you, if you have more
 > devices
 > > than pdflush threads
 > I do not believe that Bret Towe has more devices than
 > MAX_PDFLUSH_THREADS=8.

Some people do, should they suffer? :-)

 > 
 > > See how wbc.nr_to_write is set up by balance_dirty_pages().
 > It is number TO write but I said about number after what user has to
 > write-out all dirty pages. 

Not _all_, only nr_to_write of them:

			if (pages_written >= write_chunk)
				break;		/* We've done our duty
*/

 > 
 > > imagine that MAX_PDFLUSH_THREADS equals 1
 > Imagine that CONFIG_NR_CPUS=1 for smp.
 > Kernel has a lot of "big enough" constants.

Then why introduce more of them?

In current design each thread is responsible for write-out. This means
that write-out concurrency level scales together with the number of
writers. You propose to limit write-out concurrency by
MAX_PDFLUSH_THREADS. Obviously this is an artificial limit that will be
sub-optimal sometimes.


 > 
 > Leonid

Nikita.
