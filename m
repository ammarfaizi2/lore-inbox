Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030369AbVLOCib@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030369AbVLOCib (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 21:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030383AbVLOCia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 21:38:30 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:2792 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030369AbVLOCi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 21:38:29 -0500
Date: Thu, 15 Dec 2005 11:37:37 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Linux Kernel ML <linux-kernel@vger.kernel.org>, linux-ia64@vger.kernel.org,
       linux-mm <linux-mm@kvack.org>, Benjamin LaHaise <bcrl@kvack.org>
Subject: 2.6.15-rc5-mm2 can't boot on ia64 due to changing on_each_cpu().
Cc: Andrew Morton <akpm@osdl.org>, "Luck, Tony" <tony.luck@intel.com>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.054
Message-Id: <20051215103344.241C.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.21.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello.

I met a trouble in 2.6.15-rc5-mm2 on my ia64 box. (Tiger4)
The trouble was kernel panic at early boot time due to calling
strange instruction "break 0" at smp_flush_tlb_all().

I investigated its cause and realized that gcc warned following 
messages.
  "arch/ia64/kernel/smp.c:228 Warning: function called through a non-
   compatible type"
  "arch/ia64/kernel/smp.c:228: note: if this code is reached,
   the program will abort"
  "arch/ia64/kernel/smp.c:251 Warning: function called through a non-
   compatible type"
  "arch/ia64/kernel/smp.c:251: note: if this code is reached,
   the program will abort"

The line 228 and 251 are calling on_each_cpu(). And the last
instruction of this function was "break 0" indeed.

void
smp_flush_tlb_all (void)
{
	on_each_cpu((void (*)(void *))local_flush_tlb_all, NULL, 1, 1);
}


void
smp_flush_tlb_mm (struct mm_struct *mm)
{
             :
             :
	 */
	on_each_cpu((void (*)(void *))local_finish_flush_tlb_mm, mm, 1, 1);
}

When I removed following patch which is in 2.6.15-rc5-mm2,
which changes on_each_cpu() from static inline function to macro,
then there was no warning, and kernel could boot up.
So, I guess that gcc was not able to solve a bit messy cast
for calling function "local_flush_tlb_all()" due to its change.

Thanks.

--------------------------------------------------------------------------

From: Benjamin LaHaise <bcrl@kvack.org>

An inline function in smp.h introduces messy ordering requirements on
thread_info by way of using an inline function instead of macro.  Convert
on_each_cpu to a macro in order to avoid a big include mess.

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 include/linux/smp.h |   25 +++++++++++++------------
 1 files changed, 13 insertions(+), 12 deletions(-)

diff -puN include/linux/smp.h~untangle-smph-vs-thread_info include/linux/smp.h
--- 25/include/linux/smp.h~untangle-smph-vs-thread_info	Fri Dec  9 15:16:46 2005
+++ 25-akpm/include/linux/smp.h	Fri Dec  9 15:16:46 2005
@@ -57,19 +57,20 @@ extern int smp_call_function (void (*fun
 			      int retry, int wait);
 
 /*
- * Call a function on all processors
+ * Call a function on all processors.
+ * This needs to be a macro to allow for arch specific dependances on
+ * sched.h in preempt_*().
  */
-static inline int on_each_cpu(void (*func) (void *info), void *info,
-			      int retry, int wait)
-{
-	int ret = 0;
-
-	preempt_disable();
-	ret = smp_call_function(func, info, retry, wait);
-	func(info);
-	preempt_enable();
-	return ret;
-}
+#define on_each_cpu(func, info, retry, wait)			\
+({								\
+	int _ret = 0;						\
+								\
+	preempt_disable();					\
+	_ret = smp_call_function(func, info, retry, wait);	\
+	(func)(info);						\
+	preempt_enable();					\
+	_ret;							\
+})
 
 #define MSG_ALL_BUT_SELF	0x8000	/* Assume <32768 CPU's */
 #define MSG_ALL			0x8001
_

-- 
Yasunori Goto 


