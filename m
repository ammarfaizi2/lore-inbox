Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbUBOPr6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 10:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264974AbUBOPr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 10:47:58 -0500
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:25682 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261931AbUBOPr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 10:47:56 -0500
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] Trivial -critical : BUG()gy behaviour on OOM
Date: Sun, 15 Feb 2004 16:47:39 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_bS5LAK3TteeQCAD"
Message-Id: <200402151647.39907.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_bS5LAK3TteeQCAD
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

In short: in vanilla 2.6.3-rc2 (and also 2.6.2-mm1) do_swap_page() can return 
-ENOMEM while value return values are VM_FAULT_*; invalid return values can 
result in BUG() being called, so this patch (or a better fix) should go in 
soon. This patch corrects this by returning VM_FAULT_OOM in that case.

CC me on replies, please, as I'm not subscribed. Thanks.

In detail: do_swap_page returns -ENOMEM when memory allocation fails; the 
return value will in turn be returned by handle_pte_fault and handle_mm_fault 
to this code in do_page_fault:

switch (handle_mm_fault(mm, vma, address, write)) {
	case VM_FAULT_MINOR:
		tsk->min_flt++;
		break;
	case VM_FAULT_MAJOR:
		tsk->maj_flt++;
		break;
	case VM_FAULT_SIGBUS:
		goto do_sigbus;
	case VM_FAULT_OOM:
		goto out_of_memory;
	default:
		BUG();
}

So on OOM we can get a BUG. Since do_file_page does this:

         if (err == -ENOMEM)
                return VM_FAULT_OOM;

and other code shows similar behaviour, I think that the attached fix is the 
correct one.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

--Boundary-00=_bS5LAK3TteeQCAD
Content-Type: text/x-diff;
  charset="us-ascii";
  name="Fix-mm-return.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="Fix-mm-return.patch"

--- ./mm/memory.c.fix	2004-02-04 20:48:15.000000000 +0100
+++ ./mm/memory.c	2004-02-14 17:59:42.000000000 +0100
@@ -1250,7 +1250,7 @@
 	mark_page_accessed(page);
 	pte_chain = pte_chain_alloc(GFP_KERNEL);
 	if (!pte_chain) {
-		ret = -ENOMEM;
+		ret = VM_FAULT_OOM;
 		goto out;
 	}
 	lock_page(page);

--Boundary-00=_bS5LAK3TteeQCAD--

