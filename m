Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288227AbSACHIm>; Thu, 3 Jan 2002 02:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288228AbSACHIX>; Thu, 3 Jan 2002 02:08:23 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:21764 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S288227AbSACHIF>; Thu, 3 Jan 2002 02:08:05 -0500
Message-ID: <3C34024A.EDA31D24@zip.com.au>
Date: Wed, 02 Jan 2002 23:03:38 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: Ivan Passos <ivan@cyclades.com>, linux-kernel@vger.kernel.org
Subject: Re: Serial Driver Name Question (kernels 2.4.x)
In-Reply-To: <3C33E0D3.B6E932D6@zip.com.au>,
		<3C33BCF3.20BE9E92@cyclades.com>
		<3C33E0D3.B6E932D6@zip.com.au> <200201030637.g036bxe03425@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch wrote:
> 
> > Instead, it appears that someone broke tty_name().  Here's the
> > 2.2 kernel's version:
> 
> That "someone" was me, and I changed it from broken to fixed.
> 

Look at serial.c:

#if (LINUX_VERSION_CODE > 0x2032D && defined(CONFIG_DEVFS_FS))
        serial_driver.name = "tts/%d";
#else
        serial_driver.name = "ttyS";
#endif

tty_name will just print "ttyS".   So the transition for this case
was fixed->broken.

> 
> No, originally tty_name() did it, and then I shifted it to the
> drivers. I don't recall the reason, but it was necessary. So I don't
> want this changed.

Oh dear.  Why cannot devfs expand the minor part itself?

It looks like all the drivers need to be given a %d, as Ivan suggests.  And we
need to audit all uses to make sure nobody is doing printk(driver.name);

I think it would be better to drop the printf control construct from the
names altogether.

-
