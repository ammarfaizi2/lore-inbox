Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292269AbSBBMef>; Sat, 2 Feb 2002 07:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292270AbSBBMe0>; Sat, 2 Feb 2002 07:34:26 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:34826 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S292269AbSBBMeJ>; Sat, 2 Feb 2002 07:34:09 -0500
Message-Id: <200202021232.g12CWat01313@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Subject: Re: [PATCH] Re: crc32 and lib.a (was Re: [PATCH] nbd in 2.5.3 does
Date: Sat, 2 Feb 2002 14:32:38 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020131.145904.41634460.davem@redhat.com> <E16WQYs-0003Ux-00@the-village.bc.nu> <20020131232119.GN10772@conectiva.com.br>
In-Reply-To: <20020131232119.GN10772@conectiva.com.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 31 January 2002 21:21, Arnaldo Carvalho de Melo wrote:
> Em Thu, Jan 31, 2002 at 11:24:10PM +0000, Alan Cox escreveu:
> > What I'd much rather see if this is an issue is:
> >
> > bool	'Do you want to customise for a very small system'
> >
> > which auto enables all the random small stuff if you say no, and goes
> > much deeper into options if you say yes.
>
> heh, after I've read that you managed to boot 2.4 + rmap in a machine with
> just 4 MB after tweaking some table sizes I thought about devoting some
> time to identify those tables and making them options in make *config, with
> even a nice CONFIG_TINY, like you said 8)
>
> I'll eventually do this, and I'd appreciate if people send me suggestions
> of tables/data structures that can be trimmed/reduced. Yeah, I'll take a
> look at the .config files used in the embedded distros.

One of inhabitants of my "Don't delete!" mail folder:

Re: Limited RAM - how to save it?
 From: Lars Brinkhoff <lars.spam@nocrew.org>
 To: Jan-Benedict Glaw <jbglaw@microdata-pos.de>
 Cc: linux-kernel@vger.kernel.org
 
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

mm/Makefile, mm/swapfile.c, mm/swap_state.c, mm/noswapfile.c, 
mm/noswap_state.c

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
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

