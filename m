Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266014AbUGIXGx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266014AbUGIXGx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 19:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266016AbUGIXGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 19:06:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:37315 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266014AbUGIXGu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 19:06:50 -0400
Subject: Re: [LTP] Re: Recent changes in LTP test results
From: Daniel McNeil <daniel@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Bryce Harrington <bryce@osdl.org>, wli@holomorphy.com,
       ltp-list@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "testdev@osdl.org" <testdev@osdl.org>, Mark Haverkamp <markh@osdl.org>
In-Reply-To: <20040707230715.7a25c95c.akpm@osdl.org>
References: <20040706191009.279aed14.akpm@osdl.org>
	 <Pine.LNX.4.33.0407071334460.22452-100000@osdlab.pdx.osdl.net>
	 <20040707230715.7a25c95c.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1089416583.2265.47.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 09 Jul 2004 16:43:04 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-07-07 at 23:07, Andrew Morton wrote:
> Bryce Harrington <bryce@osdl.org> wrote:
> >
> > I have retested with ltp-full-20040603.  This version of LTP hangs on
> >  our system but fortunately completes most of the tests before doing so.
> >  It indicates that it still encounters the same errors, e.g.:
> > 
> >  access03       1   FAIL : access((char *)-1,R_OK) failed with errno 2 : No such file or directory but expected 14 (EFAULT)
> >  access03       2   FAIL : access((char *)-1,W_OK) failed with errno 2 : No such file or directory but expected 14 (EFAULT)
> 
> Nope, sorry, still cannot reproduce it - you'll need to debug it at your end.


Andrew,

Mark and I are able to reproduce this with the simple
program below.  The mmap() PROT_NONE is not giving a EFAULT
on read.  The test was mmap a PROT_NONE address and passing
that into the access() syscall and then looking for a
EFAULT.  Instead it was getting ENOENT.  We found that
by backing out the nx-update.patch from -mm1 patches
the problem went away.

The /proc/pid/maps looked like this:

without nx-update patch:
40017000-40018000 ---p 40017000 00:00 0
=====
with -mm1:
40017000-40018000 --xp 40017000 00:00 0

So it looks like the page being executable allows read
access.

Not sure why you do not see this on your machine.  This
fails on my 2-proc xeon box (and all the STP machines).

I can send more info if you need it.

Daniel (and Mark)

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


