Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283585AbRLWE30>; Sat, 22 Dec 2001 23:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283438AbRLWE3Q>; Sat, 22 Dec 2001 23:29:16 -0500
Received: from cx340599-a.omhan1.ne.home.com ([24.22.140.45]:38407 "EHLO
	kaitain.obix.com") by vger.kernel.org with ESMTP id <S283581AbRLWE3D>;
	Sat, 22 Dec 2001 23:29:03 -0500
Subject: [PATCH] 2.4.17 compile error + fix
From: Phil Brutsche <pbrutsch@tux.creighton.edu>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-DTSMJGfkh+oduYIxGq60"
X-Mailer: Evolution/1.0 (Preview Release)
Date: 22 Dec 2001 22:28:56 -0600
Message-Id: <1009081736.968.0.camel@fury>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-DTSMJGfkh+oduYIxGq60
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Compiling 2.4.17 on a Debian woody machine generates errors:

ld -m elf_i386 -T /usr/src/linux/arch/i386/vmlinux.lds -e stext
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o
init/version.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o
mm/mm.o fs/fs.o ipc/ipc.o \
         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o
drivers/net/net.o drivers/media/media.o drivers/char/drm/drm.o
drivers/net/appletalk/appletalk.o drivers/ide/idedriver.o
drivers/scsi/scsidrv.o drivers/cdrom/driver.o drivers/pci/driver.o
drivers/video/video.o drivers/usb/usbdrv.o drivers/input/inputdrv.o
drivers/md/mddev.o \
        net/network.o \
        /usr/src/linux/arch/i386/lib/lib.a /usr/src/linux/lib/lib.a
/usr/src/linux/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
drivers/usb/usbdrv.o: In function `alloc_uhci':
drivers/usb/usbdrv.o(.text.init+0x363): undefined reference to
`uhci_pci_remove'
make: *** [vmlinux] Error 1

The same kernel tree builds fine under Debian potato & RH 7.x.

This patch seems to fix it (also attached in case my email client screws
up it up):

diff -urN linux/drivers/usb/usb-uhci.c
linux-2.4.17-modified/drivers/usb/usb-uhci.c
--- linux/drivers/usb/usb-uhci.c        Fri Dec 21 11:41:55 2001
+++ linux-2.4.17-modified/drivers/usb/usb-uhci.c        Sat Dec 22
22:10:27 2001
@@ -3001,7 +3001,7 @@
        s->irq = irq;

        if(uhci_start_usb (s) < 0) {
-               uhci_pci_remove(dev);
+               __devexit_p (uhci_pci_remove(dev));
                return -1;
        }

The resulting kernel boots fine on a PII; there are no problems with
hot-plugging USB devices.

Marcelo, please consider for 2.4.18.


Phil

--=-DTSMJGfkh+oduYIxGq60
Content-Disposition: attachment; filename=2.4.17-patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; charset=ISO-8859-1

diff -urN linux/drivers/usb/usb-uhci.c linux-2.4.17-modified/drivers/usb/us=
b-uhci.c
--- linux/drivers/usb/usb-uhci.c	Fri Dec 21 11:41:55 2001
+++ linux-2.4.17-modified/drivers/usb/usb-uhci.c	Sat Dec 22 22:10:27 2001
@@ -3001,7 +3001,7 @@
 	s->irq =3D irq;
=20
 	if(uhci_start_usb (s) < 0) {
-		uhci_pci_remove(dev);
+		__devexit_p (uhci_pci_remove(dev));
 		return -1;
 	}
=20

--=-DTSMJGfkh+oduYIxGq60--

