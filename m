Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262098AbTKUTyh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 14:54:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262321AbTKUTyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 14:54:37 -0500
Received: from gprs149-160.eurotel.cz ([160.218.149.160]:12672 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262098AbTKUTye (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 14:54:34 -0500
Date: Fri, 21 Nov 2003 16:39:00 +0100
From: Pavel Machek <pavel@suse.cz>
To: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: ionice kills vanilla 2.6.0-test9 was [Re: [PATCH] cfq + io priorities (fwd)]
Message-ID: <20031121153900.GA193@elf.ucw.cz>
References: <20031113124510.GZ643@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031113124510.GZ643@openzaurus.ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I'm attaching the simple ionice tool. It's used as follows:
> 
> Here's one that works, sorry about that. To compile:
> 
> # gcc -Wall -D__X86 -o ionice ionice.c
> 
> or other define for PPC or X86_64.

Well, did that, run it on vanilla kernel, and it kills the
machine. Can someone reproduce it?
							Pavel
[What is needed to start using cfq? Is your patch, this utility and
elevator=cfq enough?]

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


----- End forwarded message -----

-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...



-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
