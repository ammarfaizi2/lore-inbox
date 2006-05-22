Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965011AbWEVErM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965011AbWEVErM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 00:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965016AbWEVErM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 00:47:12 -0400
Received: from ns.suse.de ([195.135.220.2]:56008 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965011AbWEVErL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 00:47:11 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 22 May 2006 14:46:47 +1000
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH - RESEND - 000 of 2] Avoid subtle cache consistancy problem
Message-ID: <20060522143524.25410.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a resend of a pair of patches that didn't get a lot of attention
last time.
I've cleaned up the second one a bit, as it had some ugliness that might
have put some people off...

The problem is that when we write to a file, the copy from userspace
to pagecache is first done with preemption disabled, so if the source
address is not immediately available the copy fails *and* *zeros*
*the*  *destination*.

This is a problem because a concurrent read (which admittedly is an
odd thing to do) might see zeros rather that was there before the
write, or what was there after, or some mixture of the two (any of
these being a reasonable thing to see).

If the copy did fail, it will immediately be retried with preemption
re-enabled so any transient problem with accessing the source won't
cause an error.

The first copying does not need to zero any uncopied bytes, and doing
so causes the problem.
It uses copy_from_user_atomic rather than copy_from_user so the simple
expedient is to change copy_from_user_atomic to *not* zero out bytes
on failure.

The first of these two patches prepares for the change by fixing two
places which assume copy_from_user_atomic does zero the tail.  The
two usages are very similar pieces of code which copy from
a userspace iovec into one or more page-cache pages.  These are
changed to remove the assumption.

The second patch changes __copy_from_user_inatomic* to not zero the
tail.
Once these are accepted, I will look at similar patches of other
architectures where this is important (ppc, mips and sparc being the
ones I can find).

Feedback very welcome.

Thanks.
NeilBrown


 [PATCH 001 of 2] Prepare  for __copy_from_user_inatomic to not zero missed bytes.
 [PATCH 002 of 2] Make copy_from_user_inatomic NOT zero the tail on i386
