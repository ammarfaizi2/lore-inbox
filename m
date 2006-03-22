Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932085AbWCVWKd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbWCVWKd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 17:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932089AbWCVWKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 17:10:33 -0500
Received: from smtpout.mac.com ([17.250.248.86]:63469 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932085AbWCVWKc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 17:10:32 -0500
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Transfer-Encoding: 7bit
Message-Id: <BE2452EA-2566-4C2A-B07D-BD63404A42C1@mac.com>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Mark Rustad <mrustad@mac.com>
Subject: 2.6.16 hugetlbfs problem
Date: Wed, 22 Mar 2006 16:10:33 -0600
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,

I seem to be having trouble using hugetlbfs with kernel 2.6.16. I  
have a small test program that worked with 2.6.16-rc5, but fails with  
2.6.16-rc6 or the release. The program is below. Given a path to a  
file on a hugetlbfs, it opens/creates the file, mmaps it and tries to  
access the first word. On 2.6.16-rc5, it works. On 2.6.16, it hangs  
page-faulting until it is killed.

#include <stdint.h>
#include <unistd.h>
#include <sys/types.h>
#include <stdio.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <sys/stat.h>


int main(int argc, char *argv[])
{
	unsigned	len = 4 * 1024 * 1024;
	void	*vaddr = (void *)0x48000000;
	int	hfd;
	void	*p;
	int	*ip;

	if (!argc || !argv[1] || !argv[1][0]) {
		fprintf(stderr, "Missing argument\n");
		return 1;
	}
	hfd = open(argv[1], O_RDWR | O_CREAT, S_IRUSR | S_IWUSR);
	if (hfd < 0) {
		perror("open");
		return 1;
	}
	p = mmap(vaddr, len, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_FIXED,
		hfd, 0);
	if (p == MAP_FAILED) {
		perror("mmap");
		fprintf(stderr, "mmap failed at %p\n", vaddr);
		return 1;
	}
	ip = p;
	*ip = 0;	// This loops on page faults
	close(hfd);
	printf("Size %d in file %s\n", len, argv[1]);

	return 0;
}

Any ideas?

-- 
Mark Rustad, MRustad@mac.com

