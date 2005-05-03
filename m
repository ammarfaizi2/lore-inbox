Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261735AbVECPQR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbVECPQR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 11:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261739AbVECPQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 11:16:17 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:22410 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261735AbVECPPy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 11:15:54 -0400
Subject: Re: 2.6.12-rc2 + rc3: reaim with ext3 - system stalls.
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Jan Kara <jack@suse.cz>
Cc: cliff white <cliffw@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050503144325.GF4501@atrey.karlin.mff.cuni.cz>
References: <20050421152345.6b87aeae@es175>
	 <20050503144325.GF4501@atrey.karlin.mff.cuni.cz>
Content-Type: multipart/mixed; boundary="=-LBuZsEP+un6vb/N1S6Yo"
Organization: 
Message-Id: <1115132463.26913.828.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 03 May 2005 08:01:03 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-LBuZsEP+un6vb/N1S6Yo
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2005-05-03 at 07:43, Jan Kara wrote:
>   Hello,
> 
> > Started seeing some odd behaviour with recent kernels, haven't been able to
> > run it down, could use some suggestions/help.
> > 
> > Running re-aim7 with 2.6.12-rc2 and rc3, if I use xfs, jfs, or
> > reiserfs things work just fine.
> > 
> > With ext3, the  test stalls, such that:
> > CPU is 50% idle, 50% waiting IO (top)
> > vmstat shows one process blocked wio
>   I've looked through your dumps and I spotted where is the problem -
> it's our well known and beloved lock inversion between PageLock and
> transaction start (giving CC to Badari who's the author of the patch
> that introduced it AFAIK).

Yuck. It definitely not intentional.

>   The correct order is: first get PageLock and *then* start transaction.
> But in ext3_writeback_writepages() first ext3_journal_start() is called
> and then __mpage_writepages is called that tries to do LockPage and
> deadlock is there. Badari, could you please fix that (sadly I think that
> would not be easy)? Maybe we should back out those changes until it gets
> fixed...

Hmm.. let me take a closer look. You are right, its not going to be
simple fix.

Cliff, here is the patch to backout writepages() for ext3. Can you
verify that problems goes away with this patch ?

Thanks,
Badari

--=-LBuZsEP+un6vb/N1S6Yo
Content-Disposition: attachment; filename=ext3-writeback-nowritepages.patch
Content-Type: text/plain; name=ext3-writeback-nowritepages.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.12-rc3.org/fs/ext3/inode.c	2005-05-02 22:28:30.000000000 -0700
+++ linux-2.6.12-rc3/fs/ext3/inode.c	2005-05-02 22:29:00.000000000 -0700
@@ -1621,7 +1621,9 @@ static struct address_space_operations e
 	.readpage	= ext3_readpage,
 	.readpages	= ext3_readpages,
 	.writepage	= ext3_writeback_writepage,
+#if 0
 	.writepages	= ext3_writeback_writepages,
+#endif
 	.sync_page	= block_sync_page,
 	.prepare_write	= ext3_prepare_write,
 	.commit_write	= ext3_writeback_commit_write,

--=-LBuZsEP+un6vb/N1S6Yo--

