Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272671AbRIGOSk>; Fri, 7 Sep 2001 10:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272674AbRIGOSa>; Fri, 7 Sep 2001 10:18:30 -0400
Received: from smtp2.libero.it ([193.70.192.52]:38114 "EHLO smtp2.libero.it")
	by vger.kernel.org with ESMTP id <S272671AbRIGOSQ>;
	Fri, 7 Sep 2001 10:18:16 -0400
Date: Fri, 7 Sep 2001 16:13:23 +0200
From: antirez <antirez@invece.org>
To: Ingo Rohloff <rohloff@in.tum.de>
Cc: epic@scyld.com, linux-kernel@vger.kernel.org
Subject: Re: epic100.c, gcc-2.95.2 compiler bug!
Message-ID: <20010907161323.B31574@blu>
Reply-To: antirez <antirez@invece.org>
In-Reply-To: <20010903130404.B1064@lxmayr6.informatik.tu-muenchen.de> <20010907160159.C621@lxmayr6.informatik.tu-muenchen.de> <20010907160315.D621@lxmayr6.informatik.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010907160315.D621@lxmayr6.informatik.tu-muenchen.de>; from rohloff@in.tum.de on Fri, Sep 07, 2001 at 04:03:15PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2001 at 04:03:15PM +0200, Ingo Rohloff wrote:
> BEWARE: DON'T USE gcc-2.95.2!
> I compiled the linux-2.4.9 version with gcc-2.95.2.
> And I can _definitely_ confirm that epic100.c triggers a compiler
> bug. (I have the erronous assembler code on my harddisk if anyone is
> interested.)

The following seems a gcc 3.0 bug, not sure it was fixed in gcc 3.01.

See the assembly generated with -O3 for the following code:

--------------------------------------------------------------
inline static long QInt(double inval)
{
        long *l;
        char *c = (char*) &inval;
        inval = 68719476991.99;

        l = (long*) (c+2);
        return *l;
}

int main(void)
{
        printf("%lu\n", QInt(OFFENDING_VALUE));
        return 0;
}
---------------------------------------------------------------

the above function is compiled as:

        .file   "test2.c"
        .section        .rodata
.LC0:
        .string "%lu\n"
        .text
        .align 16
.globl main
        .type   main,@function
main:
        pushl   %ebp
        movl    %esp, %ebp
        subl    $48, %esp
*       movl    $16776561, -32(%ebp)
*       movl    -30(%ebp), %eax
*       movl    $1110441984, -28(%ebp)
        pushl   %eax
        pushl   $.LC0
        call    printf
        addl    $16, %esp
        movl    %ebp, %esp
        xorl    %eax, %eax
        popl    %ebp
        ret
.Lfe1:
        .size   main,.Lfe1-main
        .ident  "GCC: (GNU) 3.0"

Note the line I marked with "*".
The double var is 8 byte, it is loaded
moving two 32 bit words in the -32 and -28 offset.
Unfortunatelly with -O3 the "*l" value get
computed between the two 'movl', and not after
the second movl.

This code is really unsane anyway but this seems
a clear gcc 3.0 bug.

I hope that the gcc folks here may report the
problem if not already known.

I didn't tested it but maybe the same problem
exists with other 8 byte types like 'long long'.

regards,
antirez
