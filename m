Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288787AbSAIRZg>; Wed, 9 Jan 2002 12:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288246AbSAIRZ1>; Wed, 9 Jan 2002 12:25:27 -0500
Received: from air-1.osdl.org ([65.201.151.5]:25104 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S288830AbSAIRZK>;
	Wed, 9 Jan 2002 12:25:10 -0500
Date: Wed, 9 Jan 2002 09:23:41 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Jens Axboe <axboe@suse.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: bounce buffer usage
In-Reply-To: <20020108084200.B19380@suse.de>
Message-ID: <Pine.LNX.4.33L2.0201090844550.9139-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jan 2002, Jens Axboe wrote:

| On Mon, Jan 07 2002, Randy.Dunlap wrote:
| >
| > OK, here's 'fillmem 700' run against 5 kernels as described below,
| > with my bounce io/swap statistics patch added.
| >
| > All tests are 6 instances of "fillmem 700" (700 MB) on a 4-way 4 GB
| > x86 VA 4450 server.
| >
| > I'm including a reduced version of /proc/stat -- before and after the
| > fillmem test in each case.
| >
| > Let me know if you'd like to see other variations.
|
| The results look very promising, although I'm a bit surprised that 2.5
| is actually that much quicker :-)

I was too.  When I have the bounce accounting straightened out,
I'll run each test multiple times.

| The bounce counts you are doing don't make too much sense to me though,
| how come 2.4 + block-high and 2.5 show any bounced numbers at all? Maybe
| you are not doing the accounting correctly? To get the right counts do
| something ala:

Clearly I mucked that up.  Thanks for pointing it out.
The patch below makes sense, but I also want to count
"bounced swap IOs" separately.  I'll retest and report that
when I have it done.

| +++ mm/highmem.c
| @@ -409,7 +409,9 @@
|                         vfrom = kmap(from->bv_page) + from->bv_offset;
|                         memcpy(vto, vfrom, to->bv_len);
|                         kunmap(from->bv_page);
| -               }
| +                       bounced_write++;
| +               } else
| +                       bounced_read++;
|         }
|
| Of course those are all bounces, not just (or only) swap bounces. Also
| note that the above is not SMP safe.

Is this the only place that kstat (kernel_stat) counters
are not SMP safe...?

-- 
~Randy

