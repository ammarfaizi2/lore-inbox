Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751417AbVKDH0x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbVKDH0x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 02:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbVKDH0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 02:26:53 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:20392 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751417AbVKDH0w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 02:26:52 -0500
Date: Fri, 4 Nov 2005 08:26:28 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Badari Pulavarty <pbadari@gmail.com>, Linus Torvalds <torvalds@osdl.org>,
       jdike@addtoit.com, rob@landley.net, nickpiggin@yahoo.com.au,
       gh@us.ibm.com, kamezawa.hiroyu@jp.fujitsu.com, haveblue@us.ibm.com,
       mel@csn.ul.ie, mbligh@mbligh.org, kravetz@us.ibm.com,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Subject: [patch] swapin rlimit
Message-ID: <20051104072628.GA20108@elte.hu>
References: <E1EXEfW-0005ON-00@w-gerrit.beaverton.ibm.com> <200511021747.45599.rob@landley.net> <43699573.4070301@yahoo.com.au> <200511030007.34285.rob@landley.net> <20051103163555.GA4174@ccure.user-mode-linux.org> <1131035000.24503.135.camel@localhost.localdomain> <20051103205202.4417acf4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051103205202.4417acf4.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> Similarly, that SGI patch which was rejected 6-12 months ago to kill 
> off processes once they started swapping.  We thought that it could be 
> done from userspace, but we need a way for userspace to detect when a 
> task is being swapped on a per-task basis.

wouldnt the clean solution here be a "swap ulimit"?

I.e. something like the 2-minute quick-hack below (against Linus-curr).  

	Ingo

---
implement a swap ulimit: RLIMIT_SWAP.

setting the ulimit to 0 causes any swapin activity to kill the task.  
Setting the rlimit to 0 is allowed for unprivileged users too, since it 
is a decrease of the default RLIM_INFINITY value. I.e. users could run 
known-memory-intense jobs with such an ulimit set, and get a guarantee 
that they wont put the system into a swap-storm.

Note: it's just swapin that causes the SIGKILL, because at swapout time 
it's hard to identify the originating task. Pure swapouts and a buildup 
in the swap-cache is not punished, only actual hard swapins. I didnt try 
too hard to make the rlimit particularly finegrained - i.e. right now we 
only know 'zero' and 'infinity' ...

Signed-off-by: Ingo Molnar <mingo@elte.hu>

 include/asm-generic/resource.h |    4 +++-
 mm/memory.c                    |   13 +++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

Index: linux/include/asm-generic/resource.h
===================================================================
--- linux.orig/include/asm-generic/resource.h
+++ linux/include/asm-generic/resource.h
@@ -44,8 +44,9 @@
 #define RLIMIT_NICE		13	/* max nice prio allowed to raise to
 					   0-39 for nice level 19 .. -20 */
 #define RLIMIT_RTPRIO		14	/* maximum realtime priority */
+#define RLIMIT_SWAP		15	/* maximum swapspace for task */
 
-#define RLIM_NLIMITS		15
+#define RLIM_NLIMITS		16
 
 /*
  * SuS says limits have to be unsigned.
@@ -86,6 +87,7 @@
 	[RLIMIT_MSGQUEUE]	= {   MQ_BYTES_MAX,   MQ_BYTES_MAX },	\
 	[RLIMIT_NICE]		= { 0, 0 },				\
 	[RLIMIT_RTPRIO]		= { 0, 0 },				\
+	[RLIMIT_SWAP]		= {  RLIM_INFINITY,  RLIM_INFINITY },	\
 }
 
 #endif	/* __KERNEL__ */
Index: linux/mm/memory.c
===================================================================
--- linux.orig/mm/memory.c
+++ linux/mm/memory.c
@@ -1647,6 +1647,18 @@ void swapin_readahead(swp_entry_t entry,
 }
 
 /*
+ * Crude first-approximation swapin-avoidance: if there is a zero swap
+ * rlimit then kill the task.
+ */
+static inline void check_swap_rlimit(void)
+{
+	unsigned long limit = current->signal->rlim[RLIMIT_SWAP].rlim_cur;
+
+	if (limit != RLIM_INFINITY)
+		force_sig(SIGKILL, current);
+}
+
+/*
  * We enter with non-exclusive mmap_sem (to exclude vma changes,
  * but allow concurrent faults), and pte mapped but not yet locked.
  * We return with mmap_sem still held, but pte unmapped and unlocked.
@@ -1667,6 +1679,7 @@ static int do_swap_page(struct mm_struct
 	entry = pte_to_swp_entry(orig_pte);
 	page = lookup_swap_cache(entry);
 	if (!page) {
+		check_swap_rlimit();
  		swapin_readahead(entry, address, vma);
  		page = read_swap_cache_async(entry, vma, address);
 		if (!page) {
