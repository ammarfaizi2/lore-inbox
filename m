Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284857AbRLEXwI>; Wed, 5 Dec 2001 18:52:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284859AbRLEXvy>; Wed, 5 Dec 2001 18:51:54 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:3792 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S284857AbRLEXvT>; Wed, 5 Dec 2001 18:51:19 -0500
Message-ID: <3C0EB2F6.6040402@redhat.com>
Date: Wed, 05 Dec 2001 18:51:18 -0500
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6+) Gecko/20011129
X-Accept-Language: en-us
MIME-Version: 1.0
To: Nathan Bryant <nbryant@optonline.net>
CC: Mario Mikocevic <mozgy@hinet.hr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: i810 audio patch
In-Reply-To: <3C0C16E7.70206@optonline.net> <3C0C508C.40407@redhat.com> <3C0C58DE.9020703@optonline.net> <3C0C5CB2.6000602@optonline.net> <3C0C61CC.1060703@redhat.com> <20011204153507.A842@danielle.hinet.hr> <3C0D1DD2.4040609@optonline.net> <3C0D223E.3020904@redhat.com> <3C0D350F.9010408@optonline.net> <3C0D3CF7.6030805@redhat.com> <3C0D4E62.4010904@optonline.net> <3C0D52F1.5020800@optonline.net> <3C0D5796.6080202@redhat.com> <3C0D5CB6.1080600@optonline.net> <3C0D5FC7.3040408@redhat.com> <3C0D77D9.70205@optonline.net> <3C0D8B00.2040603@optonline.net> <3C0D8F02.8010408@redhat.com> <3C0D9456.6090106@optonline.net> <3C0DA1CC.1070408@redhat.com> <3C0DAD26.1020906@optonline.net> <3C0DAF35.50008@redhat.com> <3C0E7DCB.6050600@optonline.net> <3C0E7DFB.2030400@optonline.net> <3C0E7F1C.4060603@redhat.com> <3C0E8DBF.5010000@optonline.net> <3C0E90B2.1030601@redhat.com> <3C0EB1F2.7050007@optonline.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Bryant wrote:

> Doug Ledford wrote:
> 
>> Can you add a debug check to update_lvi()?  Something like:
>>
>> #ifdef DEBUG_MMAP
>>         if (dmabuf->count > dmabuf->fragsize && inb(port+OFF_CIV) == x)
>>                 printk(KERN_DEBUG,"i810_audio: update_lvi - CIV == 
>> LVI\n");
>> #endif
>>
>> and see if that triggers with the original mmap code? 
> 
> 
> I've narrowed it down a little more.. the above does not trigger. but 
> i've added some other printk's and the sequence of events goes like this:
> 
> open, mmap
> SETTRIGGER : works properly with the resync_dma removed; count 
> initialized to 65536
> we take 6 interrupts; 4 comp + lvi + dch; count drains to 0 properly
> [quake finishes initializing]
> GETOPTR:
> at the beginning of the call, count is 0; by the end of the call, count 
> has been set to 64K
> 
> but, we take no interrupts after this point.
> 

In __i810_update_lvi(), try changing the line that reads:

x = (dmabuf->dmasize + dmabuf->swptr - 1) % dmabuf->dmasize;

to use - 2 instead of -1 and see if that solves the problem (I've been 
suspecting an off-by-one error, I just haven't found it for sure.  The 
whole 65536 vs. 0 could be providing the off-by-one though.)

-- 

  Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
       Please check my web site for aic7xxx updates/answers before
                       e-mailing me about problems

