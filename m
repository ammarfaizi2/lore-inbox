Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267054AbRGXH7E>; Tue, 24 Jul 2001 03:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267055AbRGXH6z>; Tue, 24 Jul 2001 03:58:55 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:12557 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267054AbRGXH6k>; Tue, 24 Jul 2001 03:58:40 -0400
To: linux-kernel@vger.kernel.org
Cc: xinyuepeng@yahoo.com
Subject: Re: How to change the root filesystem
In-Reply-To: <20010724055530.33747.qmail@web20004.mail.yahoo.com>
From: Daniel Quinlan <quinlan@transmeta.com>
Date: 24 Jul 2001 00:58:38 -0700
In-Reply-To: =?gb2312?q?=D0=C2=20=D4=C2?='s message of "Tue, 24 Jul 2001 13:55:30 +0800 (CST)"
Message-ID: <6yu20269n5.fsf@sodium.transmeta.com>
X-Mailer: Gnus v5.7/Emacs 20.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

xinyuepeng@yahoo.com writes:

> I want change the root filesystem from ext2 to cramfs, I read the
> init code about the filesystem.  But I cannot understand how to make
> a device that is used as cramfs device.

(I asked: "desktop system?"  Reply: "No! embedded system!"  So, here's
the answer.)

cramfs should work out of the box as the root filesystem.  I'm not
sure what you mean by "make a device".  cramfs is meant to be used on
a block device like ext2 such as /dev/hda1.

If you want to include the kernel on the root filesystem, it's a bit
more complicated.

Option 1

  - use Midori Linux: http://midori.transmeta.com/

Option 2

You need a few things:

  - linux 2.4.7 kernel
  - mkcramfs version from linux 2.4.7
  - cramfsboot (part of Midori Linux) which is located here:
    http://midori.transmeta.com/pub/midori-1.0.0-beta2/apps/
    (includes an MBR, the cramfs secondary loader, set_boot, and
    make_active)

Run mkcramfs with a command line of something like:

  mkcramfs -E -p -i bzImage -z root root.img.cram

where bzImage is the kernel, root is the directory to cram, and
root.img.cram is the output.  Actually, it's worse than that because
cramfsboot wants the kernel to start 1024 bytes from the beginning of
the partition.

  dd if=/dev/zero of=bzImage.padded bs=436c count=1
  cat bzImage >> bzImage.padded
  mkcramfs -E -p -i bzImage.padded -z root roott.img.cram
  cp cramfsboot.bin root1.img.cram	# from cramfsboot
  tail +513c roott.img.cram >> root1.img.cram
  cramfsck root1.img.cram
  set_boot root1.img.cram 1
  rm roott.img.cram

Then root1.img.cram can be put on the first partition of say a Compact
Flash or other IDE device.  You will need to use the MBR that's
included with cramfsboot and don't forget to set the active flag (the
cramfsboot MBR uses it).

This code is a much-simplified version of what's in the Midori Linux
"mlbuild" package.  (I haven't tried the simplified version, so if you
need more help, please refer to the mlbuild package, same location as
the cramfsboot package.)

It sounds like you're just getting started on your embedded system,
though, so I'd strongly recommend looking at what's out there.  Midori
Linux makes heavy use of cramfs, but a bunch of the other offerings
also use cramfs.

- Dan
