Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932279AbVJaLHs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbVJaLHs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 06:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751069AbVJaLHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 06:07:47 -0500
Received: from mail4.hitachi.co.jp ([133.145.228.5]:58291 "EHLO
	mail4.hitachi.co.jp") by vger.kernel.org with ESMTP
	id S1751054AbVJaLHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 06:07:47 -0500
Message-ID: <4365FB01.2070505@sdl.hitachi.co.jp>
Date: Mon, 31 Oct 2005 20:07:45 +0900
From: Masami Hiramatsu <hiramatu@sdl.hitachi.co.jp>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Satoshi Oshima <soshima@redhat.com>, Hideo Aoki <haoki@redhat.com>,
       Yumiko Sugita <sugita@sdl.hitachi.co.jp>, noboru.obata.ar@hitachi.com,
       systemtap@sources.redhat.com
Subject: [RFC][PATCH 1/3]Djprobe (Direct Jump Probe) for 2.6.14-rc5-mm1
References: <4365FA24.7030207@sdl.hitachi.co.jp>
In-Reply-To: <4365FA24.7030207@sdl.hitachi.co.jp>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch enables get_insn_slot() to handle slots that have
different size.
The djprobe requires this patch to work it on the machines which
support "NX bit".

---
Masami HIRAMATSU
2nd Research Dept.
Hitachi, Ltd., Systems Development Laboratory
E-mail: hiramatu@sdl.hitachi.co.jp

Signed-off-by: Masami Hiramatsu <hiramatu@sdl.hitachi.co.jp>

 include/linux/kprobes.h |    5 ++++
 kernel/kprobes.c        |   58 +++++++++++++++++++++++++++++++-----------------
 2 files changed, 43 insertions(+), 20 deletions(-)
diff -Narup linux-2.6.14-rc5-mm1/include/linux/kprobes.h linux-2.6.14-rc5-mm1.djp.1/include/linux/kprobes.h
--- linux-2.6.14-rc5-mm1/include/linux/kprobes.h	2005-10-25 11:29:02.000000000 +0900
+++ linux-2.6.14-rc5-mm1.djp.1/include/linux/kprobes.h	2005-10-25 13:11:26.000000000 +0900
@@ -147,6 +147,11 @@ struct kretprobe_instance {
 	struct task_struct *task;
 };

+struct kprobe_insn_page_list {
+	struct hlist_head list;
+	int insn_size;		/* size of an instruction slot */
+};
+
 #ifdef CONFIG_KPROBES
 extern spinlock_t kretprobe_lock;
 extern int arch_prepare_kprobe(struct kprobe *p);
diff -Narup linux-2.6.14-rc5-mm1/kernel/kprobes.c linux-2.6.14-rc5-mm1.djp.1/kernel/kprobes.c
--- linux-2.6.14-rc5-mm1/kernel/kprobes.c	2005-10-25 11:29:02.000000000 +0900
+++ linux-2.6.14-rc5-mm1.djp.1/kernel/kprobes.c	2005-10-25 13:13:58.000000000 +0900
@@ -58,44 +58,50 @@ static DEFINE_PER_CPU(struct kprobe *, k
  * stepping on the instruction on a vmalloced/kmalloced/data page
  * is a recipe for disaster
  */
-#define INSNS_PER_PAGE	(PAGE_SIZE/(MAX_INSN_SIZE * sizeof(kprobe_opcode_t)))
+#define INSNS_PER_PAGE(size) (PAGE_SIZE/(size * sizeof(kprobe_opcode_t)))

 struct kprobe_insn_page {
 	struct hlist_node hlist;
 	kprobe_opcode_t *insns;		/* Page of instruction slots */
-	char slot_used[INSNS_PER_PAGE];
 	int nused;
+	char slot_used[1];
 };

-static struct hlist_head kprobe_insn_pages;
+static struct kprobe_insn_page_list kprobe_insn_pages = {
+	HLIST_HEAD_INIT, MAX_INSN_SIZE
+};

 /**
- * get_insn_slot() - Find a slot on an executable page for an instruction.
+ * __get_insn_slot() - Find a slot on an executable page for an instruction.
  * We allocate an executable page if there's no room on existing ones.
  */
-kprobe_opcode_t __kprobes *get_insn_slot(void)
+kprobe_opcode_t
+	__kprobes * __get_insn_slot(struct kprobe_insn_page_list *pages)
 {
 	struct kprobe_insn_page *kip;
 	struct hlist_node *pos;
+	int ninsns = INSNS_PER_PAGE(pages->insn_size);

-	hlist_for_each(pos, &kprobe_insn_pages) {
+	hlist_for_each(pos, &pages->list) {
 		kip = hlist_entry(pos, struct kprobe_insn_page, hlist);
-		if (kip->nused < INSNS_PER_PAGE) {
+		if (kip->nused < ninsns) {
 			int i;
-			for (i = 0; i < INSNS_PER_PAGE; i++) {
+			for (i = 0; i < ninsns; i++) {
 				if (!kip->slot_used[i]) {
 					kip->slot_used[i] = 1;
 					kip->nused++;
-					return kip->insns + (i * MAX_INSN_SIZE);
+					return kip->insns +
+					    (i * pages->insn_size);
 				}
 			}
 			/* Surprise!  No unused slots.  Fix kip->nused. */
-			kip->nused = INSNS_PER_PAGE;
+			kip->nused = ninsns;
 		}
 	}

-	/* All out of space.  Need to allocate a new page. Use slot 0.*/
-	kip = kmalloc(sizeof(struct kprobe_insn_page), GFP_KERNEL);
+	/* All out of space.  Need to allocate a new page. Use slot 0. */
+	kip = kmalloc(sizeof(struct kprobe_insn_page) +
+		    sizeof(char) * (ninsns - 1), GFP_ATOMIC);
 	if (!kip) {
 		return NULL;
 	}
@@ -111,23 +117,25 @@ kprobe_opcode_t __kprobes *get_insn_slot
 		return NULL;
 	}
 	INIT_HLIST_NODE(&kip->hlist);
-	hlist_add_head(&kip->hlist, &kprobe_insn_pages);
-	memset(kip->slot_used, 0, INSNS_PER_PAGE);
+	hlist_add_head(&kip->hlist, &pages->list);
+	memset(kip->slot_used, 0, ninsns);
 	kip->slot_used[0] = 1;
 	kip->nused = 1;
 	return kip->insns;
 }

-void __kprobes free_insn_slot(kprobe_opcode_t *slot)
+void __kprobes __free_insn_slot(struct kprobe_insn_page_list *pages,
+				kprobe_opcode_t * slot)
 {
 	struct kprobe_insn_page *kip;
 	struct hlist_node *pos;
+	int ninsns = INSNS_PER_PAGE(pages->insn_size);

-	hlist_for_each(pos, &kprobe_insn_pages) {
+	hlist_for_each(pos, &pages->list) {
 		kip = hlist_entry(pos, struct kprobe_insn_page, hlist);
 		if (kip->insns <= slot &&
-		    slot < kip->insns + (INSNS_PER_PAGE * MAX_INSN_SIZE)) {
-			int i = (slot - kip->insns) / MAX_INSN_SIZE;
+		    slot < kip->insns + (ninsns * pages->insn_size)) {
+			int i = (slot - kip->insns) / pages->insn_size;
 			kip->slot_used[i] = 0;
 			kip->nused--;
 			if (kip->nused == 0) {
@@ -138,10 +146,10 @@ void __kprobes free_insn_slot(kprobe_opc
 				 * next time somebody inserts a probe.
 				 */
 				hlist_del(&kip->hlist);
-				if (hlist_empty(&kprobe_insn_pages)) {
+				if (hlist_empty(&pages->list)) {
 					INIT_HLIST_NODE(&kip->hlist);
 					hlist_add_head(&kip->hlist,
-						&kprobe_insn_pages);
+						       &pages->list);
 				} else {
 					module_free(NULL, kip->insns);
 					kfree(kip);
@@ -152,6 +160,16 @@ void __kprobes free_insn_slot(kprobe_opc
 	}
 }

+kprobe_opcode_t __kprobes *get_insn_slot(void)
+{
+	return __get_insn_slot(&kprobe_insn_pages);
+}
+
+void __kprobes free_insn_slot(kprobe_opcode_t * slot)
+{
+	__free_insn_slot(&kprobe_insn_pages, slot);
+}
+
 /* We have preemption disabled.. so it is safe to use __ versions */
 static inline void set_kprobe_instance(struct kprobe *kp)
 {

