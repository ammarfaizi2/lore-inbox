Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131135AbRBQUIm>; Sat, 17 Feb 2001 15:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131443AbRBQUIc>; Sat, 17 Feb 2001 15:08:32 -0500
Received: from colorfullife.com ([216.156.138.34]:59153 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S131135AbRBQUIT>;
	Sat, 17 Feb 2001 15:08:19 -0500
Message-ID: <3A8ED9F4.AEFC4D29@colorfullife.com>
Date: Sat, 17 Feb 2001 21:07:16 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.1-ac15 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Mark Swanson <swansma@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: System V msg queue bugs in latest kernels
In-Reply-To: <20010217184242.1070.qmail@web1302.mail.yahoo.com> <3A8ECB1B.776D0372@colorfullife.com>
Content-Type: multipart/mixed;
 boundary="------------0175B2EE9FC624DBC0DA8706"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------0175B2EE9FC624DBC0DA8706
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Manfred Spraul wrote:
> 
> Mark Swanson wrote:
> >
> > Hello,
> >
> > ipcs (msg) gives incorrect results if used-bytes is above 65536. It
> > stays at 65536 even though messages are being read and removed from the
> > msg queue.
> >

Ok, does the value stay at 65536 or 65535?
It should stay at 65535 if you use a too old version of util-linux.

Please upgrade (see linux/Documentation/Changes)

The proc interface at /proc/sysvipc/msg should report the correct
numbers.

If you want to access values > 65535 from your app you have 2 options:

1) use the new msqid64_ds structure. You must pass IPC_64 to the msgctl
call. This is the only option if you need correct 32-bit uids.
Check the util-linux source, I don't have sample code.
msqid64_ds is only supported by the 2.4 kernel.

2) the old msqid_ds structure also support 32-bit queue length, an
unused field was reused. No support for 32-bit uids.

#define msg_lqbytes	__rwait;

I've attached my old sample code.
--
	Manfred
--------------0175B2EE9FC624DBC0DA8706
Content-Type: text/plain; charset=us-ascii;
 name="longqueue.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="longqueue.c"

/*
 * This code is public domain sample code.
 * Written by Manfred Spraul, 1999
 *
 * The application must be started by root or
 * setuid(root).
 *
 * $Header: /pub/cvs/ms/ipcmsg/longqueue.c,v 1.2 1999/10/09 23:27:54 manfreds Exp $
 */

#include <sys/msg.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

/* result codes:
 * 0: success
 * 1: partial success, queue len now USHORT_MAX
 * 100: invalid parameters.
 * 101: other error
 * 256: fatal error, please delete the queue: queue len now 0.
 */

#define USHORT_MAX	0xFFff
struct queuelen {
	int llen;
	unsigned short slen;
};

struct msqid_ds g_q;

#define msg_lqbytes		__rwait
void failure(char* msg)
{
	printf(" unexpected error in %s.\n",msg);
	exit(101);
}

int init_ipc(int id)
{
	int res;
	
	res = msgget(id,0);
	if(res == -1)
		failure("findkey()");
	id = res;
	res = msgctl(id,IPC_STAT,&g_q);
	if(res == -1)
		failure("init_ipc()");
	return id;
}

void get_queuelen(int id,
		struct queuelen *out)
{
	int res;
	struct msqid_ds q;

	res = msgctl(id,IPC_STAT,&q);
	if(res == -1)
		failure("get_queuelen()");
	out->llen = q.msg_lqbytes;
	out->slen = q.msg_qbytes;
}

int set_queuelen(int id, int len)
{
	struct msqid_ds q;

	memcpy(&q,&g_q,sizeof(q));
	if(len > USHORT_MAX) {
		q.msg_qbytes = 0;
		q.msg_lqbytes = len;
	} else
	{
		q.msg_qbytes = len;
	}
	return msgctl(id,IPC_SET,&q);
}

int main(int argc,char** argv)
{
	int id;
	int len;
	struct queuelen prev;
	struct queuelen new;

	printf("longqueue <id> <len>\n");
	if(argc != 3) {
		printf("Invalid parameters.\n");
		return 100;
	}
	id = atoi(argv[1]);
	len = atoi(argv[2]);
	if(len <= 0) {
		printf("Invalid parameters.\n");
		return 100;
	}
	id = init_ipc(id);
	get_queuelen(id,&prev);
	if(set_queuelen(id,len) == -1)
		failure("set_queuelen()");
	if(len <= USHORT_MAX) {
out_success:
		get_queuelen(id,&prev);
		printf(" new queuelen: (%d,%d).\n",prev.slen,prev.llen);
		return 0;
	}
	/* the old Linux ipcmsg code doesn't support
	 * long queues. It interprets this as "queue len 0".
	 * Check for this, and try USHORT_MAX, then the original
	 * value.
	 */
	get_queuelen(id,&new);
	if(new.slen != 0)
		goto out_success;

	if(set_queuelen(id,USHORT_MAX) == -1) {
		if(set_queuelen(id,prev.slen) == -1) {
			printf(" fatal error. queue len now 0.\n");
			return 256;
		};
		failure("set_queuelen()");
	}
	get_queuelen(id,&new);
	printf(" new queuelen: (%d,%d).\n",prev.slen,prev.llen);
	return 1;
}


--------------0175B2EE9FC624DBC0DA8706--


