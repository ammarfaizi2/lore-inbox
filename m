Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264545AbUEEL1g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264545AbUEEL1g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 07:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264560AbUEEL1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 07:27:36 -0400
Received: from niit.caravan.ru ([217.23.131.158]:48388 "EHLO mail.tv-sign.ru")
	by vger.kernel.org with ESMTP id S264545AbUEEL1Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 07:27:25 -0400
Message-ID: <4098CFEB.468E6326@tv-sign.ru>
Date: Wed, 05 May 2004 15:28:43 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, William Lee Irwin III <wli@holomorphy.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.6-rc3-mm2
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Andrew Morton wrote:
> +filtered-wakeups-core.patch

i beleive, there is better alternative, patch at the end.

> +void fastcall wake_up_filtered(wait_queue_head_t *q, void *key)
> +{
> +	struct filtered_wait_queue *wait, *save;
> +
> +	list_for_each_entry_safe(wait, save, &q->task_list, wait.task_list) {
> +		if (wait->key == key)
> +			wait->wait.func(&wait->wait, mode, 0);
> +	}
> +}

this way we cannot mix filtered/nonfiltered waiters on one
wait_queue_head_t, and we have to modify both waiters and wakers.

i think we can shift this check in wait_queue_t.func:

struct wait_bit_queue {
	unsigned long *flags;
	int bit_nr;
	wait_queue_t wait;
};

#define DEFINE_WAIT_BIT(name, _flags, _bit_nr)					\
	struct wait_bit_queue name = {						\
		.flags	= _flags,						\
		.bit_nr	= _bit_nr,						\
		.wait	= {							\
			.task = current,					\
			.func = wake_bit_function,				\
			.task_list = LIST_HEAD_INIT(name.wait.task_list),	\
		},								\
	}

int wake_bit_function(wait_queue_t *wait, unsigned mode, int sync)
{
	struct wait_bit_queue *wait_bit =
		container_of(wait, struct wait_bit_queue, wait);

	if (test_bit(wait_bit->bit_nr, wait_bit->flags))
		return 0;

	return autoremove_wake_function(wait, mode, sync);
}

This way only waiters must be modified, and we can use
page_waitqueue(page) for nonfiltered wait too.

void fastcall wait_on_page_bit(struct page *page, int bit_nr)
{
	wait_queue_head_t *waitqueue = page_waitqueue(page);
	DEFINE_WAIT_BIT(wait, &page->flags, bit_nr);

	prepare_to_wait(waitqueue, &wait.wait, TASK_UNINTERRUPTIBLE);

	if (test_bit(bit_nr, &page->flags)) {
		sync_page(page);
		io_schedule();
	}

	finish_wait(waitqueue, &wait.wait);
}

__wait_on_buffer() can use DEFINE_WAIT_BIT(wait, &bh->b_state, BH_Lock)

> --- 25/fs/jbd/transaction.c~filtered-buffer_head-wakeups-tweaks	2004-05-04 23:58:14.719170368 -0700
> +++ 25-akpm/fs/jbd/transaction.c	2004-05-04 23:58:24.840631672 -0700
> -			wqh = bh_waitq_head(jh2bh(jh));
> -			wait_event_filtered(*wqh, jh2bh(jh), (jh->b_jlist != BJ_Shadow));
> +			wqh = bh_waitq_head(bh);
> +			wait_event_filtered(*wqh, bh, jh->b_jlist != BJ_Shadow);

becomes unneeded.

i tested this idea on i386, what do you think about it?

Oleg.

diff -urp 6.5-clean/include/linux/wait.h 6.5-waitb/include/linux/wait.h
--- 6.5-clean/include/linux/wait.h	2004-03-11 05:55:28.000000000 +0300
+++ 6.5-waitb/include/linux/wait.h	2004-05-05 14:13:23.000000000 +0400
@@ -258,6 +258,26 @@ int autoremove_wake_function(wait_queue_
 		INIT_LIST_HEAD(&wait->task_list);			\
 	} while (0)
 	
+
+struct wait_bit_queue {
+	unsigned long *flags;
+	int bit_nr;
+	wait_queue_t wait;
+};
+
+#define DEFINE_WAIT_BIT(name, _flags, _bit_nr)					\
+	struct wait_bit_queue name = {						\
+		.flags	= _flags,						\
+		.bit_nr	= _bit_nr,						\
+		.wait	= {							\
+			.task = current,					\
+			.func = wake_bit_function,				\
+			.task_list = LIST_HEAD_INIT(name.wait.task_list),	\
+		},								\
+	}
+
+int wake_bit_function(wait_queue_t *wait, unsigned mode, int sync);
+
 #endif /* __KERNEL__ */
 
 #endif
diff -urp 6.5-clean/kernel/fork.c 6.5-waitb/kernel/fork.c
--- 6.5-clean/kernel/fork.c	2004-03-11 05:55:22.000000000 +0300
+++ 6.5-waitb/kernel/fork.c	2004-05-05 13:53:32.000000000 +0400
@@ -206,6 +206,18 @@ int autoremove_wake_function(wait_queue_
 
 EXPORT_SYMBOL(autoremove_wake_function);
 
+int wake_bit_function(wait_queue_t *wait, unsigned mode, int sync)
+{
+	struct wait_bit_queue *wait_bit =
+		container_of(wait, struct wait_bit_queue, wait);
+
+	if (test_bit(wait_bit->bit_nr, wait_bit->flags))
+		return 0;
+
+	return autoremove_wake_function(wait, mode, sync);
+}
+
+
 void __init fork_init(unsigned long mempages)
 {
 #ifndef __HAVE_ARCH_TASK_STRUCT_ALLOCATOR
diff -urp 6.5-clean/mm/filemap.c 6.5-waitb/mm/filemap.c
--- 6.5-clean/mm/filemap.c	2004-04-11 13:35:37.000000000 +0400
+++ 6.5-waitb/mm/filemap.c	2004-05-05 14:38:22.000000000 +0400
@@ -297,16 +297,16 @@ static wait_queue_head_t *page_waitqueue
 void fastcall wait_on_page_bit(struct page *page, int bit_nr)
 {
 	wait_queue_head_t *waitqueue = page_waitqueue(page);
-	DEFINE_WAIT(wait);
+	DEFINE_WAIT_BIT(wait, &page->flags, bit_nr);
 
-	do {
-		prepare_to_wait(waitqueue, &wait, TASK_UNINTERRUPTIBLE);
-		if (test_bit(bit_nr, &page->flags)) {
-			sync_page(page);
-			io_schedule();
-		}
-	} while (test_bit(bit_nr, &page->flags));
-	finish_wait(waitqueue, &wait);
+	prepare_to_wait(waitqueue, &wait.wait, TASK_UNINTERRUPTIBLE);
+
+	if (test_bit(bit_nr, &page->flags)) {
+		sync_page(page);
+		io_schedule();
+	}
+
+	finish_wait(waitqueue, &wait.wait);
 }
 
 EXPORT_SYMBOL(wait_on_page_bit);
@@ -369,17 +369,8 @@ EXPORT_SYMBOL(end_page_writeback);
  */
 void fastcall __lock_page(struct page *page)
 {
-	wait_queue_head_t *wqh = page_waitqueue(page);
-	DEFINE_WAIT(wait);
-
-	while (TestSetPageLocked(page)) {
-		prepare_to_wait(wqh, &wait, TASK_UNINTERRUPTIBLE);
-		if (PageLocked(page)) {
-			sync_page(page);
-			io_schedule();
-		}
-	}
-	finish_wait(wqh, &wait);
+	while (TestSetPageLocked(page))
+		wait_on_page_bit(page, PG_locked);
 }
 
 EXPORT_SYMBOL(__lock_page);
