Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751087AbVIWFoj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbVIWFoj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 01:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbVIWFoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 01:44:39 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:45978 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S1751087AbVIWFoi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 01:44:38 -0400
In-Reply-To: <20050922214940.5ab30894.rdunlap@xenotime.net>
References: <CE56193B-A4BB-4557-87C0-BFCC6B9E7E5B@freescale.com> <20050922214940.5ab30894.rdunlap@xenotime.net>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <669340F6-17D1-487D-A055-374077E96500@freescale.com>
Cc: <sam@ravnborg.org>, <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: kernel buildsystem error/warning?
Date: Fri, 23 Sep 2005 00:44:53 -0500
To: "Randy.Dunlap" <rdunlap@xenotime.net>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sep 22, 2005, at 11:49 PM, Randy.Dunlap wrote:

> On Thu, 22 Sep 2005 08:45:35 -0500 Kumar Gala wrote:
>
>
>> Sam,
>>
>> I was wondering if anyone else is seeing the following error/warning
>> when building a recent kernel.  This error seems to have been
>> introduced between 2.6.13 and 2.6.14-rc1:
>>
>>    CHK     include/linux/version.h
>>    CHK     include/linux/compile.h
>>    CHK     usr/initramfs_list
>> /bin/sh: line 1: +@: command not found
>>    CHK     include/linux/compile.h
>>    UPD     include/linux/compile.h
>>    CC      init/version.o
>>    LD      init/built-in.o
>>    LD      vmlinux
>>    SYSMAP  System.map
>>
>>
>> I'm building a cross compiled ARCH ppc kernel on an x86 host.  I
>> tried using git bisect to track down the error but for some reason it
>>
>
>
>> ended up referencing a change before 2.6.13 which I really dont
>> understand.
>>
>> Anyways, let me know if you need more info on this.
>>
>
> I don't see the error message.  Do you have anything (added) to
> usr/initramfs_list ?  (of course, the error messsage doesn't have
> to be coming from that file at all)

Nope. Hmm, after a little more debug it appears to be an issue with  
"if_changed_rule" in scripts/Kbuild.include. If I remove the '@' in  
front of the "set -e" I get the following:

   CHK     include/linux/version.h
   CHK     include/linux/compile.h
   CHK     usr/initramfs_list
set -e;         +@ echo '  GEN     .version' && set -e; if [ ! - 
r .version ]; then rm -f .version; echo 1 >.version; else  
mv .version .old_version; expr 0$(cat .old_version) + 1 >.version;  
fi; make -f scripts/Makefile.build obj=init
/bin/sh: line 1: +@: command not found
   CHK     include/linux/compile.h
   UPD     include/linux/compile.h
set -e;           echo '  CC      init/version.o'; powerpc-unknown- 
linux-gnu-gcc -m32 -Wp,-MD,init/.version.o.d  -nostdinc -isystem / 
_TOOLS_/dist/gnu-gcc-3.4.3-binutils-2.15-powerpc-unknown-linux-gnu/ 
i686-pc-linux2.4/lib/gcc/powerpc-unknown-linux-gnu/3.4.3/include - 
D__KERNEL__ -Iinclude  -Iarch/ppc -Iarch/ppc/include -Wall -Wundef - 
Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common - 
ffreestanding -O2     -fomit-frame-pointer -Iarch/ppc -msoft-float - 
pipe -ffixed-r2 -mmultiple -Wa,-me500 -Wdeclaration-after- 
statement     -DKBUILD_BASENAME=version -DKBUILD_MODNAME=version -c - 
o init/version.o init/version.c;  scripts/basic/fixdep  
init/.version.o.d init/version.o 'powerpc-unknown-linux-gnu-gcc -m32 - 
Wp,-MD,init/.version.o.d  -nostdinc -isystem /_TOOLS_/dist/gnu- 
gcc-3.4.3-binutils-2.15-powerpc-unknown-linux-gnu/i686-pc-linux2.4/ 
lib/gcc/powerpc-unknown-linux-gnu/3.4.3/include -D__KERNEL__ - 
Iinclude  -Iarch/ppc -Iarch/ppc/include -Wall -Wundef -Wstrict- 
prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common - 
ffreestanding -O2     -fomit-frame-pointer -Iarch/ppc -msoft-float - 
pipe -ffixed-r2 -mmultiple -Wa,-me500 -Wdeclaration-after- 
statement     -DKBUILD_BASENAME=version -DKBUILD_MODNAME=version -c - 
o init/version.o init/version.c' > init/.version.o.tmp; rm -f  
init/.version.o.d; mv -f init/.version.o.tmp init/.version.o.cmd
   CC      init/version.o
   LD      init/built-in.o
   LD      vmlinux
   SYSMAP  System.map

I'm guessing the +@ echo... is what's getting me, not to figure out  
why that's happening.

- kumar

