Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261323AbUKFHPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261323AbUKFHPw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 02:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261327AbUKFHPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 02:15:52 -0500
Received: from BACHE.ECE.CMU.EDU ([128.2.129.23]:49662 "EHLO bache.ece.cmu.edu")
	by vger.kernel.org with ESMTP id S261323AbUKFHPr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 02:15:47 -0500
Message-ID: <418C7A22.3000205@ece.cmu.edu>
Date: Sat, 06 Nov 2004 02:15:46 -0500
From: Michael Mesnier <mmesnier@ece.cmu.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, mmesnier@ece.cmu.edu
Subject: delay in block_read_full_page()
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Please cc: me directly in your response.

I'm running into some trouble with an installable file system I'm 
writing. In myfs_readpage() I simply return block_read_full_page() which 
subsequently calls myfs_get_block().  However, there's a delay before 
the I/O actually gets issued to the device.  Running sync from the 
command line causes the I/O to get issued immediately, so the sync call 
(even it there aren't dirty buffers) also manages to schedule any 
outstanding read I/Os. How should my fs indicate to the vfs that these 
read I/Os need to be issued immediately after my_readpage() is called?

Thanks in advanced,

-Mike

static int myfs_get_block(struct inode *inode, long iblock, struct 
buffer_head *bh_result, int create) {
    bh_result->b_dev = inode->i_dev;
    bh_result->b_blocknr = iblock;
    bh_result->b_state |= (1UL << BH_Mapped);
    return 0;
}

static int myfs_readpage(struct file *file, struct page *page) {
    return block_read_full_page(page,myfs_get_block);
}

