Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264711AbTFLMbr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 08:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264748AbTFLMbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 08:31:47 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:57229 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S264711AbTFLMbn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 08:31:43 -0400
Date: Thu, 12 Jun 2003 14:45:28 +0200
From: bert hubert <ahu@ds9a.nl>
To: perex@suse.cz, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: snd_pcm_oss: Oopsen with resampling
Message-ID: <20030612124528.GA18274@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>, perex@suse.cz,
	linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This code is too weird for me to follow, I would've loved to sent a better
debugged Oops, but I lost it when I found sound/core/oss/plugin_ops.h which
takes addresses of labels and gotos back to a predefined label called
GET_S16_END. Brrr. There is probably a reason for doing it this way but
currently I don't fathom it.

Anyhow, when playing at 22050 Hz, I get the oops below after about 200ms of
sound, at 44010 there is no problem. It doesn't always occur though.

gdb can't trace the line due to the aforementioned goto antics, but the code
mentioned corresponds to this:

get_s16_xx12_xx92: sample = as_u16(src) ^ 0x8000; goto GET_S16_END;
get_s16_xx12_xx21: sample = swab16(as_u16(src)); goto GET_S16_END;
get_s16_xx12_xxA1: sample = swab16(as_u16(src) ^ 0x80); goto GET_S16_END;
get_s16_x123_xx12: sample = as_u32(src) >> 8; goto GET_S16_END;
get_s16_x123_xx92: sample = (as_u32(src) >> 8) ^ 0x8000; goto GET_S16_END;

I have the following modules loaded in my gcc 3.3 compiled 2.5.70 (Debian
Unstable):

$ sudo lsmod
Module                  Size  Used by
snd_pcm_oss            47140  0 
snd_mixer_oss          16512  1 snd_pcm_oss
snd_via82xx            15524  0 
snd_pcm                78752  2 snd_pcm_oss,snd_via82xx
snd_timer              19716  1 snd_pcm
snd_ac97_codec         45828  1 snd_via82xx
snd_page_alloc          7684  2 snd_via82xx,snd_pcm
snd_mpu401_uart         5760  1 snd_via82xx
snd_rawmidi            18592  1 snd_mpu401_uart
snd                    42500  8
snd_pcm_oss,snd_mixer_oss,snd_via82xx,snd_pcm,snd_timer,snd_ac97_codec,snd_mpu401_uart,snd_rawmidi
usbkbd                  6016  0 

Oops:

 <1>Unable to handle kernel paging request at virtual address e08e7000
 printing eip:
e09af98b
*pde = 1fec6067
*pte = 00000000
Oops: 0000 [#3]
CPU:    0
EIP:    0060:[<e09af98b>]    Not tainted
EFLAGS: 00010202
EIP is at resample_expand+0x343/0x377 [snd_pcm_oss]
eax: e09af98b   ebx: 00000001   ecx: 000ae7ff   edx: 8b518e09
esi: e08eaffc   edi: db1f5c0c   ebp: e08e6ffe   esp: d13bde54
ds: 007b   es: 007b   ss: 0068
Process wavp (pid: 27806, threadinfo=d13bc000 task=caf74780)
Stack: e09ace05 db1f5b80 db0dec80 d13bde80 00008cad d23ffa80 00001000 ffffffff 
       e09af7af e09af903 e09af98b db1f5bf0 00000000 00000002 00000002 00000000 
       8e098e09 00000000 00001000 00000800 db1f5b80 d428ee00 e09afe35 db1f5b80 
Call Trace:
 [<e09ace05>] snd_pcm_plug_playback_channels_mask+0x72/0xd8 [snd_pcm_oss]
 [<e09af7af>] resample_expand+0x167/0x377 [snd_pcm_oss]
 [<e09af903>] resample_expand+0x2bb/0x377 [snd_pcm_oss]
 [<e09af98b>] resample_expand+0x343/0x377 [snd_pcm_oss]
 [<e09afe35>] rate_transfer+0x59/0x5d [snd_pcm_oss]
 [<e09ad1dd>] snd_pcm_plug_write_transfer+0x95/0xf4 [snd_pcm_oss]
 [<e09a934c>] snd_pcm_oss_write2+0xae/0x118 [snd_pcm_oss]
 [<c011647b>] default_wake_function+0x0/0x2e
 [<e09a9549>] snd_pcm_oss_write1+0x193/0x1ba [snd_pcm_oss]
 [<e09ab42f>] snd_pcm_oss_write+0x43/0x5d [snd_pcm_oss]
 [<e09ab3ec>] snd_pcm_oss_write+0x0/0x5d [snd_pcm_oss]
 [<c01441cf>] vfs_write+0xb0/0x119
 [<c01442dd>] sys_write+0x42/0x63
 [<c010a62b>] syscall_call+0x7/0xb

Code: 8b 45 00 eb ac 0f b6 45 00 c1 e0 08 eb a3 81 fa 00 80 00 00 

Thanks.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
