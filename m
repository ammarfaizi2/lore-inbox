Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261579AbVCUF5i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261579AbVCUF5i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 00:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261584AbVCUF5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 00:57:34 -0500
Received: from 206.175.9.210.velocitynet.com.au ([210.9.175.206]:27780 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261579AbVCUF5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 00:57:31 -0500
Subject: Re: Suspend-to-disk woes
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <E1DDAcH-0002n5-00@chiark.greenend.org.uk>
References: <423B01A3.8090501@gmail.com>
	 <20050319132612.GA1504@openzaurus.ucw.cz>
	 <200503191220.35207.rmiller@duskglow.com>
	 <20050319212922.GA1835@elf.ucw.cz> <20050319212922.GA1835@elf.ucw.cz>
	 <1111364066.9720.2.camel@desktop.cunningham.myip.net.au>
	 <E1DDAcH-0002n5-00@chiark.greenend.org.uk>
Content-Type: text/plain
Message-Id: <1111384766.9720.144.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Mon, 21 Mar 2005 16:59:26 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, 2005-03-21 at 11:17, Matthew Garrett wrote:
> Nigel Cunningham <ncunningham@cyclades.com> wrote:
> 
> > Yuck! Why panic when you know what is needed? A better solution is to
> > tell the user they've messed up and given them the option to (1) reboot
> > and try another kernel or (2) have swsusp restore the original swap
> > signature and continue booting. This is what suspend2 does (with a
> > timeout for the prompt). It's not that hard.
> 
> It's trivial to do this in userspace - just have an app in initramfs
> that checks for a swsusp signature, and then compare the kernel
> versions. If they mismatch, prompt for what to do. Putting it in the
> kernel is madness.

It's not that trivial.

- You need to know how to modify your initramfs to do it;
- You might have to (learn how to) set up an initramfs just for this;
- Your image might not be stored in a swap partition. For Suspend2, it
can potentially in a swap file or (soon) an ordinary file;
- Finding which partition to look in for the signature might be non
trivial (labels in fstab). You'd want to hard code it or (perferably)
copy a config file from the root (or other) partition;
- Having addressed the above issues, you still need to add code to read
the swap header, parse it to find the header, read the header from the
image, parse it and obtain the kernel version of the saved image.

If your image is not stored in a swap partition, you probably can't
mount the fs the image is stored on, because doing so will replay the
image and make resuming unsafe, so this approach is less trivial without
knowing exactly which disk blocks and device IDs to use (and using dd to
access them).

On top of these, we have two implementations, so you'll want to check
for the signatures of both.

That said, I am considering making something like what you're saying:
exposing methods of testing whether an image exists and an entry through
which you can get Suspend to erase an image via a proc (eventually
sysfs) entry. This will allow something like what you're saying to be
controlled from userspace.

Regards,

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://suspend2.net

