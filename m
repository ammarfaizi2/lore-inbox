Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbUD3NSp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbUD3NSp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 09:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265106AbUD3NSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 09:18:45 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:28120 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S261474AbUD3NSm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 09:18:42 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16530.21039.756717.489879@laputa.namesys.com>
Date: Fri, 30 Apr 2004 17:18:39 +0400
To: Rik van Riel <riel@redhat.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       Paul Mackerras <paulus@samba.org>, <brettspamacct@fastclick.com>,
       <jgarzik@pobox.com>, <linux-kernel@vger.kernel.org>
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
In-Reply-To: <Pine.LNX.4.44.0404300849480.6976-200000@chimarrao.boston.redhat.com>
References: <4091C15D.7040800@yahoo.com.au>
	<Pine.LNX.4.44.0404300849480.6976-200000@chimarrao.boston.redhat.com>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel writes:
 > On Fri, 30 Apr 2004, Nick Piggin wrote:
 > > Rik van Riel wrote:
 > 
 > > > The basic idea of use-once isn't bad (search for LIRS and
 > > > ARC page replacement), however the Linux implementation
 > > > doesn't have any of the checks and balances that the
 > > > researched replacement algorithms have...
 > 
 > > No, use once logic is good in theory I think. Unfortunately
 > > our implementation is quite fragile IMO (although it seems
 > > to have been "good enough").
 > 
 > Hey, that's what I said ;))))
 > 
 > > This is what I'm currently doing (on top of a couple of other
 > > patches, but you get the idea). I should be able to transform
 > > it into a proper use-once logic if I pick up Nikita's inactive
 > > list second chance bit.
 > 
 > Ummm nope, there just isn't enough info to keep things
 > as balanced as ARC/LIRS/CAR(T) can do.  No good way to
 > auto-tune the sizes of the active and inactive lists.

While keeping "history" for non-resident pages is very good from many
points of view (provides infrastructure for local replacement and
working set tuning, for example) and in the long term, current scanner
can still be improved somewhat.

Here are results that I obtained some time ago. Test is to concurrently
clone (bk) and build (make -jN) kernel source in M directories.

For N = M = 11, TIMEFORMAT='%3R %3S %3U'

                                        REAL    SYS      USER
"stock"                               3818.320 568.999 4358.460
transfer-dirty-on-refill              3368.690 569.066 4377.845
check-PageSwapCache-after-add-to-swap 3237.632 576.208 4381.248
dont-unmap-on-pageout                 3207.522 566.539 4374.504
async-writepage                       3115.338 562.702 4325.212

(check-PageSwapCache-after-add-to-swap was added to mainline since them.)

These patches weren't updated for some time. Last version is at
ftp://ftp.namesys.com/pub/misc-patches/unsupported/extra/2004.03.25-2.6.5-rc2

[from Nick Piggin's patch]
 > 
 > Changes mark_page_accessed to only set the PageAccessed bit, and
 > not move pages around the LRUs. This means we don't have to take
 > the lru_lock, and it also makes page ageing and scanning consistient
 > and all handled in mm/vmscan.c

By the way, batch-mark_page_accessed patch at the URL above also tries
to reduce lock contention in mark_page_accessed(), but through more
standard approach of batching target pages in per-cpu pvec.

Nikita.

