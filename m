Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267883AbRHASVW>; Wed, 1 Aug 2001 14:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267892AbRHASVN>; Wed, 1 Aug 2001 14:21:13 -0400
Received: from draco.cus.cam.ac.uk ([131.111.8.18]:45311 "EHLO
	draco.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S267883AbRHASU6>; Wed, 1 Aug 2001 14:20:58 -0400
Message-Id: <5.1.0.14.2.20010801181300.00af32f0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 01 Aug 2001 19:21:08 +0100
To: Urban Widmark <urban@teststation.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [PATCH] 2.4.8-pre3 NTFS update (1.1.16)
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.30.0108011135300.9860-100000@cola.teststation.c
 om>
In-Reply-To: <E15Rn2h-0000E5-00@virgo.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Urban,

At 11:40 01/08/2001, Urban Widmark wrote:
>On Wed, 1 Aug 2001, Anton Altaparmakov wrote:
> > - Simplified time conversion functions drastically without
> > sacrificing accuracy, now the offending function is 3 lines instead of
> > two pages of code. (-8
>
>Does this mean I have to change the code I borrowed?
>(Never mind ... :)

You don't _have_ to, but it will remove some nasty code and speed up the 
conversion significantly. I haven't benchmarked it but I can imagine the 
speed up is several fold... (-:

> > +static int to_utf8(ntfs_u16 c, unsigned char *buf)
>
>How is this different from utf8_wctomb in fs/nls/nls_base.c?
>(in purpose)
>
>If it is to allow ntfs_dupuni2utf8 to count the new string length, could
>that be done differently? If there is a max allowed length of filenames
>the "double parsing" can be avoided.

Possibly no difference. I didn't touch this much. You are of course right 
that it can be optimized a lot. The double parsing stroke me as odd, too 
but considering it works, I left it as is for the moment. This patch was a 
"fix it" rather than a "make it fly" one. (-;

The reason for leaving the utf8 built in code was to allow people without 
nls_utf8.o compiled into the kernel / present as a module to be able to use 
utf8 anyway. - It is the only way I can see to get some extended characters 
to work. - The driver now notifies the user via printk(KERN_ERR ...); if it 
finds something and cannot convert it and suggests to the user to use the 
utf8 mount option to be able to access the files. - This is as easy as 
doing a remount -o remount,utf8 of the file system so it is quite nice IMO.

In the future this could allow NTFS to be compiled without NLS support 
being built into the kernel (at the moment NTFS requires NLS but that could 
be changed). - Alternatively, we could just get rid of this altogether and 
tell the user to use iocharset=utf8 and if they don't have it, tough...

>ntfs_printcb -> ntfs_encodeuni -> ntfs_dupuni2utf8 -> to_utf8
>
>ntfs_dupuni2utf8 does a kmalloc, which is later free'd by ntfs_printcb.
>Which in turn is called once for each entry read by ntfs_readdir.
>
>Wouldn't it be nicer to allocate one 255*max_utf8_size buffer in
>ntfs_readdir and use that for all entries. Assuming 255 is the upper limit
>on NTFS filename length, as I read somewhere.

Yes this would be a good optimization, indeed.

>smbfs does something like this, except it allocates a buffer at mount time
>(which works since it is only used while protected by a per-mount lock).

<looks at code>Interesting. I am not sure NTFS will use that kind of lock 
so I would rather not go that far (or at least I would prefer to use an 
rwsemaphore rather than a straight semaphore, which precludes using only 
one buffer per mount). But I will keep it in mind.

Thanks for reviewing the code.

Best regards,

Anton


-- 
   "Nothing succeeds like success." - Alexandre Dumas
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

