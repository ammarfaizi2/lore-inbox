Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267244AbTAUVJP>; Tue, 21 Jan 2003 16:09:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267245AbTAUVJP>; Tue, 21 Jan 2003 16:09:15 -0500
Received: from packet.digeo.com ([12.110.80.53]:35298 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267244AbTAUVJN>;
	Tue, 21 Jan 2003 16:09:13 -0500
Message-ID: <3E2DB916.CA2221CC@digeo.com>
Date: Tue, 21 Jan 2003 13:18:14 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.51 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext2 allocation failures
References: <Pine.LNX.4.44.0301212043250.2751-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Jan 2003 21:18:14.0333 (UTC) FILETIME=[9BD0BED0:01C2C192]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> 
> For almost a year (since 2.5.4) ext2_new_block has tended to set err
> 0 instead of -ENOSPC or -EIO.  This manifested variously (typically
> depends on what's stale in ext2_get_block's chain[4] array): sometimes
> __brelse free free buffer backtraces, sometimes release_pages oops,
> usually generic_make_request beyond end of device messages, followed
> by further ext2 errors.

ugh.

> [Insert lecture on dangers of using goto for unwind :-]

Actually, I rather don't like the practice of:

	*errp = -EFOO;
	<200 lines of code>
	if (something_bad)
		goto out;

And lo, both ext2_new_block() and ext3_new_block() have additional
bugs, due mainly to this dubious optimisation.

I'll change them to the very straightforward

	if (something_bad) {
		*errp = -EFOO;
		goto out;
	}


Thanks.
