Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265237AbUBBKNF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 05:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265333AbUBBKNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 05:13:05 -0500
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:5260 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S265237AbUBBKNB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 05:13:01 -0500
Date: Mon, 02 Feb 2004 19:12:42 +0900 (JST)
Message-Id: <20040202.191242.278747628.nomura@linux.bs1.fc.nec.co.jp>
To: linux-kernel@vger.kernel.org
Cc: j-nomura@ce.jp.nec.com
Subject: [2.4] heavy-load under swap space shortage
From: j-nomura@ce.jp.nec.com
X-Mailer: Mew version 3.3 on XEmacs 21.4.14 (Reasonable Discussion)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

swap_out() seems always trying scan even if there are no swap space available.
This keeps CPU(s) busy with rare successful page-out and may cause lock
contention in big smp system.

  swap_out()
    ..
    try_to_swap_out()
      ..
      entry = get_swap_page()
      /* find no swap page available */

How about checking nr_swap_pages first and giving up if it's 0?
Applying the patch below extremely reduced systime consumption by swap_out
under swap space shortage.

Systems without swap also suffer from the same problem.

Any comments?

Best regards.
--
NOMURA, Jun'ichi <j-nomura@ce.jp.nec.com>

--- linux-2.4.24/mm/vmscan.c
+++ linux/mm/vmscan.c
@@ -326,8 +326,11 @@ out_unlock:
 static int swap_out(zone_t * classzone)
 {
 	int counter, nr_pages = SWAP_CLUSTER_MAX;
 	struct mm_struct *mm;
+
+	if (nr_swap_pages <= 0)
+		return 0;
 
 	counter = mmlist_nr << 1;
 	do {
		if (unlikely(current->need_resched)) {

