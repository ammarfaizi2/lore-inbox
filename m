Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992720AbWJTWEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992720AbWJTWEp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 18:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992886AbWJTWEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 18:04:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18059 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S2992880AbWJTWEn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 18:04:43 -0400
Date: Fri, 20 Oct 2006 15:02:39 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Ralf Baechle <ralf@linux-mips.org>
cc: David Miller <davem@davemloft.net>, nickpiggin@yahoo.com.au,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       anemo@mba.ocn.ne.jp, linux-arch@vger.kernel.org,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       James Bottomley <James.Bottomley@SteelEye.com>
Subject: Re: [PATCH 1/3] Fix COW D-cache aliasing on fork
In-Reply-To: <20061020214916.GA27810@linux-mips.org>
Message-ID: <Pine.LNX.4.64.0610201500040.3962@g5.osdl.org>
References: <Pine.LNX.4.64.0610200846260.3962@g5.osdl.org>
 <20061020.123635.95058911.davem@davemloft.net> <Pine.LNX.4.64.0610201251440.3962@g5.osdl.org>
 <20061020.125851.115909797.davem@davemloft.net> <Pine.LNX.4.64.0610201302090.3962@g5.osdl.org>
 <20061020214916.GA27810@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 20 Oct 2006, Ralf Baechle wrote:
> 
> As a minimal solution your patch would work for MIPS but performance would be
> suboptimal.

Not so.

> With my D-cache alias series applied the flush_cache_mm() in dup_mmap()
> becomes entirely redundant.

No it does not, as pointed out by  Nick.

If there are dirty lines in the virtual cache, they _must_ be flushd long 
before the COW happens. Because if they are not, they don't show up in the 
child of the fork (which only sees it's _own_ virtual cache). See?

> When I delete the call (not part of my patchset) it means 12% faster 
> fork.  But I'm not proposing this for 2.6.19.

I just suspect it means a _buggy_ fork.

It so happens (I think), that fork is big enough that it probably flushes 
the L1 cache _anyway_. 

Does MIPS have some kind of "flush_cache_mm()" that could only flush 
user-level caches? Maybe the overhead is from flushing all dirty 
cachelines, regardless of whether they are kernel or not (and dirty kernel 
cachelines are going to be the most common by far in that path).

		Linus
