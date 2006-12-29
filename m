Return-Path: <linux-kernel-owner+w=401wt.eu-S1752317AbWL2MXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752317AbWL2MXe (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 07:23:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752326AbWL2MXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 07:23:34 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:57246 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752317AbWL2MXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 07:23:33 -0500
Date: Fri, 29 Dec 2006 13:19:46 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Segher Boessenkool <segher@kernel.crashing.org>,
       David Miller <davem@davemloft.net>, nickpiggin@yahoo.com.au,
       kenneth.w.chen@intel.com, guichaz@yahoo.fr, hugh@veritas.com,
       linux-kernel@vger.kernel.org, ranma@tdiedrich.de,
       gordonfarquharson@gmail.com, akpm@osdl.org, a.p.zijlstra@chello.nl,
       tbm@cyrius.com, arjan@infradead.org, andrei.popa@i-neo.ro
Subject: [patch] fix data corruption bug in __block_write_full_page()
Message-ID: <20061229121946.GA17837@elte.hu>
References: <Pine.LNX.4.64.0612281125100.4473@woody.osdl.org> <20061228114517.3315aee7.akpm@osdl.org> <Pine.LNX.4.64.0612281156150.4473@woody.osdl.org> <20061228.143815.41633302.davem@davemloft.net> <3d6d8711f7b892a11801d43c5996ebdf@kernel.crashing.org> <Pine.LNX.4.64.0612282155400.4473@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612282155400.4473@woody.osdl.org>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Linus Torvalds <torvalds@osdl.org> wrote:

> I do have a few interesting details from the trace I haven't really 
> analyzed yet. Here's the trace for events on one of the pages that was 
> corrupted. Note how the events are numbered (there were 171640 events 
> total), so the thing you see is just a small set of events from the 
> whole big trace, but it's the ones that talk about _that_ particular 
> page.

i've extended the tracer in -rt to trace all relevant pagetable, 
pagecache, buffer-cache and IO events and coupled the tracer to your 
test.c code. The corruption happens here:

    test-2126  0.... 3756170us+: trace_page (cf20ebd8 b6a2c000 0)
 pdflush-2006  0.... 6432909us+: trace_page (cf20ebd8 b6a2c000 4200420)
    test-2126  0.... 8135596us+: trace_page (cf20ebd8 b6a2c000 4200420)
    test-2126  0D... 9012933us+: do_page_fault (8048900 4 b6a2c000)
    test-2126  0.... 9023278us+: trace_page (cf262f24 b6a2c000 0)
    test-2126  0.... 9023305us > sys_prctl (000000d8 b6a2c000 000000ac)

address 0xb6a2c000 is the one that shows the corruption. Now, this 
address is mapped to page cf262f24 when the bug happened, but it had 
page 0xcf20ebd8 mapped to it 3 seconds ago, which has this history:

    test-2126  0.... 3756413us+: trace_page (cf20ebd8 0 0)
    test-2126  0.... 3756469us+: trace_page (cf20ebd8 0 0)
    test-2126  0.... 3757341us+: trace_page (cf20ebd8 10 0)
  IRQ-14-402   0.... 3759332us+: trace_page (cf20ebd8 ffffffff 0)
  IRQ-14-402   0.... 3759376us+: trace_page (cf20ebd8 ffffffff 0)
    test-2126  0.... 5104662us+: trace_page (cf20ebd8 b6a2c400 0)
    test-2126  0.... 5104687us+: trace_page (cf20ebd8 1 0)
 pdflush-2006  0.... 6432909us+: trace_page (cf20ebd8 b6a2c000 4200420)
 pdflush-2006  0.... 6432952us+: trace_page (cf20ebd8 ffffffff 4200420)
 pdflush-2006  0.... 6432986us+: trace_page (cf20ebd8 1 4200420)
 pdflush-2006  0.... 6433022us+: trace_page (cf20ebd8 4096 4200420)
 pdflush-2006  0.... 6433061us+: trace_page (cf20ebd8 0 4200420)
 pdflush-2006  0.... 6433112us+: trace_page (cf20ebd8 0 4200420)
 pdflush-2006  0.... 6433154us+: trace_page (cf20ebd8 0 4200420)
 pdflush-2006  0.... 6433303us+: trace_page (cf20ebd8 11 4200420)
 pdflush-2006  0.... 6433343us+: trace_page (cf20ebd8 13 4200420)
 pdflush-2006  0.... 6433382us+: trace_page (cf20ebd8 14 4200420)
 pdflush-2006  0.... 6433421us+: trace_page (cf20ebd8 15 4200420)
 pdflush-2006  0.... 6433460us+: trace_page (cf20ebd8 ffffffff 4200420)
 pdflush-2006  0.... 6433504us+: trace_page (cf20ebd8 ffffffff 4200420)
    test-2126  0.... 8135596us+: trace_page (cf20ebd8 b6a2c000 4200420)

in particular timestamp 6433421us is interesting:

 pdflush-2006  0.... 6433504us+: trace_page (cf20ebd8 ffffffff 4200420)
 pdflush-2006  0.... 6433526us : trace_page()<-test_clear_page_writeback()<-end_page_writeback()<-__block_write_full_page()
 pdflush-2006  0.... 6433526us+: block_write_full_page()<-ext3_ordered_writepage()<-generic_writepages()<-(-1)()

i.e. the page got its pending writeback cancelled in 
block_write_full_page(), without any IRQ#14 activity whatsoever! That 
looks quite suspect. It is this piece of code in 
__block_write_full_page():

                /*
                 * The page was marked dirty, but the buffers were
                 * clean.  Someone wrote them back by hand with
                 * ll_rw_block/submit_bh.  A rare case.
                 */
                ....
                if (uptodate)
                        SetPageUptodate(page);
                end_page_writeback(page);

A 'rare case' ... hm. So i tried a quick workaround below, just to keep 
us from marking the page clean, to see whether the corruption goes away 
- and i was unable to trigger the corruption after half an hour of 
testing, while before it triggered within 10 seconds!

now this patch is only an ugly hack, but the bug definitely seems to be 
related to buffer management, as you suspected.

	Ingo

---
 fs/buffer.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux/fs/buffer.c
===================================================================
--- linux.orig/fs/buffer.c
+++ linux/fs/buffer.c
@@ -1702,6 +1702,7 @@ done:
 		} while (bh != head);
 		if (uptodate)
 			SetPageUptodate(page);
+		set_page_dirty(page);
 		end_page_writeback(page);
 		/*
 		 * The page and buffer_heads can be released at any time from
