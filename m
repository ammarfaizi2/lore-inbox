Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755964AbWKREbf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755964AbWKREbf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 23:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755972AbWKREbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 23:31:35 -0500
Received: from twinlark.arctic.org ([207.7.145.18]:50333 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP
	id S1755964AbWKREbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 23:31:34 -0500
Date: Fri, 17 Nov 2006 20:31:33 -0800 (PST)
From: dean gaudet <dean@arctic.org>
To: Bela Lubkin <blubkin@vmware.com>
cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: RE: touch_cache() only touches two thirds
In-Reply-To: <Pine.LNX.4.64.0611171953420.12661@twinlark.arctic.org>
Message-ID: <Pine.LNX.4.64.0611172028480.12661@twinlark.arctic.org>
References: <FE74AC4E0A23124DA52B99F17F441597DA118C@PA-EXCH03.vmware.com>
 <p734pt7k8s0.fsf@bingen.suse.de> <FE74AC4E0A23124DA52B99F17F44159701DBBFE7@PA-EXCH03.vmware.com>
 <Pine.LNX.4.64.0611171953420.12661@twinlark.arctic.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2006, dean gaudet wrote:

> another pointer chase arranged to fill the L1 (or L2) using many many 
> pages.  i.e. suppose i wanted to traverse 32KiB L1 with 64B cache lines 
> then i'd allocate 512 pages and put one line on each page (pages ordered 
> randomly), but colour them so they fill the L1.  this conveniently happens 
> to fit in a 2MiB huge page on x86, so you could even ameliorate the TLB 
> pressure from the microbenchmark.

btw, for L2-sized measurements you don't need to be so clever... you can 
get away with a random traversal of the L2 on 128B boundaries.  (need to 
avoid the "next-line prefetch" issues on p-m/core/core2, p4 model 3 and 
later.)  there's just so many more pages required to map the L2 than any 
reasonable prefetcher is going to have any time soon.

-dean


> the benchmark i was considering would be like so:
> 
> 	switch to cpu m
> 	scrub the cache
> 	switch to cpu n
> 	scrub the cache
> 	traverse the coloured list and modify each cache line as we go
> 	switch to cpu m
> 	start timing
> 	traverse the coloured list without modification
> 	stop timing
