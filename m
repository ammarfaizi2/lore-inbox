Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284470AbRLEVhQ>; Wed, 5 Dec 2001 16:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284657AbRLEVg4>; Wed, 5 Dec 2001 16:36:56 -0500
Received: from odin.allegientsystems.com ([208.251.178.227]:51330 "EHLO
	lasn-001.allegientsystems.com") by vger.kernel.org with ESMTP
	id <S284745AbRLEVgi>; Wed, 5 Dec 2001 16:36:38 -0500
Message-ID: <3C0E935F.3070505@optonline.net>
Date: Wed, 05 Dec 2001 16:36:31 -0500
From: Nathan Bryant <nbryant@optonline.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: Doug Ledford <dledford@redhat.com>
CC: Mario Mikocevic <mozgy@hinet.hr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: i810 audio patch
In-Reply-To: <3C0C16E7.70206@optonline.net> <3C0C508C.40407@redhat.com> <3C0C58DE.9020703@optonline.net> <3C0C5CB2.6000602@optonline.net> <3C0C61CC.1060703@redhat.com> <20011204153507.A842@danielle.hinet.hr> <3C0D1DD2.4040609@optonline.net> <3C0D223E.3020904@redhat.com> <3C0D350F.9010408@optonline.net> <3C0D3CF7.6030805@redhat.com> <3C0D4E62.4010904@optonline.net> <3C0D52F1.5020800@optonline.net> <3C0D5796.6080202@redhat.com> <3C0D5CB6.1080600@optonline.net> <3C0D5FC7.3040408@redhat.com> <3C0D77D9.70205@optonline.net> <3C0D8B00.2040603@optonline.net> <3C0D8F02.8010408@redhat.com> <3C0D9456.6090106@optonline.net> <3C0DA1CC.1070408@redhat.com> <3C0DAD26.1020906@optonline.net> <3C0DAF35.50008@redhat.com> <3C0E7DCB.6050600@optonline.net> <3C0E7DFB.2030400@optonline.net> <3C0E7F1C.4060603@redhat.com> <3C0E8DBF.5010000@optonline.net> <3C0E90B2.1030601@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Ledford wrote:

> This didn't used to be a bug, but it is now (all these changes and 
> merges have let some thigns slip in I'm afraid, and I'm not just 
> referring to the work in the last few days, I'm also referring to 
> changes that were lost in the time of the S/PDIF and PM merges). 

Agreed. There are some uglies...

>
>
> Anyway, in i810_write, the lines that read:
>
> if (cnt > (dmabuf->dmasize - dmabuf->count))
>     cnt = dmabuf->dmasize - dmabuf->count;
>
> should read:
>
> if (cnt > (dmabuf->dmasize - swptr))
>     cnt = dmabuf->dmasize - swptr; 

Okay. I thought I was being stupid. :-)

> Can you add a debug check to update_lvi()?  Something like:
>
> #ifdef DEBUG_MMAP
>         if (dmabuf->count > dmabuf->fragsize && inb(port+OFF_CIV) == x)
>                 printk(KERN_DEBUG,"i810_audio: update_lvi - CIV == 
> LVI\n");
> #endif
>
> and see if that triggers with the original mmap code? 

Actually, I think I *may* have found the problem, in update ptr, it 
should look like this: going to test in a moment

        /* error handling and process wake up for DAC */
        if (dmabuf->enable == DAC_RUNNING) {
                /* update hardware pointer */
                hwptr = i810_get_dma_addr(state, 0);
                diff = hwptr - dmabuf->hwptr;
                if (hwptr < dmabuf->hwptr)
                        diff += dmabuf->dmasize;
#if defined(DEBUG_INTERRUPTS) || defined(DEBUG_MMAP)
                printk("DAC HWP %d,%d,%d\n", hwptr, dmabuf->hwptr, diff);
#endif

reason: hwptr hits 65536 which is indistinguishable from 0 in mod arithmetic

also, I ran your other DEBUG_MMAP patch and the news is that count just 
sits at 65536 ad nauseum.

