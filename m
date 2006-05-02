Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932231AbWEBMjs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbWEBMjs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 08:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932232AbWEBMjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 08:39:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23008 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932229AbWEBMjr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 08:39:47 -0400
Subject: Re: [PATCH 04/16] GFS2: Daemons and address space operations
From: Steven Whitehouse <swhiteho@redhat.com>
To: Wendy Cheng <wcheng@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <44565ABC.6080301@redhat.com>
References: <1145635949.3856.100.camel@quoit.chygwyn.com>
	 <44565ABC.6080301@redhat.com>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Tue, 02 May 2006 13:43:06 +0100
Message-Id: <1146573786.3856.281.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2006-05-01 at 15:00 -0400, Wendy Cheng wrote:
> Steven Whitehouse wrote
> 
> >+static int gfs2_writepage(struct page *page, struct writeback_control *wbc)
> >+{
> >+	struct inode *inode = page->mapping->host;
> >+	struct gfs2_inode *ip = page->mapping->host->u.generic_ip;
> >+	struct gfs2_sbd *sdp = ip->i_sbd;
> >+	loff_t i_size = i_size_read(inode);
> >+	pgoff_t end_index = i_size >> PAGE_CACHE_SHIFT;
> >+	unsigned offset;
> >+	int error;
> >+	int done_trans = 0;
> >+
> >+	if (gfs2_assert_withdraw(sdp, gfs2_glock_is_held_excl(ip->i_gl))) {
> >+		unlock_page(page);
> >+		return -EIO;
> >+	}
> >+	if (current->journal_info)
> >+		goto out_ignore;
> >+
> >+	/* Is the page fully outside i_size? (truncate in progress) */
> >+        offset = i_size & (PAGE_CACHE_SIZE-1);
> >+	if (page->index >= end_index+1 || !offset) {
> >+		page->mapping->a_ops->invalidatepage(page, 0);
> >+		unlock_page(page);
> >+		return 0; /* don't care */
> >+	}
> >
> >  
> >
> Will above "|| !offset" unconditionally drop the page if the file size 
> happens to be multiples of PAGE_CACHE_SIZE ?  Maybe this truncate 
> handling should be removed to let block_write_full_page() handle all the 
> cases ?
> 
This test was incorrectly borrowed from block_write_full_page in order
that we would avoid having to start a transaction, or add buffers to
pages, in case the page had already been truncated. I've just pushed a
patch to fix this:

http://www.kernel.org/git/?p=linux/kernel/git/steve/gfs2-2.6.git;a=commitdiff;h=d2d7b8a2a756fb520792ca3db3abdeed9214ae5b

Steve.


