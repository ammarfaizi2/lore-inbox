Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261956AbUABAXu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 19:23:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261965AbUABAXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 19:23:50 -0500
Received: from fw.osdl.org ([65.172.181.6]:58568 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261956AbUABAXs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 19:23:48 -0500
Date: Thu, 1 Jan 2004 16:24:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: Peter Osterlund <petero2@telia.com>
Cc: axboe@suse.de, packet-writing@suse.com, linux-kernel@vger.kernel.org
Subject: Re: ext2 on a CD-RW
Message-Id: <20040101162427.4c6c020b.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0401020022060.2407-100000@telia.com>
References: <Pine.LNX.4.44.0401020022060.2407-100000@telia.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Osterlund <petero2@telia.com> wrote:
>
> If I create an ext2 filesystem
>  with 2kb blocksize, I hit a bug when I try to write some large files to
>  the filesystem. The problem is that the code in mpage_writepage() fails if
>  a page is mapped to disk across a packet boundary. In that case, the
>  bio_add_page() call at line 543 in mpage.c can fail even if the bio was
>  previously empty. The code then passes an empty bio to submit_bio(), which
>  triggers a bug at line 2303 in ll_rw_blk.c. This patch seems to fix the
>  problem.
> 
>  --- linux/fs/mpage.c.old	2004-01-02 00:26:19.000000000 +0100
>  +++ linux/fs/mpage.c	2004-01-02 00:26:50.000000000 +0100
>  @@ -541,6 +541,11 @@
>   
>   	length = first_unmapped << blkbits;
>   	if (bio_add_page(bio, page, length, 0) < length) {
>  +		if (!bio->bi_size) {
>  +			bio_put(bio);
>  +			bio = NULL;
>  +			goto confused;
>  +		}
>   		bio = mpage_bio_submit(WRITE, bio);
>   		goto alloc_new;
>   	}

Confused.  We initially have an empty BIO, and we run bio_add_page()
against it, adding one page.

How can that bio_add_page() fail to add the page?

Cold you describe the failure a little more please?

>  I noted that performance is quite bad with 2kb blocksize. It is a lot
>  faster with 4kb blocksize. (2kb blocksize with the udf filesystem is not
>  slow, only ext2 seems to have this problem.) Maybe the "confused" case
>  (which calls a_ops->writepage()) in mpage_writepage() isn't really meant
>  to be fast. Is there a better way to fix this problem?

How much slower is it?
