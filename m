Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262950AbTJQKMX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 06:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263364AbTJQKMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 06:12:23 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:17130 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262950AbTJQKMV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 06:12:21 -0400
Date: Fri, 17 Oct 2003 12:12:19 +0200
From: Jens Axboe <axboe@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: I/O errors in -test7-mm1 tree on ia64
Message-ID: <20031017101219.GD1128@suse.de>
References: <20031016185505.GA1255@sgi.com> <20031016194934.GB711@holomorphy.com> <20031016204649.GA1778@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031016204649.GA1778@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 16 2003, Jesse Barnes wrote:
> On Thu, Oct 16, 2003 at 12:49:34PM -0700, William Lee Irwin III wrote:
> > On Thu, Oct 16, 2003 at 11:55:05AM -0700, Jesse Barnes wrote:
> > > I don't see this when using Linus' BK tree as of a few minutes ago, and
> > > the only changes I've made are adding the kgdb.h for ia64 and adding in
> > > the Altix console driver.  Any ideas?  I'll try reverting some patches
> > > and looking around a bit more.
> > 
> > Well, the first thing to try is backing out invalidate_inodes-speedup.patch
> 
> That didn't seem to help.  Got the same errors.

--- fs/xfs/pagebuf/page_buf.c	2003-10-17 12:11:30.000000000 +0200
+++ fs/xfs/pagebuf/page_buf.c~	2003-10-17 12:11:19.000000000 +0200
@@ -1406,10 +1406,8 @@
 		int cmd = WRITE;
 		if (pb->pb_flags & PBF_READ)
 			cmd = READ;
-#if 0
 		else if (pb->pb_flags & PBF_FLUSH)
 			cmd = WRITESYNC;
-#endif
 		submit_bio(cmd, bio);
 		if (size)
 			goto next_chunk;

it was a mistake to enable barriers unconditionally on XFS when it has
no fallback logic. If you apply the above on test7-mm1, it should work
fine for you.

-- 
Jens Axboe

