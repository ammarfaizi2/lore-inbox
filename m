Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262256AbULMNKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262256AbULMNKZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 08:10:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262259AbULMNKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 08:10:24 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:10890 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262256AbULMNKI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 08:10:08 -0500
Date: Mon, 13 Dec 2004 14:09:27 +0100
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Time sliced cfq with basic io priorities
Message-ID: <20041213130926.GH3033@suse.de>
References: <20041213125046.GG3033@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="v9Ux+11Zm5mwPlX6"
Content-Disposition: inline
In-Reply-To: <20041213125046.GG3033@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 13 2004, Jens Axboe wrote:
> 2.6.10-rc2-mm4 patch:

So 2.6.10-rc3-mm1 is out I notice, here's a patch for that:

http://www.kernel.org/pub/linux/kernel/people/axboe/patches/v2.6/2.6.10-rc3-mm1/cfq-time-slices-10-2.6.10-rc3-mm1.gz

And an updated ionice.c attached, the syscall numbers changed.

-- 
Jens Axboe


--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ionice.c"

#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <getopt.h>
#include <unistd.h>
#include <sys/ptrace.h>
#include <asm/unistd.h>

extern int sys_ioprio_set(int);
extern int sys_ioprio_get(void);

#if defined(__i386__)
#define __NR_ioprio_set		294
#define __NR_ioprio_get		295
#elif defined(__ppc__)
#define __NR_ioprio_set		277
#define __NR_ioprio_get		278
#elif defined(__x86_64__)
#define __NR_ioprio_set		254
#define __NR_ioprio_get		255
#elif defined(__ia64__)
#define __NR_ioprio_set		1274
#define __NR_ioprio_get		1275
#else
#error "Unsupported arch"
#endif

_syscall1(int, ioprio_set, int, ioprio);
_syscall0(int, ioprio_get);

int main(int argc, char *argv[])
{
	int ioprio = 2, set = 0;
	int c;

	while ((c = getopt(argc, argv, "+n:")) != EOF) {
		switch (c) {
		case 'n':
			ioprio = strtol(optarg, NULL, 10);
			set = 1;
			break;
		}
	}

	if (!set) {
		int ioprio = ioprio_get();
		if (ioprio == -1)
			perror("ioprio_get");
		else
			printf("%d\n", ioprio_get());
	} else if (argv[optind]) {
		if (ioprio_set(ioprio) == -1) {
			perror("ioprio_set");
			return 1;
		}
		execvp(argv[optind], &argv[optind]);
	}

	return 0;
}

--v9Ux+11Zm5mwPlX6--
