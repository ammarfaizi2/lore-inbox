Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261355AbVDBXtA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbVDBXtA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 18:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261370AbVDBXtA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 18:49:00 -0500
Received: from smtp06.auna.com ([62.81.186.16]:27095 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S261355AbVDBXso (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 18:48:44 -0500
Message-ID: <424F20F6.8010804@latinsud.com>
Date: Sun, 03 Apr 2005 00:47:18 +0200
From: "SuD (Alex)" <sud@latinsud.com>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Oops in set_spdif_output in i810_audio
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, i got a new ahtec laptop and i get null pointer oops everytime i 
load i810_audio on 2.4 and 2.6 (including 2.6.11.6) kernels.

*** These are init messages & oops:
i810_audio: Unknown symbol ac97_set_dac_rate
i810_audio: Unknown symbol ac97_release_codec
i810_audio: Unknown symbol ac97_set_adc_rate
i810_audio: Unknown symbol ac97_alloc_codec
i810_audio: Unknown symbol ac97_probe_codec
Intel 810 + AC97 Audio, version 1.01, 04:15:45 Jan 24 2005
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 10 (level, low) -> IRQ 10
i810: Intel ICH4 found at IO 0x18c0 and 0x1c00, MEM 0xe0100c00 and 
0xe0100800, IRQ 10
i810: Intel ICH4 mmio at 0xde9f3c00 and 0xdea84800
i810_audio: Primary codec has ID 0
i810_audio: Audio Controller supports 6 channels.
i810_audio: Defaulting to base 2 channel mode.
i810_audio: Resetting connection 0
i810_audio: Connection 0 with codec id 0
ac97_codec: AC97 Modem codec, id: CXT48 (Unknown)
i810_audio: codec 0 is a softmodem - skipping.
...
EIP:    0060:[<dec4b172>]    Not tainted
EFLAGS: 00010246   (2.6.8-2-686)
EIP is at i810_set_spdif_output+0x22/0x160 [i810_audio]
eax: ffffffff   ebx: 00000000   ecx: d9c28400   edx: d9c28400
esi: 00000000   edi: 00000000   ebp: d6edfb80   esp: d7383e30
ds: 007b   es: 007b   ss: 0068
Process insmod (pid: 3358, threadinfo=d7382000 task=dca643b0)
Stack: 00004461 ffffffce c011c7f4 00000000 d6edfb80 00000000 d6edfc18 
00000000
       dec4ff9f d6edfb80 ffffffff 00000000 dec51740 d7383e7c dda3c240 
00000a04
       d9c28400 dec4fdb0 d6edfbb0 d9c28400 00000000 00000001 00000000 
00000001
Call Trace:
 [<c011c7f4>] release_console_sem+0xc4/0xd0
 [<dec4ff9f>] i810_configure_clocking+0xbf/0x4c0 [i810_audio]
 [<dec4fdb0>] i810_ac97_init+0x4a0/0x5d0 [i810_audio]
 [<dec5084f>] i810_probe+0x4af/0x690 [i810_audio]

*** This is my device:
0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801DB/DBL/DBM 
(ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 03)
        Subsystem: QUANTA Computer Inc: Unknown device 0707
        Flags: bus master, medium devsel, latency 0, IRQ 10
        I/O ports at 1c00 [size=256]
        I/O ports at 18c0 [size=64]
        Memory at e0100c00 (32-bit, non-prefetchable) [size=512]
        Memory at e0100800 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2


*** What happened in set_spdif_output:
      struct ac97_codec *codec = state->card->ac97_codec[0];
     // ... for some reason codec is NULL, and then
      if(!codec->codec_ops->digital)
     // ... oops

*** Why is that null?
   Perhaps it is because the driver thinks that the card is a modem and 
releases it. So no codecs are available, but some functions expect at 
least one codec to exist.

   if(codec->modem)
                {
                        printk(KERN_WARNING "i810_audio: codec %d is a 
softmodem - skipping.\n", ac97_id);
                        ac97_release_codec(codec);

  And is detected as modem because of this condition (in ac97_codec.c):
  /* Check for an AC97 1.0 soft modem (ID1) */
  if(codec->codec_read(codec, AC97_RESET) & 2)                        

I don't know much about ac97, i also have an ac97 modem. Anybody knows 
what is wrong?

Btw, Alsa snd-intel8x0 driver works, but as many distros still default 
to Oss i think this bug should be hunt.

