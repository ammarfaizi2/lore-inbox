Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030504AbWBNIJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030504AbWBNIJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 03:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030493AbWBNIJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 03:09:56 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:16090 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030504AbWBNIJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 03:09:55 -0500
Date: Tue, 14 Feb 2006 09:09:42 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Olaf Hering <olh@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, Hannes Reinecke <hare@suse.de>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: calibrate_migration_costs takes ages on s390
Message-ID: <20060214080942.GC19896@osiris.boeblingen.de.ibm.com>
References: <20060213102634.GA4677@osiris.boeblingen.de.ibm.com> <20060213104645.GA17173@elte.hu> <20060213234254.GA5368@suse.de> <20060214000807.GA6188@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060214000807.GA6188@suse.de>
User-Agent: mutt-ng/devel-r781 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > We did a bit of testing, -rc2-git3 + the patch below was still ok.
> > 
> >  [PATCH] s390: earlier initialization of cpu_possible_map
> >  9733e2407ad2237867cb13c04e7d619397fa3090
> 
> I need to double check, but -git5 + that patch was reported to be slow.

I did a quick git bisect search. This is one is the hurting one:

Author: Ingo Molnar <mingo@elte.hu>  2006-02-07 21:58:54
Committer: Linus Torvalds <torvalds@g5.osdl.org>  2006-02-08 01:12:33
Parent: 8519fb30e438f8088b71a94a7d5a660a814d3872 ([PATCH] mm: compound release fix)
Child:  0d4c3e7a8c65892c7d6a748fdbb4499e988880db ([PATCH] unshare system call -v5: Documentation file)

    [PATCH] Fix spinlock debugging delays to not time out too early
    
    The spinlock-debug wait-loop was using loops_per_jiffy to detect too long
    spinlock waits - but on fast CPUs this led to a way too fast timeout and false
    messages.
    
    The fix is to include a __delay(1) call in the loop, to correctly approximate
    the intended delay timeout of 1 second.  The code assumes that every
    architecture implements __delay(1) to last around 1/(loops_per_jiffy*HZ)
    seconds.
    
    Signed-off-by: Ingo Molnar <mingo@elte.hu>
    Cc: Andi Kleen <ak@muc.de>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

I guess we're once again suffering from being a virtualized platform: the
formerly used call to cpu_relax() informed the underlying hypervisor that
we want to give up the current cpu while __delay() keeps it.
Unless we're scheduled away involuntarily.
The "Detect Soft Lockups" option doesn't make too much sense too on our
platform, since we get a lot of false positives.
Quick fix: turn off the options CONFIG_DEBUG_SPINLOCK and
CONFIG_DETECT_SOFTLOCKUP.

Heiko
