Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314111AbSDFJzL>; Sat, 6 Apr 2002 04:55:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314115AbSDFJzL>; Sat, 6 Apr 2002 04:55:11 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:49161 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S314111AbSDFJzK>; Sat, 6 Apr 2002 04:55:10 -0500
Message-Id: <200204060952.g369qjX26739@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: linux-kernel@vger.kernel.org
Subject: Re: [DEADLOCK] automount, kupdated: D state
Date: Sat, 6 Apr 2002 12:56:03 -0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <200204051319.g35DJXX25033@Port.imtp.ilyichevsk.odessa.ua>
Cc: Martin Dalecki <martin@dalecki.de>, Vojtech Pavlik <vojtech@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 April 2002 16:22, Denis Vlasenko wrote:
> I was saving my daily work on an IDE disk.
> I use automounter. On an attempt to mount it several processes
> got stuck in D state.
>
> kernel: 2.5.7 + new NTFS driver
> ps and ksymoopsed parts of Alt-Sysrq-T output are attached.
> ksymoops warnings trimmed except automount.dump.ksymoops
> (they were the same).

Forgot to add that it was a hdc. IDE led is constantly on,
any attempt to mount (even partitions from _hda_) are leading to
more "D" state processes (I already have: mount, cat and dd).
CPU load in low.

Box is alive thanks to fully NFS-based setup.

I decided to disconnect hdc from IDE and power connectors without
poweroff, and - whoa! - processes got unstuck. I must mention that
this disk seem to have intermittent problems with DMA
(a flaky/too long IDE cable I guess, DMA works flawlessly at home
with the same disk).

Maybe new IDE code is not timing out on DMA failure or something
like this? lspci says:
00:04.1 IDE interface: Intel Corp. 82371AB PIIX4 IDE (rev 01)

syslog around this event:
Apr  5 16:03:09 manta automount[2173]: do_mount /dev/hdc2 /.local/mnt/auto/hdc2/ type auto options noatime using module generic
Apr  5 16:03:09 manta automount[2173]: mount(generic): calling mkdir_path /.local/mnt/auto/hdc2/
Apr  5 16:03:09 manta automount[2173]: mount(generic): calling mount -t auto -s -o noatime /dev/hdc2 /.local/mnt/auto/hdc2/
Apr  5 16:03:09 manta kernel: EXT2-fs warning: maximal mount count reached, running e2fsck is recommended
Apr  5 16:03:09 manta automount[2173]: mount(generic): mounted /dev/hdc2 type auto on /.local/mnt/auto/hdc2/
Apr  5 16:03:34 manta automount[2180]: running expiration on path /.local/mnt/auto/hdc2
Apr  5 16:03:39 manta automount[1911]: attempting to mount entry /.local/mnt/auto/hdc2
Apr  5 16:03:39 manta automount[2182]: lookup(program): looking up hdc2
Apr  5 16:03:39 manta automount[2182]: lookup(program): hdc2 -> -fstype=auto,noatime :/dev/hdc2
Apr  5 16:03:39 manta automount[2182]: parse(sun): expanded entry: -fstype=auto,noatime :/dev/hdc2
Apr  5 16:03:39 manta automount[2182]: parse(sun): dequote("fstype=auto,noatime") -> fstype=auto,noatime
Apr  5 16:03:39 manta automount[2182]: parse(sun): gathered options: fstype=auto,noatime
Apr  5 16:03:39 manta automount[2182]: parse(sun): dequote("/dev/hdc2") -> /dev/hdc2
Apr  5 16:03:39 manta automount[2182]: parse(sun): core of entry: options=fstype=auto,noatime, loc=/dev/hdc2
Apr  5 16:03:39 manta automount[2182]: parse(sun): mounting root /.local/mnt/auto, mountpoint hdc2/, what /dev/hdc2, fstype auto, options noatime 
Apr  5 16:03:39 manta automount[2182]: do_mount /dev/hdc2 /.local/mnt/auto/hdc2/ type auto options noatime using module generic
Apr  5 16:03:39 manta automount[2182]: mount(generic): calling mkdir_path /.local/mnt/auto/hdc2/
Apr  5 16:03:39 manta automount[2182]: mount(generic): calling mount -t auto -s -o noatime /dev/hdc2 /.local/mnt/auto/hdc2/
Apr  5 16:05:54 manta kernel: SysRq : Show State

[snip: read my 1st email to see ksymoopsed "D" state processes]

Apr  5 16:31:51 manta -- MARK --

[I disconnect hdc here]

Apr  5 16:32:26 manta kernel: hdc: dma_intr: status=0x7f { DriveReady DeviceFault SeekComplete DataRequest CorrectedError Index Error }
Apr  5 16:32:26 manta kernel: hdc: dma_intr: error=0x7f { DriveStatusError UncorrectableError SectorIdNotFound TrackZeroNotFound AddrMarkNotFound }, LBAsect=260013951, sector=229312
Apr  5 16:32:26 manta kernel: hdc: DMA disabled
Apr  5 16:32:26 manta kernel: ide1: reset: master: error (0x7f?)
Apr  5 16:32:26 manta kernel: hdc: status error: status=0x7f { DriveReady DeviceFault SeekComplete DataRequest CorrectedError Index Error }
Apr  5 16:32:26 manta kernel: hdc: status error: error=0x7f { DriveStatusError UncorrectableError SectorIdNotFound TrackZeroNotFound AddrMarkNotFound }, LBAsect=260013951, sector=229312
Apr  5 16:32:26 manta kernel: hdc: drive not ready for command
Apr  5 16:32:27 manta kernel:  255864
Apr  5 16:32:27 manta kernel: end_request: I/O error, dev 16:00, sector 255872
Apr  5 16:32:27 manta kernel: end_request: I/O error, dev 16:00, sector 255880
Apr  5 16:32:27 manta kernel: end_request: I/O error, dev 16:00, sector 255888
Apr  5 16:32:27 manta kernel: end_request: I/O error, dev 16:00, sector 255896
[snip]
Apr  5 16:32:27 manta kernel: end_request: I/O error, dev 16:00, sector 256024
Apr  5 16:32:27 manta kernel: end_request: I/O error, dev 16:00, sector 256032
Apr  5 16:32:27 manta kernel: end_request: I/O error, dev 16:00, sector 256040
Apr  5 16:32:27 manta kernel: end_request: I/O error, dev 16:00, sector 256048
Apr  5 16:32:27 manta automount[2182]: >> mount: wrong fs type, bad option, bad superblock on /dev/hdc2,
Apr  5 16:32:27 manta kernel: end_request: I/O error, dev 16:00, sector 256056
Apr  5 16:32:27 manta automount[2180]: expired /.local/mnt/auto/hdc2
Apr  5 16:32:27 manta automount[2182]: >>        or too many mounted file systems
Apr  5 16:32:27 manta kernel: end_request: I/O error, dev 16:00, sector 256064
Apr  5 16:32:27 manta automount[2182]: mount(generic): failed to mount /dev/hdc2 (type auto) on /.local/mnt/auto/hdc2/
Apr  5 16:32:27 manta kernel: end_request: I/O error, dev 16:00, sector 256072
Apr  5 16:32:27 manta automount[1911]: attempting to mount entry /.local/mnt/auto/hdc2
Apr  5 16:32:27 manta kernel: end_request: I/O error, dev 16:00, sector 256080
Apr  5 16:32:27 manta automount[2363]: lookup(program): looking up hdc2
Apr  5 16:32:27 manta kernel: end_request: I/O error, dev 16:00, sector 256088
Apr  5 16:32:27 manta kernel: end_request: I/O error, dev 16:00, sector 256096
Apr  5 16:32:27 manta kernel: end_request: I/O error, dev 16:00, sector 256104
...
