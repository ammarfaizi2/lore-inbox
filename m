Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261835AbTCaTQT>; Mon, 31 Mar 2003 14:16:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261831AbTCaTQP>; Mon, 31 Mar 2003 14:16:15 -0500
Received: from chaos.analogic.com ([204.178.40.224]:61843 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S261835AbTCaTQI>; Mon, 31 Mar 2003 14:16:08 -0500
Date: Mon, 31 Mar 2003 14:29:59 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: attempt to free, allready freed memory .. rfc
In-Reply-To: <1049134044.945.35.camel@gregs>
Message-ID: <Pine.LNX.4.53.0303311350190.21451@chaos>
References: <1049134044.945.35.camel@gregs>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Mar 2003, Grzegorz Jaskiewicz wrote:

> Hello !
> As allways, i have a problem. Thus i want ask you for comment.
>
> Today i had a strange problem with my customers program. It is very
> fresh soft, and they are still strugling with it (developing i meant :-)
> ). But they were stucked on very strange problem.
>
> [explanation of problem in program- ommited]
>
> Problem it self.
>
> this code will be an example.
>
> struct doom{
>         int data1;
>         int data2;
>         void *mydata;
> };
>
> doom doomed;
>
> void dosomething_with_data(doom *d)
> {
> //      .... doing some fancy operations
> //      then..
>         if (d->mydata)
>         {
>                 free(d->mydata);
>                 d->mydata=NULL;
>         }
> }
>
> void main()
> {
>         int i,j;
>         void *t;
>
>         // this program is just not doing anything important :-)
>
>         t=doomed.mydata=malloc(somenumberofbytes);

[Snipped...]

First, this is not the way to make a linked list (if that's what
is intended). In particular, you need storage for all three data
elements which you get only in the first (static) allocation.

Second, the malloc() that comes with the usual C runtime library
does not check if you have corrupted data elements by overwriting
the heap. So, unlike visual C++, you can't rely on that to point
out coding errors. The only time the operating system will even
know that you have overwritten something is if you overwrite some
allocated page. A page is 0x1000 in length for ix86 in Linux so you
can destroy a lot of stuff before you get a seg-fault.

When writing (or porting) code for Linux/Unix machines, you need
to carefully use the sizeof() operator and take care to prevent
overwriting or even over-reading array bounds. Some stuff that you
can get away with in Visual C++ will get you in Linux/Unix for
instance, the following looks pretty good:

	double *ft;
        fp = (double *) malloc(ARRAY_SIZE * sizeof(float));

... actual code that ran for years on some V/C++ stuff. Once it was
compiled on Linux, there were unrelated problems, like the inability
to write to files. Some floating-point data was overwriting some
very important stuff, but nobody knew it. This was very hard to find
because none of the failures were related to the code being reviewed.

In your program, just instrument it. FYI, the very first function that's
linked will be the one used, even if there is another one in the 'C'
runtime library. So think about this...

You can make your own malloc() (real easy). First check to see
if your C runtime library uses "_" or "__" to mark an alias..

main()
{
   __malloc(0);
   __free(0);
}

This should compile. If it doesn't, use a single underscore.

Then make your own malloc()

static long long nr_bytes = 0;

void *malloc(size_t len)
{
    fprintf(stderr, "malloc called for %u bytes\n", len);
    nr_bytes += (long long) len;
    return __malloc(len);
}

You do the same thing for free(). You can write/save some global
variable to keep track as shown..

Make a malloc/free object file and link it first with your
program. You can also put a print statement in either malloc()
or free() showing the remaining nr_bytes.

This kind of instrumentation is a hell of a lot easier than
single-stepping through a debugger. You can let your program run
for a long time and the variable 'nr_bytes' should increase to
some stable value and remain there. If it doesn't, you can even
get the address of a caller who called your malloc() and ultimately
find the culprit that is allocating without subsequent freeing, but
that's a topic for another lesson.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

