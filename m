Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751170AbWITMUT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbWITMUT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 08:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbWITMUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 08:20:19 -0400
Received: from gateway.argo.co.il ([194.90.79.130]:29971 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S1751170AbWITMUS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 08:20:18 -0400
Message-ID: <45113200.3040107@argo.co.il>
Date: Wed, 20 Sep 2006 15:20:16 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Chris Jefferson <chris@bubblescope.net>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Allocated large blocks of memory on 64 bit linux.
References: <5cc6b04e0609200428ja52fa8dl5246488f64d794cb@mail.gmail.com>
In-Reply-To: <5cc6b04e0609200428ja52fa8dl5246488f64d794cb@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Sep 2006 12:20:16.0840 (UTC) FILETIME=[21A3AC80:01C6DCAF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Jefferson wrote:
>
> I apologise for this slightly off-topic message, but I believe it can
> best be answered here, and hope the question may be interesting.
>
> Many libraries have some kind of dynamically sized container (for
> example C++'s std::vector). When the container is full a new block of
> memory, typically double the original size, is allocated and the old
> data copied across.
>
> On a 64 bit architecture, where the memory space is massive, it seems
> at first glance a sensible thing to do might be to first make a buffer
> of size 4k, and then when this fills up, just straight to something
> huge, like 1MB or even 1GB, as the memory space is effectively
> infinate compared to the physical memory. Obvious most of this buffer
> may never be written to, as the object never grows large enough to
> fill it.
>
> What is the overhead of allocating memory which is never used? Is this
>

A 1MB virtual area which has just one page instantiated has (amortized) 
2KB cost in page tables, while a similar 1GB mapping has 8KB cost. 
That's a 50%-200% overhead which is quite bad.  Also cache line usage is 
worse since each pte needs a full cache line (two for the 1GB version) now.

In addition, the virtual address space is not infinite. On x86-64, 
userspace has 47 bits = 128 TB, enough for 128K of these 1G mappings, so 
your program would exhaust it after allocating 128,000 buffers, which is 
less than a gigabyte of physical RAM.

-- 
error compiling committee.c: too many arguments to function

