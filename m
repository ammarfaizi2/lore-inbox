Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261174AbTEHFDE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 01:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261175AbTEHFDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 01:03:04 -0400
Received: from dp.samba.org ([66.70.73.150]:21901 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261174AbTEHFDD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 01:03:03 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com, rml@tech9.net, mingo@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] How to write a portable "run_on" program?
Date: Thu, 08 May 2003 15:14:40 +1000
Message-Id: <20030508051539.31CFA2C04B@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

	Currently you need to do the following in userspace to set
your affinity portably:

#include <limits.h>

#define BITS_PER_LONG (sizeof(long)*CHAR_BIT)

int set_cpu(int cpu)
{
	size_t size = sizeof(unsigned long);
	unsigned long *bitmask = NULL;
	int ret;

	do {
		size *= 2;
		bitmask = realloc(bitmask, size);
		memset(bitmask, 0, size);
		bitmask[cpu / BITS_PER_LONG] = (1 << (cpu % BITS_PER_LONG);
		ret = sched_setaffinity(getpid(), size, bitmask);
	} while (ret < 0 && errno = -EINVAL);
	return ret;
}

I know Linus thinks this is natural and fine[1], but for the rest of
us, how about the following patch, which allows:

int set_cpu(int cpu)
{
	size_t size = sched_getaffinity(getpid(), 0, NULL);
	unsigned char bitmask[size];

	memset(bitmask, 0, size);
	bitmask[cpu/8] = (1 << (cpu%8));
	return sched_setaffinity(getpid(), size, bitmask);
}

Thoughts?
Rusty.

[1] http://www.ussg.iu.edu/hypermail/linux/kernel/0206.2/0551.html
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.69-bk2/kernel/sched.c working-2.5.69-bk2-getaffinity/kernel/sched.c
--- linux-2.5.69-bk2/kernel/sched.c	2003-05-05 12:37:13.000000000 +1000
+++ working-2.5.69-bk2-getaffinity/kernel/sched.c	2003-05-08 15:11:30.000000000 +1000
@@ -1949,6 +1949,10 @@ asmlinkage long sys_sched_getaffinity(pi
 	task_t *p;
 
 	real_len = sizeof(mask);
+
+	/* This lets the user query the bitmask size. */
+	if (!len)
+		return real_len;
 	if (len < real_len)
 		return -EINVAL;
 
