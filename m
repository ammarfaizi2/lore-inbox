Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270695AbTHSOz2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 10:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270703AbTHSOz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 10:55:28 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:3482 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP id S270695AbTHSOzJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 10:55:09 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: gkajmowi@tbaytel.net, linux-kernel@vger.kernel.org
Subject: Re: Initramfs confusion
Date: Tue, 19 Aug 2003 04:14:09 -0400
User-Agent: KMail/1.5
References: <200308161940.52579.gkajmowi@tbaytel.net>
In-Reply-To: <200308161940.52579.gkajmowi@tbaytel.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308190414.10317.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 16 August 2003 19:40, Garrett Kajmowicz wrote:
> I am just begining to test out 2.6 with an eye on use by X-terminals
> without hard drives or NFS. As such I am quite enthusiastic about
> initramfs.  After much stumbling around I created a root image that I would
> like to test, compiled into kernel and created image.
>
> I am doing testing under VMWare with 2.88 MB floppy images (for testing
> purposes), but lilo is barfing trying to write to a regular file as a raw
> device (doesn't know how to handle device 0x0700).
>
> I cannot use a real floppy because I do not have any 2.88 MB floppies
>
> Any suggestions?
>
> Thanks for the help.
>
> Garrett Kajmowicz
> gkajmowi@tbaytel.net

Here's a big cut and paste from a script of mine that does a lot of this gorp 
automatically while creating a bootable CD image.

Let me know if I missed something from the snip.  (I do remember there was 
some head scratching back when I was first figuring this out... :)

There are a number of assumptions baked into this script (I.E. earlier on an 
empty directory named sub (I.E. the sub directory) was created for use as a 
mount point, that sort of thing.  Shouldn't be too hard to figure out...)

Rob

echo === "Create a 2.88 meg floppy image (CD emulates floppy when booting)..."

rm -f floppy.img &&
dd if=/dev/zero of=floppy.img bs=512 count=5760 &&

echo === Format and mount it... &&

mke2fs -N 24 -m 0 -F floppy.img &&
tune2fs -c 0 -i 0 floppy.img &&
losetup /dev/loop7 floppy.img &&
mount /dev/loop7 sub &&

echo === Write lilo.conf for bootable CD... &&

rm -rf sub/lost+found &&
cat > sub/lilo.conf << EOF &&
boot=/dev/loop7
disk=/dev/loop7
        bios=0x00
        cylinders=80
        heads=2
        sectors=36
install=/boot.b
map=/map
backup=/dev/null
compact
geometric
image=/bzImage
        label=linux
        root=/dev/loop7
        initrd=ramdisk.img.gz
        read-write
EOF

echo === "Copy other data (kernel, ramdisk, dev, etc)..." &&

cat /boot/boot.b > sub/boot.b &&
cat /boot/vmlinuz > sub/bzImage &&
mv ramdisk.img.gz sub &&
mkdir sub/dev &&
cp -R /dev/{null,loop7} sub/dev &&
mkdir sub/tmp &&

echo === Run lilo to make image bootable.... &&

lilo -v -C lilo.conf -r sub &&
umount sub &&
losetup -d /dev/loop7

if [ $? -ne 0 ]; then exit 1; fi



> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


