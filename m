Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289388AbSAODq7>; Mon, 14 Jan 2002 22:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289395AbSAODqt>; Mon, 14 Jan 2002 22:46:49 -0500
Received: from mx.fluke.com ([129.196.128.53]:9 "EHLO evtvir03.tc.fluke.com")
	by vger.kernel.org with ESMTP id <S289388AbSAODqj>;
	Mon, 14 Jan 2002 22:46:39 -0500
Date: Mon, 14 Jan 2002 19:46:47 -0800 (PST)
From: David Dyck <dcd@tc.fluke.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.5.2 / IDE cdrom_read_intr: data underrun / end_request: I/O error
In-Reply-To: <Pine.LNX.4.33.0201120834140.672-100000@dd.tc.fluke.com>
Message-ID: <Pine.LNX.4.33.0201141938480.214-100000@dd.tc.fluke.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm still getting data underrun errors using 2.5.2
that don't occur using 2.4.18-pre3.

Linux dd 2.5.2 #1 Mon Jan 14 19:02:09 PST 2002 i686

here's a section of dmesg output

VFS: Disk change detected on device ide1(22,0)
ISO 9660 Extensions: Microsoft Joliet Level 3
ISOFS: changing to secondary root
hdc: cdrom_read_intr: data underrun (4294967256 blocks)
end_request: I/O error, dev 16:00, sector 299300
hdc: cdrom_read_intr: data underrun (4294967260 blocks)
end_request: I/O error, dev 16:00, sector 299304


the blocks number is 'interesting' in that it is either negative or
really massive, not something that would seem to be appropriate
for the cdrom driver.

dd:dcd$ dmesg | perl -ne 'printf "%x\n", $1 if /data underrun.*?(\d+) blocks/ ' | sort | uniq -c | head
      2 ffffff40
      2 ffffff44
      2 ffffff48
      2 ffffff4c
      2 ffffff50
      2 ffffff54
      2 ffffff58
      2 ffffff5c
      2 ffffff60
      2 ffffff64
dd:dcd$ dmesg | perl -ne 'printf "%x\n", $1 if /data underrun.*?(\d+) blocks/ ' | sort | uniq -c | tail
      4 ffffffd8
      4 ffffffdc
      4 ffffffe0
      4 ffffffe4
      4 ffffffe8
      4 ffffffec
      4 fffffff0
      4 fffffff4
      4 fffffff8
      4 fffffffc



On Sat, 12 Jan 2002 at 08:37 -0800, David Dyck <dcd@tc.fluke.com> wrote:

> On Fri, 11 Jan 2002 at 18:55 -0800, David Dyck <dcd@tc.fluke.com> wrote:
>
> I had been testing 2.5.2-pre11 and earlier, but hadn't looked at
> reading from my cdrom for a while.  Yesterday I created examined several
> large cdrom sets that had been readable earlier and they read partially
> but get read errors.  These same cdroms can be read reliable on
> 2.4.18-pre3 using the same hardware, and are readable on other
> PC's runing older kernels.
>
> Has anyone else seen cdrom read errors with 2.5.2-pre* kernels?
>
> Using 2.5.2-pre11
>
> # mount /cdrom && md5sum /cdrom/*
> md5sum: /cdrom/dcd-c.tar.gz: I/O error
> md5sum: /cdrom/dcd-d.tar.gz: I/O error
>
>
> An example of some of the messages were
>
>     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
> hdc: NEC CD-ROM DRIVE:28B, ATAPI CD/DVD-ROM drive
> hdc: ATAPI 32X CD-ROM drive, 256kB Cache
>
>
> VFS: Disk change detected on device ide1(22,0)
> ISO 9660 Extensions: Microsoft Joliet Level 3
> ISOFS: changing to secondary root
> hdc: cdrom_read_intr: data underrun (4294967256 blocks)
> end_request: I/O error, dev 16:00, sector 299300
> hdc: cdrom_read_intr: data underrun (4294967260 blocks)
> end_request: I/O error, dev 16:00, sector 299304
>
>   errors repeated with sector and blocks increasing by 4
>   repeating 118 times
>
>
> using 2.4.18-pre3 I get no errors

