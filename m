Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932459AbVLIVZR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932459AbVLIVZR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 16:25:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932467AbVLIVZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 16:25:16 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:14801 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932459AbVLIVZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 16:25:15 -0500
Subject: Re: i386 -> x86_64 cross compile failure (binutils bug?)
From: Steven Rostedt <rostedt@goodmis.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Kyle McMartin <kyle@mcmartin.ca>
In-Reply-To: <1134161906.18432.15.camel@mindpipe>
References: <1134154208.14363.8.camel@mindpipe>
	 <20051209195816.GF32168@quicksilver.road.mcmartin.ca>
	 <1134159677.18432.7.camel@mindpipe>
	 <20051209204151.GH32168@quicksilver.road.mcmartin.ca>
	 <1134161906.18432.15.camel@mindpipe>
Content-Type: text/plain
Date: Fri, 09 Dec 2005 16:25:06 -0500
Message-Id: <1134163506.5238.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-09 at 15:58 -0500, Lee Revell wrote:
> Also, isn't it a bug for the Makefile not to pass -m64 if I specify
> ARCH=x86_64?  If I don't change the CFLAGS I get:
> 
> $ make ARCH=x86_64                              
>   CHK     include/linux/version.h
>   CC      arch/x86_64/kernel/asm-offsets.s
> arch/x86_64/kernel/asm-offsets.c:1: error: code model 'kernel' not
> supported in the 32 bit mode
> make[1]: *** [arch/x86_64/kernel/asm-offsets.s] Error 1
> make: *** [prepare0] Error 2

Lee,

For my x86_64, I gave up on trying to do it through the normal path
(having a plain debian unstable system), and finally just downloaded the
gcc toolchain (gcc, binutils, and glibc) and built them as cross
compilers with the prefix x86_64-linux-

For binutils I made a directory binutils_x86_64 and in there I used:

../binutils-2.16/configure  --prefix=/usr/local/x86_64 --target=x86_64-linux

For gcc (first pass) I used:

../gcc-4.0.2/configure   --prefix=/usr/local/x86_64 --target=x86_64-linux \
--enable-shared --disable-threads --enable-languages=c

That's enough to get a gcc that builds the kernel.

Then I built glibc, and then once again the gcc with:

../gcc-4.0.2/configure   --prefix=/usr/local/x86_64 --target=x86_64-linux \
--enable-shared --with-headers=/usr/local/x86_64/include \
--with-libs=/usr/local/x86_64/lib --disable-multilib \
--enable-languages=c

Probably not the best way, but it worked for me ;-)

Now I also installed a hack make program in /usr/local/bin that is used first:

---
#!/bin/sh

if [ ! -z $__MY_MAKE_RUNNING__ ]; then
        /usr/bin/make $*
        exit $?
fi

__MY_MAKE_RUNNING__=1
export __MY_MAKE_RUNNING__

pwd=`pwd | sed -ne '/\/home\/rostedt\/work\/kernels\//p'`

if [ -z $pwd ]; then
        m="intmake"
else
        m="amdmake"
fi

# prove to me that I'm running the right one
echo $m
$m $*
---

with amdmake in /usr/local/bin:
---
PATH=$PATH:/usr/local/x86_64/bin/ make CROSS_COMPILE=x86_64-linux- ARCH=x86_64 $*
---


and intmake also in /usr/local/bin:
---
make ARCH=i386 $*
---


So now all the kernels in my /home/rostedt/work/kernels are built with
the cross compiling x86_64 and all other kernels for intel i386.  I know
this is a major hack, but I don't have time to pretty this up!

-- Steve


