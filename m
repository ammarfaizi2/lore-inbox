Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161306AbWAMFP0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161306AbWAMFP0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 00:15:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161309AbWAMFPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 00:15:25 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:44195 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161306AbWAMFPZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 00:15:25 -0500
Message-ID: <43C73767.5060506@us.ibm.com>
Date: Thu, 12 Jan 2006 23:15:19 -0600
From: Brian Twichell <tbrian@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave McCracken <dmccr@us.ibm.com>
CC: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>, slpratt@us.ibm.com
Subject: Re: [PATCH/RFC] Shared page tables
References: <A6D73CCDC544257F3D97F143@[10.1.1.4]>
In-Reply-To: <A6D73CCDC544257F3D97F143@[10.1.1.4]>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave McCracken wrote:

>Here's a new version of my shared page tables patch.
>
>The primary purpose of sharing page tables is improved performance for
>large applications that share big memory areas between multiple processes.
>It eliminates the redundant page tables and significantly reduces the
>number of minor page faults.  Tests show significant performance
>improvement for large database applications, including those using large
>pages.  There is no measurable performance degradation for small processes.
>
>  
>
Hi,

We evaluated page table sharing on x86_64 and ppc64 setups, using a database
OLTP workload.  In both cases, 4-way systems with 64 GB of memory were used.

On the x86_64 setup, page table sharing provided a 25% increase in 
performance,
when the database buffers were in small (4 KB) pages.  In this case, 
over 14 GB
of memory was freed, that had previously been taken up by page tables.  
In the
case that the database buffers were in huge (2 MB) pages, page table sharing
provided a 4% increase in performance.

Our ppc64 experiments used an earlier version of Dave's patch, along with
ppc64-specific code for sharing of ppc64 segments.  On this setup, page
table sharing provided a 49% increase in performance, when the database
buffers were in small (4 KB) pages.  Over 10 GB of memory was freed, that
had previously been taken up by page tables.  In the case that the database
buffers were in huge (16 MB) pages, page table sharing provided a 3% 
increase
in performance.

In the experiments above, page table sharing brought performance with small
pages to within 12% of the performance observed with hugepages.

Given the results above, we are keen for page table sharing to get included,
for a couple of reasons.  First, we feel it provides for significantly more
robust "out-of-the-box" performance for process-based middleware such as 
DB2,
Oracle, and SAP.  Customers don't have to use or even know about hugepages
to get near best-case performance.  Secondly, the performance boost provided
will help efforts to publish proof points which can be used to advance the
adoption of Linux in performance-sensitive data-center environments.

Cheers,
Brian Twichell


