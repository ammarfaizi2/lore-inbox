Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261192AbVCLScK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbVCLScK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 13:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbVCLScJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 13:32:09 -0500
Received: from stark.xeocode.com ([216.58.44.227]:7296 "EHLO stark.xeocode.com")
	by vger.kernel.org with ESMTP id S261192AbVCLSbv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 13:31:51 -0500
To: linux-kernel@vger.kernel.org
Subject: OSS Audio borked between 2.6.6 and 2.6.10
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 12 Mar 2005 13:31:43 -0500
Message-ID: <87u0ng90mo.fsf@stark.xeocode.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


OSS Audio doesn't work properly for Quake3 in 2.6.10 but it worked in 2.6.6.
In fact I have the same problems in 2.6.9-rc1 so I assume 2.6.9 is affected as
well. This is with the Intel i810 drivers. 

Quake3 just prints "dropping sound" over and over again and doesn't output any
sound in the actual game (the menus seem to work 50% of the time). I assume
this is related to Quake3's use of the memory mapped audio interface. Perhaps
it's never getting interrupts through the ioctl interface?

Here is the lspci info:

0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) AC'97 Audio Controller (rev 02)
	Subsystem: Asustek Computer, Inc. P4P800 Mainboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 17
	Region 0: I/O ports at e800 [size=256]
	Region 1: I/O ports at ee80 [size=64]
	Region 2: Memory at f7fff400 (32-bit, non-prefetchable) [size=512]
	Region 3: Memory at f7fff000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

I tried it with pci=routeirq but no change.

The strace from quake running on the two kernels looks essentially identical.
Here are all the syscalls that look relevant from the 2.6.10. The output is
essentially identical for 2.6.6 except for the memory addresses, pid, and the
number of omitted read calls where the ellipses are. Note, that it *does*
print "sound system is muted" in 2.6.6 as well, but it works fine.


ioctl(3, SNDCTL_TMR_TIMEBASE or TCGETS, 0xbffff718) = -1 ENOTTY (Inappropriate ioctl for device)
[pid  8904] write(2, "\n------- sound initialization --"..., 38
------- sound initialization -------
[pid  8904] open("/dev/dsp", O_RDWR)    = 19
[pid  8904] ioctl(19, SNDCTL_DSP_GETCAPS, 0xbffff774) = 0
[pid  8904] ioctl(19, SNDCTL_DSP_SPEED or SOUND_PCM_READ_RATE, 0x81776ac) = 0
[pid  8904] ioctl(19, SNDCTL_DSP_STEREO, 0xbffff76c) = 0
[pid  8904] ioctl(19, SNDCTL_DSP_SPEED or SOUND_PCM_READ_RATE, 0x88446b4) = 0
[pid  8904] ioctl(19, SNDCTL_DSP_SETFMT or SOUND_PCM_READ_BITS, 0xbffff768) = 0
[pid  8904] ioctl(19, SNDCTL_DSP_GETOSPACE, 0xbffff780) = 0
[pid  8904] ioctl(19, SNDCTL_DSP_GETTRIGGER, 0xbffff76c) = 0
[pid  8904] ioctl(19, SNDCTL_DSP_GETTRIGGER, 0xbffff76c) = 0
[pid  8904] write(2, "sound system is muted\n", 22sound system is muted
[pid  8904] ioctl(0, SNDCTL_TMR_TIMEBASE or TCGETS, {B38400 opost isig icanon echo ...}) = 0
[pid  8904] ioctl(0, SNDCTL_TMR_TIMEBASE or TCGETS, {B38400 opost isig icanon echo ...}) = 0
[pid  8904] ioctl(0, SNDCTL_TMR_TIMEBASE or TCGETS, {B38400 opost isig icanon echo ...}) = 0
[pid  8904] ioctl(0, SNDCTL_TMR_STOP or TCSETSW, {B38400 opost isig -icanon -echo ...}) = 0
[pid  8904] ioctl(0, SNDCTL_TMR_TIMEBASE or TCGETS, {B38400 opost isig -icanon -echo ...}) = 0
[pid  8904] fcntl64(0, F_GETFL)         = 0x2 (flags O_RDWR)
[pid  8904] fcntl64(0, F_SETFL, O_RDWR|O_NONBLOCK) = 0
[pid  8904] read(0, 0xbfffb62f, 1)      = -1 EAGAIN (Resource temporarily unavailable)
[pid  8904] read(0, 0xbfffb62f, 1)      = -1 EAGAIN (Resource temporarily unavailable)
[pid  8904] read(0, 0xbffef0cf, 1)      = -1 EAGAIN (Resource temporarily unavailable)
[pid  8904] ioctl(19, SNDCTL_DSP_GETOPTR, 0xbffef264) = 0
[pid  8904] read(0, 0xbfffb62f, 1)      = -1 EAGAIN (Resource temporarily unavailable)
[pid  8904] read(0, 0xbffff5af, 1)      = -1 EAGAIN (Resource temporarily unavailable)
[pid  8904] ioctl(19, SNDCTL_DSP_GETOPTR, 0xbffff744) = 0
[pid  8904] read(0, 0xbfffb62f, 1)      = -1 EAGAIN (Resource temporarily unavailable)
[pid  8904] read(0, 0xbfffb62f, 1)      = -1 EAGAIN (Resource temporarily unavailable)
[pid  8904] read(0, 0xbffff5af, 1)      = -1 EAGAIN (Resource temporarily unavailable)
[pid  8904] ioctl(19, SNDCTL_DSP_GETOPTR, 0xbffff744) = 0
[pid  8904] read(0, 0xbfffb62f, 1)      = -1 EAGAIN (Resource temporarily unavailable)
[pid  8904] read(0, 0xbfffb62f, 1)      = -1 EAGAIN (Resource temporarily unavailable)
[pid  8904] read(0, 0xbfffb62f, 1)      = -1 EAGAIN (Resource temporarily unavailable)
...
[pid  8904] ioctl(19, SNDCTL_DSP_GETOPTR, 0xbffff744) = 0
[pid  8904] read(0, 0xbfffb62f, 1)      = -1 EAGAIN (Resource temporarily unavailable)
[pid  8904] read(0, 0xbfffb62f, 1)      = -1 EAGAIN (Resource temporarily unavailable)
[pid  8904] read(0, 0xbfffb62f, 1)      = -1 EAGAIN (Resource temporarily unavailable)
...
[pid  8904] ioctl(19, SNDCTL_DSP_GETOPTR, 0xbffff744) = 0
[pid  8904] read(0, 0xbfffb62f, 1)      = -1 EAGAIN (Resource temporarily unavailable)
[pid  8904] read(0, 0xbfffb62f, 1)      = -1 EAGAIN (Resource temporarily unavailable)
[pid  8904] read(0, 0xbfffdfcb, 1)      = -1 EAGAIN (Resource temporarily unavailable)
[pid  8904] write(2, "dropping sound\n", 15dropping sound
[pid  8904] read(0, 0xbfffdfc3, 1)      = -1 EAGAIN (Resource temporarily unavailable)
[pid  8904] write(2, "dropping sound\n", 15dropping sound
[pid  8904] read(0, 0xbfffdef3, 1)      = -1 EAGAIN (Resource temporarily unavailable)
[pid  8904] read(0, 0xbffff5af, 1)      = -1 EAGAIN (Resource temporarily unavailable)











The list of modules in 2.6.10

Module                  Size  Used by
vmnet                  30640  12 
parport_pc             37188  0 
parport                36552  1 parport_pc
vmmon                  48352  0 
binfmt_misc            12296  1 
ipv6                  243584  18 
8250                   24292  0 
serial_core            22784  1 8250
i2c_i801                8716  0 
hw_random               5908  0 
uhci_hcd               34188  0 
evdev                   9216  0 
ehci_hcd               44164  0 
usbcore               129656  3 uhci_hcd,ehci_hcd
snd_intel8x0           32032  0 
snd_ac97_codec         70752  1 snd_intel8x0
snd_pcm                95492  2 snd_intel8x0,snd_ac97_codec
snd_timer              25476  1 snd_pcm
snd_page_alloc         10116  2 snd_intel8x0,snd_pcm
bttv                  151760  0 
video_buf              22148  1 bttv
firmware_class         10240  1 bttv
i2c_algo_bit            9864  1 bttv
v4l2_common             6016  1 bttv
btcx_risc               5128  1 bttv
i2c_core               22784  3 i2c_i801,bttv,i2c_algo_bit
videodev               10112  1 bttv
md                     46032  0 
dm_mod                 58496  0 
gameport                4992  0 
snd_mpu401_uart         8192  0 
snd_rawmidi            24864  1 snd_mpu401_uart
snd_seq_device          8972  1 snd_rawmidi
snd                    54116  7 snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device
mga                   118676  2 
intel_agp              21660  1 
agpgart                34092  2 intel_agp
sk98lin               162920  1 
i810_audio             37396  1 
ac97_codec             17804  1 i810_audio
rtc                    12872  0 

The list of modules in 2.6.6:

Module                  Size  Used by
vmnet                  31504  12 
parport_pc             28832  0 
parport                42312  1 parport_pc
vmmon                  49376  0 
binfmt_misc            11144  1 
ipv6                  254432  20 
8250                   23232  0 
serial_core            24320  1 8250
ehci_hcd               40836  0 
usbcore               116956  3 ehci_hcd
snd_intel8x0           28968  0 
snd_ac97_codec         64004  1 snd_intel8x0
snd_pcm                98976  1 snd_intel8x0
snd_timer              26628  1 snd_pcm
snd_page_alloc         11652  2 snd_intel8x0,snd_pcm
gameport                5248  1 snd_intel8x0
snd_mpu401_uart         8576  1 snd_intel8x0
snd_rawmidi            25248  1 snd_mpu401_uart
snd_seq_device          8456  1 snd_rawmidi
snd                    53860  7 snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device
bttv                  143468  0 
video_buf              21508  1 bttv
i2c_algo_bit            9992  1 bttv
v4l2_common             6528  1 bttv
btcx_risc               5128  1 bttv
i2c_core               23684  2 bttv,i2c_algo_bit
videodev                9984  1 bttv
md                     47560  0 
dm_mod                 43424  0 
mga                   104880  2 
intel_agp              17308  1 
agpgart                33964  2 intel_agp
sk98lin               167592  1 
i810_audio             30996  1 
ac97_codec             18828  1 i810_audio
rtc                    14152  0 



-- 
greg

