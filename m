Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287200AbSAZWhV>; Sat, 26 Jan 2002 17:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287193AbSAZWhM>; Sat, 26 Jan 2002 17:37:12 -0500
Received: from sm10.texas.rr.com ([24.93.35.222]:37259 "EHLO sm10.texas.rr.com")
	by vger.kernel.org with ESMTP id <S287163AbSAZWg6>;
	Sat, 26 Jan 2002 17:36:58 -0500
Date: Sat, 26 Jan 2002 16:35:22 -0600 (CST)
From: Jeff Meininger <jeffm@boxybutgood.com>
X-X-Sender: <jeffm@mangonel.localdomain>
To: <linux-kernel@vger.kernel.org>
Subject: loopback anomaly?
Message-ID: <Pine.LNX.4.33.0201261611400.836-100000@mangonel.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've found some undesirable behavior when trying to use the loop block
driver with files with strange byte counts.  The files I'd like to setup
as loopback devices are on read-only media, and they're all different byte
counts... not necessarily even an integral multiple of 512.  I can't just
pad them to work with losetup.

Here's the scoop on strange filesizes.

Sometimes, the loopback driver takes a file, and calculates the greatest
number of blocks that will fit in the file, and uses that.  It
understandably chops off the remaining bytes that don't quite add up to a
full block.  The amount of data you get when reading the device and the
return from BLKGETSIZE are the same.  This is good.

Other times, the loopback driver will do something kinda funky... it will
once again figure out block counts that will fit in the file, but it
reports one thing in BLKGETSIZE, but provides less data than you actually
get when you try to read (dd, md5sum, whatever) the /dev/loopN device.
This is bad.  I get an I/O error when I try to read such a loopback
device.

Which of the two above paths is taken seems to be a rounding issue, as far
as I can tell.

If you have a 1048576-byte file (exactly 1M), losetup works perfectly.
You get every byte.  BLKGETSIZE says 2048.

If you have a 1048577-byte file (1 byte more than 1M), the loopback device
skips the last byte, which is what I believe it should do.  BLKGETSIZE
says 2048.

If you have a 1048575-byte file (1 byte less than 1M), the loopback device
reports 2046 for it's BLKGETSIZE.  This sounds correct, since it has to
use one less 1024-block to get an integral multiple.  However, when you
examine the contents of the loopback device, you'll find that there are
only 2040 sectors... there are 3072 more bytes missing than you'd expect.

So what is the block size we're dealing with here?  1024 or 4096?  I don't
really care how much gets chopped off the end of the loopback device...
just so long as the results are predictable, and that BLKGETSIZE matches
the actual amount of data that can be read from the loopback device.

I'd love to help solve this problem by myself... in fact I've spent the
last several hours trying.  I think I need the aid of a more experienced
kernel hacker, though.  :)

BTW...
I'm not a subscriber to this list, so I'd greatly appreciate any replies
being cc'ed to me.

Thanks!
-Jeff Meininger

