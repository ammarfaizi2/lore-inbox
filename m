Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284746AbRLEVZ0>; Wed, 5 Dec 2001 16:25:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284751AbRLEVZS>; Wed, 5 Dec 2001 16:25:18 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:17537 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S284746AbRLEVZJ>; Wed, 5 Dec 2001 16:25:09 -0500
Message-ID: <3C0E90B2.1030601@redhat.com>
Date: Wed, 05 Dec 2001 16:25:06 -0500
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6+) Gecko/20011129
X-Accept-Language: en-us
MIME-Version: 1.0
To: Nathan Bryant <nbryant@optonline.net>
CC: Mario Mikocevic <mozgy@hinet.hr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: i810 audio patch
In-Reply-To: <3C0C16E7.70206@optonline.net> <3C0C508C.40407@redhat.com> <3C0C58DE.9020703@optonline.net> <3C0C5CB2.6000602@optonline.net> <3C0C61CC.1060703@redhat.com> <20011204153507.A842@danielle.hinet.hr> <3C0D1DD2.4040609@optonline.net> <3C0D223E.3020904@redhat.com> <3C0D350F.9010408@optonline.net> <3C0D3CF7.6030805@redhat.com> <3C0D4E62.4010904@optonline.net> <3C0D52F1.5020800@optonline.net> <3C0D5796.6080202@redhat.com> <3C0D5CB6.1080600@optonline.net> <3C0D5FC7.3040408@redhat.com> <3C0D77D9.70205@optonline.net> <3C0D8B00.2040603@optonline.net> <3C0D8F02.8010408@redhat.com> <3C0D9456.6090106@optonline.net> <3C0DA1CC.1070408@redhat.com> <3C0DAD26.1020906@optonline.net> <3C0DAF35.50008@redhat.com> <3C0E7DCB.6050600@optonline.net> <3C0E7DFB.2030400@optonline.net> <3C0E7F1C.4060603@redhat.com> <3C0E8DBF.5010000@optonline.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Bryant wrote:

> Doug Ledford wrote:
> 
>> If that fixes it, then the real fix is to find the bug in 
>> i810_get_free_Wwrite_space() and i810_update_lvi(). 
> 
> 
> It does fix it.
> 
> By the way, I'm confused about something. i810_write appears to overrun 
> the end of the DMA buffer instead of wrapping around to the beginning 
> when it does copy_from_user. which makes no sense to me.


This didn't used to be a bug, but it is now (all these changes and 
merges have let some thigns slip in I'm afraid, and I'm not just 
referring to the work in the last few days, I'm also referring to 
changes that were lost in the time of the S/PDIF and PM merges).

Anyway, in i810_write, the lines that read:

if (cnt > (dmabuf->dmasize - dmabuf->count))
	cnt = dmabuf->dmasize - dmabuf->count;

should read:

if (cnt > (dmabuf->dmasize - swptr))
	cnt = dmabuf->dmasize - swptr;



> so ok, the correct number is 31/32nds, not 3/4ths - not so bad.
> 
>> By using the first function to find the available data in the GETOPTR 
>> ioctl, then using update_lvi(), we *should* be setting the lvi 
>> fragment to exactly 31 sg segments away from the current index.  If 
>> that's failing, and we are instead setting lvi == civ, then things 
>> will stop and not work.
> 
> 
> yeah, i think that's what's happening


Can you add a debug check to update_lvi()?  Something like:

#ifdef DEBUG_MMAP
         if (dmabuf->count > dmabuf->fragsize && inb(port+OFF_CIV) == x)
                 printk(KERN_DEBUG,"i810_audio: update_lvi - CIV == LVI\n");
#endif

and see if that triggers with the original mmap code?





-- 

  Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
       Please check my web site for aic7xxx updates/answers before
                       e-mailing me about problems

