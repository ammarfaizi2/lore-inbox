Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267048AbRGSH6K>; Thu, 19 Jul 2001 03:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267053AbRGSH6B>; Thu, 19 Jul 2001 03:58:01 -0400
Received: from sun.rhrk.uni-kl.de ([131.246.137.50]:17863 "HELO
	sun.rhrk.uni-kl.de") by vger.kernel.org with SMTP
	id <S267048AbRGSH5u>; Thu, 19 Jul 2001 03:57:50 -0400
Date: Thu, 19 Jul 2001 09:57:50 +0200
From: Martin Vogt <mvogt@rhrk.uni-kl.de>
To: linux-kernel@vger.kernel.org
Subject: kernel 2.4.6 segfault in scsi sr.c
Message-ID: <20010719095750.B36012@rhrk.uni-kl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,


I have an Adaptec AIC-7881U (rev 1) controller and kernel 2.4.6.
When I try to mount a CD the kernel segfaults.
This is the lines it prints:

>sr0: unsupported sector size 2336.

And then not so usefull things like:

>Unable to handle kernel NULL pointer dereference at virtual address 00000018
> printing eip:
>c683a61f
>*pde = 00000000
>Oops: 0000
[.....]

I have looked in the source code:

drivers/scsi/sr.c:


In line 604 begins a switch statement:

                switch (sector_size) {
                case 0:   
                case 2340:
                case 2352:
                        sector_size = 2048;
                        /* fall through */
                case 2048:
                        scsi_CDs[i].capacity *= 4;
                        /* fall through */
                case 512:
                        break;
                default:
kernel message -->      printk("sr%d: unsupported sector size %d.\n",
                               i, sector_size);
                        scsi_CDs[i].capacity = 0;
                        scsi_CDs[i].needs_sector_size = 1;

//
// here it still has the "wrong" sector_size
//
                }

                scsi_CDs[i].device->sector_size = sector_size;

// and here it stores it.

I think that the "unsupported" sector size then leads to a segfault
somewhere later in the code.

Martin


