Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129299AbRBNVT6>; Wed, 14 Feb 2001 16:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131175AbRBNVTs>; Wed, 14 Feb 2001 16:19:48 -0500
Received: from sync.nyct.net ([216.44.109.250]:56324 "HELO sync.nyct.net")
	by vger.kernel.org with SMTP id <S129299AbRBNVTm>;
	Wed, 14 Feb 2001 16:19:42 -0500
Date: Wed, 14 Feb 2001 16:22:22 -0500
From: Michael Bacarella <mbac@nyct.net>
To: linux-kernel@vger.kernel.org
Subject: Trying to fix 3dfx.o + question about char drivers..
Message-ID: <20010214162222.A19995@sync.nyct.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So, I upgrade to 2.4.0 and it's cool, except that I can't do
anything neat with my voodoo3 anymore. I've been looking
for a solution for weeks but to no avail. 3dfx's web site
looks like it's gone and nothing on lk about it.

[ By all means, if someone has fixed this, do let me know ]

Tracing the Glide test programs shows that ioctl() is returning
-EPERM. Compiling the driver with 'make debug' shows:

[  To aid in the confusion, my machine's hostname is 'mmap' ]

[ insmod 3dfx.o ]
Feb 14 15:08:14 mmap kernel: 3dfx: Entering init_module()
Feb 14 15:08:14 mmap kernel: 3dfx: Successfully registered device 3dfx
Feb 14 15:08:14 mmap kernel: 3dfx: board vendor 4634 type 5 located at de000000/

[ ./test3Dfx ]
Feb 14 15:08:29 mmap kernel: 3dfx: Entering mmap_3dfx
Feb 14 15:08:29 mmap kernel: 3dfx: Couldn't match address 0 to a card
Feb 14 15:08:29 mmap kernel: 3dfx: Entering release_3dfx

mmap_3dfx is being called before ioctl_3dfx is ever reached. Looking
to make heads of the "Couldn't match address 0 to a card" message, I
stuck in some more debugging output:

[ VM_OFFSET is #define VM_OFFSET(vma) (vma->vm_pgoff << PAGE_SHIFT) ]

Feb 14 15:08:29 mmap kernel: 3dfx: Entering mmap_3dfx
Feb 14 15:08:29 mmap kernel: 3dfx: Entering decode_vma:
Feb 14 15:08:29 mmap kernel: 3dfx: start = c1270640, end = c5e40840
Feb 14 15:08:29 mmap kernel: 3dfx: offset = 0 (VM_OFFSET = 0)
Feb 14 15:08:29 mmap kernel: 3dfx: Leaving decode_vma
Feb 14 15:08:29 mmap kernel: 3dfx: compare de000000 or e2000000 to 0
Feb 14 15:08:29 mmap kernel: 3dfx: Couldn't match address 0 to a card
Feb 14 15:08:29 mmap kernel: 3dfx: Entering release_3dfx

Sure stumped me. By my guess, it seems that mmap_3dfx is provided by
the char driver so that a userland process can map a region of (video?)
memory on the card.

The process calls ioctl() after opening /dev/3dfx. That ioctl() triggers
an mmap() call, the driver gets addresses it's totally not expecting,
and it returns -EPERM.

Why does mmap get called first?? Am I reading this right?

-- 
Michael Bacarella <mbac@nyct.net>
Technical Staff / System Development,
New York Connect.Net, Ltd.
