Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261238AbSIWM74>; Mon, 23 Sep 2002 08:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261242AbSIWM74>; Mon, 23 Sep 2002 08:59:56 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:20159 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S261238AbSIWM7y>;
	Mon, 23 Sep 2002 08:59:54 -0400
Date: Mon, 23 Sep 2002 15:05:04 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200209231305.PAA18718@harpo.it.uu.se>
To: axboe@suse.de
Subject: Re: 2.5.37 broke the floppy driver
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Sep 2002 11:10:41 +0200, Jens Axboe wrote:
>On Sun, Sep 22 2002, Mikael Pettersson wrote:
>> With 2.5.37, doing a write to floppy makes the kernel print
>> "blk: request botched" and a few seconds later instantly reboot
>> the machine (w/o any further messages). 2.5.36 works fine.
>> 
>> "dd bs=8k if=bzImage of=/dev/fd0" triggers this every time.
>
>Attached patch should fix the partial completion thing for floppy.
>
># This is a BitKeeper generated patch for the following project:
># Project Name: Linux kernel tree
># This patch format is intended for GNU patch command version 2.5 or higher.
># This patch includes the following deltas:
>#	           ChangeSet	1.601   -> 1.602  
>#	drivers/block/ll_rw_blk.c	1.107   -> 1.108  

It's an improvement (the kernel doesn't reboot as soon as I
read or write /dev/fd0), but there are still some strange
things going on with floppy in 2.5.38 (this all worked in 2.5.36):

1. dd if=/dev/fd0 bs=72k of=/tmp/a
   (after reboot) only reads 2048 bytes; /dev/fd0 is actually 1.44M
2. dd if=/dev/fd0 bs=72k of=/tmp/a
   (repeat the command) now it reads 10 records = 720K,
   which is still only half of the true size
3. dd if=/dev/fd0H1440 bs=72k of=/tmp/a
   oopses in blk_dev.c:do_open() line 676, see below:

(2.5.38 tarball, plain UP config, gcc-2.95.3)

Unable to handle kernel paging request at virtual address 00001738
c01370f0
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c01370f0>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010292
eax: c02fe12c   ebx: c11a02a0   ecx: 00001810   edx: c7b09350
esi: c11a0240   edi: c11a021c   ebp: 00000000   esp: c6c2df10
ds: 0068   es: 0068   ss: 0068
Stack: c7b09350 c6f09aa0 ffffffe9 c114b360 c11a0260 00000000 00000000 c0137276 
       c11a0240 c7b09350 c6f09aa0 c7b09350 c6f09aa0 c7b09350 c0130869 c7b09350 
       c6f09aa0 00000000 c118c000 00008000 bffff9a8 c01307a6 c6c96ca0 c114b360 
Call Trace: [<c0137276>] [<c0130869>] [<c01307a6>] [<c0130b13>] [<c0106dbf>] 
Code: 83 b9 28 ff ff ff 00 75 1f 8b 46 44 ff 48 50 8b 46 44 8d 48 


>>EIP; c01370f0 <do_open+258/344>   <=====

>>eax; c02fe12c <blk_dev+22c/d340>
>>ebx; c11a02a0 <END_OF_CODE+e87c20/????>
>>ecx; 00001810 Before first symbol
>>edx; c7b09350 <END_OF_CODE+77f0cd0/????>
>>esi; c11a0240 <END_OF_CODE+e87bc0/????>
>>edi; c11a021c <END_OF_CODE+e87b9c/????>
>>esp; c6c2df10 <END_OF_CODE+6915890/????>

Trace; c0137276 <blkdev_open+22/28>
Trace; c0130869 <dentry_open+b9/16c>
Trace; c01307a6 <filp_open+52/5c>
Trace; c0130b13 <sys_open+37/78>
Trace; c0106dbf <syscall_call+7/b>

Code;  c01370f0 <do_open+258/344>
00000000 <_EIP>:
Code;  c01370f0 <do_open+258/344>   <=====
   0:   83 b9 28 ff ff ff 00      cmpl   $0x0,0xffffff28(%ecx)   <=====
Code;  c01370f7 <do_open+25f/344>
   7:   75 1f                     jne    28 <_EIP+0x28> c0137118 <do_open+280/344>
Code;  c01370f9 <do_open+261/344>
   9:   8b 46 44                  mov    0x44(%esi),%eax
Code;  c01370fc <do_open+264/344>
   c:   ff 48 50                  decl   0x50(%eax)
Code;  c01370ff <do_open+267/344>
   f:   8b 46 44                  mov    0x44(%esi),%eax
Code;  c0137102 <do_open+26a/344>
  12:   8d 48 00                  lea    0x0(%eax),%ecx

fs/block_dev.c:
static int do_open(struct block_device *bdev, struct inode *inode, struct file *file)
{
	...
	if (bdev->bd_contains == bdev) {
		...
	} else {
		down(&bdev->bd_contains->bd_sem);
		bdev->bd_contains->bd_part_count++;
		if (!bdev->bd_openers) {
			struct gendisk *g = get_gendisk(dev);
			struct hd_struct *p;
BOGUS? ->		p = g->part + minor(dev) - g->first_minor - 1;
			inode->i_data.backing_dev_info =
			   bdev->bd_inode->i_data.backing_dev_info =
			   bdev->bd_contains->bd_inode->i_data.backing_dev_info;
OOPS HERE ->		if (!p->nr_sects) {
				bdev->bd_contains->bd_part_count--;
				up(&bdev->bd_contains->bd_sem);
				ret = -ENXIO;
				goto out2;
			}

I correlated a gdb disassembly with do_open(), and it looks like
'p' got a bogus value (ecx, 0x1810) at the indicated line.

/Mikael
