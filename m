Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261268AbRFTD74>; Tue, 19 Jun 2001 23:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262607AbRFTD7g>; Tue, 19 Jun 2001 23:59:36 -0400
Received: from smtp1.Stanford.EDU ([171.64.14.23]:15297 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S261268AbRFTD71>; Tue, 19 Jun 2001 23:59:27 -0400
Date: Tue, 19 Jun 2001 20:59:24 -0700
From: "Zack Weinberg" <zackw@Stanford.EDU>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, tridge@samba.org
Subject: Re: 2.2 PATCH: check return from copy_*_user in fs/pipe.c
Message-ID: <20010619205924.H5679@stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15152.4073.812901.656882@pizda.ninka.net>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2001 at 07:52:25PM -0700, David S. Miller wrote:
> 
> Zack Weinberg writes:
>  > It *has* been fixed in 2.4, though.  Some sort of compatibility issue?
> 
> No, some kind of "it doesn't matter" issue.

I can demonstrate user code that behaves differently under 2.2 than
2.4.  The example I have (appended) doesn't suffer data loss, but I
bet I could make one that did.

I don't think it's a security hole, if that's what you mean.

zw

/* Pointer validation hack.  Expected output is
 *	|
 *	|
 *	|{null ptr}
 *	|{unmapped: 0xAFAFAFAF}
 *	|{unmapped: 0xA5A5A5A5}
 *	|{unmapped: 0xCDEFABCD}
 *	|{unaligned: 0xBFFFFB2B}
 *
 * Under Linux 2.2, will print a blank line instead of each
 * {unmapped: 0x...}.
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

static const char *
validate_ptr(void *p, size_t align)
{
    static int pipes[2];
    static int setup = 0;
    char dummy;

    if(!setup)
    {
	if(pipe(pipes))
	    abort();
	setup = 1;
    }

    if(p == NULL)
	return "{null ptr}";

    if((unsigned long)p & (align - 1))
	return "{unaligned: 0x%lX}";

    if(write(pipes[1], p, 1) != 1)
	return "{unmapped: 0x%lX}";

    /* clear out the byte we just wrote down the pipe */
    read(pipes[0], &dummy, 1);
    return 0;
}

int
main(void)
{
    char blah = 'x';
    char *a, *b, *c, *d, *e, *f;
    const char *msg;

    a = &blah;
    b = malloc(1);
    c = (char *) 0;
    d = (char *) 0xafafafaf;
    e = (char *) 0xa5a5a5a5;
    f = (char *) 0xcdefabcd;

#define TEST(x, y) \
    if((msg = validate_ptr(x, y))) printf(msg, (unsigned long)x); \
    putchar('\n');

    TEST(a, 1);
    TEST(b, 4);
    TEST(c, 1);
    TEST(d, 1);
    TEST(e, 1);
    TEST(f, 1);
    TEST(a, 2);
    return 0;
}
