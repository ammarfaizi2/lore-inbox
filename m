Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751114AbWEQCY5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbWEQCY5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 22:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbWEQCY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 22:24:57 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:974 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751114AbWEQCY5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 22:24:57 -0400
Date: Tue, 16 May 2006 19:24:19 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Peter Chubb <peterc@gelato.unsw.edu.au>
cc: Andi Kleen <ak@suse.de>, Arnd Bergmann <arnd@arndb.de>,
       Martin Peschke <mp3@de.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, hch@infradead.org, arjan@infradead.org,
       James.Smart@emulex.com, James.Bottomley@steeleye.com
Subject: Re: [RFC] [Patch 7/8] statistics infrastructure - exploitation
 prerequisite
In-Reply-To: <17514.32708.282431.544415@wombat.chubb.wattle.id.au>
Message-ID: <Pine.LNX.4.64.0605161916280.10371@schroedinger.engr.sgi.com>
References: <446A1023.6020108@de.ibm.com> <200605170103.08917.arnd@arndb.de>
 <17514.31511.386806.484792@wombat.chubb.wattle.id.au> <200605170327.52605.ak@suse.de>
 <17514.32708.282431.544415@wombat.chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2006, Peter Chubb wrote:

> I measured do_gettimeofday on IA64 at around 120 cycles (mind you that
> was some time ago now, before the last lot of time function revisions
> in the kernel).  Whether that's slow or not depends on your application.

What I did for time critical statistics in core vm paths is to use 
get_cycles() but associate each cycle value with a processor id when the 
measurements starts. If the processor id has changed when we end the 
measurement then discard the measurement and just note that we missed one.

Here is a piece of a description for a patch that I have used in the past 
for these statistics:

----

The patch puts three performance counters into critical kernel paths to 
show how its done.

The measurements will show up in /proc/perf/all. Processor specific 
statistics may be obtained via /proc/perf/<nr-of-processor>. Writing to 
/proc/perf/reset
will reset all counters. F.e.

echo >/proc/perf/reset

Sample output:

AllocPages               786882 (+  0) 9.9s(223ns/12.6us/48.6us) 12.9gb(16.4kb/16.4kb/32.8kb)
FaultTime                786855 (+192) 10.4s(198ns/13.2us/323.6us)
PrepZeroPage             786765 (+  0) 9.2s(549ns/11.7us/48.1us) 12.9gb(16.4kb/16.4kb/16.4kb)

The first countr is the number of times that the time measurement was 
performed.(+ xx) is the number of samples that were thrown away since the 
processor on which the process is running changed. Cycle counters are not 
consistent across different processors.

Then follows the sum of the time spend in the code segment followed in 
parenthesesby the minimum / average / maximum time spent there. The 
second block are the sizes of data processed. In this sample 12.9 GB was 
allocated via AllocPages. Most allocations were 16k = 1 page although 
there were also 32K (2 page) allocations.


