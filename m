Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbTHBLxN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 07:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbTHBLxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 07:53:13 -0400
Received: from smtp-out1.blueyonder.co.uk ([195.188.213.4]:46785 "EHLO
	smtp-out1.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S261151AbTHBLxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 07:53:10 -0400
Message-ID: <3F2BA623.6030906@cn.stir.ac.uk>
Date: Sat, 02 Aug 2003 12:53:07 +0100
From: Bernd Porr <Bernd.Porr@cn.stir.ac.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: linux-kernel@vger.kernel.org, comedi@comedi.org
Subject: Re: compiling external kernel modules (comedi.org)
References: <3F2B0E06.9000907@cn.stir.ac.uk> <20030802070422.GA2404@mars.ravnborg.org>
In-Reply-To: <20030802070422.GA2404@mars.ravnborg.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Aug 2003 11:53:08.0425 (UTC) FILETIME=[A40B8390:01C358EC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok. Thanks. Now the bug is that comedi cannot find the file "Rules.make" 
which is apparently no longer there in 2.6. Is it right that the rules 
are now integrated in the corresponding makefiles?

Can you recommend me a Makefile which I can take as a template? Comedi 
uses some sort of autoconfig and I have to append then the "rules" to 
the automatically generated makefile.

Another thing: can a prevent the kernel of generating the "Stage 2"? It 
would be nice if the kernel doen't need to write to it's own directories 
if it compiles external modules. The best thing would be that one could 
compile external modules as a normal user and then only at the end 
becomes root. In my case this would be convenient as my home is a NFS 
directory which does not allow compiling as root. However the kernel 
modules at the end are stored on a root writable directory.

/Bernd

--------------------------------------------------------------------------------
removed the Rules.make includes from the comedi Makefiles:

2.4.21: only to test. Comedi cannot compile since an evil programmer has 
removed Rules.make.

snoopy:/home/bp1/c/usb/comedi/comedi# make -C /usr/src/linux 
SUBDIRS=$PWD V=1 modules
make: Entering directory `/usr/src/linux-2.4.21'
make -C  /home/bp1/c/usb/comedi/comedi CFLAGS="-D__KERNEL__ 
-I/usr/src/linux-2.4.21/include -Wall -Wstrict-prototypes -Wno-trigraphs 
-O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe 
-mpreferred-stack-boundary=2 -march=athlon -DMODULE -DMODVERSIONS 
-include /usr/src/linux-2.4.21/include/linux/modversions.h" 
MAKING_MODULES=1 modules
make[1]: Entering directory `/home/bp1/c/usb/comedi/comedi'
make[1]: *** No rule to make target `modules'.  Stop.
make[1]: Leaving directory `/home/bp1/c/usb/comedi/comedi'
make: *** [_mod_/home/bp1/c/usb/comedi/comedi] Error 2
make: Leaving directory `/usr/src/linux-2.4.21'

2.6.21: Comedi compiles without error since the kernel expects the 
Makefile to trigger the make of modules which is no longer there.

snoopy:/home/bp1/c/usb/comedi/comedi# make -C /usr/src/linux-2.6.0-test2 
SUBDIRS=$PWD V=1 modules
make: Entering directory `/usr/src/linux-2.6.0-test2'
make -f scripts/Makefile.build obj=scripts
make -f scripts/Makefile.build obj=arch/i386/kernel 
arch/i386/kernel/asm-offsets.s
make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
*** Warning: Overriding SUBDIRS on the command line can cause
***          inconsistencies
mkdir -p .tmp_versions
make -f scripts/Makefile.build obj=/home/bp1/c/usb/comedi/comedi
scripts/Makefile.build:27: kbuild: 
/home/bp1/c/usb/comedi/comedi/Makefile - Usage of export-objs is 
obsolete in 2.5. Please fix!
make -f scripts/Makefile.build obj=/home/bp1/c/usb/comedi/comedi/drivers
scripts/Makefile.build:27: kbuild: 
/home/bp1/c/usb/comedi/comedi/drivers/Makefile - Usage of export-objs is 
obsolete in 2.5. Please fix!
make -f scripts/Makefile.build obj=/home/bp1/c/usb/comedi/comedi/kcomedilib
scripts/Makefile.build:27: kbuild: 
/home/bp1/c/usb/comedi/comedi/kcomedilib/Makefile - Usage of export-objs 
is obsolete in 2.5. Please fix!
  Building modules, stage 2.
make -rR -f scripts/Makefile.modpost
  scripts/modpost vmlinux drivers/net/pcmcia/3c574_cs.o 
drivers/net/pcmcia/3c589_cs.o drivers/net/8139cp.o drivers/net/8139too.o

------------------------

Sam Ravnborg wrote:

>On Sat, Aug 02, 2003 at 02:04:06AM +0100, Bernd Porr wrote:
>  
>
>>Hi all,
>>
>>I'm trying to compile comedi on 2.6-test2. The very naive way (with 
>>configure) does not work (as expected). However, comedi conforms 
>>(mainly) to the kernel makefile convention. So I tried this:
>>
>>make -C /usr/src/linux-2.6.0-test2 
>>SUBDIRS=/home/bp1/c/usb/2.6/comedi/comedi/ V=1
>>    
>>
>
>When compiling modules use:
>make -C /usr/src/linux-2.6.0-test2 SUBDIRS=$PWD V=1 modules
>See the added "modules" target.
>
>	Sam
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>

-- 
http://www.cn.stir.ac.uk/~bp1/
mailto:bp1@cn.stir.ac.uk



