Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264474AbTLQQO6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 11:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264473AbTLQQO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 11:14:58 -0500
Received: from chaos.analogic.com ([204.178.40.224]:4484 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264474AbTLQQOt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 11:14:49 -0500
Date: Wed, 17 Dec 2003 11:16:04 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Wakko Warner <wakko@animx.eu.org>
cc: John Bradford <john@grabjohn.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6 and IDE "geometry"
In-Reply-To: <20031217104036.A13292@animx.eu.org>
Message-ID: <Pine.LNX.4.53.0312171044120.25152@chaos>
References: <20031212131704.A26577@animx.eu.org> <20031212194439.GB11215@win.tue.nl>
 <20031216135306.GA7292@iliana> <200312161717.hBGHH0kX000201@81-2-122-30.bradfords.org.uk>
 <20031217104036.A13292@animx.eu.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Dec 2003, Wakko Warner wrote:

> > > I believe parted does not. Nor any of the libparted frontends. I may be
> > > wrong though.
> >
> > If so, I consider it a missing feature in parted - why should the BIOS
> > geometry resemble the disk it describes at all?  Some machines have no
> > user-definable drive types, forcing you to use an incorrect geometry
> > if you install a disk which is not in the table of supported drives.
> >
> > This is no problem for recent Linux kernels, and doesn't even prevent
> > you booting from that disk.
>
> I think noone has really understood why I want it.  The machines in question
> will not ever boot linux from the hard disk.  Only from the CD that I built.
> The OS that is installed from the CD is one of the windows OSs which depend
> on the bios geometry definition to boot properly.  The kernel doesn't care
> about the geometry, that's all well and good except when I create the
> partitions.  Most of the pcs I work with use */255/63 notation,
> occasionally, I'll come across one that uses */128/63 notation.  Never one
> with */16/63 notation.  The smallest disk I work with would be a 1.2gb disk.
>
> I have tried to make this CD as simple to use as possible, which means
> passing the geometry on the command line is out of the question and setting
> it for every invocation of *fdisk is pretty much out as well.  I liked the
> "bogus bios"geometry the kernel was able to get from the bios.  Out of the
> hundreds of PCs I've used this on, not one has ever failed me.
>
> I have stuck with 2.4.x for now, but at some point, it'll have to be
> upgraded due to hardware support.  2.4 will eventtually become with 2.0 is
> now, stable, no new drives, only critial bug fixes.  As time progresses, the
> kernel will not support newer hardware (For instance network drivers which
> is used havily in this CD as well).
>
> All I really want is to beable to get the kernel to get the bios parameters
> for me.  If this means a patch or something, that's fine.  (I don't know
> anything about the ide drivers to do this)
>
> This CD has made my life easier at my job and it's not something I want to
> give up while I still have this job =)
>

The problem is that this phony geometry is only available in
"real-mode" from the BIOS. One needs to execute interrupt 0x13,
function-code 0x15, to get a pointer to the drive parameter
table. This is all 16-bit, BIOS residual stuff. In the "olden-
days" Linux had an "elevator" procedure for ordering read/writes
to drives. This required that Linux "know" about the geometry.
Once developers learned that the drives "know" better than
anybody else how to order reads/writes, this code was removed.
The code necessary to get the drive parameters from the BIOS,
when still in real-mode, was also removed because it has no
use anymore.

So, if you need to use that BIOS information now, you really
need to write it down. It's really that simple. Certainly you
don't expect an operating system to retrieve parameters upon
startup that might be useful to another operating system, do
you? If you MUST get that information for a program, you
can still get that information, but YOU, not the operating
system, needs to get it.

There are major problems obtaining this real-mode information
even from a custom driver (module). However, the old interrupt
table remains, starting at offset 0. Each table entry contains
an offset and a segment (4 bytes). You can therefore take
0x15 and shift it left twice to get the offset into the
interrupt table. Most of the segments will be 0x40. The offset
will be the offset off the segment value (0x40). That's 16 times
0x40 = 0x400. You add the offset to that, to get the absolute
offset of the table from C:, from a BIOS book, you can
find what each of the table entries mean. These can be returned
to your program. You actually don't need a driver to do this,
you can mmap() offset 0 without any NULL-pointer problems.
My simple debugger does this (like DOS debug, but 32-bit mode).
Note that Intel has the low byte in the lowest memory location,
also the lowest word is in the lowest memory location.

0x15 * 4 = 0x54

Script started on Wed Dec 17 11:03:15 2003
# ./debug
-d 0
00000000  01 00 00 00 6F EF 00 F0-C3 E2 00 F0 6F EF 00 F0   ....o.......o...
00000010  6F EF 00 F0 54 FF 00 F0-08 80 00 F0 6F EF 00 F0   o...T.......o...
00000020  A5 FE 00 F0 87 E9 00 F0-6F EF 00 F0 6F EF 00 F0   ........o...o...
00000030  6F EF 00 F0 6F EF 00 F0-57 EF 00 F0 6F EF 00 F0   o...o...W...o...
00000040  75 57 00 C0 4D F8 00 F0-41 F8 00 F0 64 25 00 C8   uW..M...A...d%..
00000050  39 E7 00 F0 59 F8 00 F0-2E E8 00 F0 D2 EF 00 F0   9...Y...........
                      ^^^^^^^^^^^
                      Table is at f000:f859 = ff859

00000060  A4 E7 00 F0 F2 E6 00 F0-6E FE 00 F0 53 FF 00 F0   ........n...S...
00000070  53 FF 00 F0 A4 F0 00 F0-C7 EF 00 F0 C8 5B 00 C0   S............[..
00000080  6F EF 00 F0 6F EF 00 F0-6F EF 00 F0 6F EF 00 F0   o...o...o...o...
00000090  6F EF 00 F0 6F EF 00 F0-6F EF 00 F0 6F EF 00 F0   o...o...o...o...
000000A0  6F EF 00 F0 6F EF 00 F0-6F EF 00 F0 6F EF 00 F0   o...o...o...o...
000000B0  6F EF 00 F0 6F EF 00 F0-6F EF 00 F0 6F EF 00 F0   o...o...o...o...
000000C0  6F EF 00 F0 6F EF 00 F0-6F EF 00 F0 6F EF 00 F0   o...o...o...o...
000000D0  6F EF 00 F0 6F EF 00 F0-6F EF 00 F0 6F EF 00 F0   o...o...o...o...
000000E0  6F EF 00 F0 6F EF 00 F0-6F EF 00 F0 6F EF 00 F0   o...o...o...o...
000000F0  6F EF 00 F0 6F EF 00 F0-6F EF 00 F0 6F EF 00 F0   o...o...o...o...
-q
# exit
exit
Script done on Wed Dec 17 11:04:11 2003


Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


