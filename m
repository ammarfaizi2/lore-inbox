Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313827AbSEEXgW>; Sun, 5 May 2002 19:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313862AbSEEXgW>; Sun, 5 May 2002 19:36:22 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:14598 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S313827AbSEEXgU>;
	Sun, 5 May 2002 19:36:20 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Urban Widmark <urban@teststation.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel 
In-Reply-To: Your message of "Sun, 05 May 2002 19:23:11 +0200."
             <Pine.LNX.4.33.0205051512450.4444-100000@cola.enlightnet.local> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 06 May 2002 09:36:07 +1000
Message-ID: <8322.1020641767@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 May 2002 19:23:11 +0200 (CEST), 
Urban Widmark <urban@teststation.com> wrote:
>On Thu, 2 May 2002, Keith Owens wrote:
>
>> Linus, kbuild 2.5 is ready for inclusion in the main 2.5 kernel tree.
>> It is faster, better documented, easier to write build rules in, has
>> better install facilities, allows separate source and object trees, can
>> do concurrent builds from the same source tree and is significantly
>> more accurate than the existing kernel build system.
>
>Faster ... ?
>
>The time I care about is the module rebuild time. From various posts I had
>the impression that it was significantly improved. I don't find that to be
>the case unless I'm being "foolhardy" and specify various flags or
>otherwise bypass the system.
>[times snipped]
>Shadow trees sounds interesting. I'm sure others see great benefit from
>being able to build over NFS or having stricter integrity checks. I just
>don't get the faster bit, but maybe that's just me.

You are not comparing like with like.  Much of your speed difference
from kbuild 2.4 to 2.5 is because you have omitted the make dep time.
kbuild 2.5 does not have a seperate make dep pass.  Instead it checks
the dependencies every time, during phase4.

Checking the dependencies only once in kbuild 2.4 is a very common
source of build error.  Users change their code, forget to rerun make
dep then wonder why their kernel and module build is broken.  In your
case, you "know" that your change does not affect the dependencies so
you omit the make dep run.  That is the equivalent of bypassing the
integrity checks in kbuild 2.5, i.e. it is the equivalent of
NO_MAKEFILE_GEN=1.

Also you specified make modules.  You are bypassing all the checks to
see if any part of the main kernel needs to be rebuilt because of your
changes.  Whether that bypass is correct or not is unknown, you are
asserting that it is and bypassing the dependency checks on the rest of
the kernel.  BTW, if you have a lot of modules you will find that your
make modules time in 2.4 is significantly higher than the times you
quoted.

So you found a case that appears to make kbuild 2.4 faster than 2.5.
You did it by omitting the kbuild 2.4 step that does integrity checking
and by specifying command line options that bypass most of the build.
The result is that you are comparing an inaccurate 2.4 build against an
accurate 2.5 build.

I have never considered "fast but inaccurate" to be a sensible default
goal for a kernel build.  If you want that, use NO_MAKEFILE_GEN=1.

