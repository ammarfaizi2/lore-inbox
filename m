Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751124AbVHKRHH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbVHKRHH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 13:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbVHKRHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 13:07:07 -0400
Received: from expredir6.cites.uiuc.edu ([128.174.5.97]:28636 "EHLO
	expredir6.cites.uiuc.edu") by vger.kernel.org with ESMTP
	id S1751124AbVHKRHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 13:07:06 -0400
Message-ID: <42FB8522.7080605@uiuc.edu>
Date: Thu, 11 Aug 2005 12:04:34 -0500
From: "John M. King" <jmking1@uiuc.edu>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Possible race in sound/oss/forte.c ?
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I know the OSS drivers are deprecated, but I'm trying to figure this out
for my own understanding.

Here's code from sound/oss/forte.c, in the write system call handler.  A
test has already been performed (under the protection of the lock) and
the driver has decided to sleep.

    add_wait_queue (&channel->wait, &wait);

    for (;;) {
        spin_unlock_irqrestore (&chip->lock, flags);

        set_current_state (TASK_INTERRUPTIBLE);
        schedule();

        spin_lock_irqsave (&chip->lock, flags);

        if (channel->frag_num - channel->filled_frags)
            break;
    }

    remove_wait_queue (&channel->wait, &wait);
    set_current_state (TASK_RUNNING);

The driver's interrupt handler calls wake_up_all().  What if an
interrupt occurs just after the spin_unlock_irqrestore() but before
setting TASK_INTERRUPTIBLE (and the interrupt handler does stuff that
causes the tested conditional to be true as well)?  The interrupt calls
wake_up_all(), but then when control returns here, the process will mark
itself TASK_INTERRUPTIBLE right away and sleep, effectively missing the
wake_up_all().

Is this a race condition?  If not, can someone point out the error(s) in
my reasoning?  Please CC me as I'm not subscribed to the list.

Thanks,
John
