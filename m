Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269905AbRHQIf5>; Fri, 17 Aug 2001 04:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269918AbRHQIfs>; Fri, 17 Aug 2001 04:35:48 -0400
Received: from draco.cus.cam.ac.uk ([131.111.8.18]:35295 "EHLO
	draco.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S269905AbRHQIfa>; Fri, 17 Aug 2001 04:35:30 -0400
Date: Fri, 17 Aug 2001 09:35:40 +0100 (BST)
From: Anton Altaparmakov <aia21@cus.cam.ac.uk>
To: "David S. Miller" <davem@redhat.com>
cc: zippel@linux-m68k.org, aia21@cam.ac.uk, tpepper@vato.org,
        f5ibh@db0bm.ampr.org, linux-kernel@vger.kernel.org
Subject: Re: 2.4.9 does not compile [PATCH]
In-Reply-To: <20010816.203732.107941169.davem@redhat.com>
Message-ID: <Pine.SOL.3.96.1010817085835.17700C-100000@draco.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Aug 2001, David S. Miller wrote:
>    From: Roman Zippel <zippel@linux-m68k.org>
>    Date: Fri, 17 Aug 2001 05:23:01 +0200
> 
>    Please show me a place in the kernel where such code is used and is
>    not dumb.
> 
> Why don't you point out an example yourself?  You seem pretty
> confident that a comparsion between a signed and unsigned value cannot
> possible be legitimate.

If you compare int x with unsigned int y you can get the wrong result in
the case that the unsigned value has the sign bit set and the signed
value is negative.

Example:

$ cat t.c
#include <stdio.h>

int main(void)
{
        int x = -2;
        unsigned int y = 0x80000000;

        printf("x = %i, y = %u\n", x, y);
        if (x < y)
                puts("x < y");
        else if (x > y)
                puts("x > y");
        else
                puts("x == y");
        return 0;
}
$ gcc -Wall t.c
$ ./a.out
x = -2, y = 2147483648
x > y

This is clearly wrong as -2 is less than 2147483648 and I doubt very much
that bug would be caught by introducing type casts into the min
function... It will just put people at ease that everything is now fine
when in fact it won't be (unless they make the type cast to long long
which I doubt people would do).

A bug simillar to this was present in NTFS a while ago as a matter of
fact and was causing massive corruption of run lists... And gcc doesn't
even emit a warning hence it took quite a lot of work to spot that this
was the bug. In the end I found it by looking at the generated corrupt
structures and realizing that there must be a sign bug somewhere and then
I looked at the function and I saw the light and fixed this properly by
using the same type of variables rather than playing silly games with
mixing signed and unsigned values.

If gcc had emitted a warning this bug would never have been possible to
occur so I am all for generating warnings, not suppressing them
artificially, at least in this case.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

