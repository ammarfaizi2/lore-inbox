Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265477AbUFCCoR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265477AbUFCCoR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 22:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265474AbUFCCoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 22:44:17 -0400
Received: from fw.osdl.org ([65.172.181.6]:65222 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265477AbUFCCoK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 22:44:10 -0400
Date: Wed, 2 Jun 2004 19:43:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chris Mason <mason@suse.com>
Cc: jeffm@suse.com, linux-kernel@vger.kernel.org
Subject: Re: ext3_orphan_del may double-decrement bh->b_count
Message-Id: <20040602194330.1a04badc.akpm@osdl.org>
In-Reply-To: <1086229128.22636.3540.camel@watt.suse.com>
References: <40BE3235.5060906@suse.com>
	<20040602150614.005e939f.akpm@osdl.org>
	<1086219035.22636.3524.camel@watt.suse.com>
	<20040602180032.6c96268c.akpm@osdl.org>
	<1086229128.22636.3540.camel@watt.suse.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason <mason@suse.com> wrote:
>
> > You need the buffer-tracing patch.  This is against 2.6.7-rc2.  It should
>  > spit a nice trace when you hit the problem.  It'll tell us how that buffer
>  > got itself not uptodate.
> 
>  Thanks.  jeffm had worked out something similar that stored the EIP of
>  each bit operation, the uptodate bit seems to have turned off all on its
>  own.  Once we can reproduce reliably on local boxes, we'll start
>  layering on the debugging code.  

buffer-trace code is what you need - it records the bh's internal state in
its trace buffer too, replays it all when you hit an assertion failure.

>  No triggers yet, I might have to grab a bigger machine in the morning.

Is direct-io involved?  I just discovered that clean_blockdev_aliases() is
invalidating too many blocks.  It tends to munch those indirect blocks. 
(What does bonnie++'s -f option do?)



diff -puN fs/direct-io.c~direct-io-invalidation-fix fs/direct-io.c
--- 25/fs/direct-io.c~direct-io-invalidation-fix	2004-06-02 19:29:29.300623696 -0700
+++ 25-akpm/fs/direct-io.c	2004-06-02 19:30:31.404182520 -0700
@@ -690,8 +690,11 @@ out:
 static void clean_blockdev_aliases(struct dio *dio)
 {
 	unsigned i;
+	unsigned nblocks;
 
-	for (i = 0; i < dio->blocks_available; i++) {
+	nblocks = dio->map_bh.b_size >> dio->inode->i_blkbits;
+
+	for (i = 0; i < nblocks; i++) {
 		unmap_underlying_metadata(dio->map_bh.b_bdev,
 					dio->map_bh.b_blocknr + i);
 	}
_

