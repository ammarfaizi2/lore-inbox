Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280163AbRKEDiR>; Sun, 4 Nov 2001 22:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280164AbRKEDiI>; Sun, 4 Nov 2001 22:38:08 -0500
Received: from sushi.toad.net ([162.33.130.105]:60131 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S280163AbRKEDiB>;
	Sun, 4 Nov 2001 22:38:01 -0500
Subject: Re: 2.4.12-ac3 floppy module requires 0x3f0-0x3f1 ioports
From: Thomas Hood <jdthood@mail.com>
To: Maciej Zenczykowski <maze@druid.if.uj.edu.pl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0111050149580.27009-700000@druid.if.uj.edu.pl>
In-Reply-To: <Pine.LNX.4.33.0111050149580.27009-700000@druid.if.uj.edu.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15 (Preview Release)
Date: 04 Nov 2001 22:37:19 -0500
Message-Id: <1004931442.1319.123.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2001-11-04 at 20:18, Maciej Zenczykowski wrote:
> W98SE reports the FDC at 0x3f0..0x3f5 and 0x3f7

In hw reference manuals I have looked at, the floppy
ioport range is listed as either 0x3f0-0x3f5 or
0x3f0-0x3f5,0x3f7 or 0x3f0-0x3f7.

0x3f6 is used by some IDE controllers, so it should
not be included in the range.  Floppy controller
chips don't use this ioport.

Now I'm looking at the refence for the National Semi
87338 Super I/O chip which among other things emulates
a standard IBM-style floppy controller.  It says:

0x3f0,0x3f1 are status registers that were added
      to the PS/2.  They do not exist on the PC-AT.
      The 87338 uses these addresses only in "PS/2 mode",
      not in "PC-AT" mode.
0x3f2 (*) is a digital output register
0x3f3 is a "tape drive register".  Bring this one into
      the Antiques Roadshow!
0x3f4 (*) is the main status register (r)
      and data rate select register (w)
0x3f5 (*) is the data register FIFO
0x3f7 (*) is the digital input register (r)
      and configuration control register (w)

When I look at the floppy driver itself, it reserves
0x3f0-0x3f5,0x3f7 but only uses 0x3f2, 0x3f4, 0x3f5, 0x3f7
(indicated above with an asterisk). See include/linux/fdreg.h.

I would suggest that the driver refrain from reserving
0x3f0-0x3f1 since not all floppy driver chips take up these
ioports and the Linux driver doesn't use them either.

Maciej: perhaps on your machine the motherboard uses 0x3f0-0x3f1
for some other (secret, highly classified) purpose.  Have you
read your hardware reference manual?

--
Thomas

