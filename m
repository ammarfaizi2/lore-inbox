Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261476AbSIQOF5>; Tue, 17 Sep 2002 10:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262012AbSIQOF5>; Tue, 17 Sep 2002 10:05:57 -0400
Received: from moutvdom.kundenserver.de ([195.20.224.200]:45053 "EHLO
	moutvdom.kundenserver.de") by vger.kernel.org with ESMTP
	id <S261476AbSIQOF4>; Tue, 17 Sep 2002 10:05:56 -0400
Message-ID: <3D872806.8050907@boich.de>
Date: Tue, 17 Sep 2002 15:03:02 +0200
From: Martin Kreiner <martin@boich.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020412 Debian/0.9.9-6
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: RAM disk image with offset after kernel
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

i'am currently working on a thin-client solution for IBM's 2x00.
with modified bios they are able to load an uncompressed kernel. i would 
like to append a RAM disk image as described in 
../Documentation/ramdisk.txt but rdev can't handle this magic any more?:

---snip
./arch/i386/kernel/setup.c:#define RAMDISK_IMAGE_START_MASK     0x07FF
./arch/i386/kernel/setup.c:#define RAMDISK_PROMPT_FLAG          0x8000
./arch/i386/kernel/setup.c:#define RAMDISK_LOAD_FLAG            0x4000

...

The usage of the word (two bytes) that "rdev -r" sets in the kernel image
has changed. The low 11 bits (0 -> 10) specify an offset (in 1 k blocks)
of up to 2 MB (2^11) of where to find the RAM disk (this used to be the
size). Bit 14 indicates that a RAM disk is to be loaded, and bit 15
indicates whether a prompt/wait sequence is to be given before trying
to read the RAM disk.

...

Use "rdev" to set the boot device, RAM disk offset, prompt flag, etc.
For prompt_ramdisk=1, load_ramdisk=1, ramdisk_start=400, one would
have 2^15 + 2^14 + 400 = 49552.

        rdev /dev/fd0 /dev/fd0
        rdev -r /dev/fd0 49552
--snap

so i tried :

dd if=my_ramdisk_image of=vmlinux bs=1k seek=my_kernel_size+some_space

and changed in ../arch/i386/kernel/setup.c:

-    char c = ' ', *to = command_line, *from = COMMAND_LINE
+    char c = ' ', *to = command_line, *from = strcat(COMMAND_LINE , " 
ramdisk_start=my_kernel_size+some_space");

but in ../init/do_mount.c:

if (ext2sb->s_magic == cpu_to_le16(EXT2_SUPER_MAGIC)

failed, so at boot i get:

RAMDISK: Couldn't find valid RAM disk image starting at 
my_kernel_size+some_space

what's wrong? Superblock?


TIA,

martin kreiner

