Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161098AbVIPHQG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161098AbVIPHQG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 03:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161099AbVIPHQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 03:16:05 -0400
Received: from zproxy.gmail.com ([64.233.162.203]:26209 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161098AbVIPHQD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 03:16:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:mime-version:content-type:content-transfer-encoding:x-mailer:thread-index:x-mimeole:message-id;
        b=BSFlv8ypQqJEhteW93EYHPrNExSYjr2FT7ovUsysoUFERWI/ZZm/3QNkdcHD5jyEdMpZ13FFTuKSHEthdJw9+GwXR1bJPWaokphwyyD/5CVnNLvAEDnpNBh35BBBpV0nfVf5h/DRtDfNnmyDKqny0egjPa9AJkbR/VQ9wfr1BMw=
From: "Roy Lee" <roylee17@gmail.com>
To: <linux-kernel@vger.kernel.org>
Subject: A question about sceduling
Date: Fri, 16 Sep 2005 15:15:58 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcW6jnwhyMZJKdWfQCS4VlScZPAYRQ==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Message-ID: <432a7132.75a05f0c.10f5.ffffb719@mx.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm tracing the scheduling code of 2.6.12.
During the process creation, the parent process would let the child process
execute first to avoid the COW overhead.

In wake_up_new_task():

                   if (!(clone_flags & CLONE_VM)) {
            /*
             * The VM isn't cloned, so we're in a good position to
             * do child-runs-first in anticipation of an exec. This
             * usually avoids a lot of COW overhead.
             */
            if (unlikely(!current->array))
                __activate_task(p, rq);
            else {
                p->prio = current->prio;
                list_add_tail(&p->run_list, &current->run_list);
                p->array = current->array;
                p->array->nr_active++;
                rq->nr_running++;
            }
            set_need_resched(); 

It sets the flag to notify the kernel to reschedule.
But, the child has the same priority as it's parent and is the at the "tail"
of that priority queue.
What makes the scheduler choose the child to run before the parent?
I couldn't' find the point where the parent goes to sleep voluntarily, or
when did the scheduler put the parent behind the child.

Many Thanks
--
Roy

