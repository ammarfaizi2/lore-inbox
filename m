Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261969AbUC1ALy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 19:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261990AbUC1AJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 19:09:37 -0500
Received: from fw.osdl.org ([65.172.181.6]:11201 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261969AbUC1AIE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 19:08:04 -0500
Date: Sat, 27 Mar 2004 16:07:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] speed up SATA
Message-Id: <20040327160745.7207ff98.akpm@osdl.org>
In-Reply-To: <40661049.1050004@yahoo.com.au>
References: <4066021A.20308@pobox.com>
	<40661049.1050004@yahoo.com.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
>  > 
>  > With this simple patch, the max request size goes from 128K to 32MB... 
>  > so you can imagine this will definitely help performance.  Throughput 
>  > goes up.  Interrupts go down.  Fun for the whole family.
>  > 
> 
>  Hi Jeff,
>  I think 32MB is too much. You incur latency and lose
>  scheduling grainularity. I bet returns start diminishing
>  pretty quickly after 1MB or so.

As far as interactivity and throughput is concerned, the effect of really
big requests will be the same as the effect of permitting _more_ requests. 
Namely: more memory can be under readahead or writeback at any particular
point in time.

Note that users can cause a similar effect right now by a) increasing
nr_requests or b) installing lots of disks.

The VM/VFS is pretty good at controlling this: the dirty thresholds are
really "dirty+writeback" thresholds.  We do place firm limits on the amount
of dirty+writeback memory.

When you run with a really large nr_requests you can indeed have 40% of
your machine's memory under writeback with just a single disk, and some
benchmarks do take a hit.  Mainly because truncate latency increases.  But
for real-life things, it just doesn't make much difference.

So I think the change will be OK.

If something bad does happen, the user can reduce nr_requests, or reduce
dirty_ratio or we can teach the VFS to clamp the amounts of dirty and
writeback memory separately rather than lumping them together for writer
throttling purposes.


Another effect of this change is that users can transiently pin larger
amounts of memory via O_DIRECT.  But they can do that now, by performing
I/O to lots of disks at the same time.  We'd need some form of system-wide
clamping in the direct-io code to address this.  I don't know how easy such
a DoS exploit would be in practice.
