Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278218AbRKFHDR>; Tue, 6 Nov 2001 02:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278225AbRKFHDI>; Tue, 6 Nov 2001 02:03:08 -0500
Received: from junk.nocrew.org ([212.73.17.42]:50816 "EHLO junk.nocrew.org")
	by vger.kernel.org with ESMTP id <S278218AbRKFHC4>;
	Tue, 6 Nov 2001 02:02:56 -0500
To: Jan-Benedict Glaw <jbglaw@microdata-pos.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Limited RAM - how to save it?
In-Reply-To: <20011105125231.A3783@microdata-pos.de>
From: Lars Brinkhoff <lars.spam@nocrew.org>
Organization: nocrew
Date: 06 Nov 2001 07:58:31 +0100
In-Reply-To: <20011105125231.A3783@microdata-pos.de>
Message-ID: <85wv14s7vs.fsf@junk.nocrew.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan-Benedict Glaw <jbglaw@microdata-pos.de> writes:
> I'm working on a 4MB linux system (for a customer) which has quite
> limited resources [...] If you've got further ideas on getting the
> kernel a bit smaller, would be nice to get a mail dropped...

I started a port of Linux 2.3.99 to a MIPS device which usually has 2M
flash and 4M RAM.

To reduce the size of the text and data sections, I sorted the output
of the "size" command and investigated the files with the largest
sections.

These are the memory-saving changes I arrived at.  They are not really
tested, so some of them may break some functionality.  Also, I don't
know whether they apply to the current kernels.

fs/dcache.c

        Changed HASH_BITS from 14 to 8.  This reduces the size of the
        cache from 128K to 2K.

fs/inode.c

        Changed HASH_BITS from 14 to 8.  This reduces the size of the
        cache from 128K to 2K.

include/linux/blk.h

        Changed NR_REQUEST from 256 to 16.  This reduces the number of
        requests that can be queued.  The size of the queue is reduced
        from 16K to 1K.

include/linux/major.h

        Changed MAX_BLKDEV and MAX_CHRDEV from 256 to 10 and 20,
        respectively.  This reduces the number of block and character
        devices and saves about 40K.

kernel/printk.c

        Changed LOG_BUF_LEN from 16384 bytes to 2048 bytes.

include/linux/tty.h

        Changed NR_PTYS and NR_LDISCS from 256 and 16, respectively,
        to 16 and 4, respectively.  Saved about 12K.

        Warning: this change may break the pty driver, in which case
        further modifications will have to be done to
        drivers/char/pty.c.

kernel/panic.c

        Changed a buffer from 1024 bytes to 200 bytes.

include/linux/sched.h

        Changed PIDHASH_SZ from 1024 to 16, which saves 1008 bytes.

include/linux/mmzone.h

        NR_GPFINDEX from 0x100 to 0x10.  Saves 4800 bytes, but I'm not
        sure it doesn't break anything.

net/Makefile, net/socket.c, net/nosocket.c

        Replacing socket.c with nosocket.c, a file containing dummy
        replacement functions for those in socket.c, saves about 24K.

        Warning: this disables the socket API entirely, but it is
        currently not used in the product.

mm/Makefile, mm/swapfile.c, mm/swap_state.c, mm/noswapfile.c, mm/noswap_state.c

        Replacing swapfile.c with noswapfile.c, and swap_state.c with
        noswap_state.c saves about 12K.  The no*.c files contains
        empty replacement functions.

        Warning: this disables swapping of anonymous memory, which
        isn't used in the product.  But note that demand paging of
        executables still works.

mm/Makefile, mm/mmap.c

        The functions in mmap.c could probably also be replaced by
        empty functions.  Estimated saving: 9K (not included in the
        grand total below).

*, CONFIG_MESSAGES

        Applying the CONFIG_MESSAGES patch and disabling all kernel
        messages saves about 80K.

        The CONFIG_MESSAGES patch was written by Graham Stoney
        <greyham@research.canon.com.au>.

With all of the above, and only this enabled in .config:
        CONFIG_EXPERIMENTAL=y
        CONFIG_CPU_R3000=y
        CONFIG_CPU_LITTLE_ENDIAN=y
        CONFIG_ELF_KERNEL=y
        CONFIG_BINFMT_ELF=y
        CONFIG_MODULES=y
        CONFIG_MODVERSIONS=y
        CONFIG_KMOD=y
        CONFIG_CROSSCOMPILE=y
, the kernel is down to about 550K.

Here is the output of "size vmlinux".  I think this is without the
CONFIG_MESSAGES patch (it was long since I worked with this).

text    data    bss     dec     hex     filename
572128  41964   15860   629952  99cc0   vmlinux

-- 
Lars Brinkhoff          http://lars.nocrew.org/     Linux, GCC, PDP-10
Brinkhoff Consulting    http://www.brinkhoff.se/    programming
