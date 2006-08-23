Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932240AbWHWNrV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbWHWNrV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 09:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932226AbWHWNrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 09:47:21 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:35265 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S932218AbWHWNrU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 09:47:20 -0400
Date: Wed, 23 Aug 2006 17:44:36 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [take13 1/3] kevent: Core files.
Message-ID: <20060823134435.GD29056@2ka.mipt.ru>
References: <11563322971212@2ka.mipt.ru> <200608231451.07499.dada1@cosmosbay.com> <20060823132753.GB29056@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
In-Reply-To: <20060823132753.GB29056@2ka.mipt.ru>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 23 Aug 2006 17:44:37 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline

On Wed, Aug 23, 2006 at 05:27:53PM +0400, Evgeniy Polyakov (johnpol@2ka.mipt.ru) wrote:
> One can find it in archive on homepage
> http://tservice.net.ru/~s0mbre/old/?section=projects&item=kevent 
> or attached.

Now it is really attached.

-- 
	Evgeniy Polyakov

--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=koi8-r
Content-Disposition: attachment; filename="evtest.c"

#include <sys/types.h>
#include <sys/stat.h>
#include <sys/ioctl.h>
#include <sys/time.h>
#include <sys/mman.h>

#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>
#include <unistd.h>

#include <linux/unistd.h>
#include <linux/types.h>

#define PAGE_SIZE	4096
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
_syscall6(int, kevent_get_events, int, arg1, unsigned int, argv2, unsigned int, argv3, __u64, argv4, void *, argv5, unsigned, arg6);

#define ulog(f, a...) fprintf(stderr, f, ##a)
#define ulog_err(f, a...) ulog(f ": %s [%d].\n", ##a, strerror(errno), errno)

static void usage(char *p)
{
	ulog("Usage: %s -t type -e event -o oneshot -p path -n wait_num -f kevent_file -h\n", p);
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

static void *evtest_mmap(int fd, off_t *offset, unsigned int number)
{
	void *start, *ptr;
	off_t o = *offset;

	start = NULL;

	ptr = mmap(start, PAGE_SIZE*number, PROT_READ, MAP_SHARED, fd, o*PAGE_SIZE);
	if (ptr == MAP_FAILED) {
		ulog_err("Failed to mmap: start: %p, number: %u, offset: %lu", start, number, o);
		return NULL;
	}

	printf("mmap: ptr: %p, start: %p, number: %u, offset: %lu.\n", ptr, start, number, o);
	*offset =  o + number;
	return ptr;
}

int main(int argc, char *argv[])
{
	int ch, fd, err, type, event, oneshot, wait_num, number;
	unsigned int i, num, old_idx;
	char *path, *file;
	char buf[4096];
	struct ukevent *uk;
	struct kevent_mring *ring;
	off_t offset;

	path = NULL;
	type = event = -1;
	oneshot = 0;
	wait_num = 10;
	offset = 0;
	number = 1;
	old_idx = 0;
	file = "/dev/kevent";

	while ((ch = getopt(argc, argv, "f:p:t:e:o:n:h")) > 0) {
		switch (ch) {
			case 'f':
				file = optarg;
				break;
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
	
	fd = open(file, O_RDWR);
	if (fd == -1) {
		ulog_err("Failed create kevent control block using file %s", file);
		return -1;
	}

	ring = evtest_mmap(fd, &offset, number);
	if (!ring)
		return -1;

	memset(buf, 0, sizeof(buf));
	
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
		if (err) {
			ulog("%d: ret_flags: 0x%x, ret_data: %u %d.\n", i, uk->ret_flags, uk->ret_data[0], (int)uk->ret_data[1]);
		}
	}
	
	while (1) {
		err = kevent_get_events(fd, 1, wait_num, 10000000000, buf, 0);
		if (err < 0) {
			ulog_err("Failed to perform control operation: type=%d, event=%d, oneshot=%d", type, event, oneshot);
			close(fd);
			return err;
		}

		num = ring->index;
		if (num != old_idx) {
			ulog("mmap: idx: %u, returned: %d.\n", num, err);
			while (old_idx != num) {
				if (old_idx < KEVENTS_ON_PAGE) {
					struct mukevent *m = &ring->event[old_idx];
					ulog("%08x: %08x.%08x - %08x\n", 
						i, m->id.raw[0], m->id.raw[1], m->ret_flags);
				} else {
					/*
					 * Mmap next page.
					 */
				}
				if (++old_idx >= KEVENT_MAX_EVENTS)
					old_idx = 0;
			}
			old_idx = num;
		}

		num = (unsigned)err;
		if (num) {
			ulog("syscall dump: %u events.\n", num);
			uk = (struct ukevent *)buf;
			for (i=0; i<num; ++i) {
				ulog("%08x: %08x.%08x - %08x.%08x\n", 
						uk[i].user[0],
						uk[i].id.raw[0], uk[i].id.raw[1],
						uk[i].ret_data[0], uk[i].ret_data[1]);
			}
		}
	}

	close(fd);
	return 0;
}

--J2SCkAp4GZ/dPZZf--
