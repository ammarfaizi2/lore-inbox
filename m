Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293074AbSBWEDM>; Fri, 22 Feb 2002 23:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293077AbSBWEDD>; Fri, 22 Feb 2002 23:03:03 -0500
Received: from mail.gmx.de ([213.165.64.20]:16440 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S293074AbSBWECu>;
	Fri, 22 Feb 2002 23:02:50 -0500
Message-ID: <3C770E77.5C7111B1@gmx.de>
Date: Sat, 23 Feb 2002 04:37:27 +0100
From: Edgar Toernig <froese@gmx.de>
MIME-Version: 1.0
To: Dan Aloni <da-x@gmx.net>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH] C exceptions in kernel
In-Reply-To: <1014412325.1074.36.camel@callisto.yi.org>
Content-Type: multipart/mixed;
 boundary="------------BC6CCA47544425EA45E8E072"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------BC6CCA47544425EA45E8E072
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Dan Aloni wrote:
> 
> The attached patch implements C exceptions in the kernel,

Bad idea ...

> which *don't* depend on special support from the compiler.

... which can be implemented in simple ANSI-C.  See below.

Ciao, ET.
--------------BC6CCA47544425EA45E8E072
Content-Type: text/plain; charset=us-ascii;
 name="try-n-catch.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="try-n-catch.c"

#include <setjmp.h>

struct _catch
{
    struct _catch *next;
    jmp_buf buf;
};

static struct _catch _catch_top[1];
struct _catch *_catch = _catch_top;

#define throw()				\
    do {				\
	_catch = _catch->next;		\
	longjmp(_catch->buf, 1);	\
    } while (0)


#define try				\
    if (setjmp(_catch->buf) == 0) {	\
	struct _catch _catch_new[1];	\
	_catch_new->next = _catch;	\
	_catch = _catch_new;

#define catch \
	_catch = _catch->next;		\
    } else


/**** example below ****/

#include <stdio.h>

int a = 1;

void
foo(int x)
{
    a=2;
    if (x & 1)
	throw();
}

int
main(int argc, char **argv)
{
    int i;

    for (i = 0; i < 10; ++i)
    {
	a=i;
	try
	{
	    try foo(i); catch
	    {
		printf("2: caught at %d (a=%d)\n", i, a);
		if ((i&3)==1)
		    throw();
	    }
	}
	catch
	{
	    printf("1: caught at %d (a=%d)\n", i, a);
	}
	printf("a=%d\n", a);
    }
    return 0;
}


--------------BC6CCA47544425EA45E8E072--


