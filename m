Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316857AbSHJMCK>; Sat, 10 Aug 2002 08:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316860AbSHJMCK>; Sat, 10 Aug 2002 08:02:10 -0400
Received: from purple.csi.cam.ac.uk ([131.111.8.4]:30646 "EHLO
	purple.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S316857AbSHJMCJ>; Sat, 10 Aug 2002 08:02:09 -0400
Message-Id: <5.1.0.14.2.20020810125310.00ae3690@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sat, 10 Aug 2002 13:05:59 +0100
To: "David S. Miller" <davem@redhat.com>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [patch 1/12] misc fixes
Cc: akpm@zip.com.au, torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <20020809.182433.69288385.davem@redhat.com>
References: <3D54647C.DB6DE08A@zip.com.au>
 <3D54647C.DB6DE08A@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 02:24 10/08/02, David S. Miller wrote:
>    From: Andrew Morton <akpm@zip.com.au>
>    Date: Fri, 09 Aug 2002 17:55:24 -0700
>
>    - `retval' should not be initialised to "~0UL" because that is
>      0x00000000ffffffff with 64-bit sector_t.
>
>'0' defaults to 'int' on 32-bit systems so ~0 isn't right either.
>
>What I think you really want is "~(sector_t) 0".

Actually, ~0 is fine. This is because of the associativity of events 
happening. Breaking it down into individual ops as the compiler sees it:

1) constant 0 -> int type
2) ~0 -> (int)-1
3) assign to larger type sector_t -> sign extend smaller type to size of 
larger type -> (sector_t)-1

Therefore not specifying anything after the initial constant definition 
_always_ works because of sign extension and the order of evaluation which 
is guaranteed by the C language.

OTOH if you hard code 0U or 0L or 0UL or whatever it breaks because it 
forces the compiler not to sign extend and assume this to be a hardvalue, 
which is zero extended.

Note I just tried all possible combinations with a little test program and 
both assignments and binary operators work as expected (with sign 
extension) when the constant is given without qualifiers and both break 
horribly (no sign extension) when the constant is given with qualifiers.

I did this testing for another reason, and that is PAGE_MASK and 
PAGE_CACHE_MASK which break when used for 64-bit values on 32-bit 
architectures exactly for the above outlined reasons.

If no one beats me to it I will submit a patch to change PAGE_SIZE (and 
thus automatically PAGE_CACHE_SIZE) on all architectures to no longer use 
the "UL" type qualifier which is responsible for the breakage. This 
supersedes my previous ugly patch introducing a PAGE_{CACHE_,}MASK_LL...

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

