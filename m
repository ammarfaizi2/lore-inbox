Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315599AbSEIDVV>; Wed, 8 May 2002 23:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315600AbSEIDVU>; Wed, 8 May 2002 23:21:20 -0400
Received: from [61.81.112.41] ([61.81.112.41]:44463 "EHLO atj.dyndns.org")
	by vger.kernel.org with ESMTP id <S315599AbSEIDVU>;
	Wed, 8 May 2002 23:21:20 -0400
Date: Thu, 9 May 2002 12:21:18 +0900
To: linux-kernel@vger.kernel.org
Subject: [BUG] mm deadlock
Message-ID: <20020509032118.GA850@atj.dyndns.org>
Reply-To: tejun@aratech.co.kr
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: TeJun Huh <tj@atj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Running the following program on linux 2.4.18 SMP results in lockup
of the thread and some part of the system (any attempt to access the
thread list results in the lockup of the attempting thread).

 The program basically mmaps memory until the mmapped region is very
close to the bottom of the stack with some unmapped region inbetween.
Then it tries to access region beyond the end of the highest mmaped
region. I think it has something to do with stack growth.

---- program follows ----

#include <stdio.h>
#include <unistd.h>
#include <sys/mman.h>

#define BASE_SIZE	(32 << 20)
#define MIN_SIZE	(512 << 10)

int main(void)
{
	size_t size;
	unsigned long *p, *lastp;
	size_t last_size;
	int i;

	lastp = NULL;
	size = BASE_SIZE;
	while (size >= MIN_SIZE) {
		p = mmap(0, size, PROT_READ|PROT_WRITE,
			 MAP_SHARED|MAP_ANONYMOUS, 0, 0);
		if (p == (unsigned long *)-1)
			size >>= 1;
		else {
			lastp = p;
			last_size = size;
		}
	}

	p = lastp + last_size / sizeof(unsigned long);
	for (i = 0; i < last_size / sizeof(unsigned long); i++)
		p[i] = i;

	printf("ok\n");
	return 0;
}
