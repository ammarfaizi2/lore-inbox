Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030243AbWAXAky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030243AbWAXAky (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 19:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030244AbWAXAky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 19:40:54 -0500
Received: from ns2.suse.de ([195.135.220.15]:17576 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030242AbWAXAkw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 19:40:52 -0500
From: NeilBrown <neilb@suse.de>
To: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 24 Jan 2006 11:40:47 +1100
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Subject: [PATCH 000 of 7] md: Introduction - raid5 reshape mark-2
Message-ID: <20060124112626.4447.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is second release of my patches to support online reshaping
of a raid5 array, i.e. adding 1 or more devices and restriping the 
whole thing.

This release fixes an assortment of bugs and adds checkpoint/restart
to the process (the last two patches).
This means that if your machine crashes, or if you have to stop an
array before the reshape is complete, md will notice and will restart
the reshape at an appropriate place.

There is still a small window ( < 1 second) at the start of the reshape
during which a crash will cause unrecoverable corruption.  My plan is
to resolve this in mdadm rather than md. The critical data will be copied
into the new drive(s) prior to commencing the reshape.  If there is a crash
the kernel will refuse the reassmble the array.  mdadm will be able to 
re-assemble it by first restoring the critical data and then letting
the remainder of the reshape run it's course.

I will be changing the interface for starting a reshape slightly before
this patch become final.  This will mean that current 'mdadm' will not
be able to start a raid5 reshape.
This is partly to save people from risking the above mentioned tiny hole,
but also to prepare for reshaping which changes other aspects of the
shape, e.g. layout, chunksize, level.

I am expecting that I will ultimately support online conversion of
raid5 to raid6 with only one extra device.  This process is not
(efficiently) checkpointable and so will be at-your-risk.
Checkpointing such a process with anything like reasonable efficiency
requires a largish (multi-megabytes) temporary store, and doing so
will at-best halve the speed.  I will make sure the posibility of
add this later will be left open.

My thanks to those who have tested the first release, who have
provided feedback, who will test this release, and who contribute to
the discussion in any way.

NeilBrown



 [PATCH 001 of 7] md: Split disks array out of raid5 conf structure so it is easier to grow.
 [PATCH 002 of 7] md: Allow stripes to be expanded in preparation for expanding an array.
 [PATCH 003 of 7] md: Infrastructure to allow normal IO to continue while array is expanding.
 [PATCH 004 of 7] md: Core of raid5 resize process
 [PATCH 005 of 7] md: Final stages of raid5 expand code.
 [PATCH 006 of 7] md: Checkpoint and allow restart of raid5 reshape
 [PATCH 007 of 7] md: Only checkpoint expansion progress occasionally.
