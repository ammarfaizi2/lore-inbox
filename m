Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261934AbSKTW0y>; Wed, 20 Nov 2002 17:26:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261950AbSKTW0y>; Wed, 20 Nov 2002 17:26:54 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:17796 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S261934AbSKTW0w>; Wed, 20 Nov 2002 17:26:52 -0500
X-AuthUser: davidel@xmailserver.org
Date: Wed, 20 Nov 2002 14:34:34 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Andrew Morton <akpm@digeo.com>
Subject: [rfc] new poll callback'd wake up hell ...
Message-ID: <Pine.LNX.4.44.0211201354210.1989-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


With the new wake_up() mechanism and wait queue that supports callbacks, a
wake_up() function call might end up calling another function. This
function might be the poll callback that someone else installed on the
first device. The callback invocation will make the one that installed the
callback on the first device to think that events are avalable, and it'll
very likely go ahead and wake_up() its own poll wait queue. See the
problem ? We can cycle through and we can either have a deadlock or a
stack blow up. An easy like ineffective solution would be to avoid the
insertion inside an epoll fd on other epoll fds. But this won't prevent
that another device that will use a similar technique will born tomorrow.
This is waht I was thinking to solve those problems :

1) Move the wake_up() call done inside the poll callback outside the lock

void poll_cb(xxx *data)
{
	int pwake = 0;

	lock(data);
	...
	if (wait_queue_active(&data->poll_wait))
		pwake++;
	unlock(data)
	if (pwake)
		ep_poll_safe_wakeup(&data->psw, &data->poll_wait)
}



2) Use this infrastructure to perform safe poll wakeups

/*
 * This is used to implement the safe poll wake up avoiding to reenter
 * the poll callback from inside wake_up().
 */
struct poll_safewake {
        int wakedoor;	/* Init = 1, can do wake up */
        atomic_t count;	/* Init = 0, wake up count */
};

/* Perform a safe wake up of the poll wait list */
static void ep_poll_safe_wakeup(struct poll_safewake *psw, wait_queue_head_t *wq)
{
        atomic_inc(&psw->count);
        do {
                if (!xchg(&psw->wakedoor, 0))
                        break;
                wake_up(wq);
                xchg(&psw->wakedoor, 1);
        } while (!atomic_dec_and_test(&psw->count));
}



Does anyone foresee problem in this implementation ?
Another ( crappy ) solution might be to avoid the epoll fd to drop inside
its poll wait queue head, wait queues that has the function pointer != NULL




- Davide



