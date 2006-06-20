Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751392AbWFTQdQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbWFTQdQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 12:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbWFTQdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 12:33:16 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:58326 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1751392AbWFTQdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 12:33:15 -0400
Message-ID: <44982344.2060507@bull.net>
Date: Tue, 20 Jun 2006 18:33:08 +0200
From: Zoltan Menyhart <Zoltan.Menyhart@bull.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en, fr, hu
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>, sct@redhat.com
Subject: Re: [PATCH] Change ll_rw_block() calls in JBD
References: <446C2F89.5020300@bull.net> <20060518134533.GA20159@atrey.karlin.mff.cuni.cz> <447F13B3.6050505@bull.net> <20060601162751.GH26933@atrey.karlin.mff.cuni.cz> <44801E16.3040300@bull.net> <20060602134923.GA1644@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20060602134923.GA1644@atrey.karlin.mff.cuni.cz>
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 20/06/2006 18:37:06,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 20/06/2006 18:37:07,
	Serialize complete at 20/06/2006 18:37:07
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have got some crashes due to:

Assertion failure in __journal_file_buffer():
      "jh->b_transaction == transaction || jh->b_transaction == 0"

[<a0000002053b44e0>] __journal_file_buffer+0x420/0x7c0 [jbd]
      r32 : e000000161a1f3e0  jh
      r33 : e00000010396a380  transaction
      r34 : 0000000000000008  jlist == BJ_Locked

*(struct journal_head *) 0xe000000161a1f3e0: // jh
{
 b_bh = 0xe00000048bb36930,
 b_jcount = 0x0,
 b_jlist = 0x1,
 b_modified = 0x0,
 b_frozen_data = 0x0,
 b_committed_data = 0x0,
 b_transaction = 0xe0000020014adb80,	// ->j_running_transaction
 b_next_transaction = 0x0,
 b_tnext = 0xe0000001c17306e0,
 b_tprev = 0xe00000204757e540,
 b_cp_transaction = 0x0,
 b_cpnext = 0x0,
 b_cpprev = 0x0
}

*(struct buffer_head *) 0xe00000048bb36930: // jh->b_bh
{
b_state = 0x8201d,
b_this_page = 0xe00000048bb33d88,
b_page = 0xa07ffffff9201300,
b_count = {
  counter = 0x2
},
b_size = 0x1000,
b_blocknr = 0xadc001,
b_data = 0xe000000492a0e000,
b_bdev = 0xe0000023fe1ca300,
b_end_io = 0xa000000100630be0,
b_private = 0xe000000161a1f3e0,
b_assoc_buffers = {
  next = 0xe00000048bb36978,
  prev = 0xe00000048bb36978
}

--- Called from --- :

journal_submit_data_buffers+0x200/0x660 [jbd]
      r32 : e0000001035ec100  journal
      r33 : e00000010396a380  commit_transaction

As you can see, the current "jh" has been stolen for the new
"->j_running_transaction" while we released temporarily "->j_list_lock"
in the middle of "journal_submit_data_buffers()".

Therefore the test "jh->b_jlist != BJ_SyncData", i.e. if it is still
on a (_any_) sync. list is not enough.

--- linux-2.6.16.20-orig/fs/jbd/commit.c	2006-06-20 17:19:47.000000000 +0200
+++ linux-2.6.16.20/fs/jbd/commit.c	2006-06-20 17:35:54.000000000 +0200
@@ -219,15 +219,26 @@
 				bufs = 0;
 				lock_buffer(bh);
 				spin_lock(&journal->j_list_lock);
+				/* Stolen (e.g. for a new transaction) ? */
+				if (jh != commit_transaction->t_sync_datalist) {
+					unlock_buffer(bh);
+					JBUFFER_TRACE(jh, "stolen sync. data");
+					put_bh(bh);
+					continue;
+				}
 				/* Someone already cleaned up the buffer? */
-				if (!buffer_jbd(bh)
-					|| jh->b_jlist != BJ_SyncData) {
+
+				// Can this happen???
+
+				if (!buffer_jbd(bh)) {
 					unlock_buffer(bh);
 					BUFFER_TRACE(bh, "already cleaned up");
 					put_bh(bh);
 					continue;
 				}
 				put_bh(bh);
+				J_ASSERT_JH(jh, jh->b_transaction ==
+							commit_transaction);
 			}
 			if (test_clear_buffer_dirty(bh)) {
 				BUFFER_TRACE(bh, "needs writeout, submitting");

I am not really sure that the test "!buffer_jbd(bh)" is really useful.
I left it alone for not introducing a new bug.
If you can confirm that it is not necessary, I can take it away.

Thanks,

Zoltan





