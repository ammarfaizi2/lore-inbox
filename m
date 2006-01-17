Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932108AbWAQEuh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbWAQEuh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 23:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932118AbWAQEuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 23:50:37 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:14236 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932108AbWAQEuh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 23:50:37 -0500
Message-ID: <43CC7796.10707@us.ibm.com>
Date: Mon, 16 Jan 2006 22:50:30 -0600
From: Brian Twichell <tbrian@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ray Bryant <raybry@mpdtxmail.amd.com>
CC: Dave McCracken <dmccr@us.ibm.com>, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>, slpratt@us.ibm.com
Subject: Re: [PATCH/RFC] Shared page tables
References: <A6D73CCDC544257F3D97F143@[10.1.1.4]> <43C73767.5060506@us.ibm.com> <200601131634.24913.raybry@mpdtxmail.amd.com>
In-Reply-To: <200601131634.24913.raybry@mpdtxmail.amd.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ray Bryant wrote:

>On Thursday 12 January 2006 23:15, Brian Twichell wrote:
>
>  
>
>>Hi,
>>
>>We evaluated page table sharing on x86_64 and ppc64 setups, using a
>>database OLTP workload.  In both cases, 4-way systems with 64 GB of memory
>>were used.
>>
>>On the x86_64 setup, page table sharing provided a 25% increase in
>>performance,
>>when the database buffers were in small (4 KB) pages.  In this case,
>>over 14 GB
>>of memory was freed, that had previously been taken up by page tables.
>>In the
>>case that the database buffers were in huge (2 MB) pages, page table
>>sharing provided a 4% increase in performance.
>>
>>    
>>
>
>Brian,
>
>Is that 25%-50% percent of overall performance (e. g. transaction throughput), 
>or is this a measurement of, say, DB process startup times, or what?   It 
>seems to me that the impact of the shared page table patch would mostly be 
>noticed at address space construction/destruction times, and for a big OLTP 
>workload, the processes are probably built once and stay around forever, no?
>
>If the performance improvement is in overall throughput, do you understand why 
>the impact would be so large?   TLB reloads?   I don't understand why one 
>would see that kind of overall performance improvement, but I could be 
>overlooking something.   (Could very likely be overlooking something...:-) )
>
>Oh, and yeah, was this an AMD x86_64 box or what?
>  
>
Ray,

The percentage improvement I quoted is of overall transaction throughput.

A full detailed characterization of the improvements hasn't been done,
especially since we just got the x86_64 setup up and running, but I can
share with you what I know.

In the case that the database buffers were in small pages, sharing page 
tables
freed up a large amount of memory, which was subsequently devoted to 
enlarging
the database buffer cache and/or increasing the number of connections to the
database.  The arithmetic of the memory savings works as follows:  The
database systems we used are structured as multiple processes which map a
large shared memory buffer for caching application data.  In the case of
unshared page tables, each database process requires its own Linux page
table entry for each 4 KB page in the buffer.  A Linux page table entry
consumes eight bytes.  So, if there are 100 database processes, there are
100 * 8 = 800 bytes of Linux page table entries per 4 KB page in the 
buffer --
equating to a 20% overhead for page table entries.  With shared page tables,
there is only one page table entry per buffer cache page, no matter how many
database processes there are, thus reducing the page table overhead down
to 8 / 4 KB = ~ 0.2%.

I suspect that, in the small page case, sharing page tables is also 
giving us a
significant benefit from reduced thrashing in the ppc64 hardware page 
tables,
although I haven't confirmed that.

For the hugepage case on ppc64, the performance improvement appears to
stem mainly from a CPI decrease due to reduced TLB and cache miss rates.

Our x86_64 setup is based on Intel processors.

Cheers,
Brian

