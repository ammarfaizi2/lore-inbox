Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbUCILBi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 06:01:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbUCILBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 06:01:38 -0500
Received: from mx1.elte.hu ([157.181.1.137]:54710 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261862AbUCILBf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 06:01:35 -0500
Date: Tue, 9 Mar 2004 12:02:33 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [lockup] Re: objrmap-core-1 (rmap removal for file mappings to avoid 4:4 in <=16G machines)
Message-ID: <20040309110233.GA3819@elte.hu>
References: <20040308202433.GA12612@dualathlon.random> <20040309105226.GA2863@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="4bRzO86E/ozDv8r1"
Content-Disposition: inline
In-Reply-To: <20040309105226.GA2863@elte.hu>
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


--4bRzO86E/ozDv8r1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


* Ingo Molnar <mingo@elte.hu> wrote:

> To reproduce, run the attached, very simple test-mmap.c code (as
> unprivileged user) which maps 80MB worth of shared memory in a
> finegrained way, creating ~19K vmas, and sleeps. Keep this process
> around.

or run the attached test-mmap2.c code, which simulates a very small DB
app using only 1800 vmas per process: it only maps 8 MB of shm and
spawns 32 processes. This has an even more lethal effect than the
previous code.

	Ingo

--4bRzO86E/ozDv8r1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="test-mmap2.c"

/*
 * Copyright (C) Ingo Molnar, 2004
 *
 * Create 8 MB worth of finegrained mappings to a shmfs file,
 * and spawn 32 processes.
 */
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/stat.h>

/* 8 MB of mappings */
#define CACHE_PAGES 2000

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


--4bRzO86E/ozDv8r1--
