Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317541AbSHOWMy>; Thu, 15 Aug 2002 18:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317544AbSHOWMy>; Thu, 15 Aug 2002 18:12:54 -0400
Received: from spratly.wl.nominum.com ([128.177.195.135]:47030 "EHLO
	spratly.nominum.com") by vger.kernel.org with ESMTP
	id <S317541AbSHOWMx>; Thu, 15 Aug 2002 18:12:53 -0400
Date: Thu, 15 Aug 2002 15:16:47 -0700 (PDT)
From: Brian Wellington <bwelling@xbill.org>
X-X-Sender: bwelling@spratly.nominum.com
To: linux-kernel@vger.kernel.org
Subject: ptrace/select/signal errno weirdness
Message-ID: <Pine.LNX.4.44.0208151508060.21876-100000@spratly.nominum.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When sending a SIGINT to a ptraced process (run under gdb), an interrupted 
select() call returns with errno==514.  linux/include/linux/errno.h says:

/* Should never be seen by user programs */
#define ERESTARTSYS     512
#define ERESTARTNOINTR  513
#define ERESTARTNOHAND  514     /* restart if no handler.. */
#define ENOIOCTLCMD     515     /* No ioctl command */

As gdb is a user program, and the printf is printing it, there's something
wrong.  This might be due to a problem in gdb, but the fact that the errno
is being seen in userspace seems bad.

A simple test program is included.  To test, build and run it under gdb.  
Hit ^C to get back to the gdb prompt, and enter 'signal SIGINT' to send a 
SIGINT.

This has been reproduced on 2.4.18 (the Red Hat 7.3 errata kernel) and 
2.4.19 (built from scratch).

Brian

----
#include <errno.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <sys/select.h>
#include <sys/signal.h>

void
printsig(int sig) {
	fprintf(stderr, "got sig %d\n", sig);
}

int
main(int argc, char **argv) {
	int n;
	struct sigaction sa;
	memset(&sa, 0, sizeof sa);
	sa.sa_handler = printsig;
	n = sigaction(SIGINT, &sa, NULL);
	if (n < 0) {
		fprintf(stderr, "sigaction: %s\n", strerror(errno));
		exit(1);
	}
	n = select(0, NULL, NULL, NULL, NULL);
	if (n < 0) {
		fprintf(stderr, "select: %s\n", strerror(errno));
		exit(1);
	}
	exit(0);
}

