Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264915AbUEVIm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264915AbUEVIm0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 04:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264919AbUEVIm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 04:42:26 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:51147 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264915AbUEVImY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 04:42:24 -0400
Date: Sat, 22 May 2004 10:42:15 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Chris Mason <mason@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext3 barrier bits
Message-ID: <20040522084214.GS1952@suse.de>
References: <20040521093207.GA1952@suse.de> <20040521023807.0de63c7a.akpm@osdl.org> <20040521100234.GK1952@suse.de> <20040521235044.6160cccb.akpm@osdl.org> <20040522073540.GO1952@suse.de> <20040522011139.01a7da10.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040522011139.01a7da10.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 22 2004, Andrew Morton wrote:
> 
> May as well cc lkml on this.  It's to do with the disk write barrier
> implementation.
> 
> 
> - How do I know that the barrier code is actually doing stuff?  It doesn't
>   seem to affect benchmarks much, if at all.

Usually not a lot of barriers would be generated. If you use reiser and
heavy fsync load, it should be pretty apparent of barriers are issued or
not (ie compare without barrier + wb cache, with barrier + wb cache, and
with/without - wb cache).

> - Does reiserfs support `mount -o remount,barrier=flush'? and "=none"?

Chris?

> - How do I test the "oh, barriers aren't working" fallback code in ext3?

A quick hack would be to replace 'err' with '1' in this line in
drivers/ide/ide-io.c:void ide_end_drive_cmd():

        if (blk_barrier_preflush(rq) || blk_barrier_postflush(rq))
                ide_complete_barrier(drive, rq, err);

that'll fail the first barrier, should trigger the fall back. Or just
try -o barrier=flush on a SCSI drive, should fail the barrier too.

> - Does the kernel tell you if your disk doesn't supoprt barriers?  ie:
>   how does the user know if it's working or not?

IDE will not tell you, the file system should flag the disabling of
barriers (like reiser currently does). Try SCSI case again.

-- 
Jens Axboe

