Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283766AbRLEFK3>; Wed, 5 Dec 2001 00:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283764AbRLEFKJ>; Wed, 5 Dec 2001 00:10:09 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:18077 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S283761AbRLEFKH>; Wed, 5 Dec 2001 00:10:07 -0500
Message-ID: <3C0DAC2C.8060506@redhat.com>
Date: Wed, 05 Dec 2001 00:10:04 -0500
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6+) Gecko/20011129
X-Accept-Language: en-us
MIME-Version: 1.0
To: Nathan Bryant <nbryant@optonline.net>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mario Mikocevic <mozgy@hinet.hr>
Subject: Re: i810 audio patch
In-Reply-To: <3C0C16E7.70206@optonline.net> <3C0C508C.40407@redhat.com> <3C0C58DE.9020703@optonline.net> <3C0C5CB2.6000602@optonline.net> <3C0C61CC.1060703@redhat.com> <20011204153507.A842@danielle.hinet.hr> <3C0D1DD2.4040609@optonline.net> <3C0D223E.3020904@redhat.com> <3C0D350F.9010408@optonline.net> <3C0D3CF7.6030805@redhat.com> <3C0D4E62.4010904@optonline.net> <3C0D52F1.5020800@optonline.net> <3C0D5796.6080202@redhat.com> <3C0D5CB6.1080600@optonline.net> <3C0D5FC7.3040408@redhat.com> <3C0D77D9.70205@optonline.net> <3C0D8B00.2040603@optonline.net> <3C0D8F02.8010408@redhat.com> <3C0D9456.6090106@optonline.net> <3C0DA588.2080000@optonline.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Bryant wrote:

> 
> 
> got this during a quake run with only DEBUG_INTERRUPTS enabled
> 
> it seems that we aren't making it properly chase its tail during mmap 
> mode.


Yes and no.  We aren't chasing our tail, but that's because the 
application is suppossed to call the GETOPTR ioctl in order to trigger a 
pointer update.  In short, the GETOPTR ioctl is our cue that the 
application knows about the empty space and will fill it.  We can always 
make the thing chase it's tail unconditionally, but then you risk 
playing total garbage when the application falls behind :-/

> so it runs through once and then stops. the final timeout is 
> waiting for a completion that's never going to come.
> 
> Dec  4 23:33:50 lasn-001 kernel: Intel 810 + AC97 Audio, version 0.07, 
> 23:28:08 Dec  4 2001
> Dec  4 23:33:50 lasn-001 kernel: PCI: Setting latency timer of device 
> 00:1f.5 to 64
> Dec  4 23:33:50 lasn-001 kernel: i810: Intel ICH 82801AA found at IO 
> 0x2400 and 0x2000, IRQ 17
> Dec  4 23:33:51 lasn-001 kernel: i810_audio: Audio Controller supports 2 
> channels.
> Dec  4 23:33:51 lasn-001 kernel: ac97_codec: AC97 Audio codec, id: 
> 0x4144:0x5360 (Analog Devices AD1885)
> Dec  4 23:33:51 lasn-001 kernel: i810_audio: AC'97 codec 0 Unable to map 
> surround DAC's (or DAC's not present), total channels = 2
> Dec  4 23:33:51 lasn-001 kernel: i810_audio: setting clocking to 41231
> Dec  4 23:34:00 lasn-001 kernel: NVRM: AGPGART: allocated 257 pages
> Dec  4 23:34:00 lasn-001 kernel: NVRM: AGPGART: allocated 128 pages
> Dec  4 23:34:00 lasn-001 kernel: CHANNEL NUM 1 PORT 10 IRQ ( ST8 DAC HWP 
> 16384,0,16384
> Dec  4 23:34:00 lasn-001 kernel: COMP 8 )
> Dec  4 23:34:01 lasn-001 kernel: CHANNEL NUM 1 PORT 10 IRQ ( ST8 DAC HWP 
> 32768,16384,16384
> Dec  4 23:34:01 lasn-001 kernel: COMP 16 )
> Dec  4 23:34:01 lasn-001 kernel: CHANNEL NUM 1 PORT 10 IRQ ( ST8 DAC HWP 
> 49152,32768,16384
> Dec  4 23:34:01 lasn-001 kernel: COMP 24 )
> Dec  4 23:34:01 lasn-001 kernel: CHANNEL NUM 1 PORT 10 IRQ ( ST15 DAC 
> HWP 65536,49152,16384
> Dec  4 23:34:01 lasn-001 kernel: COMP 32 DAC HWP 65536,65536,0
> Dec  4 23:34:01 lasn-001 kernel: LVI DAC HWP 65536,65536,0
> Dec  4 23:34:01 lasn-001 kernel: DCH - STOP )
> Dec  4 23:34:02 lasn-001 kernel: cdrom: open failed.
> Dec  4 23:34:03 lasn-001 kernel: DAC HWP 65536,65536,0


Interesting...two seconds after the buffer ran out of data, quake 
*finally* calls one of the ioctls that then calls i810_update_ptrs()...


> Dec  4 23:34:07 lasn-001 kernel: NVRM: AGPGART: freed 128 pages
> Dec  4 23:34:07 lasn-001 kernel: NVRM: AGPGART: freed 257 pages
> Dec  4 23:34:07 lasn-001 kernel: DAC HWP 65536,65536,0
> Dec  4 23:34:10 lasn-001 kernel: i810_audio: drain_dac, dma timeout?


I see no reason to drain the dac on close for mmaped stuff.  The 
application can check GETOPTR to see if the last stuff has played if it 
really cares that much.  I'm going to skip the drain_dac() calls on mmap 
from now on.  That will solve that problem (and it's also the right 
thing to do if we are chasing our tail and have set the software pointer 
to God only knows where as far as the final sounds are concerned).


> 



-- 

  Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
       Please check my web site for aic7xxx updates/answers before
                       e-mailing me about problems

