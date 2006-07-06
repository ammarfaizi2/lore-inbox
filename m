Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750862AbWGFVIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862AbWGFVIR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 17:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750864AbWGFVIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 17:08:17 -0400
Received: from mga01.intel.com ([192.55.52.88]:23925 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750862AbWGFVIQ convert rfc822-to-8bit (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 17:08:16 -0400
X-IronPort-AV: i="4.06,214,1149490800"; 
   d="scan'208"; a="94282696:sNHT33752943"
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5
Subject: RE: [PATCH] mm: moving dirty pages balancing to pdfludh entirely
Date: Fri, 7 Jul 2006 01:07:51 +0400
Message-ID: <B41635854730A14CA71C92B36EC22AAC06D2AA@mssmsx411>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] mm: moving dirty pages balancing to pdfludh entirely
Thread-Index: AcahJLUX6DTb8XeJTQK3TPouRJmxDgAEry+g
From: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
To: "Nikita Danilov" <nikita@clusterfs.com>
Cc: "Linux Kernel Mailing List" <Linux-Kernel@vger.kernel.org>
X-OriginalArrivalTime: 06 Jul 2006 21:08:05.0457 (UTC) FILETIME=[46362410:01C6A140]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov writes:
I've used with " patched UP" to underline fast, simple, superficial
fixing.

> and small number of pdflush threads is able to achieve necessary IO
concurrency level.
Can set MAX_PDFLUSH_THREADS=1000 if it is as you say. You will see huge
number of created pdflush threads created. That is why I consider that
MAX_PDFLUSH_THREADS=8 is fast-fix patch-up which is used now as an
argument contra parallelism.

> If asynchronous write-out cannot cope with the rate of dirtying,
> synchronous write-out starts.
Quite the contrary in current design: synchronous write-out is started
first and after pdflush is waked up and it sees that all done.

> You, on the other hand, are trying to use pdflush for the goal it
wasn't
> designed for.
Just after patching pdflush is used REALLY for writing out of dirty
pages concurrently with user thread work.

> No wonder it doesn't work.

It doesn't work for you because you have not run it. Have you tried to
run any real kernel with proposed path and without? 

> You didn't look carefully enough. :-)
> ratelimit_pages = 32, hence, sync_writeback_pages() returns 48. It
could
> be different, of course, if ratelimit_pages were.

I ask one more: why is it 48. Does it make best performance for any
configuration? You explanation is: 48 because it is 32+16. Is it
explanation? Is it proving?

This patch makes performance benefits for current REAL hardware and
software state and opens new performance benefits in smp. The patch was
carefully benchmarked on several configurations: 1-8 cpu; 1-8Gb memory;
1-15 disks.
You have proposed tens far-fetched contra arguments. I have explained
carefully that each your argument is ungrounded.

Leonid
-----Original Message-----
From: Nikita Danilov [mailto:nikita@clusterfs.com] 
Sent: Thursday, July 06, 2006 9:37 PM
To: Ananiev, Leonid I
Cc: Bret Towe; Linux Kernel Mailing List
Subject: Re: [PATCH] mm: moving dirty pages balancing to pdfludh
entirely

Ananiev, Leonid I writes:
 > Nikita Danilov writes:
 > >> by introducing MAX_PDFLUSH_THREADS=8. Why just 8?
 > > Sorry, I don't understand. pdflush.c appeared in 2.5.8 and
 > Thanks for explanation. Why just 8? Answer: it was introduced in
2.5.8.

No, no, I was commenting on your (incorrect) statement that kernel "was
patched up by introducing MAX_PDFLUSH_THREADS=8". It never was: this
limit is part of the original design, not some "patch".

 > Why the constant MAX_PDFLUSH_THREADS is needed? Is it because current
 > kernel may create huge number of pdflush threads and overload the
 > system? Why we can not set MAX_PDFLUSH_THREADS=512? 1000?

Because this is not needed for current pdflush usage patterns. pdflush
is used for light background write-out, and small number of pdflush
threads is able to achieve necessary IO concurrency level, because they
are mostly non-blocking, thanks to the current_is_pdflush() checks. If
asynchronous write-out cannot cope with the rate of dirtying,
synchronous write-out starts.

You, on the other hand, are trying to use pdflush for the goal it wasn't
designed for. No wonder it doesn't work.

 > 
 > >> Why 48?
 > > This is explained in comment just above sync_writeback_pages()
 > > definition. Basically, ratelimit_pages pages might be dirtied
between
 > > calls to balance_dirty_pages(), and the latter tries to write out
 > *more*
 > > pages to keep number of dirty pages under control: negative
feedback
 > > control loop, of sorts.
 > 
 > I had asked "why 48?" is hard coded for any configuration. I do not
see
 > "48" in your explanation.

You didn't look carefully enough. :-)


/*
 * When balance_dirty_pages decides that the caller needs to perform
some
 * non-background writeback, this is how many pages it will attempt to
write.
 * It should be somewhat larger than RATELIMIT_PAGES to ensure that
reasonably
 * large amounts of I/O are submitted.
 */
static inline long sync_writeback_pages(void)
{
	return ratelimit_pages + ratelimit_pages / 2;
}

ratelimit_pages = 32, hence, sync_writeback_pages() returns 48. It could
be different, of course, if ratelimit_pages were.

 > 
 > You do not recommend to use hard coded constants but
 > MAX_PDFLUSH_THREADS=8 and write_chunk=48 are sacred according you
mind. 

No, I think the fewer hard-coded constants are here---the better. I'd
happily eliminate MAX_PDFLUSH_THREADS, but just dropping this constraint
is a non-solution in search of a problem, obviously.

But this discussion is degenerating, so I shall participate in it no
longer.

 > 
 > Leonid

Nikita.
