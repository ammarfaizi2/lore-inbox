Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267427AbTA1RLT>; Tue, 28 Jan 2003 12:11:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267442AbTA1RLT>; Tue, 28 Jan 2003 12:11:19 -0500
Received: from air-2.osdl.org ([65.172.181.6]:18103 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267427AbTA1RLR>;
	Tue, 28 Jan 2003 12:11:17 -0500
Date: Tue, 28 Jan 2003 09:14:06 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Yichen Xie <yxie@cs.stanford.edu>
cc: <linux-kernel@vger.kernel.org>, <mc@cs.stanford.edu>
Subject: Re: [CHECKER] 87 potential array bounds error/buffer overruns in
 2.5.53
In-Reply-To: <Pine.OSF.4.33.0301280104520.272436-100000@glide.stanford.edu>
Message-ID: <Pine.LNX.4.33L2.0301280904520.30636-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jan 2003, Yichen Xie wrote:

| Hi Randy, Thanks for the quick feedback! I had some additional comments
| below starting with '%'. -Yichen
|
| ---------------------------------------------------------
| % I was thinking about the case where "de" is NULL and "old"
| % gets garbage from the stack (since there's no initializer);
| % _devfs_alloc_entry won't be called in this case...

I think I finally see it...  How about:

| # This one is OK.  _devfs_append_entry() sets <old>.
| [BUG] "old" might get garbage on the stack
| /home/yxie/linux-2.5.53/fs/devfs/base.c:1179:_devfs_make_parent_for_leaf
| : ERROR:BUFFER:1179:1179:Dereferencing uninitialized pointer (*old)
| evaluated in the following state
| 	    de = _devfs_alloc_entry (name, next_pos, MODE_DIR);
| 	    devfs_get (de);
| 	    if ( !de || _devfs_append_entry (dir, de, FALSE, &old) )
| 	    {
		if (!de)
			return NULL;
| 		devfs_put (de);
|
| Error --->
| 		if ( !old || !S_ISDIR (old->mode) )
| 		{
| 		    devfs_put (old);
| 		    devfs_put (dir);
| ---------------------------------------------------------
| % In the definition of split_status_strings (line #683),
| % Comma after the first string is missing, so the first and
| % second string are concatenated together to form one element
| % --the array only has 7 elements, instead of 8.
|
| # I don't see the problem....
| [BUG] missing comma in definition of split_status_strings
| /home/yxie/linux-2.5.53/drivers/scsi/aic7xxx/aic79xx_pci.c:808:ahd_pci_s
| plit_intr: ERROR:BUFFER:808:808:Array bounds error (off >= len) [RANGE]
| (split_status_strings[bit], len = 7, off = sym_42005934, max(off-len) =
| 0)

I'll add a patch for this one to my patches.

| ---------------------------------------------------------
| % similar reason as above; missing comma after "REQ_SPECIAL"
|
| # Don't see a problem here....
| [BUG] missing comma in rq_flags
| /home/yxie/linux-2.5.53/drivers/block/ll_rw_blk.c:685:blk_dump_rq_flags:
| ERROR:BUFFER:685:685:Array bounds error (off >= len) (rq_flags[bit], len
| = 17, off = 17, min(off-len) = 0)

I'll add a patch for this one to my patches.

Thanks,
-- 
~Randy

