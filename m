Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317399AbSHKBN5>; Sat, 10 Aug 2002 21:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317400AbSHKBN5>; Sat, 10 Aug 2002 21:13:57 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11539 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317399AbSHKBN4>;
	Sat, 10 Aug 2002 21:13:56 -0400
Message-ID: <3D55BD83.24EE5EDF@zip.com.au>
Date: Sat, 10 Aug 2002 18:27:31 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 6/12] hold atomic kmaps across generic_file_read
References: <3D55B109.CA52DB9C@zip.com.au> <Pine.LNX.4.44.0208101755060.1391-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sat, 10 Aug 2002, Andrew Morton wrote:
> >
> > If not, I don't think it's worth making this change just for
> > the highmem read/write thing (calculating `current' at each
> > spin_lock site...)   I just open coded it.
> 
> Well, this way it will now do the preempt count twice (once in
> kmap_atomic, once in th eopen-coded one) if preempt is enabled.
> 
> I'd suggest just making k[un]map_atomic() always do the
> inc/dec_preempt_count. Other ideas?
> 

Well the optimum solution there would be to create and use
`inc_preempt_count_non_preempt()'.  I don't see any
way of embedding this in kmap_atomic() or copy_to_user_atomic()
without loss of flexibility or incurring a double-inc somewhere.

Please let my post-virginal brain know if you're not otherwise OK
with the approach ;)


 arch/i386/mm/fault.c    |    6 +++---
 include/linux/preempt.h |   24 ++++++++++++++++++++++--
 2 files changed, 25 insertions(+), 5 deletions(-)

--- 2.5.30/arch/i386/mm/fault.c~atomic-copy_user	Sat Aug 10 14:44:03 2002
+++ 2.5.30-akpm/arch/i386/mm/fault.c	Sat Aug 10 14:44:52 2002
@@ -189,10 +189,10 @@ asmlinkage void do_page_fault(struct pt_
 	info.si_code = SEGV_MAPERR;
 
 	/*
-	 * If we're in an interrupt or have no user
-	 * context, we must not take the fault..
+	 * If we're in an interrupt, have no user context or are running in an
+	 * atomic region then we must not take the fault..
 	 */
-	if (in_interrupt() || !mm)
+	if (preempt_count() || !mm)
 		goto no_context;
 
 #ifdef CONFIG_X86_REMOTE_DEBUG
--- 2.5.30/include/linux/preempt.h~atomic-copy_user	Sat Aug 10 16:18:50 2002
+++ 2.5.30-akpm/include/linux/preempt.h	Sat Aug 10 18:23:40 2002
@@ -5,19 +5,29 @@
 
 #define preempt_count() (current_thread_info()->preempt_count)
 
+#define inc_preempt_count() \
+do { \
+	preempt_count()++; \
+} while (0)
+
+#define dec_preempt_count() \
+do { \
+	preempt_count()--; \
+} while (0)
+
 #ifdef CONFIG_PREEMPT
 
 extern void preempt_schedule(void);
 
 #define preempt_disable() \
 do { \
-	preempt_count()++; \
+	inc_preempt_count(); \
 	barrier(); \
 } while (0)
 
 #define preempt_enable_no_resched() \
 do { \
-	preempt_count()--; \
+	dec_preempt_count(); \
 	barrier(); \
 } while (0)
 
@@ -34,6 +44,9 @@ do { \
 		preempt_schedule(); \
 } while (0)
 
+#define inc_preempt_count_non_preempt()	do { } while (0)
+#define dec_preempt_count_non_preempt()	do { } while (0)
+
 #else
 
 #define preempt_disable()		do { } while (0)
@@ -41,6 +54,13 @@ do { \
 #define preempt_enable()		do { } while (0)
 #define preempt_check_resched()		do { } while (0)
 
+/*
+ * Sometimes we want to increment the preempt count, but we know that it's
+ * already incremented if the kernel is compiled for preemptibility.
+ */
+#define inc_preempt_count_non_preempt()	inc_preempt_count()
+#define dec_preempt_count_non_preempt()	dec_preempt_count()
+
 #endif
 
 #endif /* __LINUX_PREEMPT_H */

.
