Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318765AbSIKPiW>; Wed, 11 Sep 2002 11:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319123AbSIKPiV>; Wed, 11 Sep 2002 11:38:21 -0400
Received: from pC19F9C1D.dip.t-dialin.net ([193.159.156.29]:7684 "EHLO
	router.abc") by vger.kernel.org with ESMTP id <S318765AbSIKPiT> convert rfc822-to-8bit;
	Wed, 11 Sep 2002 11:38:19 -0400
Message-ID: <3D7F647B.1E0707FB@baldauf.org>
Date: Wed, 11 Sep 2002 17:42:51 +0200
From: Xuan Baldauf <xuan--lkml@baldauf.org>
X-Mailer: Mozilla 4.79 [en] (Win98; U)
X-Accept-Language: de-DE,en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Reiserfs List <reiserfs-list@namesys.com>
Subject: Heuristic readahead for filesystems
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I wonder wether Linux implements a kind of heuristic
readahead for filesystems:

If an application reads a directory with getdents() and if
in the past, it stat()ed a significant part of the directory
entries, it is likely that it will stat() every entry of
every directory it reads with getdents() in the future. Thus
readahead for the stat data could improve the perfomance,
especially if the stat data is located closely to each other
on disk.

If an application did a stat()..open()..read() sequence on a
file, it is likely that, after the next stat(), it will open
and read the mentioned file. Thus, one could readahead the
start of a file on stat() of that file.

Combined: If an application walks a directory tree and
visits each file, it is likely that it will continue up to
the end of that tree.

Example: See this diff strace:

stat64("linux/drivers/usb/net", {st_mode=S_IFDIR|0775,
st_size=400, ...}) = 0
stat64("linux-2.5.24/drivers/usb/net",
{st_mode=S_IFDIR|0775, st_size=400, ...}) = 0
open("linux/drivers/usb/net",
O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY) = 3
fstat64(3, {st_mode=S_IFDIR|0775, st_size=400, ...}) = 0
fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
getdents64(0x3, 0x8057718, 0x1000, 0)   = 432
getdents64(0x3, 0x8057718, 0x1000, 0)   = 0
close(3)                                = 0
open("linux-2.5.24/drivers/usb/net",
O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY) = 3
fstat64(3, {st_mode=S_IFDIR|0775, st_size=400, ...}) = 0
fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
getdents64(0x3, 0x8057718, 0x1000, 0)   = 432
getdents64(0x3, 0x8057718, 0x1000, 0)   = 0
close(3)                                = 0
stat64("linux/drivers/usb/net/Config.help",
{st_mode=S_IFREG|0644, st_size=5230, ...}) = 0
stat64("linux-2.5.24/drivers/usb/net/Config.help",
{st_mode=S_IFREG|0644, st_size=5230, ...}) = 0
open("linux/drivers/usb/net/Config.help", O_RDONLY) = 3
open("linux-2.5.24/drivers/usb/net/Config.help", O_RDONLY) =
4
read(3, "CONFIG_USB_CATC\n  Say Y if you w"..., 4096) = 4096

read(4, "CONFIG_USB_CATC\n  Say Y if you w"..., 4096) = 4096

read(3, "ule ( = code which can be\n  inse"..., 1134) = 1134

read(4, "ule ( = code which can be\n  inse"..., 1134) = 1134

close(3)                                = 0
close(4)                                = 0
stat64("linux/drivers/usb/net/Config.in",
{st_mode=S_IFREG|0644, st_size=931, ...}) = 0
stat64("linux-2.5.24/drivers/usb/net/Config.in",
{st_mode=S_IFREG|0644, st_size=931, ...}) = 0
open("linux/drivers/usb/net/Config.in", O_RDONLY) = 3
open("linux-2.5.24/drivers/usb/net/Config.in", O_RDONLY) = 4

read(3, "#\n# USB Network devices configur"..., 4096) = 931
read(4, "#\n# USB Network devices configur"..., 4096) = 931
close(3)                                = 0
close(4)                                = 0
stat64("linux/drivers/usb/net/Makefile",
{st_mode=S_IFREG|0644, st_size=299, ...}) = 0
stat64("linux-2.5.24/drivers/usb/net/Makefile",
{st_mode=S_IFREG|0644, st_size=299, ...}) = 0
open("linux/drivers/usb/net/Makefile", O_RDONLY) = 3
open("linux-2.5.24/drivers/usb/net/Makefile", O_RDONLY) = 4
read(3, "#\n# Makefile for USB Network dri"..., 4096) = 299
read(4, "#\n# Makefile for USB Network dri"..., 4096) = 299
close(3)                                = 0
close(4)                                = 0
stat64("linux/drivers/usb/net/catc.c",
{st_mode=S_IFREG|0644, st_size=23960, ...}) = 0
stat64("linux-2.5.24/drivers/usb/net/catc.c",
{st_mode=S_IFREG|0644, st_size=23960, ...}) = 0
open("linux/drivers/usb/net/catc.c", O_RDONLY) = 3
open("linux-2.5.24/drivers/usb/net/catc.c", O_RDONLY) = 4
read(3, "/*\n *  Copyright (c) 2001 Vojtec"..., 4096) = 4096

read(4, "/*\n *  Copyright (c) 2001 Vojtec"..., 4096) = 4096

read(3, " long last_stats;\n\n\tu8 multicast"..., 19864) =
19864
read(4, " long last_stats;\n\n\tu8 multicast"..., 19864) =
19864
close(3)                                = 0
close(4)                                = 0
stat64("linux/drivers/usb/net/cdc-ether.c",
{st_mode=S_IFREG|0644, st_size=45669, ...}) = 0
stat64("linux-2.5.24/drivers/usb/net/cdc-ether.c",
{st_mode=S_IFREG|0644, st_size=45669, ...}) = 0
open("linux/drivers/usb/net/cdc-ether.c", O_RDONLY) = 3
open("linux-2.5.24/drivers/usb/net/cdc-ether.c", O_RDONLY) =
4
read(3, "// Portions of this file taken f"..., 4096) = 4096
read(4, "// Portions of this file taken f"..., 4096) = 4096
read(3, "SY;\n}\n\nstatic void write_bulk_ca"..., 41573) =
41573
read(4, "SY;\n}\n\nstatic void write_bulk_ca"..., 41573) =
41573
close(3)                                = 0
close(4)                                = 0


Diff only takes 2% CPU time for diffing two linux-kernel
trees on a AMD Duron 1 GHz, DMA enabled. Dumb readahead only
some blocks after the original block does not work here
well. Diff always switches between the kernel trees, and I
assume, the disk head seeks accordingly back and forth. If
the trees were read (at least partly) in parallel, I assume
that reading would be much faster. Hence the question.

Xuân.


