Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264029AbUDVNm1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264029AbUDVNm1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 09:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264037AbUDVNm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 09:42:27 -0400
Received: from ns.suse.de ([195.135.220.2]:63409 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264029AbUDVNmT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 09:42:19 -0400
Subject: Re: ext3 reservation question.
From: Chris Mason <mason@suse.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, pbadari@us.ibm.com,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
In-Reply-To: <20040421204036.4e530732.akpm@osdl.org>
References: <200404211655.47329.pbadari@us.ibm.com>
	 <Pine.LNX.4.58.0404211959560.18945@ppc970.osdl.org>
	 <20040421204036.4e530732.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1082641387.12989.61.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 22 Apr 2004 09:43:07 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-04-21 at 23:40, Andrew Morton wrote:

> The code I had at the time would reserve space in the filesystem
> correspnding to the worst-case occupancy based on file offset.  When we
> actually hit ENOSPC in prepare_write(), we force writeout, which results in
> those worst-space reservations being collapsed into their _real_ space
> usage, which is much less.  So writeout reclaims space in the filesystem
> and prepare_write() can proceed.
> 
> That worked fine on ext2.  But on ext3 we have a transaction open in
> prepare_write(), and the forced writeback will cause arbitrary amounts of
> unexpected metadata to be pumped into the current transaction, causing the
> fs to explode.
> 
> At least, I _think_ that was the problem.  All is hazy.
> 
One possible solution is to allocate holes in the file during
prepare_write/commit_write, logging the metadata as you go.  Then during
each commit fill any delayed allocations.  You've still got a
potentially unbounded operation for logging the bitmaps, maybe solvable
through creative reservations.

-chris

