Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLOVdC>; Fri, 15 Dec 2000 16:33:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129319AbQLOVcy>; Fri, 15 Dec 2000 16:32:54 -0500
Received: from enterprise.cistron.net ([195.64.68.33]:3593 "EHLO
	enterprise.cistron.net") by vger.kernel.org with ESMTP
	id <S129183AbQLOVcq>; Fri, 15 Dec 2000 16:32:46 -0500
From: miquels@traveler.cistron-office.nl (Miquel van Smoorenburg)
Subject: Re: Linus's include file strategy redux
Date: 15 Dec 2000 21:02:16 GMT
Organization: Cistron Internet Services B.V.
Message-ID: <91e0so$9bn$1@enterprise.cistron.net>
In-Reply-To: <20001215152137.K599@almesberger.net> <NBBBJGOOMDFADJDGDCPHAENMCJAA.law@sgi.com>
X-Trace: enterprise.cistron.net 976914136 9591 195.64.65.67 (15 Dec 2000 21:02:16 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: miquels@traveler.cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <NBBBJGOOMDFADJDGDCPHAENMCJAA.law@sgi.com>,
LA Walsh <law@sgi.com> wrote:
>It was at that
>point, the externally compiled module "barfed", because like many modules,
>it expected, like many externally compiled modules, that it could simply
>access all of it's needed files through /usr/include/linux which it gets
>by putting /usr/include in it's path.  I've seen commercial modules like
>vmware's kernel modules use a similar system where they expect
>/usr/include/linux to contain or point to headers for the currently running
>kernel.

vmware asks you nicely

where are the running kernels include files [/usr/src/linux/include" >

And then compiles the modules with -I/path/to/include/files

In fact, the 2.2.18 kernel already puts a 'build' symlink in
/lib/modules/`uname -r` that points to the kernel source,
which should be sufficient to solve this problem.. almost.

It doesn't tell you the specific flags used to compile the kernel,
such as -m486 -DCPU=686

>	So at that point it becomes what we should name it under
>/usr/include/linux.  Should it be:
>1) "/usr/include/linux/sys" (my preference)

/usr should be static. It could be a read-only NFS mount.
Putting system dependant configuration info here (which a
/usr/include/linux/sys symlink *is*) is wrong.

I think /lib/modules/`uname -r`/ should contain a script that
reproduces the CFLAGS used to compile the kernel. That way,
you not only get the correct -I/path/to/kernel/include but
the other compile-time flags (like -m486 etc) as well.

# sh /lib/modules/`uname -r`/kconfig --cflags
-D__KERNEL__ -I/usr/src/linux-2.2.18pre24/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -fno-strength-reduce -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686

Standard module Makefile that will _always_ work:

#! /usr/bin/make -f

CC = $(shell /lib/modules/`uname -r`/kconfig --cc)
CFLAGS = $(shell /lib/modules/`uname -r`/kconfig --cflags)

module.o:
	$(CC) $(CFLAGS) -c module.c

Flags could be:

--check		Consistency check - are the header files there and
		does include/linux/version.h match
--cc		Outputs the CC variable used to compile the kernel
		(important now that we have gcc, kgcc, gcc272)
--arch		Outputs the ARCH variable
--cflags	Outputs the CFLAGS
--include-path	Outputs just the path to the include files

Generating and installing this 'kconfig' script as part of
"make modules_install" is trivial, and would solve all problems.
Well as far as I can see, ofcourse, I might have missed something..

Mike.
-- 
RAND USR 16514
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
