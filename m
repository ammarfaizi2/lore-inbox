Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263645AbUECMRh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263645AbUECMRh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 08:17:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263646AbUECMRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 08:17:37 -0400
Received: from niit.caravan.ru ([217.23.131.158]:24592 "EHLO mail.tv-sign.ru")
	by vger.kernel.org with ESMTP id S263645AbUECMRf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 08:17:35 -0400
Message-ID: <409638A8.D7A7062E@tv-sign.ru>
Date: Mon, 03 May 2004 16:18:48 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [0.5/2] scheduler caller profiling
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

William Lee Irwin III wrote:
> This patch creates a new scheduling entrypoint, wake_up_filtered(), and
> uses it in page waitqueue hashing to discriminate between the waiters
> on various pages. One of the sources of the thundering herds was
> identified as the page waitqueue hashing by a priori methods and
> empirically confirmed using the scheduler caller profiling patch.

How about this (untested, of course) idea:

struct wait_bit_queue {
	unsigned long *flags;
	int bit_nr;
	wait_queue_t wait;
};

#define DEFINE_WAIT_BIT(name, flags, bit_nr)					\
	struct wait_bit_queue name = {						\
		.flags	= flags,						\
		.bit_nr	= bit_nr,						\
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

	if (test_bit(wait_bit->bit_nr, &wait_bit->flags))
		return 0;

	return autoremove_wake_function(wait, mode, sync);
}

This way only waiters must be modified:

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

Oleg.
