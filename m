Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282222AbRK2AiD>; Wed, 28 Nov 2001 19:38:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282223AbRK2Ah5>; Wed, 28 Nov 2001 19:37:57 -0500
Received: from mail018.mail.bellsouth.net ([205.152.58.38]:59016 "EHLO
	imf18bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S282222AbRK2Ahl>; Wed, 28 Nov 2001 19:37:41 -0500
Message-ID: <3C05834F.13C60B0C@mandrakesoft.com>
Date: Wed, 28 Nov 2001 19:37:35 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David C. Hansen" <haveblue@us.ibm.com>
CC: Russell King <rmk@arm.linux.org.uk>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove BKL from drivers' release functions
In-Reply-To: <E169EFX-0006TA-00@the-village.bc.nu> <3C057410.3090201@us.ibm.com> <20011128234505.C2561@flint.arm.linux.org.uk> <3C0580A8.5030706@us.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David C. Hansen" wrote:
> 
> Russell King wrote:
> 
> >On Wed, Nov 28, 2001 at 03:32:32PM -0800, David C. Hansen wrote:
> >
> >>Nothing, because the BKL is not held for all opens anymore.  In most of
> >>the cases that we addressed, the BKL was in release _only_, not in open
> >>at all.  There were quite a few drivers where we added a spinlock, or
> >>used atomic operations to keep open from racing with release.
> >>
> >
> >All char and block devs are opened with the BKL held - see chrdev_open in
> >fs/devices.c and do_open in fs/block_dev.c
> >
> I wrote a quick and dirty char device driver to see if this happened.
>  If I run two tasks doing a bunch of opens and closes, the -EBUSY
> condition in the open function does happen.  Is my driver doing
> something wrong?
> 
> Here is the meat of the driver:
> 
> static int Device_Open = 0;
> 
> int testdev_open(struct inode *inode,  struct file *file)
> {
>   if ( test_and_set_bit(0,&Device_Open) )    {
>       printk( "attempt to open testdev more than once\n" );
>       return -EBUSY;
>     }
>   MOD_INC_USE_COUNT;
>   return SUCCESS;
> }
> 
> int testdev_release(struct inode *inode,  struct file *file)
> {
>   clear_bit(0,&Device_Open);
>   MOD_DEC_USE_COUNT;
>   return 0;
> }

it is still racy, that's why struct file_operations and other structs
have an 'owner' member......

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

