Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265213AbUEYUcs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265213AbUEYUcs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 16:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265221AbUEYUcs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 16:32:48 -0400
Received: from cfcafw.sgi.com ([198.149.23.1]:34137 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S265213AbUEYUce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 16:32:34 -0400
Date: Tue, 25 May 2004 15:32:15 -0500
From: Jack Steiner <steiner@sgi.com>
To: Manfred Spraul <manfred@dbl.q-ag.de>
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] [RFC, PATCH] 1/5 rcu lock update: Add per-cpu batch counter
Message-ID: <20040525203215.GB5127@sgi.com>
References: <200405250535.i4P5ZKAQ017591@dbl.q-ag.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405250535.i4P5ZKAQ017591@dbl.q-ag.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2004 at 07:35:20AM +0200, Manfred Spraul wrote:
> Hi,
> 
> Step one for reducing cacheline trashing within rcupdate.c:
> 
> The current code uses the rcu_cpu_mask bitmap both for keeping track
> of the cpus that haven't gone through a quiescent state and for
> checking if a cpu should look for quiescent states. The bitmap
> is frequently changed and the check is done by polling - 
> together this causes cache line trashing.
> 
.....



It looks like the patch fixes the problem that I saw.

I ran a 2.6.6+rcupatch kernel on a 512p system. Previously, this system
showed ALL cpus becoming ~50% busy when running a "ls" loop on a single
cpu.  This behavior is now fixed.

The following shows the system overhead on cpus 0-9 (higher cpus are
similar):


idle system
  CPU    0      1      2      3      4      5      6      7      8      9
      0.70   0.21   0.19   0.17   0.21   0.20   0.20   0.19   0.18   0.19
      0.72   0.21   0.18   0.17   0.21   0.21   0.21   0.20   0.18   0.19
      0.70   0.20   0.18   0.17   0.22   0.20   0.19   0.20   0.19   0.20
      0.71   0.19   0.18   0.17   0.21   0.20   0.19   0.20   0.18   0.19
      0.71   0.23   0.19   0.17   0.21   0.20   0.19   0.20   0.19   0.20


runnin "ls" loop on cpu 4 (the number for cpu4 is the ls command - NOT overhead)
  CPU    0      1      2      3      4      5      6      7      8      9
      0.83   2.08   0.31   0.29  97.87   1.25   0.32   0.32   0.32   0.33
      0.88   0.52   0.30   0.28  96.46   1.32   0.32   0.23   0.31   0.30
      0.84   1.27   0.31   0.29  97.15   1.38   0.33   0.31   0.31   0.31
      0.83   2.81   0.32   0.30  98.61   1.14   0.31   0.33   0.32   0.37
      0.84   2.32   0.32   0.40  97.91   1.43   0.33   0.43   0.32   0.36

There is a small increase in system overhead on all cpus but not the 50% seen
earlier.

I dont understand, however, why the overhead increased on cpus 1 & 5. This
may be a test anomaly but I suspect something else. I'll look into that later.

I also noticed one other anomaly. /proc/interrupts shows the number of interrupts
for each cpu. Under most circumstances, /proc/interrupts shows 1024 timer
interrupts/sec on each cpu. When the "ls" script is running, the number 
of timer interrupts/sec on the cpu running "ls" drops to ~650. I'm not
sure why (perhaps running too long somewhere with ints disabled). 

I'll look further....




-- 
Thanks

Jack Steiner (steiner@sgi.com)          651-683-5302
Principal Engineer                      SGI - Silicon Graphics, Inc.


