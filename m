Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751055AbWEPCM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbWEPCM5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 22:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751056AbWEPCM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 22:12:57 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:18594 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751054AbWEPCM4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 22:12:56 -0400
Subject: [-rt potential bug?] Bad error path in futex_wake
From: john stultz <johnstul@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
       lkml <linux-kernel@vger.kernel.org>,
       Dinakar Guniguntala <dino@in.ibm.com>
Content-Type: text/plain
Date: Mon, 15 May 2006 19:12:30 -0700
Message-Id: <1147745550.10707.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Ingo,
	I've been trying to help Dinakar chase down a futex bug where
lookup_pi_state oopses due to this->pi_state being NULL
(kernel/futex.c:480).

No clue on why yet, but looking over the code, I noticed the following
odd error path:

static int futex_wake(u32 __user *uaddr, int nr_wake)
{
        [snip]
	down_read(&current->mm->mmap_sem);

	ret = get_futex_key(uaddr, &key);
	if (unlikely(ret != 0))
		goto out;

	hb = hash_futex(&key);
	spin_lock(&hb->lock);
	head = &hb->chain;

	list_for_each_entry_safe(this, next, head, list) {
		if (match_futex (&this->key, &key)) {
			if (this->pi_state)
!!!!------>			return -EINVAL;
			wake_futex(this);
			if (++ret >= nr_wake)
				break;
		}
	}

	spin_unlock(&hb->lock);
out:
	up_read(&current->mm->mmap_sem);
	return ret;
}

I'm not very familiar w/ the futex code, so this might be the right
thing, but it sure looks wrong.

Thoughts?

thanks
-john

