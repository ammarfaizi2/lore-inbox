Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261432AbUKFRvT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261432AbUKFRvT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 12:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbUKFRvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 12:51:18 -0500
Received: from serio.al.rim.or.jp ([202.247.191.123]:6552 "EHLO
	serio.al.rim.or.jp") by vger.kernel.org with ESMTP id S261432AbUKFRu5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 12:50:57 -0500
Message-ID: <418D0EFB.2040002@yk.rim.or.jp>
Date: Sun, 07 Nov 2004 02:50:51 +0900
From: Chiaki <ishikawa@yk.rim.or.jp>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: ishikawa@yk.rim.or.jp
Subject: Configuration system bug? : tmpfs listing in /proc/filesystems when
 TMPFS was not configured!?
Content-Type: multipart/mixed;
 boundary="------------000607070702070806000803"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000607070702070806000803
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

(Please cc: me since I am not subscribed to linux-kernel list.)

I think there is something fishy about kernel 2.6.9.

I failed to enable TMPFS during configuration of
my linux kernel 2.6.9.

However, somehow /proc/filesystems lists "nodev tmpfs" line !?

Is this to be expected?

Background:
I found this hard way. At least one program, namely,
Debian udev package checks whether the system
supports tmpfs by looking at the contents of /proc/filesystems.
Because of this entry in /proc/filesystems, the script fails miserably
now.

Because of the listing of tmpfs although TMPFS was not configured(!?),
a system initialization script for udev is fooled into believing that
tmpfs is supported and tries to mount tmpfs on /dev.


Worse. Somehow the mount command doesn't complain
about tmpfs not supported, and returns succcess code to the
invoking shell. (I checked.)
(If mount fails, then we can probably fix the script to detect the
internal consistency problem and quits.)

Since the tmpfs functionality is not actually available,
from that point on, udev script fails miserably
and my kernel 2.6.9 no longer boots from that point on.

I had to disable udev initialization script for this reason by booting
under older kernel 2.4.25 and then modifies it, and
then figured out what the problem is after rebooting into 2.6.9
without udev and reporting it.

(I experienced a similar problem earlier with Debian's udev script a
few weeks ago, but when udev script was updated to a new version this
problem was not observed. The udev script used different method to
decide whether udev ought to be invoked or not.  But the latest udev
script in Debain, which I upgraded recently, now uses the checking of
availability of tmpfs feature by looking at /proc/filesystems
and then mount tmpfs, and  this strange kernel behavior is causing a
grave problem.

Listing;

Kernel version.
ishikawa@duron$ uname -a
Linux duron 2.6.9-test-tmscsim #10 Sat Oct 23 01:25:17 JST 2004 i686
GNU/Linux

Used config /proc/config.gz (attached in full)

ishikawa@duron$ zcat /proc/config.gz | grep -i tmpfs
# CONFIG_TMPFS is not set


/proc/filesystems contents:

ishikawa@duron$ cat /proc/filesystems
nodev	sysfs
nodev	rootfs
nodev	bdev
nodev	proc
nodev	sockfs
nodev	binfmt_misc
nodev	futexfs
nodev	tmpfs		<==== Why is this line here???
nodev	pipefs
nodev	eventpollfs
nodev	devpts
	ext2
nodev	ramfs
	msdos
nodev	devfs
	hpfs
	vfat
nodev	usbfs
nodev	usbdevfs
ishikawa@duron$ lsmod
Module                  Size  Used by
via686a                18720  0
w83781d                34096  0
i2c_sensor              4608  2 via686a,w83781d
i2c_isa                 2048  0
i2c_core               23168  4 via686a,w83781d,i2c_sensor,i2c_isa
snd_ymfpci             66212  0
snd_pcm               114056  1 snd_ymfpci
snd_ac97_codec         74960  1 snd_ymfpci
snd_opl3_lib           12160  1 snd_ymfpci
snd_timer              33540  3 snd_ymfpci,snd_pcm,snd_opl3_lib
snd_hwdep               8836  1 snd_opl3_lib
snd_page_alloc          8328  2 snd_ymfpci,snd_pcm
snd_mpu401_uart         9472  1 snd_ymfpci
snd_rawmidi            28068  1 snd_mpu401_uart
snd_seq_device          7432  2 snd_opl3_lib,snd_rawmidi
snd                    59492  9
snd_ymfpci,snd_pcm,snd_ac97_codec,snd_opl3_lib,snd_timer,snd_hwdep,snd_mpu401_uart,snd_rawmidi,snd_seq_device
soundcore               9440  1 snd
uhci_hcd               34188  0
usbcore               133348  3 uhci_hcd
evdev                   7808  0
nls_iso8859_1           3968  1
vfat                   14592  1
radeon                137860  0
ide_cd                 39456  0
st                     35612  0
tmscsim                23360  0
sr_mod                 15396  0
cdrom                  38172  2 ide_cd,sr_mod
sg                     35232  0
nls_cp437               5632  1
hpfs                   87172  0
ishikawa@duron$

-- 
int main(void){int j=2003;/*(c)2003 cishikawa. */
char t[] ="<CI> @abcdefghijklmnopqrstuvwxyz.,\n\"";
char *i ="g>qtCIuqivb,gCwe\np@.ietCIuqi\"tqkvv is>dnamz";
while(*i)((j+=strchr(t,*i++)-(int)t),(j%=sizeof t-1),
(putchar(t[j])));return 0;}/* under GPL */

--------------000607070702070806000803
Content-Type: application/gzip;
 name="config.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="config.gz"

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
--------------000607070702070806000803--
