Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129725AbRAEQbx>; Fri, 5 Jan 2001 11:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129911AbRAEQbn>; Fri, 5 Jan 2001 11:31:43 -0500
Received: from mailout1-1.nyroc.rr.com ([24.92.226.146]:7892 "EHLO
	mailout1-1.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S129725AbRAEQb0>; Fri, 5 Jan 2001 11:31:26 -0500
Message-ID: <3A55F6DB.24041B4C@rochester.rr.com>
Date: Fri, 05 Jan 2001 11:31:23 -0500
From: Chris Kloiber <ckloiber@rochester.rr.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-ac1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] VESA framebuffer w/ MTRR locks 2.4.0 on init
In-Reply-To: <E14EZMf-0007vp-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > 1)  The amount of video memory is being incorrectly reported my the VESA call
> > used in arch/i386/video.S (INT 10h AX=4f00h).  My Dell Inspiron 3200 (NeoMagic
> > video) returns that it has 31 64k blocks of video memory, instead of the
> > correct 32.  This means that vesafb thinks that I've got 1984k of video ram,
> 
> You have 31. The last one is used for audio buffering
> 
> > 2)  When the vesafb goes to mtrr_add its range (with the incorrect 1984k size)
> > mtrr_add fails with -EINVAL.  The code in vesafb_init then goes into a while
> > loop with no exit, as each size mtrr fails.
> >                  while (mtrr_add(video_base, temp_size, MTRR_TYPE_WRCOMB,
> > 1)==-EINVAL) {
> >                          temp_size >>= 1;
> >                  }
> 
> Ok that one is the bug.

Possibly related symptoms:

kernel 2.4.0-ac1 compiled with gcc version 2.96 20000731 (Red Hat Linux
7.0)

last 2 lines in dmesg output:
mtrr: 0xd8000000,0x2000000 overlaps existing 0xd8000000,0x1000000
mtrr: 0xd8000000,0x2000000 overlaps existing 0xd8000000,0x1000000

cat /proc/mtrr
reg00: base=0x00000000 (   0MB), size= 256MB: write-back, count=1
reg01: base=0xd8000000 (3456MB), size=  16MB: write-combining, count=1
reg05: base=0xd0000000 (3328MB), size=  64MB: write-combining, count=1
 

My video card is Voodoo3/3000/AGP and my motherboard is an MSI-6330
(Athlon Tbird 800)
I am experiencing text console video corruption. In tdfxfb mode or
regular vesafb it looks like a horizontal line of color pixels that
grows, in 'regular' text mode I get flashing characters or the font
degrades into unreadable mess. X is fine.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
