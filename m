Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262189AbUCIThR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 14:37:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbUCITdr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 14:33:47 -0500
Received: from mx2.elte.hu ([157.181.151.9]:4739 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262158AbUCITcW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 14:32:22 -0500
Date: Tue, 9 Mar 2004 20:33:38 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [lockup] Re: objrmap-core-1 (rmap removal for file mappings to avoid 4:4 in <=16G machines)
Message-ID: <20040309193338.GA15865@elte.hu>
References: <20040308202433.GA12612@dualathlon.random> <20040309105226.GA2863@elte.hu> <20040309110233.GA3819@elte.hu> <20040309155917.GH8193@dualathlon.random> <20040309160709.GA10577@elte.hu> <20040309160807.GA10778@elte.hu> <20040309163920.GN8193@dualathlon.random>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
In-Reply-To: <20040309163920.GN8193@dualathlon.random>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner-4.26.8-itk2 SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9, BAYES_00 -4.90,
	UPPERCASE_25_50 0.00
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


* Andrea Arcangeli <andrea@suse.de> wrote:

> > > how fast is the system you tried this on? If it's faster than the 500
> > > MHz box i tried it on then please try the attached test-mmap3.c.
> > > (which is still not doing anything extreme.)
> > 
> > also, please run it on an UP kernel.
> 
> I will, thanks for the hint.

test-mmap3.c attached. It locked up my UP box so hard that i couldnt
even switch consoles - i turned the box off after 30 minutes.

	Ingo

--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="test-mmap3.c"

/*
 * Copyright (C) Ingo Molnar, 2004
 *
 * Create 80 MB worth of finegrained mappings to a shmfs file,
 * and spawn 32 processes.
 */
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/stat.h>

/* 80 MB of mappings */
#define CACHE_PAGES 20000

#define PAGE_SIZE	4096
#define CACHE_SIZE	(CACHE_PAGES*PAGE_SIZE)
#define WINDOW_PAGES	(CACHE_PAGES*9/10)
#define WINDOW_SIZE	(WINDOW_PAGES*PAGE_SIZE)
#define WINDOW_START	0x48000000

int main(void)
{
	char *data, *ptr, filename[100];
	char empty_page [PAGE_SIZE];
	int i, fd;

	sprintf(filename, "/dev/shm/cache%d", getpid());
	fd = open(filename, O_RDWR|O_CREAT|O_TRUNC,S_IRWXU);
	unlink(filename);

	for (i = 0; i < CACHE_PAGES; i++)
		write(fd, empty_page, PAGE_SIZE);
	data = mmap(0, WINDOW_SIZE, PROT_READ|PROT_WRITE, MAP_SHARED , fd, 0);

	for (i = 0; i < WINDOW_PAGES; i++) {
		ptr = (char*) mmap(data + i*PAGE_SIZE, PAGE_SIZE,
				PROT_READ|PROT_WRITE, MAP_SHARED | MAP_FIXED,
					fd, (WINDOW_PAGES-i)*PAGE_SIZE);
		(*ptr)++;
	}
	printf("%d pages mapped - sleeping until Ctrl-C.\n", WINDOW_PAGES);
	fork(); fork(); fork(); fork(); fork();
	pause();

	return 0;
}


--sdtB3X0nJg68CQEu--
