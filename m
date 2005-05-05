Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262168AbVEESMv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262168AbVEESMv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 14:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262165AbVEESMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 14:12:51 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:27352 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262172AbVEESM1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 14:12:27 -0400
Subject: Re: 2.6.12-rc2 + rc3: reaim with ext3 - system stalls.
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Cliff White <cliffw@osdl.org>
Cc: Jan Kara <jack@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <E1DTMKq-00043x-BO@es175>
References: <20050421152345.6b87aeae@es175>
	 <20050503144325.GF4501@atrey.karlin.mff.cuni.cz>
	 <1115132463.26913.828.camel@dyn318077bld.beaverton.ibm.com>
	 <E1DTMKq-00043x-BO@es175>
Content-Type: multipart/mixed; boundary="=-S52tSj2AlxoHUbE+YZOS"
Organization: 
Message-Id: <1115315827.26913.907.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 05 May 2005 10:57:07 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-S52tSj2AlxoHUbE+YZOS
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Andrew & Jan Kara,

I have an extremely simple patch to fix the problem.
Basically, move the journal_start_handle from writepages()
to ext3_writepages_get_block() (which gets called after locking
the page). What am I missing here ? The patch can't
be that simple :(

Please let me know.

BTW, I haven't done enough testing with the patch yet.

Thanks,
Badari

On Wed, 2005-05-04 at 09:02, Cliff White wrote:
> > 
> > --=-LBuZsEP+un6vb/N1S6Yo
> > Content-Type: text/plain
> > Content-Transfer-Encoding: 7bit
> > 
> > On Tue, 2005-05-03 at 07:43, Jan Kara wrote:
> > >   Hello,
> > > 
> > > > Started seeing some odd behaviour with recent kernels, haven't been able 
> > to
> > > > run it down, could use some suggestions/help.
> > > > 
> > > > Running re-aim7 with 2.6.12-rc2 and rc3, if I use xfs, jfs, or
> > > > reiserfs things work just fine.
> > > > 
> > > > With ext3, the  test stalls, such that:
> > > > CPU is 50% idle, 50% waiting IO (top)
> > > > vmstat shows one process blocked wio
> > >   I've looked through your dumps and I spotted where is the problem -
> > > it's our well known and beloved lock inversion between PageLock and
> > > transaction start (giving CC to Badari who's the author of the patch
> > > that introduced it AFAIK).
> > 
> > Yuck. It definitely not intentional.
> > 
> > >   The correct order is: first get PageLock and *then* start transaction.
> > > But in ext3_writeback_writepages() first ext3_journal_start() is called
> > > and then __mpage_writepages is called that tries to do LockPage and
> > > deadlock is there. Badari, could you please fix that (sadly I think that
> > > would not be easy)? Maybe we should back out those changes until it gets
> > > fixed...
> > 
> > Hmm.. let me take a closer look. You are right, its not going to be
> > simple fix.
> > 
> > Cliff, here is the patch to backout writepages() for ext3. Can you
> > verify that problems goes away with this patch ?
> > 
> I can now verify that the problem is not there with Badari's no-writepages
> patch  - all the runs last night completed, performance is about what it was
> for 2.6.12-rc1.
> cliffw


--=-S52tSj2AlxoHUbE+YZOS
Content-Disposition: attachment; filename=ext3-writeback-writepages-fix.patch
Content-Type: text/plain; name=ext3-writeback-writepages-fix.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.12-rc3.org/fs/ext3/inode.c	2005-05-02 22:28:30.000000000 -0700
+++ linux-2.6.12-rc3/fs/ext3/inode.c	2005-05-05 00:09:59.000000000 -0700
@@ -869,6 +869,14 @@ get_block:
 static int ext3_writepages_get_block(struct inode *inode, sector_t iblock,
 			struct buffer_head *bh, int create)
 {
+	handle_t *handle = journal_current_handle();
+
+	if (!handle) {
+		handle = ext3_journal_start(inode, 
+				ext3_writepage_trans_blocks(inode));
+		if (IS_ERR(handle)) 
+			return PTR_ERR(handle);
+	}
 	return ext3_direct_io_get_blocks(inode, iblock, 1, bh, create);
 }
 
@@ -1360,24 +1368,10 @@ ext3_writeback_writepages(struct address
 	handle_t *handle = NULL;
 	int err, ret = 0;
 
-	if (!mapping_tagged(mapping, PAGECACHE_TAG_DIRTY))
-		return ret;
-
-	handle = ext3_journal_start(inode, ext3_writepage_trans_blocks(inode));
-	if (IS_ERR(handle)) {
-		ret = PTR_ERR(handle);
-		return ret;
-	}
-
         ret = __mpage_writepages(mapping, wbc, ext3_writepages_get_block,
 					ext3_writeback_writepage_helper);
 
-	/*
-	 * Need to reaquire the handle since ext3_writepages_get_block()
-	 * can restart the handle
-	 */
 	handle = journal_current_handle();
-
 	err = ext3_journal_stop(handle);
 	if (!ret)
 		ret = err;

--=-S52tSj2AlxoHUbE+YZOS--

