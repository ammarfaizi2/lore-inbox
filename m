Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261776AbTKHNZj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 08:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261777AbTKHNZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 08:25:39 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:11245 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261776AbTKHNZh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 08:25:37 -0500
Date: Sat, 8 Nov 2003 14:25:39 +0100
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cfq + io priorities
Message-ID: <20031108132539.GU14728@suse.de>
References: <20031108124758.GQ14728@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="K8nIJk4ghYZn606h"
Content-Disposition: inline
In-Reply-To: <20031108124758.GQ14728@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--K8nIJk4ghYZn606h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 08 2003, Jens Axboe wrote:
> I'm attaching the simple ionice tool. It's used as follows:

Here's one that works, sorry about that. To compile:

# gcc -Wall -D__X86 -o ionice ionice.c

or other define for PPC or X86_64.

-- 
Jens Axboe


--K8nIJk4ghYZn606h
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

#ifdef __X86
#define __NR_ioprio_set		274
#define __NR_ioprio_get		275
#endif

#ifdef __X86_64
#define __NR_ioprio_set		237
#define __NR_ioprio_get		238
#endif

#ifdef __PPC
#define __NR_ioprio_set		255
#define __NR_ioprio_get		256
#endif

#ifndef __NR_ioprio_set
#error set arch
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

	if (!set)
		printf("%d\n", ioprio_get());
	else if (argv[optind]) {
		if (ioprio_set(ioprio) == -1) {
			perror("ioprio_set");
			return 1;
		}

		execvp(argv[optind], &argv[optind]);
	}
	return 0;
}

--K8nIJk4ghYZn606h--
