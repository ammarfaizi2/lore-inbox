Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271498AbRIAXlS>; Sat, 1 Sep 2001 19:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271487AbRIAXlI>; Sat, 1 Sep 2001 19:41:08 -0400
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:39154 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S271498AbRIAXlC>; Sat, 1 Sep 2001 19:41:02 -0400
Message-Id: <5.1.0.14.2.20010902003236.03e28740@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 02 Sep 2001 00:41:15 +0100
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [RFC] lazy allocation of struct block_device
Cc: Andries.Brouwer@cwi.nl, viro@math.psu.edu, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
In-Reply-To: <20010901222659.A4089@thefinal.cern.ch>
In-Reply-To: <200109012042.UAA17644@vlet.cwi.nl>
 <200109012042.UAA17644@vlet.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 22:26 01/09/2001, Jamie Lokier wrote:
>Andries.Brouwer@cwi.nl wrote:
> >[...]
> > However, a union is not so bad. It seems a pity to avoid unions
> > and waste 4 bytes for every inode with separate i_bdev and i_cdev
> > instead of a single i_bcdev.
>
>Please, a union of different pointer types is much nicer.  You can have
>i_bdev and i_cdev without wasting any bytes.
>
>This form works with GCC 2.96:
>
>                 union {
>                         struct char_device * i_cdev;
>                         struct block_device * i_bdev;
>                 };

It sure does. One of the nicest new gcc features IMHO!

>If you're using a really old compiler that doesn't support anonymous unions,
>(GCC 2.95 might be in this category, I'm not sure),

GCC 2.95 does NOT support this. I only found out after I had people 
complain to me that Linux-NTFS userspace tools would not compile for them 
and it turned out they were using gcc-2.95... and I 2.96. - I have since 
then verified this myself:

egcs and gcc up to 2.95 do not support unnamed structs/unions.

gcc-2.96 and gcc-3.0 support them fine.

>  then you'll need this:
>
>         #define i_bdev __i_bcdev_union.i_bdev
>         #define i_cdev __i_bcdev_union.i_cdev
>                 union {
>                         struct char_device * i_cdev;
>                         struct block_device * i_bdev;
>                 } __i_bcdev_union;

Neat trick! Thanks! I was wondering what to do with NTFS TNG driver (which 
uses unnamed structs/unions extensively) and this just might solve my 
problems without having to rewrite half the driver... (-;

Best regards,

         Anton


-- 
   "Nothing succeeds like success." - Alexandre Dumas
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

