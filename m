Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267200AbTCEPWv>; Wed, 5 Mar 2003 10:22:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267204AbTCEPWv>; Wed, 5 Mar 2003 10:22:51 -0500
Received: from meryl.it.uu.se ([130.238.12.42]:6879 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id <S267200AbTCEPWq>;
	Wed, 5 Mar 2003 10:22:46 -0500
From: Mikael Pettersson <mikpe@user.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15974.6329.574794.597753@gargle.gargle.HOWL>
Date: Wed, 5 Mar 2003 16:33:13 +0100
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unable to boot a raw kernel image :??
In-Reply-To: <b453er$qo7$1@cesium.transmeta.com>
References: <20021129132126.GA102@DervishD>
	<3DF08DD0.BA70DA62@gmx.de>
	<b453er$qo7$1@cesium.transmeta.com>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin writes:
 > Followup to:  <3DF08DD0.BA70DA62@gmx.de>
 > By author:    Edgar Toernig <froese@gmx.de>
 > In newsgroup: linux.dev.kernel
 > > 
 > > I had this problem a while ago.  It turned out to be a (widespread)
 > > BIOS bug triggered be the disk-size probe of the kernel's boot loader.
 > > 
 > 
 > It's not a bug, really.  The fact of the matter is that the disk
 > geometry probe in bootsect.S pretty much only works for legacy
 > floppies... no IDE floppies, no USB floppies, no virtual floppies.
 > 
 > That, and the 1 MB limitation, is the reason it either needs to get
 > nuked or get some massive surgery.  I am currently trying to get Linus
 > to accept a patch to put it out of its misery.

FWIW, I still use bzdisk images frequently, and the 1MB limit really
is a serious problem for 2.5 kernels, and 2.4 kernels build with gcc-3.
I'm currently using a patched kernel where `make bzdisk' invokes a
user-specified script, which in my case goes roughly like:

===snip===
BOOTIMAGE=$1
LIBDIR=/home/mikpe/pkgs/linux-x86/make-zdisk/lib
FDIMAGE=/tmp/fdimage.$$
MTOOLSRC=/tmp/mtools.conf.$$

cat > $MTOOLSRC << EOF
drive v:
        file="$FDIMAGE" cylinders=80 heads=2 sectors=18 filter
EOF

dd if=/dev/zero bs=72k count=20 of=$FDIMAGE
MTOOLSRC=$MTOOLSRC mformat v:
MTOOLSRC=$MTOOLSRC mcopy $LIBDIR/ldlinux.sys v:
MTOOLSRC=$MTOOLSRC mcopy $BOOTIMAGE v:linux
dd bs=512 count=1 conv=notrunc if=$LIBDIR/bootsect.img of=$FDIMAGE

dd bs=72k if=$FDIMAGE of=/dev/fd0
===snip===

The latest mtools are supposed to have direct support for image files,
which should eliminate the MTOOLSRC kludge.

All I'm really missing is a version of syslinux that understands enough
of MS-DOS FS layout to populate the FS and update the boot block without
having to mount the damn thing. That would eliminate the ldlinux.sys and
bootsect.img files, which I extracted from a syslinux-prepared floppy.

You can kill bootsect.S right now, IF you allow a user-specified script
to control how the boot floppy is prepared. Something like:

zdisk: $(BOOTIMAGE)
	make-zdisk.sh $(BOOTIMAGE)

should be enough.

/Mikael
