Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261509AbSIPN17>; Mon, 16 Sep 2002 09:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261653AbSIPN17>; Mon, 16 Sep 2002 09:27:59 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:34993 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S261509AbSIPN15>; Mon, 16 Sep 2002 09:27:57 -0400
Message-Id: <200209161332.g8GDWfQn238958@pimout3-ext.prodigy.net>
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: David Gibson <david@gibson.dropbear.id.au>,
       Martin Schwenke <martin@meltin.net>
Subject: Re: [PATCH] Pull NFS server address off root_server_path
Date: Mon, 16 Sep 2002 04:32:33 -0400
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
References: <200209120208.MAA00777@thucydides.inspired.net.au> <200209130032.KAA32528@thucydides.inspired.net.au> <20020913013153.GP32156@zax>
In-Reply-To: <20020913013153.GP32156@zax>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 September 2002 09:31 pm, David Gibson wrote:
> On Fri, Sep 13, 2002 at 10:28:29AM +1000, Martin Schwenke wrote:
> > >>>>> "Alan" == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> >
> >     Alan> You are probably much better using the initrd based dhcp
> >     Alan> client from things like the LTSP project (ltsp.org) than the
> >     Alan> kernel one
> >
> > That's probably true in the long term.  For the short term, is the
> > initrd-based stuff working right now?  I didn't think it was quite
> > there yet...
>
> Well, initrd works (as opposed to the still-in-progress initramfs),
> but setting up an image to do the DHCP, NFS mount and pivot_root is a
> pain in the bum.

Is it?  Maybe this template will save a little time.  You'll need to supply a 
new linuxrc script, add your new executables, and possibly new libraries (you 
know the drill: whereis thingy, ldd /path/thingy, see if the list has 
anything new.  The strip technique I'm using follows symlinks nicely...), and 
you may not need losetup, of course. :)


echo --- "Creating image for bootloader ramdisk (initrd)..." &&

dd if=/dev/zero of=ramdisk.img bs=1024 count=3072 &&
mke2fs -b 1024 -F -m 0 ramdisk.img &&
tune2fs -c 0 -i 0 ramdisk.img &&
mkdir ramdisktmp &&
mount -o loop ramdisk.img ramdisktmp &&
cd ramdisktmp &&
rmdir lost+found &&
mkdir dev lib bin var &&

echo --- Creating device nodes... &&

mknod dev/hda1 b 3 1 &&
mknod dev/hda2 b 3 2 &&
mknod dev/hda3 b 3 3 &&
mknod dev/hda4 b 3 4 &&
mknod dev/loop0 b 7 0 &&
mknod dev/console c 5 1 &&
mknod dev/zero c 1 5 &&

echo --- Copying stripped executable files... &&

strip /bin/bash -o bin/bash &&
strip /bin/mount -o bin/mount &&
strip /sbin/losetup -o bin/losetup &&

echo --- Copying stripped libraries... &&

strip /lib/libc.so.6 -o lib/libc.so.6 &&
strip /lib/libncurses.so.5 -o lib/libncurses.so.5 &&
strip /lib/libdl.so.2 -o lib/libdl.so.2 &&
strip /lib/ld-linux.so.2 -o lib/ld-linux.so.2 &&

chmod +x lib/* &&

echo --- Writing ramdisk boot script... &&

cat > linuxrc << EOF &&
#!/bin/bash

mount -n /dev/$VAR /var
losetup /dev/loop0 /var/local/firmware/$DATE/zisofs.img
EOF
chmod +x linuxrc &&

echo --- Compressing ramdisk image... &&

cd .. &&
umount ramdisktmp &&
rmdir ramdisktmp &&
gzip -9 ramdisk.img

if [ $? -ne 0 ]; then exit 1; fi
