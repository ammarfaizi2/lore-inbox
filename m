Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262339AbUEQV1n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262339AbUEQV1n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 17:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbUEQV1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 17:27:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:12675 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262339AbUEQV1a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 17:27:30 -0400
Date: Mon, 17 May 2004 14:29:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: Steven Cole <elenstev@mesatop.com>
Cc: mason@suse.com, torvalds@osdl.org, lm@bitmover.com, wli@holomorphy.com,
       hugh@veritas.com, adi@bitmover.com, support@bitmover.com,
       linux-kernel@vger.kernel.org
Subject: Re: 1352 NUL bytes at the end of a page? (was Re: Assertion `s &&
 s->tree' failed: The saga continues.)
Message-Id: <20040517142946.571a3e91.akpm@osdl.org>
In-Reply-To: <1084828124.26340.22.camel@spc0.esa.lanl.gov>
References: <200405132232.01484.elenstev@mesatop.com>
	<20040517022816.GA14939@work.bitmover.com>
	<Pine.LNX.4.58.0405161936490.25502@ppc970.osdl.org>
	<200405162136.24441.elenstev@mesatop.com>
	<Pine.LNX.4.58.0405162152290.25502@ppc970.osdl.org>
	<20040517141427.GD29054@work.bitmover.com>
	<Pine.LNX.4.58.0405170717080.25502@ppc970.osdl.org>
	<20040517145217.GA30695@work.bitmover.com>
	<Pine.LNX.4.58.0405170758260.25502@ppc970.osdl.org>
	<1084807424.20437.60.camel@watt.suse.com>
	<1084825489.20437.390.camel@watt.suse.com>
	<1084828124.26340.22.camel@spc0.esa.lanl.gov>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Cole <elenstev@mesatop.com> wrote:
>
> 1) Apply your patch to 2.6.6-current, build with PREEMPT
> 2) Test bk pull via ppp on reiserfs until and if it breaks.
> 3) Test bk pull via ppp on ext3 and take a look at the s.ChangeSet file
> if/when the failure occurs.
> 4) Apply akpm's patch here:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=108478018304305&w=2
> 5) Repeat 2,3

Nope.  Please just see if this makes the problem go away:

--- 25/fs/buffer.c~a	Mon May 17 14:28:51 2004
+++ 25-akpm/fs/buffer.c	Mon May 17 14:29:02 2004
@@ -2723,7 +2723,6 @@ int block_write_full_page(struct page *p
 	 * writes to that region are not written out to the file."
 	 */
 	kaddr = kmap_atomic(page, KM_USER0);
-	memset(kaddr + offset, 0, PAGE_CACHE_SIZE - offset);
 	flush_dcache_page(page);
 	kunmap_atomic(kaddr, KM_USER0);
 	return __block_write_full_page(inode, page, get_block, wbc);

_

If this patch is confirmed to fix things up, then and only then should you
bother testing the vmtruncate patch.

Thanks.
