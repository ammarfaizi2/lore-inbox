Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270948AbRHOAFn>; Tue, 14 Aug 2001 20:05:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270953AbRHOAFe>; Tue, 14 Aug 2001 20:05:34 -0400
Received: from mercury.Sun.COM ([192.9.25.1]:56281 "EHLO mercury.Sun.COM")
	by vger.kernel.org with ESMTP id <S270948AbRHOAFT>;
	Tue, 14 Aug 2001 20:05:19 -0400
Message-ID: <3B79BD9C.4BA3546@sun.com>
Date: Tue, 14 Aug 2001 17:09:00 -0700
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC: poll change
In-Reply-To: <3B79B5F3.C816CBED@sun.com>
		<20010814.163804.66057702.davem@redhat.com>
		<3B79BA07.B57634FD@sun.com> <20010814.165320.77058794.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
>    From: Tim Hockin <thockin@sun.com>
>    Date: Tue, 14 Aug 2001 16:53:43 -0700
> 
>    The standard says negative fd's are ignored.  We get that right.  What we
>    are left with is an overly paranoid check against max_fds.  This check
>    should go away.  You should be able to pass in up to your rlimit fds, and
>    let negative ones (holes or tails) be ignored.
>
> I am saying there is no problem.
> 
> In both cases, for a properly written application we ignore the
> invalid fds.  The behavior is identical both before and after
> your change, so there is no reason to make it.

But for an application that (imho) is poorly written but IS COMPLIANT, it
fails.

This program is compliant, if your ulimit -n is maxxed out at 1048576.

I'm not saying it is good design, but it is compliant.  The patch hurts
nothing and makes poll() that little bit more friendly.



#include <stdio.h>
#include <sys/poll.h>
#include <errno.h>
#include <string.h>

int
main(void)
{
        static struct pollfd ar[1024*1024];
        int size = sizeof(ar)/sizeof(*ar);
        int i;

        for (i = 0; i < size; i++)
                ar[i].fd = -1;
        ar[1000000].fd = 0;
        ar[1000000].events = POLLIN;

        i = poll(ar, size, -1);
        printf("return = %d (%s)\n", i, i?strerror(errno):"success");

        return 0;
}


-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
