Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129458AbQLLRiY>; Tue, 12 Dec 2000 12:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129738AbQLLRiO>; Tue, 12 Dec 2000 12:38:14 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:2064 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S129458AbQLLRiC>;
	Tue, 12 Dec 2000 12:38:02 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Niels Kristian Bech Jensen <nkbj@image.dk>
Date: Tue, 12 Dec 2000 18:06:51 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: 2.4.0-test12 not liking high disk i/o
CC: <linux-kernel@vger.kernel.org>
X-mailer: Pegasus Mail v3.40
Message-ID: <F78B9AA62E2@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Dec 00 at 17:43, Niels Kristian Bech Jensen wrote:
> On Tue, 12 Dec 2000, Mohammad A. Haque wrote:
> 
> > Any one else experiencing problems when they do lots of disk activity
> > in test12?
> >
> Yes, I've had some complete freezes (nothing working at all) in
> test12-pre8 and test12. They can be triggered by e.g. Netscape.
> test12-pre7 seems to be stable.

test12-pre8 deadlocked (but probably livelocked, as NMI watchdog was
not trigerred? or maybe NMI is not trigerred when spinning with interrupts
enabled) on me. One CPU was spinning in 
drivers/char/tty_io.c:do_tty_write:716 in lock_kernel(), another one in
fs/fat/inode.c:fat_write_inode:863 in spin_lock(&fat_inode_lock).
But as I did not found how this could happen, I did not report it
(afaik if you hold fat_inode_lock, you never sleep, not even talking
about invoking fat_write_inode... But maybe I overlooked some codepath).

Of course, I do not have full stack traces of these two offenders, as
I do not have kdb in kernel yet...

It happened when I decided to copy old 18GB IDE disk to new 40GB IDE one
(both UDMA33, one (18GB src) as primary master, one (40GB dst) as 
secondary master; i440BX). 

During copy of 8GB ext2 partition I decided that copying 200MB of data
from VFAT in parallel (and leaving room for a while) with ext2 copy 
should not kill system, so I did it. Unfortunately, it killed it :-( 
ext2 was copied with tar clf - /mnt2 | (cd /new/mnt2 ; tar xf -), vfat 
was copied with midnight commander. From status on screen of mc it looks 
like that deadlock occured after copy, but before screen was refreshed - 
mc showed status 100%, copying last file in root directory of vfat.
vfat contents was copied to same partition as ext2, if that matters.

BTW, what's correct way of loading .o kernel module into gdb? I noticed
that if I create shared module from it (I was doing this up to now),
(mine) ld drops .text.lock section. Have I to use (modified) vmlinux.lds
for linking? (if loaded as relocatable module, all sections begins
at zero, overlapping one over another)
                                        Best regards,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
