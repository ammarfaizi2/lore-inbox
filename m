Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265755AbUEZSFs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265755AbUEZSFs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 14:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265757AbUEZSFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 14:05:47 -0400
Received: from bay99-f40.bay99.hotmail.com ([65.54.175.40]:49417 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S265755AbUEZSFa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 14:05:30 -0400
X-Originating-IP: [136.162.76.26]
X-Originating-Email: [ps41@hotmail.com]
From: "Parag Sharma" <ps41@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Question on the condition parameter in wait_event_interruptible()
Date: Wed, 26 May 2004 10:05:32 -0800
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY99-F40XF2hzgOJ8P0001d374@hotmail.com>
X-OriginalArrivalTime: 26 May 2004 18:05:32.0612 (UTC) FILETIME=[09516040:01C4434C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I looked at the kernel 2.4.21 sources and found that the 'condition' in 
calls to wait_event_interruptible() is usually a global variable. This 
global variable is updated before the wakeup is issued.
It is not clear to me how this update to the global variable is seen by the 
context that issued the wait_event_interruptible(). On certain processor 
architectures and on SMP systems, is it possible that the update is not 
reflected when the condition is tested in __wait_event_interruptible()?

If the answer to above is yes, then is it possible that there is a chance 
that a wakeup might be missed when the update & wakeup occur either before 
the call to add_wait_queue() or the call to 
set_current_state(TASK_INTERRUPTIBLE) in __wait_event_interruptible()?

Thanks,
Parag
PS: Please cc me on the reply.

#define __wait_event_interruptible(wq, condition, ret)                  \
do {                                                                    \
        wait_queue_t __wait;                                            \
        init_waitqueue_entry(&__wait, current);                         \
                                                                        \
        add_wait_queue(&wq, &__wait);                                   \
        for (;;) {                                                      \
                set_current_state(TASK_INTERRUPTIBLE);                  \
                if (condition)                                          \
                        break;                                          \
                if (!signal_pending(current)) {                         \
                        schedule();                                     \
                        continue;                                       \
                }                                                       \
                ret = -ERESTARTSYS;                                     \
                break;                                                  \
        }                                                               \
        current->state = TASK_RUNNING;                                  \
        remove_wait_queue(&wq, &__wait);                                \
} while (0)

_________________________________________________________________
Watch LIVE baseball games on your computer with MLB.TV, included with MSN 
Premium! http://join.msn.click-url.com/go/onm00200439ave/direct/01/

