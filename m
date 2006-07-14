Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161196AbWGNDBQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161196AbWGNDBQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 23:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161211AbWGNDBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 23:01:15 -0400
Received: from [202.99.27.194] ([202.99.27.194]:5778 "EHLO mail1.topsec.com.cn")
	by vger.kernel.org with ESMTP id S1161196AbWGNDBP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 23:01:15 -0400
Message-ID: <002001c6a6f1$74ff85f0$0100000a@codingman>
From: <wyb@topsec.com.cn>
To: <linux-kernel@vger.kernel.org>
Subject: SMP share data declaration
Date: Fri, 14 Jul 2006 10:58:57 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1807
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1807
X-Junkmail-Whitelist: YES (by domain whitelist at mail1.topsec.com.cn)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I know that an integer variable should be declared volatile to share between
CPUs.
But for more complicated variable, I don't know if it should be volatile.
for example:

linux-2.6.6/kernel/workqueue.c:
struct workqueue_struct *__create_workqueue(const char *name,int
singlethread)
{
    ...
    if (singlethread) {
        ...
    } else {
        spin_lock(&workqueue_lock);
        list_add(&wq->list, &workqueues);
        spin_unlock_irq(&workqueue_lock);
        ...
    }
    ...
}

workqueues is a none volatile list_head. The spin_lock/unlock act as memory
barrier, so gcc flush any register cached value to memory. But if another
CPU allocate workqueues.next/prev in registers, how to make sure this cpu
get new value ?

static int __devinit workqueue_cpu_callback(struct notifier_block *nfb,
      unsigned long action,
      void *hcpu)
{
    ...
    switch (action) {
    case CPU_UP_PREPARE:
    /* Create a new workqueue thread for it. */
    list_for_each_entry(wq, &workqueues, list) {
        ...
}

how to make sure workqueue_cpu_callback() get new value ?

thanks very much


