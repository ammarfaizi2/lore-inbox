Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317221AbSGNX3N>; Sun, 14 Jul 2002 19:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317217AbSGNX3M>; Sun, 14 Jul 2002 19:29:12 -0400
Received: from amsfep12-int.chello.nl ([213.46.243.17]:65338 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id <S317221AbSGNX3J>; Sun, 14 Jul 2002 19:29:09 -0400
Subject: [PATCH] 2.4.19-rc1 compile/link error (was: Re: 2.4.19-pre10 link
	error - cpqarray related ?)
From: Filip Sneppe <filip.sneppe@yucom.be>
To: Adrian Bunk <bunk@fs.tum.de>, Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org, arrays@compaq.com
In-Reply-To: <Pine.NEB.4.44.0206181035480.7375-100000@mimas.fachschaften.tu-muenchen.de>
References: <Pine.NEB.4.44.0206181035480.7375-100000@mimas.fachschaften.tu-muenchen.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 15 Jul 2002 01:43:56 +0200
Message-Id: <1026690236.594.20.camel@exile>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

2.4.19-rc1 still requires Adrian's fix to compile/link properly with
CONFIG_BLK_CPQ_*=y and a recent binutils:

--- drivers/block/cpqarray.c.old        Tue Jun 18 10:19:55 2002
+++ drivers/block/cpqarray.c    Tue Jun 18 10:30:27 2002
@@ -602,7 +602,7 @@
 static struct pci_driver cpqarray_pci_driver = {
         name:   "cpqarray",
         probe:  cpqarray_init_one,
-        remove:  cpqarray_remove_one,
+        remove:  __devexit_p(cpqarray_remove_one),
         id_table:  cpqarray_pci_device_id,
 };


Error from make bzImage:

make[2]: Leaving directory
`/home/sneppef/kernel/linux-2.4.19-rc1/arch/i386/lib'
make[1]: Leaving directory
`/home/sneppef/kernel/linux-2.4.19-rc1/arch/i386/lib'
ld -m elf_i386 -T
/home/sneppef/kernel/linux-2.4.19-rc1/arch/i386/vmlinux.lds -e stext
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o
init/version.o init/do_mounts.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o
mm/mm.o fs/fs.o ipc/ipc.o \
         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o
drivers/net/net.o drivers/media/media.o drivers/ide/idedriver.o
drivers/cdrom/driver.o drivers/pci/driver.o drivers/video/video.o
drivers/md/mddev.o \
        net/network.o \
        /home/sneppef/kernel/linux-2.4.19-rc1/arch/i386/lib/lib.a
/home/sneppef/kernel/linux-2.4.19-rc1/lib/lib.a
/home/sneppef/kernel/linux-2.4.19-rc1/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
drivers/block/block.o(.data+0xc54): undefined reference to `local
symbols in discarded section .text.exit'
make: *** [vmlinux] Error 1


Kind regards,
Filip



On Tue, 2002-06-18 at 10:42, Adrian Bunk wrote:
> On 18 Jun 2002, Filip Sneppe wrote:
> 
> > Hi,
> 
> Hi Filip,
> 
> first of all thanks for your report!
> 
> > I ran into some problems doing a "make bzImage" on 2.4.19-pre10:
> >...
> > drivers/block/block.o(.data+0xc54): undefined reference to `local
> > symbols in discarded section .text.exit'
> > make: *** [vmlinux] Error 1
> >...
> > After looking at the changelog and my kernel options, I found that
> > the compilation failed when:
> >
> > CONFIG_BLK_CPQ_DA=y
> > CONFIG_BLK_CPQ_CISS_DA=y
> >...
> 
> 
> The following patch fixes it (cpqarray_remove_one is __devexit but the
> pointer to it didn't use __devexit_p):
> 
> 
> --- drivers/block/cpqarray.c.old	Tue Jun 18 10:19:55 2002
> +++ drivers/block/cpqarray.c	Tue Jun 18 10:30:27 2002
> @@ -602,7 +602,7 @@
>  static struct pci_driver cpqarray_pci_driver = {
>          name:   "cpqarray",
>          probe:  cpqarray_init_one,
> -        remove:  cpqarray_remove_one,
> +        remove:  __devexit_p(cpqarray_remove_one),
>          id_table:  cpqarray_pci_device_id,
>  };
> 
> 
> 
> > Kind regards,
> > Filip
> >...
> 
> cu
> Adrian
> 
> -- 
> 
> You only think this is a free country. Like the US the UK spends a lot of
> time explaining its a free country because its a police state.
> 								Alan Cox
> 
> 
> 




