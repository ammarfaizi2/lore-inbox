Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266707AbUGQNj3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266707AbUGQNj3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 09:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266708AbUGQNj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 09:39:29 -0400
Received: from 23-88.ipact.nl ([82.210.88.23]:54921 "EHLO vt.shuis.tudelft.nl")
	by vger.kernel.org with ESMTP id S266707AbUGQNjZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 09:39:25 -0400
Message-ID: <3053.217.166.227.249.1090070961.squirrel@vt.shuis.tudelft.nl>
In-Reply-To: <1090011648.30657.9.camel@mindpipe>
References: <200407161116.38493.remon@vt.shuis.tudelft.nl>
    <1090011648.30657.9.camel@mindpipe>
Date: Sat, 17 Jul 2004 15:29:21 +0200 (CEST)
Subject: Re: Losing interrupts
From: "Remon Sijrier" <remon@vt.shuis.tudelft.nl>
To: "Lee Revell" <rlrevell@joe-job.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
Reply-To: remon@vt.shuis.tudelft.nl
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks!

I'm unfortunately not able to work on this for some weeks, I'm not at home.
As soon as I have some results I'll post them here.


Remon

> On Fri, 2004-07-16 at 05:16, Remon Sijrier wrote:
>> Hello,
>>
>> First, thanks a lot for the work done and still done for tackling the
>> latency
>> issues in the kernel.
>>
>> I'm interested in this area, and want to do some testing as well.
>> Lee Revel, could you please sent me the changes you made for measuring
>> interrupt times to me?
>>
>
> It's pretty sloppy, but it is just debugging code.  This patch is for
> emu10k1, you will have to adapt this to your driver (ice1712).
> Basically you just add a couple of fields to the card record to track
> the time the last interrupt occurred, and the time elapsed between the
> previous two interrupts.  Then, if you launch a program like JACK that
> should cause the soundcard interrupts to happen at a fixed interval, you
> can use some heuristics to figure out whether you have lost an
> interrupt.
>
> Also the fscking tabs below have been mangled to spaces, I am not sure
> if this is caused by copying from xterm, or pasting into Evolution, but
> I am not too happy about it.
>
> Index: include/emu10k1.h
> ===================================================================
> RCS file: /cvsroot/alsa/alsa-kernel/include/emu10k1.h,v
> retrieving revision 1.43
> diff -u -r1.43 emu10k1.h
> --- include/emu10k1.h   1 Jul 2004 09:22:16 -0000       1.43
> +++ include/emu10k1.h   16 Jul 2004 20:54:16 -0000
> @@ -1003,6 +1003,9 @@
>         emu10k1_midi_t midi2; /* for audigy */
>
>         unsigned int efx_voices_mask[2];
> +
> +       cycles_t last_interrupt_time;
> +       int last_delay;
>  };
>
>  int snd_emu10k1_create(snd_card_t * card,
> Index: pci/emu10k1/emupcm.c
> ===================================================================
> RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emupcm.c,v
> retrieving revision 1.29
> diff -u -r1.29 emupcm.c
> --- pci/emu10k1/emupcm.c        1 Jul 2004 09:22:16 -0000       1.29
> +++ pci/emu10k1/emupcm.c        16 Jul 2004 20:51:02 -0000
> @@ -37,6 +37,26 @@
>  static void snd_emu10k1_pcm_interrupt(emu10k1_t *emu, emu10k1_voice_t
> *voice)
>  {
>         emu10k1_pcm_t *epcm;
> +       cycles_t then;
> +       cycles_t now;
> +       int delay;
> +       int jitter;
> +
> +       then = emu->last_interrupt_time;
> +       now = get_cycles ();
> +       emu->last_interrupt_time = now;
> +
> +       delay = now - then;
> +       jitter = abs( delay - emu->last_delay );
> +
> +       if (jitter > 50000) {
> +           printk("IRQ: delay =  %i cycles, jitter = %i\n", delay,
> jitter);
> +       }
> +        if (jitter * 2 > emu->last_delay ) {
> +           printk("IRQ: delay =  %i cycles, jitter = %i - missed an
> interrupt?\n", delay,  jitter);
> +       }
> +
> +       emu->last_delay = delay;
>
>         if ((epcm = voice->epcm) == NULL)
>                 return;
> @@ -816,6 +836,8 @@
>         mix->send_volume[1][0] = mix->send_volume[2][1] = 255;
>         mix->attn[0] = mix->attn[1] = mix->attn[2] = 0xffff;
>         mix->epcm = epcm;
> +       emu->last_interrupt_time = 0;
> +       emu->last_delay = 0;
>         snd_emu10k1_pcm_mixer_notify(emu, substream->number, 1);
>         return 0;
>  }
>
> Lee
>
>

