Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264143AbTKLT0a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 14:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264147AbTKLT0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 14:26:30 -0500
Received: from mailer.scri.fsu.edu ([144.174.128.142]:26683 "EHLO
	mailer.csit.fsu.edu") by vger.kernel.org with ESMTP id S264143AbTKLT02
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 14:26:28 -0500
Date: Wed, 12 Nov 2003 14:26:28 -0500
From: Charles Mason <mason@csit.fsu.edu>
To: zippel@linux-m68k.org, linux-kernel@vger.kernel.org
Subject: HFS bug
Message-ID: <20031112192627.GA3331@imap.csit.fsu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This may or may not be a bug, but I figured that sending out the message
would do better good than not sending one out at all:

when I run the command:

# mount -t hfs /dev/scd0 /mnt/cdrom 

The kernel gives an Oops that traces back to line buffer.c:2555 (kernel
version 2.4.23-pre1). I'd attach the Oops output, but I'm on a remote
machine now.

The BUG() macro is called because the block size requested to be read by
HFS (512 bytes) is not the same as the hardware block size set by the
SCSI drivers (2048 by default).  grow_buffers() wants whatever called it
to request a blocksize that is a multiple of get_hardsect_size().

I would have bothered myself to write a fix, since I firmly believe that
a CD could have an HFS filesystem, but the kernel code has grown so
complex that writing the code to perform the reads correctly would be
difficult.

My idea was to change buffer.c:2555 to just modify the requested block
size to fit the hardware block size, then return an offset into a buffer
where that requested (sub)block is.  For example, if you're requesting
512 bytes but the hardsect size is 2048.  Read a 2048 block, and offset
the buffer to (block_no % 4) * 512.  This may have worked, but it could
possibly have been slow too.

By the way, the offending code is the hfs/super.c:hfs_read_super() that
traces to hfs/sysdep.c:hfs_buffer_get() which calls sb_bread() and
further then to buffer.c:grow_buffers().  hfs_read_super() sets
mdb->s_blocksize to 512.  sb_bread will use the hardsect_size set by the
SCSI driver (drivers/scsi/sr.c:sr_init()).

Alas, if this information helps out, let me know -- I'm not on any
kernel mailing list.  Further information about my system is attached.

Sincerely,
Charles Mason
mason@csit.fsu.edu


Kernel: Linux 2.4.23-pre1 (generally tained with the nvidia module)
Hardware:  AMD XP 2500+ / 1GB RAM / nVidia mainboard/chipset
Distribution: Debian unstable

