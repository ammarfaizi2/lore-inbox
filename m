Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263153AbSJBQc5>; Wed, 2 Oct 2002 12:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263154AbSJBQc5>; Wed, 2 Oct 2002 12:32:57 -0400
Received: from stingr.net ([212.193.32.15]:19722 "EHLO hq.stingr.net")
	by vger.kernel.org with ESMTP id <S263153AbSJBQcy>;
	Wed, 2 Oct 2002 12:32:54 -0400
Date: Wed, 2 Oct 2002 20:38:21 +0400
From: Paul P Komkoff Jr <i@stingr.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [STUPID TESTCASE] ext3 htree vs. reiserfs on 2.5.40-mm1
Message-ID: <20021002163820.GG6318@stingr.net>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20021001195914.GC6318@stingr.net> <E17wUYa-0006Dl-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <E17wUYa-0006Dl-00@starship>
User-Agent: Agent Darien Fawkes
X-Mailer: Intel Ultra ATA Storage Driver
X-RealName: Stingray Greatest Jr
Organization: Department of Fish & Wildlife
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replying to Daniel Phillips:
> How big are the files?

0.

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdio.h>

main(int argc, char* argv[]) {

	int i, j, k = atoi(argv[1]);
	char t[128];

	for (i = 0; i < k; i++) {
		snprintf(t, 127, "%08X", i);
		if (-1 == (j = creat(t, S_IRWXU))) {
			perror("Create file");
			printf("no: %d\n", i);
			return;
		}
		close(j);
	}

}


> You probably want to try creating the files in random order as well.  A
> program to do that is attached, use in the form:
> 
>     randfiles <basename> <count> y
> 
> where 'y' means 'print the names', for debugging purposes.

this will be the next series of tests :)

> What did your delete command look like, "rm -rf" or "echo * | xargs rm"?

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdio.h>

main(int argc, char* argv[]) {

	int i, j, k = atoi(argv[1]);
	char t[128];

	for (i = 0; i < k; i++) {
		snprintf(t, 127, "%08X", i);
		if (-1 == unlink(t)) {
			perror("unlink");
			printf("no: %d\n", i);
			return;
		}
	}

}

> Only 300,000 files, you haven't got enough to cause inode table thrashing,
> though some kernels shrink the inode cache too agressively and that can
> cause thrashing at lower numbers.  Maybe a bottleneck in the journal?

Yes, increasing journal to fit the whole directory in it (as Andreas
Dilger said) improved results by 1/4. But. Initially my test was
1000000 files. /dev/sda4 in my tests 1882844. And I am quickly hitting
inode limit on -t news ext3 filesystem so I need to artificially
increase it at mke2fs time, but I decided to not do so (yet).

> Not that anybody is going to complain about any of the above - it's still
> running less than 1 ms/create, 2 ms/delete.  Still, it's slower than I'm
> used to.

I just trying to write a caching proxy-like application and not
reinvent the wheel (aka design my own filesystem and store it in a big
file just because some filesystem is so slow on large
directories/cannot make more than N empty objects etc).

-- 
Paul P 'Stingray' Komkoff 'Greatest' Jr /// (icq)23200764 /// (http)stingr.net
  When you're invisible, the only one really watching you is you (my keychain)
