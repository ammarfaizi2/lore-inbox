Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262161AbTCMIbs>; Thu, 13 Mar 2003 03:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262194AbTCMIbs>; Thu, 13 Mar 2003 03:31:48 -0500
Received: from noc7.BelWue.de ([129.143.2.15]:17025 "EHLO smtp2.BelWue.DE")
	by vger.kernel.org with ESMTP id <S262161AbTCMIbq>;
	Thu, 13 Mar 2003 03:31:46 -0500
Date: Thu, 13 Mar 2003 09:42:26 +0100 (MET)
From: Oliver Tennert <tennert@science-computing.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel setup() and initrd problems
Message-ID: <Pine.GHP.4.53.0303130942100.16619@alderaan.science-computing.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Seems some more have problems, too. It is possibly related.

> pivot_root() is the currently preferred method. Depending on where
> the initramfs is by the time Linux 2.6 comes out it may be replaced by
> then, but for 2.4, pivot_root() is the way to go.

OK, I am pretty aware of the fact that it is the DOCUMENTED way to go. But
can you tell me ONE SINGLE current distribution using the pivot_root()
call in their initrd to mount the realrootdev?

Have a look at the following linuxrc script:

<SHELLSCRIPT>

#! /bin/sh

export PATH=/bin

echo "Loading module sym53c8xx  ..."
insmod sym53c8xx

echo "Loading module jbd  ..."
insmod jbd

echo "Loading module ext3  ..."
insmod ext3

mount -n -t proc proc /proc
echo 0x0100 > /proc/sys/kernel/real-root-dev   ## <<<---- THIS LINE IS IMPORTANT!!
mount -n -t ext3 /dev/sda4 /mnt
rm -f /mnt/.initrd 2>/dev/null
mkdir -p /mnt/.initrd
cd /mnt
pivot_root . .initrd
umount -n /.initrd/proc
exec sh -c 'umount -n /.initrd ; rmdir /.initrd ; mount -n -oremount,ro /' </dev/console >/dev/console 2>&1

</SHELLSCRIPT>

The fact is, without the "echo 0x0100 ..." line this linuxrc script WILL
NOT be able to mount your root device for kernel >=2.4.19. This is
independent of the distribution used.

So why is that?

I always thought the pivot_root() would make this echo-stuff unnecessary.

The way used by virtually all latest distributions is getting rid of the
pivot stuff altogether, leaving the loading of the modules, and that's it.

Seems totally unclear (and unclean) to me.

best regards

Oliver Tennert





		   Dr. Oliver Tennert

  		   +49 -7071 -9457-598

 		   e-mail: O.Tennert@science-computing.de
  		   science + computing AG
  		   Hagellocher Weg 71
   		   D-72070 Tuebingen


