Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135284AbRDZKui>; Thu, 26 Apr 2001 06:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135293AbRDZKu2>; Thu, 26 Apr 2001 06:50:28 -0400
Received: from hank-fep6-0.inet.fi ([194.251.242.201]:58273 "EHLO
	fep06.tmt.tele.fi") by vger.kernel.org with ESMTP
	id <S135284AbRDZKuP>; Thu, 26 Apr 2001 06:50:15 -0400
Message-ID: <3AE7FCDE.C5B3385@pp.inet.fi>
Date: Thu, 26 Apr 2001 13:47:58 +0300
From: Jari Ruusu <jari.ruusu@pp.inet.fi>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19aa2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Herbert Valerio Riedel <hvr@hvrlab.org>
CC: linux-crypto@nl.linux.org, linux-kernel@vger.kernel.org, ak@suse.de,
        axboe@suse.de, astor@fast.no
Subject: Re: Announce: cryptoapi-2.4.3 [aka international crypto (non-)patch]
In-Reply-To: <Pine.LNX.4.33.0104251552320.14365-100000@janus.txd.hvrlab.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Valerio Riedel wrote:
> On Tue, 24 Apr 2001, Jari Ruusu wrote:
> > Have you tested that code with partitions or files that are larger than
> > 4 gigs? On systems where int is 32 bits, that computation overflows.
> you're right, I actually had it right in the first place, but stupidly
> rewrote it to overflow C:-)
> 
> it should have been more or less:
> 
> unsigned long IV = loop_get_iv(lo,
>   page->index * (PAGE_CACHE_SIZE >> LO_IV_SECTOR_BITS)
>   + (offset - lo->lo_offset) >> LO_IV_SECTOR_BITS));

I hope not exactly like that. What happens when "lo->lo_offset" is larger
than "offset". Oops. Besides, the + operator takes precedence over the >>
operator on the third line.

> > If you want 512 byte based IV computation without modifying your kernel at
> > all, you can use the loop.o module from my loop-AES package. I haven't tried
> > using your modules based cryptoapi and my loop-AES drivers together, but I
> > don't see any obvious reason why they couldn't be used simultaneously.
> 
> erm... I've looked at your patch... you do just the same thing as I do, as
> it concerns 'changing the kernel'... but you do it in a 'static' way... I
> want it to be changeable at runtime... and letting the way open to add
> more IV calculation variants in the future, which every filter can choose
> among at initialization...

Have you ever observed the sizes of the transfer requests? The sizes of
transfer requests change on the fly (and I'm not not talking about the last
partial block of a file). Meaning, any IV computation that depends on the
block size of a filesystem, is broken and must die! We do not have an option
here.

Just for the record, loop-AES package does 512 byte based IV and does not
care about filesystem block size. loop-AES package does not change kernel
sources and is almost immune to kernel source changes made by distro
vendors. Look, here I'm building loop-AES on almost vanilla 2.2.19aa2.

# make LINUX_SOURCE=/usr/src/linux-2.2.19aa2
cd /usr/src/linux-2.2.19aa2 && make SUBDIRS=/root/loop-AES-v1.1b modules
make[1]: Entering directory `/usr/src/linux-2.2.19aa2'
make -C  /root/loop-AES-v1.1b CFLAGS="-Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -fno-strength-reduce -mpreferred-stack-boundary=2 -march=i686 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686 -DMODULE" MAKING_MODULES=1 modules
make[2]: Entering directory `/root/loop-AES-v1.1b'
cc -D__KERNEL__ -I/usr/src/linux-2.2.19aa2/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -fno-strength-reduce -mpreferred-stack-boundary=2 -march=i686 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686 -DMODULE -c aes-glue.c -o aes-glue.o
cc -D__KERNEL__ -I/usr/src/linux-2.2.19aa2/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -fno-strength-reduce -mpreferred-stack-boundary=2 -march=i686 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686 -DMODULE -c rijndael.c -o rijndael.o
rm -f patched-loop.c
cp /usr/src/linux-2.2.19aa2/drivers/block/loop.c patched-loop.c
patch -p0 -l --dry-run < loop.c-2.2.diff || cp loop.c-2.2.original patched-loop.c
patching file `patched-loop.c'
patch -p0 -l < loop.c-2.2.diff
patching file `patched-loop.c'
cc -D__KERNEL__ -I/usr/src/linux-2.2.19aa2/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -fno-strength-reduce -mpreferred-stack-boundary=2 -march=i686 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686 -DMODULE -DEXPORT_SYMTAB -c patched-loop.c -o patched-loop.o
ld -m elf_i386 -r patched-loop.o aes-glue.o rijndael.o -o loop.o
mkdir -p /lib/modules/2.2.19aa2/block
cp -p loop.o /lib/modules/2.2.19aa2/block
depmod
sync
make[2]: Leaving directory `/root/loop-AES-v1.1b'
make[1]: Leaving directory `/usr/src/linux-2.2.19aa2'

Result: Working loop.o module with AES cipher built in, and 512 byte IV.

Here I'm building loop-AES on 2.2.19aa2-bad where I intentionally changed
loop.c in a way that makes the loop-AES patch fail, but Makefile has a
working plan B.

# make LINUX_SOURCE=/usr/src/linux-2.2.19aa2-bad
cd /usr/src/linux-2.2.19aa2-bad && make SUBDIRS=/root/loop-AES-v1.1b modules
make[1]: Entering directory `/usr/src/linux-2.2.19aa2-bad'
make -C  /root/loop-AES-v1.1b CFLAGS="-Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -fno-strength-reduce -mpreferred-stack-boundary=2 -march=i686 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686 -DMODULE" MAKING_MODULES=1 modules
make[2]: Entering directory `/root/loop-AES-v1.1b'
cc -D__KERNEL__ -I/usr/src/linux-2.2.19aa2-bad/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -fno-strength-reduce -mpreferred-stack-boundary=2 -march=i686 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686 -DMODULE -c aes-glue.c -o aes-glue.o
cc -D__KERNEL__ -I/usr/src/linux-2.2.19aa2-bad/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -fno-strength-reduce -mpreferred-stack-boundary=2 -march=i686 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686 -DMODULE -c rijndael.c -o rijndael.o
rm -f patched-loop.c
cp /usr/src/linux-2.2.19aa2-bad/drivers/block/loop.c patched-loop.c
patch -p0 -l --dry-run < loop.c-2.2.diff || cp loop.c-2.2.original patched-loop.c
patching file `patched-loop.c'
Hunk #1 FAILED at 256.
1 out of 2 hunks FAILED -- saving rejects to patched-loop.c.rej
patch -p0 -l < loop.c-2.2.diff
patching file `patched-loop.c'
cc -D__KERNEL__ -I/usr/src/linux-2.2.19aa2-bad/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -fno-strength-reduce -mpreferred-stack-boundary=2 -march=i686 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686 -DMODULE -DEXPORT_SYMTAB -c patched-loop.c -o patched-loop.o
ld -m elf_i386 -r patched-loop.o aes-glue.o rijndael.o -o loop.o
mkdir -p /lib/modules/2.2.19aa2/block
cp -p loop.o /lib/modules/2.2.19aa2/block
depmod
sync
make[2]: Leaving directory `/root/loop-AES-v1.1b'
make[1]: Leaving directory `/usr/src/linux-2.2.19aa2-bad'

Result: Working loop.o module with AES cipher built in, and 512 byte IV.

Here I'm building loop-AES on vanilla 2.4.3-ac14.

# make LINUX_SOURCE=/usr/src/linux-2.4.3-ac14
cd /usr/src/linux-2.4.3-ac14 && make SUBDIRS=/root/loop-AES-v1.1b modules
make[1]: Entering directory `/usr/src/linux-2.4.3-ac14'
make -C  /root/loop-AES-v1.1b CFLAGS="-D__KERNEL__ -I/usr/src/linux-2.4.3-ac14/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE" MAKING_MODULES=1 modules
make[2]: Entering directory `/root/loop-AES-v1.1b'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.3-ac14/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -c aes-glue.c -o aes-glue.o
gcc -D__KERNEL__ -I/usr/src/linux-2.4.3-ac14/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -c rijndael.c -o rijndael.o
rm -f patched-loop.c
cp /usr/src/linux-2.4.3-ac14/drivers/block/loop.c patched-loop.c
patch -p0 -l --dry-run < loop.c-2.4.diff || cp loop.c-2.4.original patched-loop.c
patching file `patched-loop.c'
patch -p0 -l < loop.c-2.4.diff
patching file `patched-loop.c'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.3-ac14/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DEXPORT_SYMTAB -c patched-loop.c -o patched-loop.o
ld -m elf_i386 -r patched-loop.o aes-glue.o rijndael.o -o loop.o
mkdir -p /lib/modules/2.4.3-ac14/block
cp -p loop.o /lib/modules/2.4.3-ac14/block
depmod
sync
make[2]: Leaving directory `/root/loop-AES-v1.1b'
make[1]: Leaving directory `/usr/src/linux-2.4.3-ac14'

Result: Working loop.o module with AES cipher built in, and 512 byte IV.

Here I'm building loop-AES on 2.4.3-ac14-hvr5 with your kernel patch
cryptoapi-2.4.3-hvr5/doc/loop-iv-2.4.3.patch applied, which makes the
loop-AES patch fail, but Makefile has a working plan B.

# make LINUX_SOURCE=/usr/src/linux-2.4.3-ac14-hvr5
cd /usr/src/linux-2.4.3-ac14-hvr5 && make SUBDIRS=/root/loop-AES-v1.1b modules
make[1]: Entering directory `/usr/src/linux-2.4.3-ac14-hvr5'
make -C  /root/loop-AES-v1.1b CFLAGS="-D__KERNEL__ -I/usr/src/linux-2.4.3-ac14-hvr5/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE" MAKING_MODULES=1 modules
make[2]: Entering directory `/root/loop-AES-v1.1b'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.3-ac14-hvr5/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -c aes-glue.c -o aes-glue.o
gcc -D__KERNEL__ -I/usr/src/linux-2.4.3-ac14-hvr5/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -c rijndael.c -o rijndael.o
rm -f patched-loop.c
cp /usr/src/linux-2.4.3-ac14-hvr5/drivers/block/loop.c patched-loop.c
patch -p0 -l --dry-run < loop.c-2.4.diff || cp loop.c-2.4.original patched-loop.c
patching file `patched-loop.c'
Hunk #1 FAILED at 181.
Hunk #2 FAILED at 232.
Hunk #3 FAILED at 466.
Hunk #4 succeeded at 519 (offset 17 lines).
Hunk #5 succeeded at 1000 (offset 1 line).
Hunk #6 succeeded at 1030 (offset 17 lines).
3 out of 6 hunks FAILED -- saving rejects to patched-loop.c.rej
patch -p0 -l < loop.c-2.4.diff
patching file `patched-loop.c'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.3-ac14-hvr5/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DEXPORT_SYMTAB -c patched-loop.c -o patched-loop.o
ld -m elf_i386 -r patched-loop.o aes-glue.o rijndael.o -o loop.o
mkdir -p /lib/modules/2.4.3-ac14/block
cp -p loop.o /lib/modules/2.4.3-ac14/block
depmod
sync
make[2]: Leaving directory `/root/loop-AES-v1.1b'
make[1]: Leaving directory `/usr/src/linux-2.4.3-ac14-hvr5'

Result: Working loop.o module with AES cipher built in, and 512 byte IV.

Regards,
Jari Ruusu <jari.ruusu@pp.inet.fi>
