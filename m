Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161042AbVKXS0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161042AbVKXS0M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 13:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161037AbVKXS0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 13:26:12 -0500
Received: from smtp113.sbc.mail.re2.yahoo.com ([68.142.229.92]:63135 "HELO
	smtp113.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932644AbVKXS0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 13:26:11 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Ricardo Cerqueira <rmcc@linuxtv.org>
Subject: Re: Oops in 2.6.15-rc1
Date: Thu, 24 Nov 2005 13:26:06 -0500
User-Agent: KMail/1.8.3
Cc: Brian Marete <bgmarete@gmail.com>,
       Mauro Carvalho Chehab <mchehab@brturbo.com.br>,
       linux-kernel@vger.kernel.org
References: <6dd519ae0511240209y712549bep6ba626134bb6f502@mail.gmail.com> <1132851413.3229.12.camel@frolic>
In-Reply-To: <1132851413.3229.12.camel@frolic>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511241326.07633.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 24 November 2005 11:56, Ricardo Cerqueira wrote:
> Hello;
> 
> On Thu, 2005-11-24 at 10:09 +0000, Brian Marete wrote:
> 
> [snip]
> 
> > saa7130[0]: option to override the default value.
> > Unable to handle kernel NULL pointer dereference at virtual address 000006d0
> >  printing eip:
> > c0299163
> > *pde = 00000000
> > Oops: 0000 [#1]
> > PREEMPT
> > Modules linked in: saa7134 video_buf v4l2_common v4l1_compat ir_common
> > videodev via_agp agpgart snd_via82xx snd_ac97_codec snd_ac97_bus
> > snd_mpu401_uart snd_rawmidi snd_seq_device snd_rtctimer snd_pcm_oss
> > snd_pcm snd_timer snd_page_alloc snd_mixer_oss snd soundcore video fan
> > button thermal processor via_rhine fuse md5 ipv6 loop rtc pcspkr
> > ide_cd cdrom dm_mod
> > CPU:    0
> > EIP:    0060:[<c0299163>]    Not tainted VLI
> > EFLAGS: 00010296   (2.6.15-rc1)
> > EIP is at input_register_device+0x9/0x180
> 
> This is due to a bug that's already been identified in v4l's input
> support, caused by recent changes in the kernel's own input layer. A
> patch has been proposed at the v4l list but it hasn't been tested yet. 
> A good way to skip this for now is to add "options saa7134 disable_ir=1"
> to you modprobe.conf.
> Be aware that v4l @ rc1 has other problems related to kernel VMA changes
> that render video-buf unusable, and have been fixed after the release of
> rc1. You may want to try the latest -mm.
>

The following fixes it and is merged in mainline. There are also patches
to cinergyT2 and ir-kbd-gpio.

-- 
Dmitry

Fix an OOPS when initializing IR remote on saa7134

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/media/video/saa7134/saa7134-input.c |    2 ++
 1 files changed, 2 insertions(+)

Index: work/drivers/media/video/saa7134/saa7134-input.c
===================================================================
--- work.orig/drivers/media/video/saa7134/saa7134-input.c
+++ work/drivers/media/video/saa7134/saa7134-input.c
@@ -713,6 +713,8 @@ int saa7134_input_init1(struct saa7134_d
 		return -ENOMEM;
 	}
 
+	ir->dev = input_dev;
+
 	/* init hardware-specific stuff */
 	ir->mask_keycode = mask_keycode;
 	ir->mask_keydown = mask_keydown;

