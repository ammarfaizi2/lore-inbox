Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750816AbWIWWf7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbWIWWf7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 18:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbWIWWf7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 18:35:59 -0400
Received: from gate.crashing.org ([63.228.1.57]:48056 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750816AbWIWWf6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 18:35:58 -0400
Subject: Re: [RFC] page fault retry with NOPAGE_RETRY
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Hugh Dickins <hugh@veritas.com>, Mike Waychison <mikew@google.com>,
       linux-mm@kvack.org, Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20060923124618.e5ef3a51.akpm@osdl.org>
References: <1158274508.14473.88.camel@localhost.localdomain>
	 <20060915001151.75f9a71b.akpm@osdl.org> <45107ECE.5040603@google.com>
	 <1158709835.6002.203.camel@localhost.localdomain>
	 <1158710712.6002.216.camel@localhost.localdomain>
	 <20060919172105.bad4a89e.akpm@osdl.org>
	 <1158717429.6002.231.camel@localhost.localdomain>
	 <20060919200533.2874ce36.akpm@osdl.org>
	 <1158728665.6002.262.camel@localhost.localdomain>
	 <20060919222656.52fadf3c.akpm@osdl.org>
	 <1158735299.6002.273.camel@localhost.localdomain>
	 <20060920105317.7c3eb5f4.akpm@osdl.org>
	 <Pine.LNX.4.64.0609231421110.25804@blonde.wat.veritas.com>
	 <20060923124618.e5ef3a51.akpm@osdl.org>
Content-Type: text/plain
Date: Sun, 24 Sep 2006 08:35:36 +1000
Message-Id: <1159050936.14486.115.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Perhaps we should concentrate on that for now.  Did we have a patch to look
> at?

Only a hand written proto-patch. Below is a real (but untested) one.
Note that there might be still issues when called from get_user_pages()
which of course won't go back to userland. For the two usage scenario I
have in mind, it should be ok though. One (a signal pending) will loop
back in until the resource is available, the other (no_page() inserts
the PTE itself) is just fine. For the former case, I've added a
cond_resched() to the loop, we might want to look into adding the info
of wether we are coming from get_user_pages() vs. do_page_fault() to
these new arguments you want to add to page fault handlers. That would
allow in our case to do a non-interruptibe sleep when caused by
get_user_pages().

---

Add a way for a no_page() handler to request a retry of the faulting
instruction. It goes back to userland on page faults and just tries
again in get_user_pages(). I added a cond_resched() in the loop in that
later case.

Signed-off-by: Benjamin Herrenchmidt <benh@kernel.crashing.org>

Index: linux-work/include/linux/mm.h
===================================================================
--- linux-work.orig/include/linux/mm.h	2006-08-30 08:51:21.000000000 +1000
+++ linux-work/include/linux/mm.h	2006-09-24 08:25:33.000000000 +1000
@@ -623,6 +623,7 @@
  */
 #define NOPAGE_SIGBUS	(NULL)
 #define NOPAGE_OOM	((struct page *) (-1))
+#define NOPAGE_RETRY	((struct page *) (-2))
 
 /*
  * Different kinds of faults, as returned by handle_mm_fault().
Index: linux-work/mm/memory.c
===================================================================
--- linux-work.orig/mm/memory.c	2006-08-17 16:16:06.000000000 +1000
+++ linux-work/mm/memory.c	2006-09-24 08:34:09.000000000 +1000
@@ -1081,6 +1081,7 @@
 				default:
 					BUG();
 				}
+				cond_resched();
 			}
 			if (pages) {
 				pages[i] = page;
@@ -2117,11 +2118,13 @@
 	 * after the next truncate_count read.
 	 */
 
-	/* no page was available -- either SIGBUS or OOM */
-	if (new_page == NOPAGE_SIGBUS)
+	/* no page was available -- either SIGBUS, OOM or RETRY */
+	if (unlikely(new_page == NOPAGE_SIGBUS))
 		return VM_FAULT_SIGBUS;
-	if (new_page == NOPAGE_OOM)
+	else if (unlikely(new_page == NOPAGE_OOM))
 		return VM_FAULT_OOM;
+	else if (unlikely(new_page == NOPAGE_RETRY))
+		return VM_FAULT_MINOR;
 
 	/*
 	 * Should we do an early C-O-W break?


