Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261446AbVBHCrj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261446AbVBHCrj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 21:47:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261448AbVBHCrj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 21:47:39 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:2210 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261446AbVBHCrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 21:47:17 -0500
Date: Mon, 7 Feb 2005 21:47:14 -0500
From: Noel Maddy <noel@zhtwn.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jan Kasprzak <kas@fi.muni.cz>, Jens Axboe <axboe@suse.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Memory leak in 2.6.11-rc1? (also here)
Message-ID: <20050208024714.GA16808@uglybox.localnet>
Reply-To: Noel Maddy <noel@zhtwn.com>
References: <20050121161959.GO3922@fi.muni.cz> <20050207110030.GI24513@fi.muni.cz> <Pine.LNX.4.58.0502070728280.2165@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0502070728280.2165@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2005 at 07:38:12AM -0800, Linus Torvalds wrote:
> 
> Whee. You've got 5 _million_ bio's "active". Which account for about 750MB
> of your 860MB of slab usage.

Same situation here, at different rates on two different platforms,
both running same kernel build. Both show steadily increasing biovec-1.

uglybox was previously running Ingo's 2.6.11-rc2-RT-V0.7.36-03, and was
well over 3,000,000 bios after about a week of uptime. With only 512M of
memory, it was pretty sluggish.

Interesting that the 4-disk RAID5 seems to be growing about 4 times as
fast as the RAID1.

If there's anything else that could help, or patches you want me to try,
just ask.

Details:

=================================
#1: Soyo KT600 Platinum, Athlon 2500+, 512MB
	2 SATA, 2 PATA (all on 8237)
	RAID1 and RAID5
	on-board tg3
================================

>uname -a
Linux uglybox 2.6.11-rc3 #2 Thu Feb 3 16:19:44 EST 2005 i686 GNU/Linux
>uptime
 21:27:47 up  7:04,  4 users,  load average: 1.06, 1.03, 1.02
>grep '^bio' /proc/slabinfo
biovec-(256)         256    256   3072    2    2 : tunables   24   12    0 : slabdata    128    128      0
biovec-128           256    260   1536    5    2 : tunables   24   12    0 : slabdata     52     52      0
biovec-64            256    260    768    5    1 : tunables   54   27    0 : slabdata     52     52      0
biovec-16            256    260    192   20    1 : tunables  120   60    0 : slabdata     13     13      0
biovec-4             256    305     64   61    1 : tunables  120   60    0 : slabdata      5      5      0
biovec-1           64547  64636     16  226    1 : tunables  120   60    0 : slabdata    286    286      0
bio                64551  64599     64   61    1 : tunables  120   60    0 : slabdata   1059   1059      0
>lsmod
Module                  Size  Used by
ppp_deflate             4928  2 
zlib_deflate           21144  1 ppp_deflate
bsd_comp                5376  0 
ppp_async               9280  1 
crc_ccitt               1728  1 ppp_async
ppp_generic            21396  7 ppp_deflate,bsd_comp,ppp_async
slhc                    6720  1 ppp_generic
radeon                 76224  1 
ipv6                  235456  27 
pcspkr                  3300  0 
tg3                    84932  0 
ohci1394               31748  0 
ieee1394               94196  1 ohci1394
snd_cmipci             30112  1 
snd_pcm_oss            48480  0 
snd_mixer_oss          17728  1 snd_pcm_oss
usbhid                 31168  0 
snd_pcm                83528  2 snd_cmipci,snd_pcm_oss
snd_page_alloc          7620  1 snd_pcm
snd_opl3_lib            9472  1 snd_cmipci
snd_timer              21828  2 snd_pcm,snd_opl3_lib
snd_hwdep               7456  1 snd_opl3_lib
snd_mpu401_uart         6528  1 snd_cmipci
snd_rawmidi            20704  1 snd_mpu401_uart
snd_seq_device          7116  2 snd_opl3_lib,snd_rawmidi
snd                    48996  12 snd_cmipci,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_opl3_lib,snd_timer,snd_hwdep,snd_mpu401_uart,snd_rawmidi,snd_seq_device
soundcore               7648  1 snd
uhci_hcd               29968  0 
ehci_hcd               29000  0 
usbcore               106744  4 usbhid,uhci_hcd,ehci_hcd
dm_mod                 52796  0 
it87                   23900  0 
eeprom                  5776  0 
lm90                   11044  0 
i2c_sensor              2944  3 it87,eeprom,lm90
i2c_isa                 1728  0 
i2c_viapro              6412  0 
i2c_core               18512  6 it87,eeprom,lm90,i2c_sensor,i2c_isa,i2c_viapro
>lspci
0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400/KT600 AGP] Host Bridge (rev 80)
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge
0000:00:07.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5705 Gigabit Ethernet (rev 03)
0000:00:0d.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 46)
0000:00:0e.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
0000:00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA RAID Controller (rev 80)
0000:00:0f.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
0000:00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
0000:00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge [K8T800 South]
0000:00:13.0 RAID bus controller: Silicon Image, Inc. (formerly CMD Technology Inc) SiI 3112 [SATALink/SATARaid] Serial ATA Controller (rev 02)
0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon RV200 QW [Radeon 7500]
>cat /proc/mdstat
Personalities : [raid0] [raid1] [raid5] 
md1 : active raid1 sdb1[0] sda1[1]
      489856 blocks [2/2] [UU]
      
md4 : active raid5 sdb3[2] sda3[3] hdc3[1] hda3[0]
      8795136 blocks level 5, 128k chunk, algorithm 2 [4/4] [UUUU]
      
md5 : active raid5 sdb5[2] sda5[3] hdc5[1] hda5[0]
      14650752 blocks level 5, 128k chunk, algorithm 2 [4/4] [UUUU]
      
md6 : active raid5 sdb6[2] sda6[3] hdc6[1] hda6[0]
      43953408 blocks level 5, 128k chunk, algorithm 2 [4/4] [UUUU]
      
md7 : active raid5 sdb7[2] sda7[3] hdc7[1] hda7[0]
      164103552 blocks level 5, 128k chunk, algorithm 2 [4/4] [UUUU]
      
md0 : active raid1 hdc1[1] hda1[0]
      489856 blocks [2/2] [UU]
      
unused devices: <none>

================================
#2: Soyo KT400 Platinum, Athlon 2500+, 512MB
	2 PATA (one on 8235, one on HPT372)
	RAID1
	on-board via rhine
================================

>uname -a
Linux lepke 2.6.11-rc3 #2 Thu Feb 3 16:19:44 EST 2005 i686 GNU/Linux
>uptime
 21:30:13 up  7:16,  1 user,  load average: 1.00, 1.00, 1.23
>grep '^bio' /proc/slabinfo
biovec-(256)         256    256   3072    2    2 : tunables   24   12    0 : slabdata    128    128      0
biovec-128           256    260   1536    5    2 : tunables   24   12    0 : slabdata     52     52      0
biovec-64            256    260    768    5    1 : tunables   54   27    0 : slabdata     52     52      0
biovec-16            256    260    192   20    1 : tunables  120   60    0 : slabdata     13     13      0
biovec-4             256    305     64   61    1 : tunables  120   60    0 : slabdata      5      5      0
biovec-1           14926  15142     16  226    1 : tunables  120   60    0 : slabdata     67     67      0
bio                14923  15006     64   61    1 : tunables  120   60    0 : slabdata    246    246      0
Module                  Size  Used by
ipv6                  235456  17 
pcspkr                  3300  0 
tuner                  21220  0 
ub                     15324  0 
usbhid                 31168  0 
bttv                  146064  0 
video_buf              17540  1 bttv
firmware_class          7936  1 bttv
i2c_algo_bit            8840  1 bttv
v4l2_common             4736  1 bttv
btcx_risc               3912  1 bttv
tveeprom               11544  1 bttv
videodev                7488  1 bttv
uhci_hcd               29968  0 
ehci_hcd               29000  0 
usbcore               106744  5 ub,usbhid,uhci_hcd,ehci_hcd
via_ircc               23380  0 
irda                  121784  1 via_ircc
crc_ccitt               1728  1 irda
via_rhine              19844  0 
mii                     4032  1 via_rhine
dm_mod                 52796  0 
snd_bt87x              12360  0 
snd_cmipci             30112  0 
snd_opl3_lib            9472  1 snd_cmipci
snd_hwdep               7456  1 snd_opl3_lib
snd_mpu401_uart         6528  1 snd_cmipci
snd_cs46xx             85064  0 
snd_rawmidi            20704  2 snd_mpu401_uart,snd_cs46xx
snd_seq_device          7116  2 snd_opl3_lib,snd_rawmidi
snd_ac97_codec         73976  1 snd_cs46xx
snd_pcm_oss            48480  0 
snd_mixer_oss          17728  1 snd_pcm_oss
snd_pcm                83528  5 snd_bt87x,snd_cmipci,snd_cs46xx,snd_ac97_codec,snd_pcm_oss
snd_timer              21828  2 snd_opl3_lib,snd_pcm
snd                    48996  13 snd_bt87x,snd_cmipci,snd_opl3_lib,snd_hwdep,snd_mpu401_uart,snd_cs46xx,snd_rawmidi,snd_seq_device,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
soundcore               7648  1 snd
snd_page_alloc          7620  3 snd_bt87x,snd_cs46xx,snd_pcm
lm90                   11044  0 
eeprom                  5776  0 
it87                   23900  0 
i2c_sensor              2944  3 lm90,eeprom,it87
i2c_isa                 1728  0 
i2c_viapro              6412  0 
i2c_core               18512  10 tuner,bttv,i2c_algo_bit,tveeprom,lm90,eeprom,it87,i2c_sensor,i2c_isa,i2c_viapro
0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400/KT600 AGP] Host Bridge
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8235 PCI Bridge
0000:00:09.0 Multimedia audio controller: Cirrus Logic CS 4614/22/24 [CrystalClear SoundFusion Audio Accelerator] (rev 01)
0000:00:0b.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
0000:00:0b.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
0000:00:0e.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
0000:00:0f.0 RAID bus controller: Triones Technologies, Inc. HPT366/368/370/370A/372 (rev 05)
0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80)
0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80)
0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80)
0000:00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
0000:00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
0000:00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 74)
0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R200 QM [Radeon 9100]
Personalities : [raid0] [raid1] [raid5] 
md4 : active raid1 hda1[0] hde1[1]
      995904 blocks [2/2] [UU]
      
md5 : active raid1 hda2[0] hde2[1]
      995904 blocks [2/2] [UU]
      
md6 : active raid1 hda7[0] hde7[1]
      5855552 blocks [2/2] [UU]
      
md7 : active raid0 hda8[0] hde8[1]
      136496128 blocks 32k chunks
      
unused devices: <none>


-- 
Educators cannot hope to instill a desire for life-long learning in
students until they themselves are life-long learners.
					    -- cvd6262, on slashdot.org
+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
Noel Maddy <noel@zhtwn.com>
