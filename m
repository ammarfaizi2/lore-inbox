Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263576AbTEDJgm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 05:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263578AbTEDJgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 05:36:42 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:1554 "EHLO www.home.local")
	by vger.kernel.org with ESMTP id S263576AbTEDJgk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 05:36:40 -0400
Date: Sun, 4 May 2003 11:49:00 +0200
From: Willy TARREAU <willy@w.ods.org>
To: Thomas Backlund <tmb@iki.fi>
Cc: Willy Tarreau <willy@w.ods.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4.21-rc1] vesafb with large memory
Message-ID: <20030504094900.GA342@pcw.home.local>
References: <3EB0413D.2050200@superonline.com> <200305020314.01875.tmb@iki.fi> <20030502130331.GA1803@alpha.home.local> <200305031546.57631.tmb@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305031546.57631.tmb@iki.fi>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

 
> the correct line should AFAIK be:
> video_size = screen_info.lfb_width * screen_info.lfb_height * video_bpp;
> 
> (AFAIK we are calculating bits here, not bytes so the '/8' you used is 
> wrong... could you try without it, and let me know...)

No, after verification, I insist, we're really calculating BYTES here. Please
take a look :

================== with lfb_width/8 :

wtap:~$ dmesg|grep vesafb
vesafb: framebuffer at 0xe9000000, mapped to 0xe0825000, size 1435k
vesafb: mode is 1400x1050x8, linelength=1400, pages=4
vesafb: protected mode interface info at c000:50ae
vesafb: scrolling: redraw

wtap:~$ grep vesafb /proc/iomem
    e9000000-e9166e2f : vesafb

wtap:~$ cat /proc/mtrr
reg00: base=0x00000000 (   0MB), size= 512MB: write-back, count=1
reg01: base=0xe9000000 (3728MB), size=   1MB: write-combining, count=1

================== with lfb_width :

wtap:~$ dmesg|grep vesafb
vesafb: framebuffer at 0xe9000000, mapped to 0xe0825000, size 11484k
vesafb: mode is 1400x1050x8, linelength=1400, pages=4
vesafb: protected mode interface info at c000:50ae
vesafb: scrolling: redraw

wtap:~$ grep vesafb /proc/iomem
    e9000000-e9b3717f : vesafb

wtap:~$ cat /proc/mtrr
reg00: base=0x00000000 (   0MB), size= 512MB: write-back, count=1
reg01: base=0xe9000000 (3728MB), size=   8MB: write-combining, count=1

============

So I think that the correct line really is :
  video_size = screen_info.lfb_width * screen_info.lfb_height * video_bpp / 8;

(Which also handles line widths which are not multiple of 8).

BTW, I wonder why we truncate the mtrr size to the highest lower power of 2.
Shouldn't we round it up to the next one ?

Personnally, I would find this change more logical. For instance, it returns
1 MB for video_size between 1MB and 2MB-1 inclusive.

Any comments ?

Willy

--- ./drivers/video/vesafb.c
+++ ./drivers/video/vesafb.c
@@ -647,4 +647,5 @@
-		int temp_size = video_size;
+		int temp_size = video_size - 1;
 		/* Find the largest power-of-two */
 		while (temp_size & (temp_size - 1))
 			temp_size &= (temp_size - 1);
+		temp_size <<= 1;

