Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262274AbUKVRtB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262274AbUKVRtB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 12:49:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262301AbUKVRqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 12:46:38 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:64734 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262292AbUKVRox (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 12:44:53 -0500
Date: Mon, 22 Nov 2004 09:44:02 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: Linus Torvalds <torvalds@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Andrew Morton <akpm@osdl.org>, benh@kernel.crashing.org,
       hugh@veritas.com, linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: page fault scalability patch V11 [0/7]: overview
In-Reply-To: <20041120193325.GZ2714@holomorphy.com>
Message-ID: <Pine.LNX.4.58.0411220932270.22144@schroedinger.engr.sgi.com>
References: <20041120053802.GL2714@holomorphy.com> <419EDB21.3070707@yahoo.com.au>
 <20041120062341.GM2714@holomorphy.com> <419EE911.20205@yahoo.com.au>
 <20041119225701.0279f846.akpm@osdl.org> <419EEE7F.3070509@yahoo.com.au>
 <1834180000.1100969975@[10.10.2.4]> <Pine.LNX.4.58.0411200911540.20993@ppc970.osdl.org>
 <20041120190818.GX2714@holomorphy.com> <Pine.LNX.4.58.0411201112200.20993@ppc970.osdl.org>
 <20041120193325.GZ2714@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Nov 2004, William Lee Irwin III wrote:
> I'm not particularly "stuck on" the per-cpu business, it was merely the
> most obvious method of splitting the RSS counter without catastrophes
> elsewhere. Robin Holt's 2.4 performance studies actually show that
> splitting the counter is not even essential.

There is no problem moving back to the atomic approach that is if it is
okay to also make anon_rss atomic. But its a pretty significant
performance hit (comparison with some old data from V4 of patch which
makes this data a bit suspect since the test environment is likely
slightly different. I should really test this again. Note that the old
performance test was only run 3 times instead of 10):

atomic vs. sloppy rss performance 64G allocation:

sloppy rss:

 Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
 16  10    1    1.818s    131.556s 133.038s 78618.592  78615.672
 16  10    2    1.736s    121.167s  65.026s 85317.098 160656.362
 16  10    4    1.835s    120.444s  36.002s 85751.810 291074.998
 16  10    8    1.820s    131.068s  25.049s 78906.310 411304.895
 16  10   16    3.275s    194.971s  22.019s 52892.356 472497.962
 16  10   32   13.006s    496.628s  27.044s 20575.038 381999.865

atomic:

 Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
 16   3    1    0.610s     61.557s  62.016s 50600.438  50599.822
 16   3    2    0.640s     83.116s  43.016s 37557.847  72869.978
 16   3    4    0.621s     73.897s  26.023s 42214.002 119908.246
 16   3    8    0.596s     86.587s  14.098s 36081.229 209962.059
 16   3   16    0.646s     69.601s   7.000s 44780.269 448823.690
 16   3   32    0.903s    185.609s   8.085s 16866.018 355301.694

Lets go for the approach to move rss into the thread structure but
keep the rss in the mm structure as is (need to take page_table_lock
for update) to consolidate the values. This allows to keep most
of the code as is and the rss in the task struct is only used if
we are not holding page_table_lock.

Maybe we can then find some way to regularly update the rss in the mm
structure to avoid the loop over the tasklist in proc.

