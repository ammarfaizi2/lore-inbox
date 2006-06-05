Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751016AbWFETws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbWFETws (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 15:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbWFETws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 15:52:48 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:9125 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1750733AbWFETwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 15:52:47 -0400
Subject: Re: 2.6.17-rc5-mm3-lockdep - locking error in quotaon
From: Arjan van de Ven <arjan@linux.intel.com>
To: Jan Kara <jack@suse.cz>
Cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20060605193552.GB24342@atrey.karlin.mff.cuni.cz>
References: <200606051700.k55H015q004029@turing-police.cc.vt.edu>
	 <1149528339.3111.114.camel@laptopd505.fenrus.org>
	 <200606051920.k55JKQGx003031@turing-police.cc.vt.edu>
	 <20060605193552.GB24342@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 05 Jun 2006 21:52:36 +0200
Message-Id: <1149537156.3111.123.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> following confuses the code (and I agree that it's kind of ugly from
> quota code to do that):
>   i_mutex of inode containing quota file is acquired after all other
> quota locks. i_mutex of all other inodes is acquired before quota locks.
> Quota code makes sure (by resetting inode operations and setting special
> flag on inode) that noone tries to enter quota code while holding
> i_mutex on a quota file...

can you point this out in a bit more detail, eg where exactly is this
happening? I think it is in this bit
       /* As we bypass the pagecache we must now flush the inode so that
         * we see all the changes from userspace... */
        write_inode_now(inode, 1);
        /* And now flush the block cache so that kernel sees the changes
*/
        invalidate_bdev(sb->s_bdev, 0);
        mutex_lock(&inode->i_mutex);
        mutex_lock(&dqopt->dqonoff_mutex);
        if (sb_has_quota_enabled(sb, type)) {
                error = -EBUSY;
                goto out_lock;

but that doesn't quite match your description...
