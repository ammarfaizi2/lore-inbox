Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261679AbSJHSyP>; Tue, 8 Oct 2002 14:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261698AbSJHSyP>; Tue, 8 Oct 2002 14:54:15 -0400
Received: from [209.48.37.1] ([209.48.37.1]:17026 "EHLO xdr.com")
	by vger.kernel.org with ESMTP id <S261679AbSJHSyM>;
	Tue, 8 Oct 2002 14:54:12 -0400
Date: Tue, 8 Oct 2002 11:59:39 -0700
From: David Ashley <dash@xdr.com>
Message-Id: <200210081859.g98Ixdi31844@xdr.com>
To: linux-kernel@vger.kernel.org
Subject: Possible bug with Via VT8235 alsa sound driver
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please cc me on replies.

I'm running 2.5.40 with a via CLE motherboard with VT8235 southbridge
chip. The alsa driver for 8233 (sound/pci/via8233.c) seems to work fine,
meaning the sound output works as expected. I get lots of kernel messages
like below. A very simple program reproduces the problem:
#include <fcntl.h>

int main(int argc,char **argv)
{
int dsp;
	dsp=open("/dev/dsp",O_WRONLY);
	close(dsp);  // After this we get the kernel errors
}

The following repeats dozens and perhaps hundreds of times. I've worked out
from an objdump -d of vmlinux what the functions in the call stack are, and
their addresses.


Jan 19 13:15:44 test kernel: bad: scheduling while atomic!
Jan 19 13:15:44 test kernel: c5f01bcc c011175e c029d300 000003d9 c0241d9a 00000000 c5f01bfc 0003fbb0 
Jan 19 13:15:44 test kernel:        00000026 c118b800 c011d7ae c5f01bfc c035fa10 c035fa10 0003fbb0 c6265920 
Jan 19 13:15:44 test kernel:        c011d710 c035f480 0003fbaf c5f00000 0003fbaf c5f00000 c02459b9 0200b800 
Jan 19 13:15:44 test kernel: Call Trace:
 [<c011175e>] schedule = 111720
 [<c0241d9a>] snd_via8233_codec_ready=241d80
 [<c011d7ae>] schedule_timeout=11d720
 [<c011d710>] process_timeout = 11d710
 [<c02459b9>] snd_ac97_set_rate=245830
 [<c0242359>] snd_via8233_playback_prepare=242330
 [<c0233617>] snd_pcm_prepare=233570
 [<c0235095>] snd_pcm_common_ioctl1=234ec0
 [<c02354b2>] snd_pcm_playback_ioctl1=235160
 [<c0235867>] snd_pcm_kernel_playback_ioctl=235840
 [<c02294d5>] snd_pcm_oss_prepare=2294c0
 [<c0229536>] snd_pcm_oss_make_ready=229500
 [<c0229ccb>] snd_pcm_oss_sync=229cb0
 [<c013c12e>] chrdev_open=13c0d0
 [<c013a74c>] dentry_open=13a74c
 [<c022aeeb>] snd_pcm_oss_release=22aed0
 [<c013c52b>] __fput=13c500
 [<c013ab33>] filp_close=13aa90
 [<c013aba1>] sys_close=13ab40
 [<c0108e57>] syscall_call=108e50

Here are the configs related to sound:
CONFIG_SOUND=y
CONFIG_SND=y
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_VIA686=y
CONFIG_SND_VIA8233=y
All other sound related configs are unset.

I'm happy to run experiments of someone has any suggestions of what to try.

Thanks!
-Dave

