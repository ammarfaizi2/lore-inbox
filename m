Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266169AbUGJGqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266169AbUGJGqm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 02:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266170AbUGJGqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 02:46:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:23224 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266169AbUGJGqj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 02:46:39 -0400
Date: Fri, 9 Jul 2004 23:45:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: Daniel McNeil <daniel@osdl.org>
Cc: bryce@osdl.org, wli@holomorphy.com, ltp-list@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, testdev@osdl.org, markh@osdl.org
Subject: Re: [LTP] Re: Recent changes in LTP test results
Message-Id: <20040709234522.56cdd515.akpm@osdl.org>
In-Reply-To: <1089416583.2265.47.camel@ibm-c.pdx.osdl.net>
References: <20040706191009.279aed14.akpm@osdl.org>
	<Pine.LNX.4.33.0407071334460.22452-100000@osdlab.pdx.osdl.net>
	<20040707230715.7a25c95c.akpm@osdl.org>
	<1089416583.2265.47.camel@ibm-c.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel McNeil <daniel@osdl.org> wrote:
>
> The /proc/pid/maps looked like this:
> 
>  without nx-update patch:
>  40017000-40018000 ---p 40017000 00:00 0
>  =====
>  with -mm1:
>  40017000-40018000 --xp 40017000 00:00 0

Here's mine, with current -linus bk:

40000000-40001000 ---p 40000000 00:00 0 

>  So it looks like the page being executable allows read
>  access.
> 
>  Not sure why you do not see this on your machine.  This
>  fails on my 2-proc xeon box (and all the STP machines).
> 


#include <unistd.h>
#include <errno.h>
#include <sys/mman.h>


main()
{
	char *p0 = 0;
	char *p1 = (char *)-1;
	char *p2;
	int err;

	p2 = mmap(0, 4096, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS, 0, 0);

	printf("p2=%p\n", p2);
	printf("pid=%d\n", getpid());

	getchar();

	errno = 0;
	err = access(p0, R_OK);
	printf("access 0 ptr %p return code %d errno %d\n", p0, err, errno);
	perror("access result:");
	errno = 0;
	err = access(p1, R_OK);
	printf("access 1 ptr %p return code %d errno %d\n", p1, err, errno);
	perror("access result:");
	errno = 0;
	err = access(p2, R_OK);
	printf("access 2 ptr %p return code %d errno %d\n", p2, err, errno);
	perror("access result:");
}

vmm:/home/akpm> ./x
p2=0x40000000
pid=2038

access 0 ptr (nil) return code -1 errno 14
access result:: Bad address
access 1 ptr 0xffffffff return code -1 errno 14
access result:: Bad address
access 2 ptr 0x40000000 return code -1 errno 14
access result:: Bad address

I get this result on both p4 xeon and p3 xeon.
