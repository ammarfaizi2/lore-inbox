Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129168AbQKAAF7>; Tue, 31 Oct 2000 19:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129455AbQKAAFu>; Tue, 31 Oct 2000 19:05:50 -0500
Received: from zeus.kernel.org ([209.10.41.242]:55568 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130049AbQKAAFe>;
	Tue, 31 Oct 2000 19:05:34 -0500
Message-ID: <39FF60D2.8FE0E42E@intel.com>
Date: Tue, 31 Oct 2000 16:16:18 -0800
From: Randy Dunlap <randy.dunlap@intel.com>
X-Mailer: Mozilla 4.51 [en] (X11; I; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Keith Owens <kaos@ocs.com.au>, Jeff Garzik <jgarzik@mandrakesoft.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test10-pre7 (LINK ordering)
In-Reply-To: <Pine.LNX.4.10.10010311257510.22165-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
[snip]
> 
> That was going to be my next question if somebody actually said "sure".
> 
> The question was rhetorical, since the way LINK_FIRST is implemented
> means
> that it has all the same problems that $(obj-y) has, and is hard to get
> right in the generic case (but you can get it trivially right for the
> subset case, like for USB).


So now we have something in 2.4.0-test10, but there's
still a problem.  Help is appreciated^W wanted. !!!

With CONFIG_USB=y and all other USB modules built as
modules (=m), linking usbdrv.o into the kernel image
gives this:

ld -m elf_i386 -T /work/linsrc/240-test10/arch/i386/vmlinux.lds -e stext
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o
init/version.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o
mm/mm.o fs/fs.o ipc/ipc.o \
        drivers/block/block.o drivers/char/char.o drivers/misc/misc.o
drivers/net/net.o drivers/media/media.o drivers/parport/parport.a 
drivers/ide/idedriver.o drivers/scsi/scsidrv.o drivers/cdrom/cdrom.a
drivers/sound/sounddrivers.o drivers/pci/pci.a drivers/video/video.o
drivers/usb/usbdrv.o drivers/input/inputdrv.o drivers/i2c/i2c.o \
        net/network.o \
        /work/linsrc/240-test10/arch/i386/lib/lib.a
/work/linsrc/240-test10/lib/lib.a
/work/linsrc/240-test10/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
drivers/usb/usbdrv.o(.data+0x2f4): undefined reference to
`__this_module'
make: *** [vmlinux] Error 1
[rdunlap@dragon linux]$ 


I believe that this is caused by drivers/usb/inode.c:

static DECLARE_FSTYPE(usbdevice_fs_type, "usbdevfs",
usbdevfs_read_super, 0);

in which this macro uses "THIS_MODULE".  inode.c already #includes
module.h.  What else does it need to do?
(inode.c is part of the usbcore in this case, so it shouldn't be
compiled with -DMODULE.)

Help ?!?

~Randy
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
