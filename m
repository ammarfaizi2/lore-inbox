Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264498AbRFYMrq>; Mon, 25 Jun 2001 08:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264492AbRFYMrg>; Mon, 25 Jun 2001 08:47:36 -0400
Received: from t111.niisi.ras.ru ([193.232.173.111]:10018 "EHLO
	t111.niisi.ras.ru") by vger.kernel.org with ESMTP
	id <S264451AbRFYMrW>; Mon, 25 Jun 2001 08:47:22 -0400
Message-ID: <3B37A32C.9020604@niisi.msk.ru>
Date: Mon, 25 Jun 2001 16:46:36 -0400
From: Alexandr Andreev <andreev@niisi.msk.ru>
Organization: niisi
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.3 i686; en-US; rv:0.9) Gecko/20010507
X-Accept-Language: ru, en
MIME-Version: 1.0
To: Qingbo Wu <wuqb@china.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: about mips linux root file system
In-Reply-To: <20010602080540Z262119-932+3811@vger.kernel.org>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Qingbo Wu wrote:

>
>I think if I can use ramdisk using serail port. I do not know
>how to combine kernel image with ramdisk root file image.
>And where can I get small size root file image for mipsel?
>If someone knows, please help me.
>Thanks in advance!
>
There is a way which i use.

Take a look at the arch/mips/ld.script linker commandfile. As you can 
see, you
need to create an ELF binary with the ".initrd" section, and link this 
binary
into your kernel. You must put your initial ramdisk into this section. 
There are
ext2fs, romfs, gzipped ext2fs and minixfs ramdisks currently supported.

Here is an example with gzipped ramdisk for MIPS linux-2.4.x :

NOTE:
the 'disk' directory is assumed your root filesystem directory, which 
you going
to be using on your mips

1) First of all, you need the properly MIPS linux kernel:
cvs -d :pserver:cvs@oss.sgi.com:/cvs -z9 co linux

2) Add new target to your specific Makefile (i mean 
arch/mips/xxxx/Makefile):

...
obj-$(CONFIG_BLK_DEV_INITRD)    += ramdisk.o
...
ramdisk.c:    ramdisk.bin
       $(CC) $(CFLAGS) -c -o $@ $<
       $(OBJCOPY) --add-section=.initrd=ramdisk.bin $@
...

3) Create the root filesystem gzipped image and copy it to your specific
location:

# dd if=/dev/zero of=ramdisk bs=1k count=4096
# mke2fs -Fvm0 ramdisk 4096
# mount -o loop ramdisk /tmp/ram
# cp -a disk/* /tmp/ram/
# umount /tmp/ram/
# dd if=ramdisk bs=1k count=4096 | gzip -v9 > ramdisk.bin
# cp ramdisk.bin linux/arch/mips/xxxx/

4) Compile the kernel
# cd linux
# make

... I think that's all

Regards.



