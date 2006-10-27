Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752334AbWJ0QnE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752334AbWJ0QnE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 12:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752340AbWJ0QnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 12:43:03 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:38022 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1752304AbWJ0QnB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 12:43:01 -0400
Date: Fri, 27 Oct 2006 20:42:31 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: johnpol@2ka.mipt.ru
Cc: David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org
Subject: Re: [take21 0/4] kevent: Generic event handling mechanism.
Message-ID: <20061027164231.GB14133@2ka.mipt.ru>
References: <1154985aa0591036@2ka.mipt.ru> <11619654014077@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
In-Reply-To: <11619654014077@2ka.mipt.ru>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Fri, 27 Oct 2006 20:42:32 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline

On Fri, Oct 27, 2006 at 08:10:01PM +0400, Evgeniy Polyakov (johnpol@2ka.mipt.ru) wrote:
> 
> Generic event handling mechanism.
> 
> Consider for inclusion.
> 
> Changes from 'take20' patchset:
>  * new ring buffer implementation

Test userspace application can be found in archive on project's
homepage. It is also attached to this mail.

Short design notes about ring buffer implementation.

Ring buffer is designed in a way that first ready kevent will be at
ring->uidx position, and all other ready events will be in FIFO order
after it. So when we need to commit num events, it means we should just
remove first num kevents from ready queue and commit them. We do not use
any special locking to protect this function against simultaneous
running - kevent dequeueing is atomic, and we do not care about order in
which events were committed.
An example: thread 1 and thread 2 simultaneously call kevent_wait() to
commit 2 and 3 events. It is possible that first thread will commit
events 0 and 2 while second thread will commit events 1, 3 and 4. If
there were only 3 ready events, then one of the calls will return lesser
number of committed events than it was requested.
ring->uidx update is atomic, since it is protected by u->ready_lock,
which removes race with kevent_user_ring_add_event().

If user asks to commit events which have beed removed by
kevent_get_events() recently (for example when one thread looked into
ring indexes and started to commit evets, which were simultaneously
committed by other thread through kevent_get_events(), kevent_wait()
will not commit unprocessed events, but will return number of actually
committed events instead.

It is forbidden to try to commit events not from the start of the
buffer, but from some 'futher' event.

An example: if ready events use positions 2-5, it is permitted to start
to commit 3 events from position 0, in this case 0 and 1 positions will
be ommited and only event in position 2 will be committed and
kevent_wait() will return 1, since only one event was actually
committed.
It is forbidden to try to commit from position 4, 0 will be returned.
This means that if some events were committed using kevent_get_events(),
they will not be counted, instead userspace should check ring index and
try to commit again.

-- 
	Evgeniy Polyakov

--T4sUOijqQbZv57TR
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
#include <time.h>
#include <unistd.h>

#include <linux/unistd.h>
#include <linux/types.h>

#define PAGE_SIZE	4096
#include <linux/ukevent.h>

#define _syscall3(type,name,type1,arg1,type2,arg2,type3,arg3) \
type name (type1 arg1, type2 arg2, type3 arg3) \
{\
	return syscall(__NR_##name, arg1, arg2, arg3);\
}

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
_syscall4(int, kevent_wait, int, arg1, unsigned int, arg2, unsigned int, argv3, __u64, argv4);

#define ulog(f, a...) fprintf(stderr, "%8u: "f, time(NULL), ##a)
#define ulog_err(f, a...) ulog(f ": %s [%d].\n", ##a, strerror(errno), errno)

static void usage(char *p)
{
	ulog("Usage: %s -t type -e event -o oneshot -p path -n wait_num -f kevent_file -r ready_num -h\n", p);
}

static int evtest_mmap(int fd, struct kevent_mring **ring, int number)
{
	int i;
	off_t o = 0;

	for (i=0; i<number; ++i) {
		ring[i] = mmap(NULL, PAGE_SIZE, PROT_READ, MAP_SHARED, fd, o);
		if (ring[i] == MAP_FAILED) {
			ulog_err("Failed to mmap: i: %d, number: %u, offset: %lu", i, number, o);
			return -ENOMEM;
		}

		printf("mmap: %d: number: %u, offset: %lu.\n", i, number, o);
		o += PAGE_SIZE;
	}
	
	return 0;
}

int main(int argc, char *argv[])
{
	int ch, fd, err, oneshot, wait_num;
	unsigned int i, ready_num, old_idx, new_idx, tm_sec, tm_nsec;
	char *file;
	char buf[4096];
	struct ukevent *uk;
	struct mukevent *m;
	struct kevent_mring *ring[KEVENT_MAX_PAGES];
	off_t offset;

	oneshot = 0;
	wait_num = 10;
	offset = 0;
	old_idx = 0;
	file = "/dev/kevent";
	tm_sec = 2;
	tm_nsec = 0;
	ready_num = 1;

	while ((ch = getopt(argc, argv, "r:f:t:T:o:n:h")) > 0) {
		switch (ch) {
			case 'f':
				file = optarg;
				break;
			case 'r':
				ready_num = atoi(optarg);
				break;
			case 'n':
				wait_num = atoi(optarg);
				break;
			case 't':
				tm_sec = atoi(optarg);
				break;
			case 'T':
				tm_nsec = atoi(optarg);
				break;
			case 'o':
				oneshot = atoi(optarg);
				break;
			default:
				usage(argv[0]);
				return -1;
		}
	}

	fd = open(file, O_RDWR);
	if (fd == -1) {
		ulog_err("Failed create kevent control block using file %s", file);
		return -1;
	}

	err = evtest_mmap(fd, ring, KEVENT_MAX_PAGES);
	if (err)
		return err;

	memset(buf, 0, sizeof(buf));
	
	for (i=0; i<ready_num; ++i) {
		uk = (struct ukevent *)buf;
		uk->event = KEVENT_TIMER_FIRED;
		uk->type = KEVENT_TIMER;
		if (oneshot)
			uk->req_flags |= KEVENT_REQ_ONESHOT;
		uk->user[0] = i;
		uk->id.raw[0] = tm_sec;
		uk->id.raw[1] = tm_nsec+i;

		err = kevent_ctl(fd, KEVENT_CTL_ADD, 1, uk);
		if (err < 0) {
			ulog_err("Failed to perform control operation: oneshot: %d, sec: %u, nsec: %u", 
					oneshot, tm_sec, tm_nsec);
			close(fd);
			return err;
		}
		if (err) {
			ulog("%d: %016llx: ret_flags: 0x%x, ret_data: %u %d.\n", 
					i, uk->id.raw_u64, 
					uk->ret_flags, uk->ret_data[0], (int)uk->ret_data[1]);
		}
	}

	old_idx = ready_num = 0;
	while (1) {
		new_idx = ring[0]->kidx;
		old_idx = ring[0]->uidx;
		if (new_idx != old_idx) {
			ready_num = (old_idx > new_idx)?(KEVENT_MAX_EVENTS - (old_idx - new_idx)):(new_idx - old_idx);

			ulog("mmap: new: %u, old: %u, ready: %u.\n", new_idx, old_idx, ready_num);

			for (i=0; i<ready_num; ++i) {
				int ridx = old_idx / KEVENTS_ON_PAGE;
				int idx = old_idx % KEVENTS_ON_PAGE;
				m = &ring[ridx]->event[idx % KEVENTS_ON_PAGE];
				ulog("%08x: %08x.%08x - %08x\n", 
					i, m->id.raw[0], m->id.raw[1], m->ret_flags);
			}
		}
		ulog("going to wait: old: %u, new: %u, ready_num: %u, uidx: %u, kidx: %u.\n", 
				old_idx, new_idx, ready_num, ring[0]->uidx, ring[0]->kidx);
		err = kevent_wait(fd, old_idx, ready_num, 10000000000ULL);
		if (err < 0) {
			if (errno != EAGAIN) {
				ulog_err("Failed to perform control operation: oneshot: %d, sec: %u, nsec: %u", 
						oneshot, tm_sec, tm_nsec);
				close(fd);
				return err;
			}
			old_idx = (old_idx + ready_num) % KEVENT_MAX_EVENTS;
			ready_num = 0;
		}
		ulog("wait: old: %u, ready: %u, ret: %d.\n", old_idx, ready_num, err);
	}

	close(fd);
	return 0;
}

--T4sUOijqQbZv57TR--
