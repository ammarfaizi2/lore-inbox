Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263042AbTC1QzJ>; Fri, 28 Mar 2003 11:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263043AbTC1QzJ>; Fri, 28 Mar 2003 11:55:09 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:57056 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S263042AbTC1QzH> convert rfc822-to-8bit;
	Fri, 28 Mar 2003 11:55:07 -0500
Content-Type: text/plain; charset=US-ASCII
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Jens Axboe <axboe@suse.de>
Subject: Re: [patch for playing] 2.5.65 patch to support > 256 disks
Date: Fri, 28 Mar 2003 09:04:41 -0800
User-Agent: KMail/1.4.1
Cc: Nick Piggin <piggin@cyberone.com.au>, Andrew Morton <akpm@digeo.com>,
       dougg@torque.net, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
References: <200303211056.04060.pbadari@us.ibm.com> <200303261629.34868.pbadari@us.ibm.com> <20030327091854.GY30908@suse.de>
In-Reply-To: <20030327091854.GY30908@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200303280904.41797.pbadari@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I found 2048-byte slab heavy users. 8MB doesn't seem much they all
add up.

size-2048       before:98 after:4095 diff:3997 size:2060 incr:8233820

The problem is with

	sd.c: sd_attach()
		 alloc_disk(16)

alloc_disk() allocates "hd_struct" structure for 15 minors. 
So it is a 84*15 = 1260 byte allocation. They all come from 
2048-byte slabs. Since I have 4000 simulated disks, it uses up 8MB.

Proposed fixes:

1) Make the allocations come from its own slab, instead of
2048-byte slab. (~40% saving).

2) Instead of allocatinf hd_struct structure for all possible partitions,
why not allocated them dynamically, as we see a partition ? This
way we could (in theory) support more than 16 partitions, if needed.

Are there any issues with doing (2) ? 

Thanks,
Badari
