Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbUCFBBV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 20:01:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261387AbUCFBBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 20:01:21 -0500
Received: from fw.osdl.org ([65.172.181.6]:56241 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261338AbUCFBBT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 20:01:19 -0500
Date: Fri, 5 Mar 2004 17:03:19 -0800
From: Andrew Morton <akpm@osdl.org>
To: Daniel McNeil <daniel@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-aio@kvack.org, hugh@veritas.com
Subject: Re: [PATCH 2.6.3-mm4] writeback trylock patch
Message-Id: <20040305170319.7490b880.akpm@osdl.org>
In-Reply-To: <1078533612.1773.37.camel@ibm-c.pdx.osdl.net>
References: <1078533612.1773.37.camel@ibm-c.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel McNeil <daniel@osdl.org> wrote:
>
> Here is update to the wb_rwsema patch that adds back the trylock.
> It avoids the hang hugh was seeing by setting encountered_congestion
> if the trylock fails and checking it in sync_sb_inodes().  Hugh
> tested this and did not see the hang.
> 
> This prevents non-sync writebacks to from blocking behind sync
> writebacks.
> 
> This patch applies to 2.6.4-rc1-mm2.
> 
> Thoguhts?

spose so.  One concern is with writer throttling: if the caller of write(2)
is simply skipping a large file then it should throttle in
balance_dirty_pages() or block on i_sem I guess.  This code is getting
pretty sticky.

Why are you setting wbc->encountered_congestion in sync_sb_inodes()?

And why are you doing a trylock in __filemap_fdatawrite()?  That only
affects fadvise(), and probably we want to block in there anyway.  It
doesn't matter really but less code is better code.


