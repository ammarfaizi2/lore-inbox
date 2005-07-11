Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262752AbVGKWUi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262752AbVGKWUi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 18:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262757AbVGKWSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 18:18:34 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:10939 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262752AbVGKWRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 18:17:39 -0400
Subject: kjournald wasting CPU in invert_lock fs/jbd/commit.c
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Daniel Walker <dwalker@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, "Stephen C. Tweedie" <sct@redhat.com>,
       Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 11 Jul 2005 18:17:02 -0400
Message-Id: <1121120222.6087.44.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that the code in commit.c of the jbd system can waste CPU
cycles. The offending code is as follows.

static int inverted_lock(journal_t *journal, struct buffer_head *bh)
{
        if (!jbd_trylock_bh_state(bh)) {
                spin_unlock(&journal->j_list_lock);
                schedule();
                return 0;
        }
        return 1;
}

[...]

void journal_commit_transaction(journal_t *journal)
{

[...]

write_out_data:
        cond_resched();
        spin_lock(&journal->j_list_lock);

        while (commit_transaction->t_sync_datalist) {
                struct buffer_head *bh;

                jh = commit_transaction->t_sync_datalist;
                commit_transaction->t_sync_datalist = jh->b_tnext;
                bh = jh2bh(jh);
                if (buffer_locked(bh)) {
                        BUFFER_TRACE(bh, "locked");
                        if (!inverted_lock(journal, bh))
                                goto write_out_data;


This code makes a loop if the jbd_trylock_bh_state fails. This code will
wait till whoever owns the lock releases it. But it is really in a busy
loop and will only be interrupted when the kjournald uses up all its
quota.  So it's basically just wasting CPU cycles here.  The following
patch should fix this.

Signed-off-by: Steven Rostedt rostedt@goodmis.org
---
--- a/fs/jbd/commit.c	2005-07-11 17:51:37.000000000 -0400
+++ b/fs/jbd/commit.c	2005-07-11 17:51:58.000000000 -0400
@@ -87,7 +87,7 @@ static int inverted_lock(journal_t *jour
 {
 	if (!jbd_trylock_bh_state(bh)) {
 		spin_unlock(&journal->j_list_lock);
-		schedule();
+		yield();
 		return 0;
 	}
 	return 1;


