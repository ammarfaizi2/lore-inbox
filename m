Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbUCIKvV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 05:51:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261860AbUCIKvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 05:51:21 -0500
Received: from mx2.elte.hu ([157.181.151.9]:59609 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261862AbUCIKvR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 05:51:17 -0500
Date: Tue, 9 Mar 2004 11:52:26 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: [lockup] Re: objrmap-core-1 (rmap removal for file mappings to avoid 4:4 in <=16G machines)
Message-ID: <20040309105226.GA2863@elte.hu>
References: <20040308202433.GA12612@dualathlon.random>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
In-Reply-To: <20040308202433.GA12612@dualathlon.random>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner-4.26.8-itk2 SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


* Andrea Arcangeli <andrea@suse.de> wrote:

> This patch avoids the allocation of rmap for shared memory and it uses
> the objrmap framework to do find the mapping-ptes starting from a
> page_t which is zero memory cost, (and zero cpu cost for the fast
> paths)

this patch locks up the VM.

To reproduce, run the attached, very simple test-mmap.c code (as
unprivileged user) which maps 80MB worth of shared memory in a
finegrained way, creating ~19K vmas, and sleeps. Keep this process
around.

Then try to create any sort of VM swap pressure. (start a few desktop
apps or generate pagecache pressure.) [the 500 MHz P3 system i tried
this on has 256 MB of RAM and 300 MB of swap.]

stock 2.6.4-rc2-mm1 handles it just fine - it starts swapping and
recovers. The system is responsive and behaves just fine.

with 2.6.4-rc2-mm1 + your objrmap patch the box in essence locks up and
it's not possible to do anything. The VM is looping within the objrmap
functions. (a sample trace attached.)

Note that the test-mmap.c app does nothing that a normal user cannot do. 
In fact it's not even hostile - it only has lots of vmas but is
otherwise not actively pushing the VM, it's just sleeping. (Also, the
test is a very far cry from Oracle's workload of gigabytes of shm mapped
in a finegrained way to hundreds of processes.) All in one, currently i
believe the patch is pretty unacceptable in its present form.

	Ingo

Pid: 7, comm:              kswapd0
EIP: 0060:[<c013ee6d>] CPU: 0
EIP is at page_referenced_obj+0xdd/0x120
 EFLAGS: 00000246    Not tainted
EAX: cb311808 EBX: cb311820 ECX: 40a2d000 EDX: cb311848
ESI: cfe202fc EDI: cfe2033c EBP: cfdf9dc4 DS: 007b ES: 007b
CR0: 8005003b CR2: 40507000 CR3: 0b11e000 CR4: 00000290
Call Trace:
 [<c013ef71>] page_referenced+0xc1/0xd0
 [<c0137bad>] refill_inactive_zone+0x3fd/0x4c0
 [<c01376bc>] shrink_cache+0x26c/0x360
 [<c0137d11>] shrink_zone+0xa1/0xb0
 [<c01380d7>] balance_pgdat+0x1a7/0x200
 [<c013820b>] kswapd+0xdb/0xe0
 [<c01180b0>] autoremove_wake_function+0x0/0x50
 [<c01180b0>] autoremove_wake_function+0x0/0x50
 [<c0138130>] kswapd+0x0/0xe0
 [<c01050f9>] kernel_thread_helper+0x5/0xc


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="test-mmap.c"

/*
 * Copyright (C) Ingo Molnar, 2004
 *
 * Create 80 MB worth of finegrained mappings to a shmfs file.
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
	pause();

	return 0;
}


--9jxsPFA5p3P2qPhR--
