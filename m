Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313202AbSEERXd>; Sun, 5 May 2002 13:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313217AbSEERXc>; Sun, 5 May 2002 13:23:32 -0400
Received: from fungus.teststation.com ([212.32.186.211]:14090 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S313202AbSEERXb>; Sun, 5 May 2002 13:23:31 -0400
Date: Sun, 5 May 2002 19:23:11 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: <puw@cola.enlightnet.local>
To: Keith Owens <kaos@ocs.com.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel
In-Reply-To: <20507.1020263013@ocs3.intra.ocs.com.au>
Message-ID: <Pine.LNX.4.33.0205051512450.4444-100000@cola.enlightnet.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 May 2002, Keith Owens wrote:

> Linus, kbuild 2.5 is ready for inclusion in the main 2.5 kernel tree.
> It is faster, better documented, easier to write build rules in, has
> better install facilities, allows separate source and object trees, can
> do concurrent builds from the same source tree and is significantly
> more accurate than the existing kernel build system.

Faster ... ?

The time I care about is the module rebuild time. From various posts I had
the impression that it was significantly improved. I don't find that to be
the case unless I'm being "foolhardy" and specify various flags or
otherwise bypass the system.

The time to rebuild everything isn't that interesting to me as it's too
long anyway to sit around and wait for it to complete. Maybe that is where
the improvements are.


Here is how I work. First I configure and build a complete kernel for the
.config I use. Something like:

cp ../.config-2.5 .config
make -f Makefile-2.5 oldconfig
make -f Makefile-2.5 installable

Then I will do a number of rebuild modules & install cycles, where the
environment does not change (.config, tools, etc) except for the module I
am working on. The times I get for various things are:

A - Time to rebuild smbfs.o with proc.c changed:
	time make -f Makefile-2.5 fs/smbfs/smbfs.o
	51.910u 2.760s 0:54.95 99.4%    0+0k 0+0io 102368pf+0w

B - Same, with NO_MAKEFILE_GEN=1, 1st run:
	time make -f Makefile-2.5 NO_MAKEFILE_GEN=1 fs/smbfs/smbfs.o
	28.280u 0.600s 0:28.91 99.8%    0+0k 0+0io 27014pf+0w

C - Same, with NO_MAKEFILE_GEN=1, 2nd run:
	time make -f Makefile-2.5 NO_MAKEFILE_GEN=1 fs/smbfs/smbfs.o
	0.910u 0.420s 0:01.33 100.0%    0+0k 0+0io 21928pf+0w

D - Installing as root:
	time make -f Makefile-2.5 install
	1.110u 0.960s 0:02.63 78.7%     0+0k 0+0io 34905pf+0w

E - proc.c changed, module rebuild+install with the 2.4 build system
   (separate tree from above):
	time make modules modules_install
	21.160u 2.020s 0:23.12 100.2%   0+0k 0+0io 50927pf+0w

(Built on 2.5.8, 2xPIII 500, 512M, kbuild core-11, 2.5.13 tree)


A + D > 2 * E, and this is the way it's supposed to be used, no?
B + D > E
C + D < E, but C becomes a B after installing as the install wants to be
run with NO_MAKEFILE_GEN not set.

The difference between B and C is that pp_makefile4 is run.


I have seen you claim that it is faster, and others have repeated that. I
just wonder at doing what?

A full build it was slightly faster 12:00.47 vs 12:20.55, but here the
kbuild-2.5 build was run twice since I missed that it otherwise uses kgcc
(which makes it ~3 minutes faster) and the "2.4" build did an install
also. So that's about equal.

make oldconfig is also slower 0:21.06 vs, 0:04.55 since it runs phase1
first, and that was done outside the timed command.

Shadow trees sounds interesting. I'm sure others see great benefit from
being able to build over NFS or having stricter integrity checks. I just
don't get the faster bit, but maybe that's just me.

/Urban

