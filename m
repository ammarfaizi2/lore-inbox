Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030273AbWGFNzh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030273AbWGFNzh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 09:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030275AbWGFNzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 09:55:37 -0400
Received: from mga03.intel.com ([143.182.124.21]:55108 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1030273AbWGFNzg convert rfc822-to-8bit (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 09:55:36 -0400
X-IronPort-AV: i="4.06,213,1149490800"; 
   d="scan'208"; a="62077744:sNHT3172856946"
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5
Subject: RE: [PATCH] mm: moving dirty pages balancing to pdfludh entirely
Date: Thu, 6 Jul 2006 17:54:57 +0400
Message-ID: <B41635854730A14CA71C92B36EC22AAC06D204@mssmsx411>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] mm: moving dirty pages balancing to pdfludh entirely
Thread-Index: Acagxu5Je9TCLKshQFqhhUHhFgZ9XQAMhTug
From: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
To: "Nikita Danilov" <nikita@clusterfs.com>
Cc: "Bret Towe" <magnade@gmail.com>,
       "Linux Kernel Mailing List" <Linux-Kernel@vger.kernel.org>
X-OriginalArrivalTime: 06 Jul 2006 13:54:54.0203 (UTC) FILETIME=[C23784B0:01C6A103]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov writes:
> You are inhumane. :-)
OK. A lame argument was a joke.

> No. User thread will not write _all_ dirty pages (if it does---it's a
> bug in the current code and should be fixed):

Some bugs are fixed by the patch.
Current kernel generates pdflush thread unlimitedly. It was patched up
by introducing MAX_PDFLUSH_THREADS=8. Why just 8? Now
MAX_PDFLUSH_THREADS still present. But it could be removed.
Unlimited thread generation is fixed in proposed patch.

Now we are discussing other wonderful constant write_chunk=48. Why 48?
The patch deletes this magic constant using:
-			.nr_to_write	= write_chunk,
It was needed in user thread only.

If user thread A writes 1 byte into disk it has to write not all but 48
dirty pages. User main work is paused. User thread B continues
generating of dirty pages. Thread B is main generator of dirty pages.
Thread A found was able to write-out 47 pages only because user B locks
inodes. That is why user A forced to wait 0.1 sec and than repeat
compulsory community works. User thread lunch wide inodes scanning and
list creating but interrupted after 48 pages. It is inefficient method. 

You can see in very first mail that write(2) latency is ...; 43; 292;
346; 368 ... 400 msec. You may want to mark that there was no one
latency time 43<t<292 msec while 130,000 writes were made during
benchmark running.

Proposed patch deletes long latency fluctuations and increases
throughput. The patch is benchmarked on real nowadays machines.

Leonid
-----Original Message-----
From: Nikita Danilov [mailto:nikita@clusterfs.com] 
Sent: Thursday, July 06, 2006 10:34 AM
To: Ananiev, Leonid I
Cc: Bret Towe; Linux Kernel Mailing List
Subject: Re: [PATCH] mm: moving dirty pages balancing to pdfludh
entirely

Ananiev, Leonid I writes:
 > Nikita Danilov writes:
 > > Some people do, should they suffer? :-)
 > You - yes. You have used that example as an argument incorrectly.

You are inhumane. :-) What is incorrect in assuming people may have many
devices?

 > 
 > > Not _all_, only nr_to_write of them
 > 	Yes. User thread writes all dirty pages in the system calling

No. User thread will not write _all_ dirty pages (if it does---it's a
bug in the current code and should be fixed):

balance_dirty_pages():
			if (pages_written >= write_chunk)
				break;		/* We've done our duty
*/

writeback_inodes():
		if (wbc->nr_to_write <= 0)
			break;

sync_sb_inodes():
		if (wbc->nr_to_write <= 0)
			break;

mpage_writepages():
			if (ret || (--(wbc->nr_to_write) <= 0))
				done = 1;

Everywhere down call-chain ->nr_to_write is checked.

 > writeback_inodes() and after it tests
 > 			if (pages_written >= write_chunk)

[rants skipped.]

 > 
 > Leonid

Nikita.
