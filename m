Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261832AbUD3XlO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbUD3XlO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 19:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbUD3XlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 19:41:14 -0400
Received: from smtp1.Stanford.EDU ([171.67.16.123]:26326 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP id S261832AbUD3XlL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 19:41:11 -0400
Date: Fri, 30 Apr 2004 16:40:39 -0700 (PDT)
From: Junfeng Yang <yjf@stanford.edu>
To: Dave Kleikamp <shaggy@austin.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <jfs-discussion@www-124.southbury.usf.ibm.com>,
       Madanlal S Musuvathi <madan@stanford.edu>,
       "David L. Dill" <dill@cs.stanford.edu>
Subject: [CHECKER] Kernel panic when diWrite fails to get a page
Message-ID: <Pine.GSO.4.44.0404301638500.14945-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


txCommit calls diWrite, which can fail (diWrite -> read_metapage ->
read_cache_page).  txAbortCommit will be called in that case.  Kernel will
panic in LogSyncRelease on assert(log) because the "lo"g fields for some
metapages are NULL.  If we are going to kernel panic anyway, we should
panic at the first place without doing all these works to abort a
transcation.


int diWrite(tid_t tid, struct inode *ip)
{
	...
      retry:
	mp = read_metapage(ipimap, pageno << sbi->l2nbperpage, PSIZE, 1);
	if (mp == 0)
Fail -->	return -EIO;
	...
}

static void txAbortCommit(struct commit * cd)
{
	...
			if (mp->xflag & COMMIT_PAGE)
-->				LogSgyncRelease(mp);
	...
}




static void LogSyncRelease(struct metapage * mp)
{
	struct jfs_log *log = mp->log;

	assert(atomic_read(&mp->nohomeok));
Panic -->
	assert(log);
	atomic_dec(&mp->nohomeok);

	if (atomic_read(&mp->nohomeok))
		return;

	hold_metapage(mp, 0);

	LOGSYNC_LOCK(log);
	mp->log = NULL;
	mp->lsn = 0;
	mp->clsn = 0;
	log->count--;
	list_del_init(&mp->synclist);
	LOGSYNC_UNLOCK(log);

	release_metapage(mp);
}


