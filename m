Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263847AbTEWHHM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 03:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263850AbTEWHHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 03:07:12 -0400
Received: from tmi.comex.ru ([217.10.33.92]:28097 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S263847AbTEWHHL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 03:07:11 -0400
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@digeo.com>, ext2-devel@lists.sourceforge.net,
       Alex Tomas <bzzz@tmi.comex.ru>
Subject: [RFC] probably invalid accounting in jbd
From: Alex Tomas <bzzz@tmi.comex.ru>
Organization: HOME
Date: Fri, 23 May 2003 11:20:31 +0000
In-Reply-To: <20030521093848.59ada625.akpm@digeo.com> (Andrew Morton's
 message of "Wed, 21 May 2003 09:38:48 -0700")
Message-ID: <871xypx62o.fsf_-_@gw.home.net>
User-Agent: Gnus/5.090018 (Oort Gnus v0.18) Emacs/21.3 (gnu/linux)
References: <87d6igmarf.fsf@gw.home.net>
	<1053376482.11943.15.camel@sisko.scot.redhat.com>
	<87he7qe979.fsf@gw.home.net>
	<1053377493.11943.32.camel@sisko.scot.redhat.com>
	<87addhd2mc.fsf@gw.home.net> <20030521093848.59ada625.akpm@digeo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi!

I think current journal_release_buffer() which is used by ext3 allocator
in -mm tree has a bug. look, it won't decrement credits if concurrent
thread already put buffer on metadata list. but this may ext3_try_to_allocate()
may overflow handle's credist.
so, jbd will hit J_ASSERT_JH(jh, handle->h_buffer_credits > 0) somewhere


void journal_release_buffer (handle_t *handle, struct buffer_head *bh)
{
        .....
        if (jh->b_jlist == BJ_Reserved && jh->b_transaction == transaction &&
            !buffer_jdirty(jh2bh(jh))) {
                JBUFFER_TRACE(jh, "unused: refiling it");
                handle->h_buffer_credits++;
                __journal_refile_buffer(jh);
        }
        ....
}


here is the patch against 2.5.69-mm6:

diff -puNr linux-2.5.69-mm6/fs/jbd/transaction.c edited/fs/jbd/transaction.c
--- linux-2.5.69-mm6/fs/jbd/transaction.c	Fri May 16 18:03:20 2003
+++ b_commited_data-race/fs/jbd/transaction.c	Fri May 23 11:10:21 2003
@@ -1146,10 +1146,10 @@ void journal_release_buffer (handle_t *h
 	if (jh->b_jlist == BJ_Reserved && jh->b_transaction == transaction &&
 	    !buffer_jdirty(jh2bh(jh))) {
 		JBUFFER_TRACE(jh, "unused: refiling it");
-		handle->h_buffer_credits++;
 		__journal_refile_buffer(jh);
 	}
 	spin_unlock(&journal_datalist_lock);
+	handle->h_buffer_credits++;
 
 	JBUFFER_TRACE(jh, "exit");
 	unlock_journal(journal);

