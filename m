Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289026AbSBSADy>; Mon, 18 Feb 2002 19:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289018AbSBSADk>; Mon, 18 Feb 2002 19:03:40 -0500
Received: from holomorphy.com ([216.36.33.161]:51854 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S289026AbSBSADY>;
	Mon, 18 Feb 2002 19:03:24 -0500
Date: Mon, 18 Feb 2002 16:03:18 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: bmatthews@redhat.com
Subject: Re: [TEST] page tables filling non-highmem
Message-ID: <20020219000318.GE3511@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, bmatthews@redhat.com
In-Reply-To: <20020215045106.GB26322@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020215045106.GB26322@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, I hereby place this testcase under the GPL:

/*
 * death.c -- Testcase for pagetable memory management.
 *
 *   Copyright (C) 2002  William Irwin
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation; either version 2 of the License, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with this program; if not, write to the Free Software
 *   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */

#define __USE_LARGEFILE64
#include <stdio.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <sys/types.h>
#define __USE_LARGEFILE64
#include <fcntl.h>
#include <errno.h>

#define MAPPING_START 0x20000000
#define MAPPING_SIZE  (0x80000000/sizeof(unsigned long))
#define MAPPING_END   (MAPPING_START + MAPPING_SIZE*sizeof(unsigned long))

int main(void)
{
	int fd;
	unsigned long *data = NULL;
	unsigned long try = 64;
	unsigned long k = 0;

	fd = open("/home/wli/bench/mapfile", O_RDWR|O_LARGEFILE);

	if (fd < 0) {
		perror("death");
		printf("could not open mapfile!\n");
		exit(1);
	}

	data = mmap((void *)MAPPING_START,
			MAPPING_SIZE,
			PROT_READ|PROT_WRITE, 
			MAP_FIXED | MAP_SHARED,
			fd,
			0);

	if (!try || data == MAP_FAILED) {
		printf("mmap() failed, tries = %lu!\n", 64 - try + 1);
		exit(1);
	}

	printf("managed to mmap() at %p\n", (void *)data);

	sleep(60);

	try = 0;
	while (1) {
		printf("entered iteration %lu\n", k);
		data[k++] = try++;
		k %= MAPPING_SIZE;
		if (k >= MAPPING_SIZE-1)
			k = 0;
	}
	return 0;
}
