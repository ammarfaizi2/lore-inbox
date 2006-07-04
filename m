Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932124AbWGDIi3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbWGDIi3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 04:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932108AbWGDIi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 04:38:28 -0400
Received: from mga01.intel.com ([192.55.52.88]:1137 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S932097AbWGDIi2 convert rfc822-to-8bit (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 04:38:28 -0400
X-IronPort-AV: i="4.06,203,1149490800"; 
   d="scan'208"; a="92958077:sNHT2064433014"
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5
Subject: RE: [PATCH] mm: moving dirty pages balancing to pdfludh entirely
Date: Tue, 4 Jul 2006 12:35:17 +0400
Message-ID: <B41635854730A14CA71C92B36EC22AAC0540D3@mssmsx411>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] mm: moving dirty pages balancing to pdfludh entirely
Thread-Index: AcaexphWVgJi3+eZSzSzmUhgy1bq5AAWxzDA
From: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
To: "Antonio Vargas" <windenntw@gmail.com>,
       "Nikita Danilov" <nikita@clusterfs.com>,
       "Linux Kernel Mailing List" <Linux-Kernel@vger.kernel.org>
X-OriginalArrivalTime: 04 Jul 2006 08:35:22.0767 (UTC) FILETIME=[CA5309F0:01C69F44]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Antonio Vargas writes:
>  Maybe we should keep the sync-write logic if there is only one online
> cpu, and thus avoiding extra context switches when they are not
> profitable?

A parallelism makes sense even if 1 cpu and 1 user task is there because
of IO.
>From other hand if user thread actually does inodes write back, it may
wait a lot (fs, jorn, io queue) events and get context switch.
	The  results of 3-4 repeated runs of "/usr/bin/time -f  "%c"
iozone -i 0 -r 4 -s 1200m " in Pentium-4HT with 1GB RAM show that the
patch is useful for 1 cpu as well as for 2:

                                   Old_1cpu         new_1cpu
old_2cpu        new_2cpu
/usr/bin/time %c	           1932-3400       1700-3003
1900-2728      2014-2700
'vmstat 1' (cs/sec)         506-621           693-753           708-715
679-752
throughput(MB/sec)       54-58              71-94               53-59
74-105

Leonid

-----Original Message-----
From: Antonio Vargas [mailto:windenntw@gmail.com] 
Sent: Monday, July 03, 2006 9:32 PM
To: Nikita Danilov; Ananiev, Leonid I; Linux Kernel Mailing List
Subject: Re: [PATCH] mm: moving dirty pages balancing to pdfludh
entirely

On 6/28/06, Nikita Danilov <nikita@clusterfs.com> wrote:
> Ananiev, Leonid I writes:
>  > >From Leonid Ananiev
>
> Hello,
>
>  >
>  > Moving dirty pages balancing from user to kernel thread pdfludh
entirely
>  > reduces extra long write(2) latencies, increases performance.
>  >
>
> [...]
>
>  >      The benchmarks IOzone and Sysbench for file size 50% and 120%
of
>  > RAM size on Pentium4, Xeon, Itanium have reported write and mix
>  > throughput increasing about 25%. The described Iozone > 0.1 sec
write(2)
>
> Results are impressive.
>
> Wouldn't this interfere with current->backing_dev_info logic? This
field
> is set by __generic_file_aio_write_nolock() and checked by
> may_write_to_queue() to force heavy writes to do more pageout. Maybe
> pdflush threads should set this field too?
>
>  > latencies are deleted. The condition writeback_in_progress() is
tested
>  > earlier now. As a result extra pdflush works are not created and
number
>  > of context switches increasing is inside variation limites.
>
> Nikita.

Maybe we should keep the sync-write logic if there is only one online
cpu, and thus avoiding extra context switches when they are not
profitable?

-- 
Greetz, Antonio Vargas aka winden of network
