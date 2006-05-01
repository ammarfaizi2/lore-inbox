Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932165AbWEATBL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbWEATBL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 15:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbWEATBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 15:01:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:40871 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932165AbWEATBJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 15:01:09 -0400
Message-ID: <44565ABC.6080301@redhat.com>
Date: Mon, 01 May 2006 15:00:12 -0400
From: Wendy Cheng <wcheng@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050427 Red Hat/1.7.7-1.1.3.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steven Whitehouse <swhiteho@redhat.com>
CC: Andrew Morton <akpm@osdl.org>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/16] GFS2: Daemons and address space operations
References: <1145635949.3856.100.camel@quoit.chygwyn.com>
In-Reply-To: <1145635949.3856.100.camel@quoit.chygwyn.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Whitehouse wrote

>+static int gfs2_writepage(struct page *page, struct writeback_control *wbc)
>+{
>+	struct inode *inode = page->mapping->host;
>+	struct gfs2_inode *ip = page->mapping->host->u.generic_ip;
>+	struct gfs2_sbd *sdp = ip->i_sbd;
>+	loff_t i_size = i_size_read(inode);
>+	pgoff_t end_index = i_size >> PAGE_CACHE_SHIFT;
>+	unsigned offset;
>+	int error;
>+	int done_trans = 0;
>+
>+	if (gfs2_assert_withdraw(sdp, gfs2_glock_is_held_excl(ip->i_gl))) {
>+		unlock_page(page);
>+		return -EIO;
>+	}
>+	if (current->journal_info)
>+		goto out_ignore;
>+
>+	/* Is the page fully outside i_size? (truncate in progress) */
>+        offset = i_size & (PAGE_CACHE_SIZE-1);
>+	if (page->index >= end_index+1 || !offset) {
>+		page->mapping->a_ops->invalidatepage(page, 0);
>+		unlock_page(page);
>+		return 0; /* don't care */
>+	}
>
>  
>
Will above "|| !offset" unconditionally drop the page if the file size 
happens to be multiples of PAGE_CACHE_SIZE ?  Maybe this truncate 
handling should be removed to let block_write_full_page() handle all the 
cases ?

>+	error = block_write_full_page(page, get_block_noalloc, wbc);
>+	if (done_trans)
>+		gfs2_trans_end(sdp);
>+	gfs2_meta_cache_flush(ip);
>+	return error;
>+
>+out_ignore:
>+	redirty_page_for_writepage(wbc, page);
>+	unlock_page(page);
>+	return 0;
>+}
>+
>  
>
-- Wendy
