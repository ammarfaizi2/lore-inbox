Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266308AbUHWSNK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266308AbUHWSNK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 14:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266306AbUHWSNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 14:13:10 -0400
Received: from inetc.connecttech.com ([64.7.140.42]:33543 "EHLO
	inetc.connecttech.com") by vger.kernel.org with ESMTP
	id S266296AbUHWSMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:12:41 -0400
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: "LKML" <linux-kernel@vger.kernel.org>
Subject: Is it possible to wait on multiple wait_queues?
Date: Mon, 23 Aug 2004 14:12:39 -0400
Organization: Connect Tech Inc.
Message-ID: <000e01c4893c$c69c6d80$294b82ce@stuartm>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there anything wrong with the code below (which has been modified
from the __wait_event_interruptible macro)? Assuming of course that
(condition) checks for both conditions.

..Stu

#define __wait_event2_interruptible(wq1, wq2, condition, ret)		\
do {									\
	wait_queue_t __wait1, __wait2;					\
	init_waitqueue_entry(&__wait1, current);			\
	init_waitqueue_entry(&__wait2, current);			\
									\
	add_wait_queue(&wq1, &__wait1);					\
	add_wait_queue(&wq2, &__wait2);					\
	for (;;) {							\
		set_current_state(TASK_INTERRUPTIBLE);			\
		if (condition)						\
			break;						\
		if (!signal_pending(current)) {				\
			schedule();					\
			continue;					\
		}							\
		ret = -ERESTARTSYS;					\
		break;							\
	}								\
	current->state = TASK_RUNNING;					\
	remove_wait_queue(&wq1, &__wait1);				\
	remove_wait_queue(&wq2, &__wait2);				\
} while (0)

