Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965687AbWKGSKp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965687AbWKGSKp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 13:10:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965686AbWKGSKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 13:10:44 -0500
Received: from mx1.redhat.com ([66.187.233.31]:17886 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965684AbWKGSKn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 13:10:43 -0500
Message-ID: <4550CC1C.6050205@redhat.com>
Date: Tue, 07 Nov 2006 12:10:36 -0600
From: Eric Sandeen <sandeen@redhat.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
CC: Jeff Layton <jlayton@redhat.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make last_inode counter in new_inode 32-bit on kernels
 that offer x86 compatability
References: <20061106182222.GO27140@parisc-linux.org> <1162838843.12129.8.camel@dantu.rdu.redhat.com> <20061106202313.GA691@wohnheim.fh-wedel.de> <454FA032.1070008@redhat.com> <20061106211134.GB691@wohnheim.fh-wedel.de> <454FAAF8.8080707@redhat.com> <1162914966.28425.24.camel@dantu.rdu.redhat.com> <20061107172835.GB15629@wohnheim.fh-wedel.de> <20061107174217.GA29746@wohnheim.fh-wedel.de> <20061107175601.GB29746@wohnheim.fh-wedel.de> <20061107180127.GC29746@wohnheim.fh-wedel.de>
In-Reply-To: <20061107180127.GC29746@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel wrote:
> And the last one is xfs_mapping_buftarg().  I am completely at a loss.
> As far as I can tell, inode allocated, partially initiated and -
> leaked.  Am I missing something?

It's not leaked... the new inode's mapping is saved in the buftarg:

 	btp->bt_mapping = mapping;

and then eventually the inode is put/freed in xfs_free_buftarg():

        iput(btp->bt_mapping->host);

The inode's mapping itself is used in several places:

  File                    Function              Line
0 xfs/linux-2.6/xfs_buf.h <global>                84 struct address_space *bt_mapping;
1 xfs/linux-2.6/xfs_buf.c _xfs_buf_lookup_pages  345 struct address_space *mapping = bp->b_target->bt_mapping;
2 xfs/linux-2.6/xfs_buf.c xfs_buf_readahead      671 bdi = target->bt_mapping->backing_dev_info;
3 xfs/linux-2.6/xfs_buf.c xfs_buf_lock           906 blk_run_address_space(bp->b_target->bt_mapping);
4 xfs/linux-2.6/xfs_buf.c xfs_buf_wait_unpin     978 blk_run_address_space(bp->b_target->bt_mapping);
5 xfs/linux-2.6/xfs_buf.c xfs_buf_iowait        1291 blk_run_address_space(bp->b_target->bt_mapping);
6 xfs/linux-2.6/xfs_buf.c xfs_free_buftarg      1451 iput(btp->bt_mapping->host);
7 xfs/linux-2.6/xfs_buf.c xfs_mapping_buftarg   1545 btp->bt_mapping = mapping;
8 xfs/linux-2.6/xfs_buf.c xfsbufd               1728 blk_run_address_space(target->bt_mapping);
9 xfs/linux-2.6/xfs_buf.c xfs_flush_buftarg     1801 blk_run_address_space(target->bt_mapping);

-Eric

