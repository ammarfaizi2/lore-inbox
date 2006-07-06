Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030185AbWGFQg1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030185AbWGFQg1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 12:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965192AbWGFQg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 12:36:27 -0400
Received: from mga02.intel.com ([134.134.136.20]:3931 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S965109AbWGFQg0 convert rfc822-to-8bit (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 12:36:26 -0400
X-IronPort-AV: i="4.06,214,1149490800"; 
   d="scan'208"; a="61402623:sNHT8304537976"
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5
Subject: RE: [PATCH] mm: moving dirty pages balancing to pdfludh entirely
Date: Thu, 6 Jul 2006 20:33:25 +0400
Message-ID: <B41635854730A14CA71C92B36EC22AAC06D26C@mssmsx411>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] mm: moving dirty pages balancing to pdfludh entirely
Thread-Index: AcahD/EPNZWlwMCjSi+hCQoyVyks8wAAZNAw
From: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
To: "Nikita Danilov" <nikita@clusterfs.com>
Cc: "Bret Towe" <magnade@gmail.com>,
       "Linux Kernel Mailing List" <Linux-Kernel@vger.kernel.org>
X-OriginalArrivalTime: 06 Jul 2006 16:33:33.0330 (UTC) FILETIME=[EC0F0720:01C6A119]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov writes:
>> by introducing MAX_PDFLUSH_THREADS=8. Why just 8?
> Sorry, I don't understand. pdflush.c appeared in 2.5.8 and
Thanks for explanation. Why just 8? Answer: it was introduced in 2.5.8.
Why the constant MAX_PDFLUSH_THREADS is needed? Is it because current
kernel may create huge number of pdflush threads and overload the
system? Why we can not set MAX_PDFLUSH_THREADS=512? 1000?

>> Why 48?
> This is explained in comment just above sync_writeback_pages()
> definition. Basically, ratelimit_pages pages might be dirtied between
> calls to balance_dirty_pages(), and the latter tries to write out
*more*
> pages to keep number of dirty pages under control: negative feedback
> control loop, of sorts.

I had asked "why 48?" is hard coded for any configuration. I do not see
"48" in your explanation.

You do not recommend to use hard coded constants but
MAX_PDFLUSH_THREADS=8 and write_chunk=48 are sacred according you mind. 

> it will enter balance_dirty_pages() more often than A.
B will get 1 second additional latency 60 times per minute and user A
only 3 times per minute but after each pressing 'ENTER'.

Leonid
-----Original Message-----
From: Nikita Danilov [mailto:nikita@clusterfs.com] 
Sent: Thursday, July 06, 2006 7:17 PM
To: Ananiev, Leonid I
Cc: Bret Towe; Linux Kernel Mailing List
Subject: Re: [PATCH] mm: moving dirty pages balancing to pdfludh
entirely

Ananiev, Leonid I writes:
 > Nikita Danilov writes:
 > > You are inhumane. :-)
 > OK. A lame argument was a joke.
 > 
 > > No. User thread will not write _all_ dirty pages (if it does---it's
a
 > > bug in the current code and should be fixed):
 > 
 > Some bugs are fixed by the patch.
 > Current kernel generates pdflush thread unlimitedly. It was patched
up
 > by introducing MAX_PDFLUSH_THREADS=8. Why just 8? Now

Sorry, I don't understand. pdflush.c appeared in 2.5.8 and

#define MAX_PDFLUSH_THREADS    8

was here from the very beginning:
http://www.kernelhq.cc/browse-view.py?fv_nr=107897

 > MAX_PDFLUSH_THREADS still present. But it could be removed.
 > Unlimited thread generation is fixed in proposed patch.
 > 
 > Now we are discussing other wonderful constant write_chunk=48. Why
48?

This is explained in comment just above sync_writeback_pages()
definition. Basically, ratelimit_pages pages might be dirtied between
calls to balance_dirty_pages(), and the latter tries to write out *more*
pages to keep number of dirty pages under control: negative feedback
control loop, of sorts.

 > The patch deletes this magic constant using:
 > -			.nr_to_write	= write_chunk,
 > It was needed in user thread only.
 > 
 > If user thread A writes 1 byte into disk it has to write not all but
48
 > dirty pages. User main work is paused. User thread B continues
 > generating of dirty pages. Thread B is main generator of dirty pages.
 > Thread A found was able to write-out 47 pages only because user B
locks
 > inodes. That is why user A forced to wait 0.1 sec and than repeat
 > compulsory community works. User thread lunch wide inodes scanning
and
 > list creating but interrupted after 48 pages. It is inefficient
method. 

It may so happen, right, but in the long term most of writeback will be
performed by thread B, because, being heavy writer, it will enter
balance_dirty_pages() more often than A.

If you want to get rid of write latencies, you need better accounting,
to know what pages were dirtied by the current thread (or at least their
number), so that synchronous writeback can be fairer.

[...]

 > 
 > Leonid

Nikita.
