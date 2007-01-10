Return-Path: <linux-kernel-owner+w=401wt.eu-S932789AbXAJMVN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932789AbXAJMVN (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 07:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932792AbXAJMVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 07:21:13 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:36136 "EHLO 2ka.mipt.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932790AbXAJMVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 07:21:11 -0500
Date: Wed, 10 Jan 2007 15:18:06 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Jeff Garzik <jeff@garzik.org>
Cc: David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jamal Hadi Salim <hadi@cyberus.ca>, Ingo Molnar <mingo@elte.hu>,
       linux-fsdevel@vger.kernel.org
Subject: Kevent bonus: epoll implementaion over kevent.
Message-ID: <20070110121806.GB28862@2ka.mipt.ru>
References: <11684170003907@2ka.mipt.ru> <45A4C9DE.8020605@garzik.org> <20070110113051.GA4950@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20070110113051.GA4950@2ka.mipt.ru>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 10 Jan 2007 15:18:08 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As a usage scenario, compile-tested only.
Replace fs/eventpoll.c with this code and see,
how your kernel crashes. Or works.

:)

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>

#include <linux/kernel.h>
#include <linux/types.h>
#include <linux/list.h>
#include <linux/spinlock.h>
#include <linux/kevent.h>
#include <linux/ukevent.h>
#include <linux/syscalls.h>
#include <asm/poll.h>
#include <asm/uaccess.h>
#include <linux/eventpoll.h>

asmlinkage long sys_epoll_create(int size)
{
	return sys_kevent_init(NULL, 0, 0);
}

#define EP_PRIVATE_BITS (EPOLLONESHOT | EPOLLET)

asmlinkage long sys_epoll_ctl(int epfd, int op, int fd, struct epoll_event __user *event)
{
	struct epoll_event epds;
	struct ukevent uk;
	int cmd, err;

	switch (op) {
		case EPOLL_CTL_DEL:
			cmd = KEVENT_CTL_REMOVE;
			break;
		case EPOLL_CTL_ADD:
			cmd = KEVENT_CTL_ADD;
			break;
		case EPOLL_CTL_MOD:
			cmd = KEVENT_CTL_MODIFY;
			break;
		default:
			err = -EINVAL;
			goto err_out_exit;
	}

	if (copy_from_user(&epds, event, sizeof(struct epoll_event))) {
		err = -EFAULT;
		goto err_out_exit;
	}

	memset(&uk, 0, sizeof(struct ukevent));

	uk.id.raw[0] = fd;
	memcpy(uk.user, &epds.data, sizeof(u64));
	uk.type = KEVENT_POLL;
	uk.event = (epds.events & ~EP_PRIVATE_BITS)| POLLERR | POLLHUP;
	uk.req_flags = KEVENT_REQ_ALWAYS_QUEUE | KEVENT_REQ_LAST_CHECK;
	if (epds.events & EPOLLONESHOT)
		uk.req_flags |= KEVENT_REQ_ONESHOT;
	if (epds.events & EPOLLET)
		uk.req_flags |= KEVENT_REQ_ET;

	return sys_kevent_ctl(epfd, cmd, 1, &uk);

err_out_exit:
	return err;
}

asmlinkage long sys_epoll_wait(int epfd, struct epoll_event __user *events,
			       int maxevents, int timeout)
{
	struct ukevent uk[3];
	struct timespec ts;
	long num, i;
	int err;
	
	if (!access_ok(VERIFY_WRITE, events, maxevents * sizeof(struct epoll_event))) {
		err = -EFAULT;
		goto err_out_exit;
	}

	memset(uk, 0, sizeof(uk));

	ts.tv_sec = timeout/1000;
	ts.tv_nsec = (timeout - ts.tv_sec*1000)*1000;

	num = sys_kevent_get_events(epfd, 1, min(3, maxevents), ts, uk, 0);
	if (num <= 0)
		return num;

	for (i=0; i<num; ++i) {
		__u64 data;

		memcpy(&data, &uk[i].user, sizeof(u64));

		if (__put_user(uk[i].ret_data[0], &events[i].events) ||
		    __put_user(data, &events[i].data))
			return -EFAULT;
	}

	return num;

err_out_exit:
	return err;
}


-- 
	Evgeniy Polyakov
