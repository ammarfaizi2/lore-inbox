Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261849AbTCaVVl>; Mon, 31 Mar 2003 16:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261850AbTCaVVl>; Mon, 31 Mar 2003 16:21:41 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:21509 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S261849AbTCaVVk>; Mon, 31 Mar 2003 16:21:40 -0500
Date: Mon, 31 Mar 2003 23:32:55 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Joel Becker <Joel.Becker@oracle.com>
cc: bert hubert <ahu@ds9a.nl>, Greg KH <greg@kroah.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, <Andries.Brouwer@cwi.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Wim Coekaerts <Wim.Coekaerts@oracle.com>
Subject: Re: 64-bit kdev_t - just for playing
In-Reply-To: <20030331172403.GM32000@ca-server1.us.oracle.com>
Message-ID: <Pine.LNX.4.44.0303312215020.5042-100000@serv>
References: <UTC200303272027.h2RKRbf27546.aeb@smtp.cwi.nl>
 <Pine.LNX.4.44.0303272245490.5042-100000@serv> <1048805732.3953.1.camel@dhcp22.swansea.linux.org.uk>
 <Pine.LNX.4.44.0303280008530.5042-100000@serv> <20030327234820.GE1687@kroah.com>
 <Pine.LNX.4.44.0303281031120.5042-100000@serv> <20030328180545.GG32000@ca-server1.us.oracle.com>
 <Pine.LNX.4.44.0303281924530.5042-100000@serv> <20030331083157.GA29029@outpost.ds9a.nl>
 <Pine.LNX.4.44.0303311039190.5042-100000@serv> <20030331172403.GM32000@ca-server1.us.oracle.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 31 Mar 2003, Joel Becker wrote:

> > > Can you envision solutions based on 16 bit kdev_t infrastructure? 
> > 
> > I know that 16bit is getting small (but with dynamic assignment even 
> > that is still enough for most people), but OTOH I don't understand the 
> > obsession for 64bit. 32bit is more than enough on a 32bit system.
> 
> 	There are big companies out there that require thousands of
> disks.  Many don't want to use hardware raid, they just want JBOD.
> There are installations today with 2k-4k disks covering the gamut from
> massive databases to HPC to research facilities.  Today.
> 	A 32bit dev_t with the 12/20 Linus split provides 64k minors.
> That's 16k disks with our current 15-partitions-per limit.  But if
> someone wants 35 partitions (I've seen that somewhere) you're down to
> 8k.  And the places using 2-4k disks today will be getting to 8k disks
> soon after 2.6 becomes usable, if not before.  They will likely hit 16k
> disks before 2.6 becomes an afterthought.

Umm, I must be missing something, I get here 1024k minors, 64k disks with 
15 partitions and 16k disks with 63 partitions.
Anyway, the sooner userspace accepts that dev_t number is just a number 
the better. The major/minor split is useless information in userspace and 
it becomes less and less important in the kernel.

> > Somehow it sounds that we just have to introduce a huge dev_t and all our 
> > problems are magically solved and I doubt that. If people want to encode 
> 
> 	64bit dev_t is not a panacea.  However, if we have to do this
> change, we want to do it once.  This only solves the space issue.  All
> of the other issues, such as naming, are orthogonal to this change.
> Holding one change until everything else has been written is silly.

SCSI already enumerates the devices sequentially, without userspace tools
already now it's very painful to manage thousands of disk, but all the
kernel can do is to give you all the information about the disks it has
and the number you can use to access the disk. How you call that thing is
a userspace issue not a kernel issue.
A lot of information is already exported via sysfs, missing information 
can be added. Changing the kernel to sequentially assign dev_t numbers 
starting 0x10000, when they are registered via add_disk, is a rather 
simple change. Then you have can have 16M disks with 256 partitions, that 
should be enough for a while?
What mostly is missing now is the userspace code. I haven't seen a 
request, that someone has simple daemon and needs now this and that 
information from the kernel to map a disk reliably to a name.

> 	There is no conspiracy.  Everyone agrees we need more dev_t
> space.  Peter, Andries, and others see it like I do; we only want to do
> this once, and we already can see a day when 20bits of minors isn't
> enough.

If you only want to do it once, then do it right. There are 2 basic 
questions, which have to be answered:
1. How do we want to manage dev_t numbers in the future?
2. What compromises can we make for 2.6?
Without answering these questions now, we risk to pay heavily for it 
later. The ones who ask now for a larger dev_t the loudest are likely the 
first to demand later not change anything for "compability", because they 
hardcoded certain assumptions about dev_t into their applications.

bye, Roman

