Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261763AbUD3W6b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbUD3W6b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 18:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbUD3W6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 18:58:31 -0400
Received: from radius8.csd.net ([204.151.43.208]:28308 "EHLO
	bastille.tuells.org") by vger.kernel.org with ESMTP id S261763AbUD3W63
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 18:58:29 -0400
Date: Fri, 30 Apr 2004 16:58:44 -0600
From: marcus hall <marcus@tuells.org>
To: linux-kernel@vger.kernel.org
Subject: Re: mmap returns incorrect data
Message-ID: <20040430225844.GA13015@bastille.tuells.org>
References: <20040429231243.GA8216@bastille.tuells.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040429231243.GA8216@bastille.tuells.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Apr 29 2004 - 18:48:22 EST, Russell King wrote:
>You _really_ don't want to use ext3 on CF unless you want to wear the
>flash quickly. Just because a filesystem has journaling does _not_
>mean that its suitable for flash (in fact, it may be far worse for
>flash than its non-journaled counterpart, as in this case.)

I was concerned about that in the beginning, and was told that CF devices
perform wear-leveling internally.  In fact, we have had units in the field
for a couple of years without failure, so my objections carried little
weight.  In practice, the filesystem isn't often written.  Since the jffs2
filesystem seems to be intertwined with the mtd drivers, there don't seem
to be any other good failure-tolerant solutions.  But, that isn't the
point for now..

>This is an IDE driver bug - it performs PIO but does not ensure that the
>individual pages are properly flushed to RAM before telling the kernel
>that the IO is complete. (If someone wants to disagree, look at how
>rd.c does flush_dcache_page, and see previous discussions on lkml
>concerning this.)

Yes, this was in fact where the problem was.  In the 2.5.59 kernel, in
mm/filemap.c there were still two calls to flush_page_to_ram(), but in
include/asm-arm/proc-armv/cache.h this was defined to be a nop.  I
replaced the flush_page_to_ram() calls with flush_dcache_page() calls
and everything started working properly.

In later versions, the flush_page_to_ram() calls have been removed from
filemap.c, and I do not see any replacement of the functionality (at least
nothing that seems clear to me!)

I would like to eventually move forward to a 2.6 kernel, so I am interested
in how this is addressed there.

I also didn't seem to find (or recognize) the earlier discussion, so perhaps
it is covered there..

Anyhow, thanks for the help.  Things are rolling again!

Marcus Hall
marcus@tuells.org
