Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262348AbTD3TF2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 15:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262351AbTD3TF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 15:05:28 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:50049 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S262348AbTD3TF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 15:05:26 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304301921.h3UJLgCZ001523@81-2-122-30.bradfords.org.uk>
Subject: Re: Bootable CD idea
To: hpa@zytor.com (H. Peter Anvin)
Date: Wed, 30 Apr 2003 20:21:42 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <b8p6b6$tm9$1@cesium.transmeta.com> from "H. Peter Anvin" at Apr 30, 2003 11:57:42 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > [1] I originally thought that the 2.4 kernel's in-built floppy
> > > > bootloader used BIOS calls to access the disk, and that a 2.4 kernel
> > > > image as the El-Torito boot image would work, as the kernel would be
> > > > accessing the emulated disk, but it didn't seem to when I tried it
> > > > just now - it failed with an error saying something along the lines of
> > > > it had run out of data to decompress.
> > > 
> > > when you did "make bzImage", are you sure you didn't get the message about 
> > > the kernel being too big for floppy booting?
> > 
> > No, I've just checked - the same kernel image boots fine from a real floppy.
> > 
> 
> The boot sector bootloader is broken for anything but genuine legacy
> floppies, because it relies on getting the proper sector not found in
> order to determine the geometry.  Most LBA<->CHS conversions -- and
> that includes El Torito, IDE floppies, USB floppies, and just about
> anything else that isn't a classical legacy floppy -- simply spill
> into the next track, confusing bootsect.S.  This is part of why
> bootsect.S is gone in 2.5.

Ah, it makes more sense now :-).  So, could I bodge 2.4 in to working
by modifying bootsect.S with something like this?


        movw    $disksizes+1, %si         # Force 18 sectors/track
probe_loop:
        lodsb
        cbtw                            # extend to word
        xchgw   %cx, %ax                # %cx = track and sector
        xorw    %dx, %dx                # drive 0, head 0
        movw    $0x0200, %bx            # address = 512, in INITSEG (%es = %cs)
        movw    $0x0201, %ax            # service 2, 1 sector
        int     $0x13
        movb    $0x03, %ah              # read cursor pos
        xorb    %bh, %bh

John.
