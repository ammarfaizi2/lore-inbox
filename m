Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262066AbRETQCD>; Sun, 20 May 2001 12:02:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262067AbRETQBr>; Sun, 20 May 2001 12:01:47 -0400
Received: from pop.gmx.net ([194.221.183.20]:54217 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S262062AbRETQAz>;
	Sun, 20 May 2001 12:00:55 -0400
Message-ID: <3B07E6F6.E5C543B2@gmx.de>
Date: Sun, 20 May 2001 17:47:02 +0200
From: Edgar Toernig <froese@gmx.de>
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linus Torvalds <torvalds@transmeta.com>, Ben LaHaise <bcrl@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: F_CTRLFD (was Re: Why side-effects on open(2) are evil.)
In-Reply-To: <Pine.GSO.4.21.0105191933280.7162-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> For the latter, though,
> we need to write commands into files and here your miscdevices (or procfs
> files, or /dev/foo/ctl - whatever) is needed.

IMHO any scheme that requires a special name to perform ioctl like
functions will not work.  Often you don't known the name of the
device you're talking to and then you're lost.

So, if you want an additional communication channel to a device why
not introduce an fcntl or system call like

	cltrfd = fcntl(fd, F_CTRLFD)    or  openctrl(fd)  ?

That way you can always get access to the control channel and use
regular read/write for communication [1].  To make it more versatile,
you may want to extent the shell syntax, i.e. a '@' in redirection
operators get the control fd:

	echo "eject" >@/dev/cdrom
	{ echo "b19200,onlcr" >@1 ; echo "Hello World!" ; } >/dev/ttyS0

Yes, requires support in user space apps but doesn't mess around
with the file namespace.  It's too precious to sacrifice ;-)

I don't know how much infrastructure in the kernel is required for this 
- i.e. add readctrl/writectrl methods or create virtual inodes/devices
on the fly?  There are more capable people than me to judge on that...

Ciao, ET.


[1] If you want you can even allow this flag as an open mode to
open the ctrl channel without opening the dev.
