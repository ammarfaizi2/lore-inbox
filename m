Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263605AbTLSWBw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 17:01:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263642AbTLSWBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 17:01:52 -0500
Received: from fw.osdl.org ([65.172.181.6]:61370 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263605AbTLSWBu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 17:01:50 -0500
Date: Fri, 19 Dec 2003 14:00:29 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: elgaard@agol.dk
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem loopmounting CD on 2.6.0
Message-Id: <20031219140029.346f2523.rddunlap@osdl.org>
In-Reply-To: <3FE2F8D4.1030903@agol.dk>
References: <3FE2F8D4.1030903@agol.dk>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Dec 2003 14:10:44 +0100 Niels Elgaard Larsen <elgaard@agol.dk> wrote:

| A similar (probably the same) problem have been reported for cryptoloop.
| With a ISO9660 CD (actually Knoppix) in drive /dev/hdc, no SCSI emulation:
| 
| amigos20:/mnt# losetup /dev/loop5 /dev/hdc
| amigos20:/mnt# mount -r /dev/loop5 /mnt/foo
| 
| Gives kernel output:
| 
| ===
| hdc: cdrom_read_intr: data underrun (2 blocks)
| end_request: I/O error, dev hdc, sector 64
| isofs_fill_super: bread failed, dev=loop5, iso_blknum=16, block=32
| ===
| 
| It works in 2.4.20
| 
| Also
| 
| dd if=/dev/hdc of=/tmp/foo
| losetup /dev/loop5 /tmp/foo
| mount -r /dev/loop5 /mnt/foo
| 
| works

I see differing sector size and block size reports by blockdev
as follows.  Is this OK/expected or does it hint at a problem?

(all without ide-scsi:)

2.6.0, non-loopback case:

# mount
/dev/hdd on /mnt/disk type iso9660 (ro)

[root@gargoyle rddunlap]# blockdev --getss /dev/hdd
2048
[root@gargoyle rddunlap]# blockdev --getbsz  /dev/hdd
2048


2.6.0, loopback case:

I usually see the same error that you reported.
I did mount the cdrom successfully one time, with about 50
error messages like below[1], and saw this blocksize difference:
Is this OK or indicative of a (the) problem?


[root@gargoyle rddunlap]# blockdev --getss /dev/hdd
2048
[root@gargoyle rddunlap]# blockdev --getbsz  /dev/hdd
4096


[1]
hdd: cdrom_read_intr: data underrun (2 blocks)
end_request: I/O error, dev hdd, sector 64
hdd: cdrom_read_intr: data underrun (2 blocks)
end_request: I/O error, dev hdd, sector 68
hdd: cdrom_read_intr: data underrun (2 blocks)
end_request: I/O error, dev hdd, sector 72
...
hdd: cdrom_read_intr: data underrun (2 blocks)
end_request: I/O error, dev hdd, sector 388
hdd: cdrom_read_intr: data underrun (2 blocks)
end_request: I/O error, dev hdd, sector 392
hdd: cdrom_read_intr: data underrun (2 blocks)
end_request: I/O error, dev hdd, sector 396

2.4.2x:

[root@gargoyle rddunlap]# blockdev --getss /dev/hdd
512
[root@gargoyle rddunlap]# blockdev --getbsz  /dev/hdd
2048


--
~Randy
MOTD:  Always include version info.
