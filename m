Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262747AbVAVV1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262747AbVAVV1F (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 16:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262754AbVAVV1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 16:27:04 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:30468 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S262747AbVAVVXb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 16:23:31 -0500
Date: Sat, 22 Jan 2005 22:23:28 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: negative diskspace usage
Message-ID: <20050122212328.GC11170@pclin040.win.tue.nl>
References: <20050121141106.GG7147@wiggy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050121141106.GG7147@wiggy.net>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: : 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2005 at 03:11:06PM +0100, Wichert Akkerman wrote:

> After cleaning up a bit df suddenly showed interesting results:
> 
> Filesystem            Size  Used Avail Use% Mounted on
> /dev/md4             1019M  -64Z  1.1G 101% /tmp
> 
> Filesystem           1K-blocks      Used Available Use% Mounted on
> /dev/md4               1043168 -73786976294838127736   1068904 101% /tmp
> 
> This is on a ext3 filesystem on a 2.6.10-ac10 kernel.

Funny.

The Used column is total-free, so free was 2^66 + 964440.
That 2^66 no doubt was 2^64 in a computation counting 4K-blocks,
and arose at some point where a negative number was considered unsigned.

But having available=1068904 larger than free=964440 is strange.

I assume this was produced by statfs or statfs64 or so.
You can check using "strace -e statfs64 df /dev/md4" that
these really are the values returned by the kernel,
so that we can partition the blame between df and the kernel.

The values are computed by

        buf->f_blocks = es->s_blocks_count - overhead;
        buf->f_bfree = ext3_count_free_blocks (sb);
        buf->f_bavail = buf->f_bfree - es->s_r_blocks_count;

that is: blocks = total - overhead, and available = free - reserved.
strace shows three values, and I expect tune2fs or so will show 2 more.

More available than free sounds like a negative count of reserved blocks.
Are you still able to examine the situation?

Andries

