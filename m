Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbTDKR2o (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 13:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbTDKR2o (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 13:28:44 -0400
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:30713 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S261294AbTDKR2m (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 13:28:42 -0400
Date: Fri, 11 Apr 2003 11:39:41 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: CaT <cat@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext3 weirdness
Message-ID: <20030411113941.O26054@schatzie.adilger.int>
Mail-Followup-To: CaT <cat@zip.com.au>, linux-kernel@vger.kernel.org
References: <20030411170655.GA10449@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030411170655.GA10449@zip.com.au>; from cat@zip.com.au on Sat, Apr 12, 2003 at 03:06:56AM +1000
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 12, 2003  03:06 +1000, CaT wrote:
> Why would this:
> 
> while true; do dd if=/dev/zero of=foo count=100 bs=10000; rm foo; done
> 
> Produce the following result?
> 
> ...
> 100+0 records in
> 100+0 records out
> 100+0 records in
> 100+0 records out
> dd: writing `foo': No space left on device
> 70+0 records in
> 69+0 records out
> dd: writing `foo': No space left on device
> 1+0 records in
> 0+0 records out
:
> dd: writing `foo': No space left on device
> 1+0 records in
> 0+0 records out
> 100+0 records in
> 100+0 records out
> 100+0 records in
> 100+0 records out
> ...

Because you can't reallocate in-use blocks until the dirty bitmaps have
been committed to disk in a transaction.

What should probably happen is that in ext3_new_block() we should flush
the journal (once!) if we are going to return -ENOSPC and restart
the allocation attempt.

This may be easy (just calling journal_flush()) or it may be more effort,
depending on how the locking looks.  I think journal_flush() is no good,
because by the time ext3_new_block() is called we always have a journal
handle, and I believe journal_flush() will wait for all transactions to
complete -> deadlock.

Maybe something like (just a guess):

+	int flushed = 0;

	:
	:
+repeat:
	/*
	 * First, test whether the goal block is free.
	 */

	:
	:

	/* No space left on the device */
+	if (!flushed && journal->j_committing_transaction) {
+		transaction = journal->j_committing_transaction;
+		log_wait_commit(journal, transaction->t_tid);
+		flushed = 1;
+		goto repeat;
+	}
+
	goto out;

search_back:

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

