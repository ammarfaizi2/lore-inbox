Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131020AbRDCKKN>; Tue, 3 Apr 2001 06:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131158AbRDCKKD>; Tue, 3 Apr 2001 06:10:03 -0400
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:43947 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S131020AbRDCKJ5>; Tue, 3 Apr 2001 06:09:57 -0400
Date: Tue, 3 Apr 2001 12:09:11 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Andries.Brouwer@cwi.nl
Cc: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk, hpa@transmeta.com,
        linux-kernel@vger.kernel.org, tytso@MIT.EDU
Subject: Re: Larger dev_t
Message-ID: <20010403120911.B4561@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <UTC200104022017.WAA89061.aeb@vlet.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <UTC200104022017.WAA89061.aeb@vlet.cwi.nl>; from Andries.Brouwer@cwi.nl on Mon, Apr 02, 2001 at 10:17:02PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 02, 2001 at 10:17:02PM +0200, Andries.Brouwer@cwi.nl wrote:
> What is dev_t used for? It is a communication channel from
> filesystem to user space (via the stat() system call)
> and from user space to filesystem (via the mknod() system call).
 
The question is WHAT do we communicate (and don't answer "major
minor" here, since this is only numbers) and WHY do we need this
communication.

Devfs aims to associate device names with dynamic, flat device
numbers. So we have a scalable solution for the kernel -> user
space communication. What we DON't have, is a similar simple way
to tell it the other way around.

The reasons, why we need to know where a file is located on are:
   -  to only include files from one media
   -  to run certain optimizations like fsck does with disk
      spindles
   -  ...

So instead of just shifting the problems into the future and
making the same mistake again, we should better think of
interfaces, that give us the information we need and let this
error prone (ever had a typo on mknod?) and never large enough
static interface die.

Maybe there should be a way to translate a dynamic associated
device number into a real device name, like the devfs name of it.
May be a reverse mapping in devfs (/dev/by_dev_no/[0-9]+) would
work. If these are symlinks, a readlink() would suffice. Very
simple solution.

For comparing inode1.media == inode2.media (one of the most
important uses for device numbers) we don't need to change
anything.

For getting the device number of the spindle, the block devices
which support partitions or are remapping a (set of) block
device(s) could get IOCTLs (where this information belongs into
and is as reliable as the driver).

For all these things, we can have a flat and dynamic device
number namespace.

Device numbers have to be uniqe only during one power on -> run ->
power off cycle. For the rest applications should store device
names instead anyway. The applications, that don't are buggy by
defintion.

Note: I certainly overlooked sth., so please flame me ;-)

> The current discussion is almost entirely about mknod.]

Yes: Let "mknod /dev/foo [bc] x y" die!

Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<     been there and had much fun   >>>>>>>>>>>>
