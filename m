Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268589AbTGTWAK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 18:00:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268644AbTGTWAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 18:00:10 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:11539 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S268589AbTGTWAF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 18:00:05 -0400
Date: Mon, 21 Jul 2003 00:15:03 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Hielke Christian Braun <hcb@unco.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1 cryptoloop & aes & xfs
Message-ID: <20030721001503.A11447@pclin040.win.tue.nl>
References: <20030720005726.GA735@jolla> <20030720103852.A11298@pclin040.win.tue.nl> <20030720213803.GA777@jolla>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030720213803.GA777@jolla>; from hcb@unco.de on Sun, Jul 20, 2003 at 02:38:03PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 20, 2003 at 02:38:03PM -0700, Hielke Christian Braun wrote:

> Thanks for the tip. With util-linux-2.12 i can setup the device.
> 
> So the new cryptoloop in 2.6.0 is incompatible to the one in the
> international crypto patch?

I have not investigated. But at least the way to transmit the passphrase
is very different. These out-of-kernel patch sets also come with
patches for util-linux. Usually the resulting patched losetup uses
some cryptographically strong digest algorithm to transform the
passphrase into the byte array sent to the kernel.

But I left all crypto out of mount and losetup in util-linux 2.12.
On the one hand we already have crypto in the kernel - no need to
duplicate that. But on the other hand, the preparation of the passphrase
has also been left out. The only handle put into mount/losetup is the
ability to read from a specified file descriptor.
So, today, you would need something like

% get_passphrase | mount -o loop,encryption=aes -p0 dev dir

where get_passphrase is a separate, to be written, utility that reads
the passphrase and digestifies.

Maybe I'll make things a bit friendlier in 2.12a, for example with

% mount -o loop,encryption=aes,getpw=/usr/local/bin/get_passwd dev dir

where mount itself forks off a process that produces the password.
Comments (and code) are welcome.

> I could not access my old data. So i created a new one. But when 
> i copy some data onto it, i get: 
> 
> XFS mounting filesystem loop5
> Ending clean XFS mount for filesystem: loop5
> xfs_force_shutdown(loop5,0x8) called from line 1070 of file fs/xfs/xfs_trans.c. Return address = 0xc02071ab
> Filesystem "loop5": Corruption of in-memory data detected. Shutting down filesystem: loop5
> Please umount the filesystem, and rectify the problem(s)
>  
> To setup, i did this:
> 
> losetup -e aes /dev/loop5 /dev/hda4
> mkfs.xfs /dev/hda4

Wait! /dev/loop5 is your block device, and /dev/hda4 is the file it is setup on.
Now behind the back of loop you fiddle with /dev/hda4. No surprise that fails.

Andries

