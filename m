Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261800AbVDKPM2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261800AbVDKPM2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 11:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbVDKPM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 11:12:28 -0400
Received: from mx1.elte.hu ([157.181.1.137]:22716 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261800AbVDKPMQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 11:12:16 -0400
Date: Mon, 11 Apr 2005 17:12:04 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Paul Jackson <pj@engr.sgi.com>
Cc: torvalds@osdl.org, pasky@ucw.cz, rddunlap@osdl.org, ross@jose.lug.udel.edu,
       linux-kernel@vger.kernel.org, git@vger.kernel.org
Subject: Re: [rfc] git: combo-blobs
Message-ID: <20050411151204.GA5562@elte.hu>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org> <20050409200709.GC3451@pasky.ji.cz> <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org> <20050411113523.GA19256@elte.hu> <20050411074552.4e2e656b.pj@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050411074552.4e2e656b.pj@engr.sgi.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul Jackson <pj@engr.sgi.com> wrote:

> Hmmm ... I have this strong sense that I am about 2 hours away from
> smacking my forehead and groaning "Duh - so that's what Ingo meant!"
> 
> However, one must play out one's destiny.
> 
> Could you provide an example scenario, which results in the creation 
> of a combo-blob?
> 
> The best I can come up with is the following.
> 
> Let's say Nick changes one line in the middle of kernel/sched.c (yeah 
> - I know - unlikely scenario - he usually changes more than that - 
> nevermind that detail.)
> 
> In the days Before Combo Blobs (BCB), git would have been told that 
> kernel/sched.c was to be picked up, and would have wrapped it up in a 
> zlib'd blob, sha1summed it, seen it was a new sum, and added that blob 
> to its objects (or something like this -- I'm still a little fuzzy on 
> these git details.)
> 
> But Nick just downloaded the latest git 1.5.11.1 which has added 
> support for combo blobs, so now, guessing here, instead of wrapping up 
> the new sched.c, git instead unwraps the old one, diff's with the new, 
> notices a couple of long sequences that are unchanged, wraps up both 
> of those sequences as a couple of relatively large blobs, and wraps up 
> the new lines that Nick just coded in the middle as a small blob, and 
> puts all three in the object store, along with another small 
> combo-blob, tying them all together.

actually, git would just include by reference the previous blob.

lets say we had the previous version of sched.c in a blob, ID 
cc4ee6107d19f89898a8c89d45810f01710f2ff4. We have the new edit (which is 
small, lets say 20 bytes) in blob e010fab710092b19be6e26de1721e249dff2d141.
We'd create the combo-blob representing the new version of sched.c, the 
following way:

	include cc4ee6107d19f89898a8c89d45810f01710f2ff4 0 54010
	include e010fab710092b19be6e26de1721e249dff2d141 0 20
	include cc4ee6107d19f89898a8c89d45810f01710f2ff4 54030 73061

so we'd include (by reference) most of the previous version, with a 
small blob for the extras. Since sched.c compresses down to 36K, we 
saved ~32K of bandwidth, and somewhere on the order of 20K of storage.

to construct the combo blob later on, we do have to unpack sched.c (and 
if it's already a combo-blob that is not cached then we'd have to unpack 
all parents until we arrive at some full blob).

> So far, not too bad.  Haven't gained anything, and required the 
> unpacking of a zlib blog we didn't require before, and the running and 
> analyzing of a diff we didn't require before, but the end result is 
> only moderately worse - four object blobs instead of one, but of total 
> size not much larger (well, total size typically 3 disk blocks worse, 
> due to a slight increase in fragmentation from using 4 blocks to store 
> what used to be in one.)

we'd have 2 new objects (the 'delta' and the 'combo' blob).

(if # of objects is an issue then we could include new data in the combo 
blob itself too, but that's getting too complex i think.)

	Ingo
