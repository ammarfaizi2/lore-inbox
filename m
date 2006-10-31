Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161566AbWJaGAs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161566AbWJaGAs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 01:00:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161569AbWJaGAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 01:00:48 -0500
Received: from ns1.suse.de ([195.135.220.2]:10725 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161520AbWJaGAr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 01:00:47 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 31 Oct 2006 17:00:40 +1100
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "Raz Ben-Jehuda(caro)" <raziebe@gmail.com>, gregkh@suse.de
Subject: [PATCH 000 of 6] md: udev events and cache bypass for reads
Message-ID: <20061031164814.4884.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following are 6 patches for md in -lastest which I have been sitting
on for a while because I hadn't had a chance to test them properly.
I now have so there shouldn't be too many bugs left :-)

First is suitable for 2.6.19 (if it isn't too late and gregkh thinks it
is good).  Rest are for 2.6.20.

First two make md play a bit more nicely with udev.  Currently udev gets an
'add' event once and never any remove event or anything else.  And the the 'add'
event comes before the array is ready to be used.

The first patch added online/offline events when the array becomes
ready to be used, and when the array ceases to be usable.

The second patch changes the lifetime rules of md devices so they
disappear when not in use.  This means that udev will normally dev a
'remove' event sometime after the offline, and then another 'add' if a
new array is started with a the same name.  I'm not sure if this helps 
udev particularly, but it is a lot neater.

Then we have 4 patches that cause raid5 to not use the stripe-cache
for reads when that is appropriate.  This avoids copies and improves
read throughput by as much as 30% in some tests.  These patches
are largely due to  "Raz Ben-Jehuda(caro)" <raziebe@gmail.com>.

NeilBrown



 [PATCH 001 of 6] md: Send online/offline uevents when an md array starts/stops.
 [PATCH 002 of 6] md: Change lifetime rules for 'md' devices.
 [PATCH 003 of 6] md: Define raid5_mergeable_bvec
 [PATCH 004 of 6] md: Handle bypassing the read cache (assuming nothing fails).
 [PATCH 005 of 6] md: Allow reads that have bypassed the cache to be retried on failure.
 [PATCH 006 of 6] md: Enable bypassing cache for reads.
