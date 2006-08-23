Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751430AbWHWGzO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430AbWHWGzO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 02:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbWHWGzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 02:55:14 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:64227 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1751430AbWHWGzL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 02:55:11 -0400
Date: Wed, 23 Aug 2006 10:54:22 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Nicholas Miell <nmiell@comcast.net>, David Miller <davem@davemloft.net>,
       jmorris@namei.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       netdev@vger.kernel.org, zach.brown@oracle.com, hch@infradead.org
Subject: Re: [take12 0/3] kevent: Generic event handling mechanism.
Message-ID: <20060823065422.GB24787@2ka.mipt.ru>
References: <1156276823.2476.22.camel@entropy> <20060822.133606.48392664.davem@davemloft.net> <1156281220.2476.65.camel@entropy> <20060822.142500.11271092.davem@davemloft.net> <1156287511.2476.137.camel@entropy> <44EB974B.3030200@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44EB974B.3030200@redhat.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 23 Aug 2006 10:54:27 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Aug 22, 2006 at 04:46:19PM -0700, Ulrich Drepper (drepper@redhat.com) wrote:
> DaveM says there are example programs for the current interfaces.  I
> must admit I haven't seen those either.  So if possible, point the world
> to them again.  If you do that now I'll review everything and write up
> my recommendations re the interface before Monday.

Attached typical usage for inode and timer events.
Network AIO was implemented as separated syscalls.

> -- 
> ➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
> 



-- 
	Evgeniy Polyakov

--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=koi8-r
Content-Disposition: attachment; filename="evtest.c"

#include <sys/types.h>
#include <sys/stat.h>
#include <sys/ioctl.h>
#include <sys/time.h>

#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>
#include <unistd.h>

#include <linux/unistd.h>
#include <linux/types.h>
#include <linux/ukevent.h>

#define _syscall4(type,name,type1,arg1,type2,arg2,type3,arg3,type4,arg4) \
type name (type1 arg1, type2 arg2, type3 arg3, type4 arg4) \
{\
	return syscall(__NR_##name, arg1, arg2, arg3, arg4);\
}

#define _syscall5(type,name,type1,arg1,type2,arg2,type3,arg3,type4,arg4, \
	  type5,arg5) \
type name (type1 arg1,type2 arg2,type3 arg3,type4 arg4,type5 arg5) \
{\
	return syscall(__NR_##name, arg1, arg2, arg3, arg4, arg5);\
}

#define _syscall6(type,name,type1,arg1,type2,arg2,type3,arg3,type4,arg4, \
	  type5,arg5,type6,arg6) \
type name (type1 arg1,type2 arg2,type3 arg3,type4 arg4,type5 arg5, type6 arg6) \
{\
	return syscall(__NR_##name, arg1, arg2, arg3, arg4, arg5, arg6);\
}

_syscall4(int, kevent_ctl, int, arg1, unsigned int, argv2, unsigned int, argv3, void *, argv4);
_syscall6(int, kevent_get_events, int, arg1, unsigned int, argv2, unsigned int, argv3, unsigned int, argv4, void *, argv5, unsigned, arg6);

#define ulog(f, a...) fprintf(stderr, f, ##a)
#define ulog_err(f, a...) ulog(f ": %s [%d].\n", ##a, strerror(errno), errno)

static void usage(char *p)
{
	ulog("Usage: %s -t type -e event -o oneshot -p path -n wait_num -h\n", p);
}

static int get_id(int type, char *path)
{
	int ret = -1;

	switch (type) {
		case KEVENT_TIMER:
			ret = 3000;
			break;
		case KEVENT_INODE:
			ret = open(path, O_RDONLY);
			break;
	}

	return ret;
}

int main(int argc, char *argv[])
{
	int ch, fd, err, type, event, oneshot, i, num, wait_num;
	char *path;
	char buf[4096];
	struct ukevent *uk;
	struct timeval tm1, tm2;

	path = NULL;
	type = event = -1;
	oneshot = 0;
	wait_num = 10;

	while ((ch = getopt(argc, argv, "p:t:e:o:n:h")) > 0) {
		switch (ch) {
			case 'n':
				wait_num = atoi(optarg);
				break;
			case 'p':
				path = optarg;
				break;
			case 't':
				type = atoi(optarg);
				break;
			case 'e':
				event = atoi(optarg);
				break;
			case 'o':
				oneshot = atoi(optarg);
				break;
			default:
				usage(argv[0]);
				return -1;
		}
	}

	if (event == -1 || type == -1 || (type == KEVENT_INODE && !path)) {
		ulog("You need at least -t -e parameters and -p for inode notifications.\n");
		usage(argv[0]);
		return -1;
	}
	
	fd = kevent_ctl(0, KEVENT_CTL_INIT, 1, NULL);
	if (fd == -1) {
		ulog_err("Failed create kevent control block");
		return -1;
	}

	memset(buf, 0, sizeof(buf));
	
	gettimeofday(&tm1, NULL);

	num = 1;
	for (i=0; i<num; ++i) {
		uk = (struct ukevent *)buf;
		uk->event = event;
		uk->type = type;
		if (oneshot)
			uk->req_flags |= KEVENT_REQ_ONESHOT;
		uk->user[0] = i;
		uk->id.raw[0] = get_id(uk->type, path);

		err = kevent_ctl(fd, KEVENT_CTL_ADD, 1, uk);
		if (err < 0) {
			ulog_err("Failed to perform control operation: type=%d, event=%d, oneshot=%d", type, event, oneshot);
			close(fd);
			return err;
		}
		ulog("%s: err: %d.\n", __func__, err);
		if (err) {
			ulog("%d: ret_flags: 0x%x, ret_data: %u %d.\n", i, uk->ret_flags, uk->ret_data[0], (int)uk->ret_data[1]);
		}
	}
	
	gettimeofday(&tm2, NULL);

	ulog("%08ld.%08ld: Load: diff=%ld usecs.\n", 
			tm2.tv_sec, tm2.tv_usec, ((tm2.tv_sec - tm1.tv_sec)*1000000 + (tm2.tv_usec - tm1.tv_usec))/num);

	while (1) {
		gettimeofday(&tm1, NULL);
		
		err = kevent_get_events(fd, 1, wait_num, 3000, buf, 0);
		if (err < 0) {
			ulog_err("Failed to perform control operation: type=%d, event=%d, oneshot=%d", type, event, oneshot);
			close(fd);
			return err;
		}
		
		gettimeofday(&tm2, NULL);

		ulog("%08ld.%08ld: Wait: num=%d, diff=%ld usec.\n", 
				tm2.tv_sec, tm2.tv_usec,
				err,
				((tm2.tv_sec - tm1.tv_sec)*1000000 + (tm2.tv_usec - tm1.tv_usec))/(err?err:1));
		uk = (struct ukevent *)buf;
		for (i=0; i<(signed)err; ++i) {
			ulog("%08x: %08x.%08x - %08x.%08x\n", 
					uk[i].user[0],
					uk[i].id.raw[0], uk[i].id.raw[1],
					uk[i].ret_data[0], uk[i].ret_data[1]);
		}
	}

	close(fd);
	return 0;
}

--r5Pyd7+fXNt84Ff3--
