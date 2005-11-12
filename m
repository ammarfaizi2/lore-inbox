Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964835AbVKLVcw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964835AbVKLVcw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 16:32:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964836AbVKLVcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 16:32:52 -0500
Received: from hera.kernel.org ([140.211.167.34]:55950 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S964835AbVKLVcw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 16:32:52 -0500
Date: Sat, 12 Nov 2005 14:27:20 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Rik van Riel <riel@redhat.com>
Subject: vmtrace v0.0
Message-ID: <20051112162720.GA20166@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I've been working on updating the vmtrace patch to current 2.6-git along
with some post-processing utilities.

>From the previous email to linux-mm:
"The sequence of pages which a given process or workload accesses during
its lifetime, a.k.a. "reference trace", is very important information.
It has been used in the past for comparison of page replacement
algorithms and other optimizations. We've been talking on IRC on how to
generate reference traces for memory accesses, and a suggestion came
up to periodically unmap all present pte's of a given process. The
following patch implements a "kptecleaner" thread which is woken at a
certain interval (hardcoded to HZ/2 at present)."

At the moment the most interesting tool is average IRF calculation,
which can be used to identify workloads in which LRU policy
underperforms due to lack of frequency information.

The tarball can be found at 

http://hera.kernel.org/~marcelo/mm/vmtrace/vmtrace-0.0.tar.gz 

Thanks to Peter Zijlstra and Rik van Riel for comments and incentive.

>From README:

* Capture daemon *

vmtrace-capture.c:
Captures data from relayfs channel and writes it into a file. To be used
at workload execution.

* Post processing tools *

vmtrace-print.c:
Example to iterate over all trace entries.

vmtrace-reorder.c:
Makes sure the trace is ordered by sequence number.

vmtrace-split.c: 
Splits a single vmtrace entry into per-mapping entries.

vmtrace-irp.c:
Calculates Inter Reference Period between accesses to a mapping's pages.

This data is used to calculate per-page "average IRF" (Inter Reference
Frequency), as follows:

page-avg-IRF = (sum d(i, i+1))	<i=1...i=nr_accesses>
               ---------------
                nr_accesses

where d(i, i+1) is the inverse of the delta between the current access
and the next access to the page.

and average IRF of the entire mapping:

mapping-avg-IRF = sum (i's avg.irf)	<i=1...i=nr_pages>
                  -----------------
                     nr_pages

vmtrace-relation.c:
Calculates the numerical relation between accesses to two different
mappings. This is an attempt to estimate how interleaved the accesses
are.

>From EXAMPLE:

Example of parsing mdb randomic query bench trace (test explained in
more detail at http://www.linux-mm.org/PageReplacementTesting):

# file captured with "vmtrace-capture":
$ ls -la /tmp/vmt.txt
-rwxrwxrwT  1 root root 1338372 2005-12-12 18:29 /tmp/vmt.txt

# split it into per-mapping traces
$ ./vmtrace-split /tmp/vmt.txt /tmp/mdb-rand/

# format is <inode_nr,bdev>
$ ls /tmp/mdb-rand/
0-0      65c72-0  7ec2-0   aa54c-0  d9fd7-0
65c71-0  65c75-0  aa527-0  aaaf9-0  e5d01-0

$ for i in /tmp/mdb-rand/* ; do ./vmtrace-irp $i ; done | grep IRF
/tmp/mdb-rand/0-0: avg. IRF of all reaccessed pages(33): 12.949683
/tmp/mdb-rand/65c71-0: avg. IRF of all reaccessed pages(1808): 0.011185
/tmp/mdb-rand/65c72-0: avg. IRF of all reaccessed pages(176): 0.092401
/tmp/mdb-rand/65c75-0: avg. IRF of all reaccessed pages(16): 1.171296
/tmp/mdb-rand/7ec2-0: avg. IRF of all reaccessed pages(1): 0.000079
/tmp/mdb-rand/aa527-0: avg. IRF of all reaccessed pages(65): 0.038615
/tmp/mdb-rand/e5d01-0: avg. IRF of all reaccessed pages(6): 0.878549

The most interesting numbers here are:

65c71 is largedb.dat (7440358 bytes)
65c72 is largedb.idx (720896 bytes)
/tmp/mdb-rand/65c71-0: avg. IRF of all reaccessed pages(1808): 0.011185
/tmp/mdb-rand/65c72-0: avg. IRF of all reaccessed pages(176): 0.092401 

Which means that the index file is accessed about 9 times more frequently
than the data file itself.

The text mapping of the "mdb" binary (at address 0) is much more
frequently accessed than both database files:

/tmp/mdb-rand/0-0: avg. IRF of all reaccessed pages(33): 12.949683

>From TODO:

* Create a Makefile! 

* Add versioning to "struct vm_trace_entry"!

* Use dcache cookies to transform inode+bdev into path (much easier
to work with). At the moment, if files get deleted during the workload
you're doomed, having no way to identify deleted inode numbers.

* vmtrace-split currently splits in per "inode+bdev" type only, should
work on uid, pid, pwd, etc, etc. 

* vmtrace-split opens an unlimited amount of files, it should cap 
at 1024 open fd's and reuse those on demand.

* vmtrace-phase: recognize and classify common access patterns.

* Generate visual information such as avg.IRF histograms, address versus
time graphs, etc, etc.

