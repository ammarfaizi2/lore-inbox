Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262769AbTJPIbK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 04:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262781AbTJPIbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 04:31:10 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:8424 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S262769AbTJPIbE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 04:31:04 -0400
Date: Thu, 16 Oct 2003 10:31:03 +0200
From: bert hubert <ahu@ds9a.nl>
To: linux-via@gtf.org, linux-kernel@vger.kernel.org
Subject: [PCM OSS] via82xx soundcard Oops
Message-ID: <20031016083103.GA25472@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>, linux-via@gtf.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Via82xx soundcard, on running wavesurfer
(http://www.speech.kth.se/wavesurfer/download.html - excellent), I often get
an oops in snd_pcm_format_set_silence, especially with short segments of
sound:

Unable to handle kernel paging request at virtual address e08ca000
 printing eip: e0923dff
*pde = 1fed3067
*pte = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<e0923dff>]    Not tainted
EFLAGS: 00010217
EIP is at snd_pcm_format_set_silence+0x9f/0x1b0 [snd_pcm]
eax: 00000000   ebx: e08c8000   ecx: 000004e2   edx: 0000338a
esi: 00000002   edi: e08ca000   ebp: 000019c5   esp: d4f9df28
ds: 007b   es: 007b   ss: 0068
Process wish8.4 (pid: 10341, threadinfo=d4f9c000 task=c0f1d880)
Stack: 00000002 e09aa589 000019c5 de226000 dfccf080 de018ce0 e09aabd9 00000002 
       e08c8000 000019c5 c44d3180 de018ce0 ddff2a00 c44d3180 e09abfd2 de018ce0 
       40567aa0 c44d3180 dfff41c0 c897ec0c c9c4f380 c015240b c897ec0c c44d3180 
Call Trace:
 [<e09aa589>] snd_pcm_oss_write1+0x39/0x1f0 [snd_pcm_oss]
 [<e09aabd9>] snd_pcm_oss_sync+0x69/0x160 [snd_pcm_oss]
 [<e09abfd2>] snd_pcm_oss_release+0x22/0xb0 [snd_pcm_oss]
 [<c015240b>] __fput+0xeb/0x100
 [<c0150b19>] filp_close+0x59/0x90
 [<c0150ba0>] sys_close+0x50/0x60
 [<c010b18b>] syscall_call+0x7/0xb

I added a printk to snd_pcm_format_set_silence, it outputs the following
during general playback:

printk("format: %d, %d\n", snd_pcm_format_width(format), samples);

format: 16, 432
format: 16, 4864
format: 16, 16
format: 16, 3344
format: 16, 1520

However, here is the entire log of a short transmit:
>Oct 16 10:24:37 desktop kernel: format: 8, 49200
Oct 16 10:24:37 desktop kernel: format: 16, 32768
Oct 16 10:24:37 desktop kernel: format: 16, 4358
Oct 16 10:24:37 desktop kernel: format: 16, 4864
Oct 16 10:24:37 desktop kernel: format: 16, 16
Oct 16 10:24:37 desktop kernel: format: 16, 5216
Oct 16 10:24:37 desktop kernel: format: 16, 16
Oct 16 10:24:37 desktop kernel: format: 16, 5616
Oct 16 10:24:37 desktop kernel: format: 16, 16
Oct 16 10:24:37 desktop kernel: format: 16, 12
Oct 16 10:24:37 desktop kernel: format: 16, 4
Oct 16 10:24:37 desktop kernel: format: 16, 16
Oct 16 10:24:37 desktop last message repeated 5 times
Oct 16 10:24:37 desktop kernel: format: 16, 8
Oct 16 10:24:37 desktop kernel: format: 16, 8
Oct 16 10:24:37 desktop kernel: format: 16, 16
Oct 16 10:24:37 desktop kernel: format: 16, 6676
Oct 16 10:24:37 desktop kernel: Unable to handle kernel paging request
at virtual address e09ae000

Especially the '8' seems interesting. 

Module                  Size  Used by
nls_iso8859_1           3968  0 
snd_pcm_oss            47652  2 
snd_mixer_oss          16896  1 snd_pcm_oss
snd_via82xx            21472  2 
snd_pcm                84132  2 snd_pcm_oss,snd_via82xx
snd_timer              20868  1 snd_pcm
snd_ac97_codec         51588  1 snd_via82xx
snd_page_alloc          9348  2 snd_via82xx,snd_pcm
snd_mpu401_uart         5888  1 snd_via82xx
snd_rawmidi            19488  1 snd_mpu401_uart
snd                    42724  8
snd_pcm_oss,snd_mixer_oss,snd_via82xx,snd_pcm,snd_timer,snd_ac97_codec,snd_mpu401_uart,snd_rawmidi

I also have weird other things with this driver, a sudden speedup of
playback for a few seconds, where the sound is interleaved with rasping
noises. This speedup stops after a few seconds, and also if I press pause
and play in xmms.

This speedup almost always happens a few seconds after starting playback of
an mp3 with cmms.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
