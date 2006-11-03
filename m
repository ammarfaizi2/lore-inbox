Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753243AbWKCLwX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753243AbWKCLwX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 06:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753245AbWKCLwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 06:52:23 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:15312 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1753243AbWKCLwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 06:52:23 -0500
Date: Fri, 3 Nov 2006 12:52:21 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Gabriel C <nix.or.die@googlemail.com>, linux-kernel@vger.kernel.org
Subject: Re: New filesystem for Linux
In-Reply-To: <Pine.LNX.4.61.0611030911540.13091@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.64.0611031248030.17174@artax.karlin.mff.cuni.cz>
References: <Pine.LNX.4.64.0611022221330.4104@artax.karlin.mff.cuni.cz>
 <454A71EB.4000201@googlemail.com> <Pine.LNX.4.64.0611030219270.7781@artax.karlin.mff.cuni.cz>
 <454AA4C5.3070106@googlemail.com> <Pine.LNX.4.61.0611030911540.13091@yvahk01.tjqt.qr>
X-Personality-Disorder: Schizoid
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> This error looks fixed, now I have a new one here :)
>>
>> cc -D__NOT_FROM_SPAD -D__NOT_FROM_SPAD_TREE -Wall
>> -fdollars-in-identifiers -O2 -fomit-frame-pointer -c -o MKSPADFS.o -x c
>> MKSPADFS.C
>> MKSPADFS.C:146: error: expected declaration specifiers or '...' before
>> '_llseek'
>> MKSPADFS.C:146: error: expected declaration specifiers or '...' before 'fd'
>> MKSPADFS.C:146: error: expected declaration specifiers or '...' before 'hi'
>> MKSPADFS.C:146: error: expected declaration specifiers or '...' before 'lo'
>> MKSPADFS.C:146: error: expected declaration specifiers or '...' before 'res'
>> MKSPADFS.C:146: error: expected declaration specifiers or '...' before 'wh'
>> MKSPADFS.C:146: warning: type defaults to 'int' in declaration of
>> '_syscall5'
>
> Ugh this syscall 'crap' is butt-ugly.

Yes, it is.

> So anyway, why do you need _llseek? Can't you just use lseek() like
> everyone else?

Because I want it to work with glibc 2.0 that I still use on one machine.

>> In file included from MKSPADFS.C:153:
>> GETHSIZE.I: In function 'test_access':
>> GETHSIZE.I:13: warning: implicit declaration of function '_llseek'
>> make: *** [MKSPADFS.o] Error 1
>
> And why are the filenames all uppercase? I think I left the DOS times
> some years ago. Your makefile also has some pits. Look at unionfs how to
> organize kernel and userspace files in a better way in one tree.

Because they are shared with another project and it is just practical to 
copy them without renaming. Yes --- it looks inconsistent on Linux side.

Mikulas

> spadfs-01.diff
> Index: spadfs-0.9.1/Kbuild
> ===================================================================
> --- /dev/null
> +++ spadfs-0.9.1/Kbuild
> @@ -0,0 +1,2 @@
> +obj-m  := spadfs.o
> +spadfs-y := alloc.o buffer.o dir.o file.o inode.o link.o name.o namei.o super.o
> Index: spadfs-0.9.1/Makefile
> ===================================================================
> --- spadfs-0.9.1.orig/Makefile
> +++ spadfs-0.9.1/Makefile
> @@ -1,6 +1,4 @@
> ifneq ($(KERNELRELEASE),)
> -obj-m  := spadfs.o
> -spadfs-y := alloc.o buffer.o dir.o file.o inode.o link.o name.o namei.o super.o
> else
> KERNELDIR := /usr/src/linux-`uname -r`/
> all : spadfs mkspadfs spadfsck
> #<EOF>
>
>
> spadfs-02.diff
> Index: spadfs-0.9.1/Kbuild
> ===================================================================
> --- spadfs-0.9.1.orig/Kbuild
> +++ spadfs-0.9.1/Kbuild
> @@ -1,2 +1,2 @@
> -obj-m  := spadfs.o
> +obj-m += spadfs.o
> spadfs-y := alloc.o buffer.o dir.o file.o inode.o link.o name.o namei.o super.o
> Index: spadfs-0.9.1/Makefile
> ===================================================================
> --- spadfs-0.9.1.orig/Makefile
> +++ spadfs-0.9.1/Makefile
> @@ -1,19 +1,24 @@
> -ifneq ($(KERNELRELEASE),)
> -else
> -KERNELDIR := /usr/src/linux-`uname -r`/
> +
> +KERNELDIR := /lib/modules/$(shell uname -r)/build
> +
> all : spadfs mkspadfs spadfsck
> +
> spadfs :
> 	$(MAKE) -C $(KERNELDIR) M=`pwd`
> -CFLAGS=-D__NOT_FROM_SPAD -D__NOT_FROM_SPAD_TREE -Wall -fdollars-in-identifiers -O2 -fomit-frame-pointer
> +
> +CFLAGS := -D__NOT_FROM_SPAD -D__NOT_FROM_SPAD_TREE -Wall -fdollars-in-identifiers -O2 -fomit-frame-pointer
> #CC=icc
> #CFLAGS=-D__NOT_FROM_SPAD -D__NOT_FROM_SPAD_TREE
> +
> %.o : %.C
> 	$(CC) $(CFLAGS) -c -o $@ -x c $<
> +
> mkspadfs : MKSPADFS.o SFSAPAGE.o
> 	$(CC) $(CFLAGS) -o $@ $^ && strip $@
> +
> spadfsck : SPAD-API.o FSCK/SCK.o FSCK/SCKALLOC.o FSCK/SCKAPAGE.o FSCK/SCKBUF.o FSCK/SCKCCT.o FSCK/SCKCRT.o FSCK/SCKDIR.o FSCK/SCKEA.o FSCK/SCKFBLK.o FSCK/SCKFILE.o FSCK/SCKFN.o FSCK/SCKFXFN.o FSCK/SCKHDLNK.o FSCK/SCKLOG.o FSCK/SCKRCV.o FSCK/SCKSUPER.o FSCK/SCKXL.o
> 	$(CC) $(CFLAGS) -o $@ $^ && strip $@
> +
> clean :
> -	rm -f *.o *.ko mkspadfs FSCK/*.o spadfsck .*.cmd spadfs.mod.c Modules.symvers
> -	rm -rf .tmp_versions
> -endif
> +	${MAKE} -C ${KERNELDIR} M=$$PWD clean
> +	rm -f *.o mkspadfs FSCK/*.o spadfsck Modules.symvers
> #<EOF>
>
>
> 	-`J'
> -- 
>
