Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263091AbTJZLlh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 06:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263094AbTJZLlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 06:41:37 -0500
Received: from bender.bawue.de ([193.197.13.1]:18058 "EHLO bender.bawue.de")
	by vger.kernel.org with ESMTP id S263091AbTJZLl1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 06:41:27 -0500
From: Thilo Schulz <arny@ats.s.bawue.de>
Reply-To: arny@ats.s.bawue.de
To: linux-kernel@vger.kernel.org
Subject: Files burnt to DVDs corrupt when DMA enabled, tested with Kernel 2.4 and 2.6 series.
Date: Sun, 26 Oct 2003 12:41:12 +0100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200310261241.20531.arny@ats.s.bawue.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

I have recently used the dvd+rwtools released by Andy Polyakov to burn DVDs on
my Pioneer DVR-A06 burner.
After burning, I ran a diff on the resulting files and found the burnt file to 
be different from the original. A closer examination revealed, that a few
chunks of each having a length of exactly 28 bytes had been written
incorrectly to the DVD.
The count of incorrectly written chunks depends strongly on additional
activity to the burning process itself. The more I work on the gui (browse
the web etc.), the more errors are written.

At first I thought it was caused due to the scsi-emulation that I used in the 
kernels 2.4.20, 2.4.21 and 2.4.22 in order to be able to have decent burning 
(burning with these kernels without ide-scsi emulation works very badly, 
burning stops every 4 seconds because not enough data seems to be available).
When having ide-scsi disabled and DMA enabled, the resulting files were not 
corrupt, even though burning was painfully slow, so I guessed it was a 
problem specific to DMA and the ide-scsi driver. ide-scsi with DMA disabled 
also produced files that were not corrupt - so I originally sent an email to 
the ide-scsi maintainer a few weeks ago, I have not got a response until 
today.

Testing the latest kernel 2.6.0-test9 though I did not have problems burning 
without scsi emulation, and I now ran the same tests again. The result was, 
that with DMA enabled, there _are_ corruptions, namely those 28 byte chunks 
described above, without DMA there were no corruptions again.

FYI:
I took following steps to exclude possibilities that could have caused the
errors:

- - i managed to stop the burning process with CTRL+Z and with few background
activity, the burning proceeded correctly without any differences in the
resulting files, therefore it is unlikely to be caused by buffer underruns.

- - Burning under windows on the same hardware went eventlessly and correctly in 
all cases on the
very same computer, even with other activity running parallely, thus I deem
it unlikely to be caused by a hardware bug.

- - I checked the image that was created by mkisofs, and the files in this image
did not contain any errors.

- - The dvd burning software was reported to work well and error-free on other
hardware setups.

- - I switched DMA off - system performance drops much as expected, but the
resulting file is not corrupt.

- - burning with and without umaskirq enabled does not make any difference

When repeatedly burning the same file, these erroneous chunks never appear at
the same byte count, probably always then when I did something else at the
time of the burning.
This is a part of the response of the developer of the dvd+rwtools:

> Myself I never stare at progress indicator, but just proceed with usual
> activities, so I can't confirm your experience. Moreover, I now and then
> explicitly suspend recording program for several seconds, resume it and
> then explicitly verify the data with md5sum. What I'm trying to say is
> that your case smells *very much* like a kernel bug. It might be
> specific to your IDE controller and/or be result of some race condition
> which occurs with some specific timing.

Last but not least a bit of output from the interesting parts in the /proc
file system:

#############################
thilo@Thilo / $ cat /proc/ide/via
- ----------VIA BusMastering IDE Configuration----------------
Driver Version:                     3.38
South Bridge:                       VIA vt82c686b
Revision:                           ISA 0x40 IDE 0x6
Highest DMA rate:                   UDMA100
BM-DMA base:                        0xd800
PCI clock:                          33.3MHz
Master Read  Cycle IRDY:            0ws
Master Write Cycle IRDY:            0ws
BM IDE Status Register Read Retry:  yes
Max DRDY Pulse Width:               No limit
- -----------------------Primary IDE-------Secondary IDE------
Read DMA FIFO flush:          yes                 yes
End Sector FIFO flush:         no                  no
Prefetch Buffer:               no                  no
Post Write Buffer:             no                  no
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   80w                 80w
- -------------------drive0----drive1----drive2----drive3-----
Transfer Mode:       UDMA       PIO      UDMA       PIO
Address Setup:       30ns     120ns      30ns     120ns
Cmd Active:          90ns      90ns      90ns      90ns
Cmd Recovery:        30ns      30ns      30ns      30ns
Data Active:         90ns     330ns      90ns     330ns
Data Recovery:       30ns     270ns      30ns     270ns
Cycle Time:          60ns     600ns      60ns     600ns
Transfer Rate:   33.3MB/s   3.3MB/s  33.3MB/s   3.3MB/s
thilo@Thilo / $
#############################

This is /proc/ide/hde - my DVD burner:

################################
thilo@Thilo / $ cat /proc/ide/hde/driver
ide-cdrom version 4.59-ac1
thilo@Thilo / $
################################

###############################
thilo@Thilo / $ cat /proc/ide/hde/model
PIONEER DVD-RW DVR-106D
thilo@Thilo / $
###############################

###############################
root@Thilo / # cat /proc/ide/hde/settings
name                    value           min             max             mode
- ----                    -----           ---             ---             ----
current_speed           66              0               70              rw
dsc_overlap             0               0               1               rw
ide-scsi                0               0               1               rw
init_speed              12              0               70              rw
io_32bit                1               0               3               rw
keepsettings            0               0               1               rw
nice1                   1               0               1               rw
number                  0               0               3               rw
pio_mode                write-only      0               255             w
slow                    0               0               1               rw
unmaskirq               1               0               1               rw
using_dma               1               0               1               rw
root@Thilo / #
##################################

- -- 
 - Thilo Schulz

My public GnuPG key is available at http://home.bawue.de/~arny/public_key.asc
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/m7LdZx4hBtWQhl4RAi6VAKDTnK3wCOJNmt24a5fACxKSM9hUagCgh+oi
DB1VL1e5fy1uHqWWbTBPoU4=
=WHud
-----END PGP SIGNATURE-----

