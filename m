Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267435AbUIUBZn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267435AbUIUBZn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 21:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267445AbUIUBZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 21:25:43 -0400
Received: from ipcop.bitmover.com ([192.132.92.15]:25290 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S267435AbUIUBZg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 21:25:36 -0400
Date: Mon, 20 Sep 2004 18:25:36 -0700
From: Larry McVoy <lm@bitmover.com>
To: linux-kernel@vger.kernel.org
Subject: Re: help with next generation bkbits please
Message-ID: <20040921012536.GA17088@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	linux-kernel@vger.kernel.org
References: <20040921012208.GA16008@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040921012208.GA16008@work.bitmover.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Forgot memory scrubber, here it is.

#include <stdio.h>
#include <stdlib.h>
#include <strings.h>
#include <unistd.h>

#define	unless(x)	if (!(x))
#define	u32		unsigned int
#define	status(s)	write(1, s, 1); newline = 1;

int	newline;
void	doit(u32 bs);

int
main(int ac, char **av)
{
	if (ac != 2) {
		printf("Usage: %s amount_in_MB\n", av[0]);
		exit(0);
	}
	doit(atoi(av[1])<<20);
	return (0);
}

void
bad(u32 *start, u32 *p, u32 want)
{
	u32	off = (char*)p - (char*)start;
	u32	got = *p;

	if (newline) printf("\n");
	newline = 0;
	printf("WANT=0x%08x GOT=0x%08x DIFF=0x%08x OFF=0x%08x ADDR=%p\n",
	    want, got, want - got, off, (void*)p);
}

void
doit(u32 bs)
{
	u32	*buf = malloc(bs);
	u32	*end;
	u32	*p;
	u32	off;

	fprintf(stderr, "Scrub %u bytes\n", bs);
	unless (buf) {
		perror("malloc");
		exit(1);
	}
	end = (u32*)((char*)buf + bs);
	bzero(buf, bs);
	unless (sizeof(int) == 4) {
		fprintf(stderr, "Expected 4 byte ints\n");
		exit(1);
	}
	for (off = 0, p = buf; p < end; *p++ = off, off += 4);
	for (;;) {
		for (off = 0, p = buf; p < end; off += 4) {
			if (*p != off) bad(buf, p, off);
			*p++ = 0xdeadbeef;
		}
		status("d");
		for (off = 0, p = buf; p < end; off += 4) {
			if (*p != 0xdeadbeef) bad(buf, p, 0xdeadbeef);
			*p++ = 0x50505050;
		}
		status("5");
		for (off = 0, p = buf; p < end; off += 4) {
			if (*p != 0x50505050) bad(buf, p, 0x50505050);
			*p++ = 0x0a0a0a0a;
		}
		status("a");
		for (off = 0, p = buf; p < end; off += 4) {
			if (*p != 0x0a0a0a0a) bad(buf, p, 0x0a0a0a0a);
			*p++ = 0x55555555;
		}
		status("-");
		for (off = 0, p = buf; p < end; off += 4) {
			if (*p != 0x55555555) bad(buf, p, 0x55555555);
			*p++ = 0xaaaaaaaa;
		}
		status("A");
		for (off = 0, p = buf; p < end; off += 4) {
			if (*p != 0xaaaaaaaa) bad(buf, p, 0xaaaaaaaa);
			*p++ = 0x0;
		}
		status("0");
		for (off = 0, p = buf; p < end; off += 4) {
			if (*p != 0x0) bad(buf, p, 0);
			*p++ = 0xffffffff;
		}
		status("f");
		for (off = 0, p = buf; p < end; off += 4) {
			if (*p != 0xffffffff) bad(buf, p, 0xffffffff);
			*p++ = off;
		}
		status("o");
	}
}
