Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288282AbSAHUQF>; Tue, 8 Jan 2002 15:16:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288280AbSAHUP4>; Tue, 8 Jan 2002 15:15:56 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:18243 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S287842AbSAHUPh>; Tue, 8 Jan 2002 15:15:37 -0500
Message-ID: <3C3B5368.7090105@redhat.com>
Date: Tue, 08 Jan 2002 15:15:36 -0500
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020103
X-Accept-Language: en-us
MIME-Version: 1.0
To: Nathan Bryant <nbryant@allegientsystems.com>
CC: Thomas Gschwind <tom@infosys.tuwien.ac.at>, linux-kernel@vger.kernel.org
Subject: Re: i810_audio
In-Reply-To: <20020105031329.B6158@infosys.tuwien.ac.at> <3C3A2B5D.8070707@allegientsystems.com> <3C3A301A.2050501@redhat.com> <3C3AA6F9.5090407@redhat.com> <3C3B501D.7050508@allegientsystems.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Bryant wrote:

> Doug Ledford wrote:
> 
>>>  Added stop_dac at the end.  Otherwise the system gets locked up 
>>> sometimes.
>>
>>
>>
>>
>> This is (I think) a red herring.  I would suspect that the lockup you 
>> are seeing is more likely to have something to do with the changes in 
>> i810_get_dma_address().  I'm referring to the change to the do 
>> {}while() loop in particular.  Also, if the change you made in 
>> i810_get_dma_address() is needed for the SiS chipset, then there would 
>> appear to be a hardware bug that needs worked around.  However, I 
>> think this is the wrong way to solve it.  In prog_dmabuf(), we set the 
>> control bits on the device such that when it finishes the LVI, it's 
>> *suppossed* to stop playback.  Now, the only way I can think of that 
>> the CIV register would update as fast as you can read it in 
>> i810_get_dma_address() is if at the end of LVI, the card went into a 
>> loop and the CIV is essentially running from 0 to 31 and going round 
>> and round without doing anything.  In that case, the proper fix may 
>> actually be to go into the interrupt handler and on LVI interrupt with 
>> count==0 (for playback) call stop_dac and do similarly for record.  
>> This is because I suspect that we aren't ever getting the DCH Stopped 
>> interrupt on the SiS card.  Of course, the DCH Stop interrupt causes 
>> us to call stop_{dac,adc} as appropriate, so the call to stop_dac in 
>> drain_dac is redundant if this code is working as advertised.  I 
>> suspect that fixing things in the interrupt handler will make the 
>> stop_dac call in drain_dac and the change in i810_get_dma_address() 
>> both unnecessary.  Can you test that for me? 
> 
> 
> 1) Is the LVI interrupt supposed to arrive when the chip *starts* 
> playing the last buffer?


No, when the last buffer is complete.


> 2) Does SiS actually do it this way?


No clue.  If they follow the spec, then yes.


> If your theory on why the registers are spinning is correct, and if we 
> receive the LVI interrupt with too much latency, your code will still 
> deadlock, Doug. (The LVI interrupt handler calls update_ptr first thing, 
> which calls get_dma_address.)


My theory about get_dma_address at this point is that the upper 3 bits of 
CIV are garbage and are subject to different states each time you read the 
register.  Since I bounded the read by using &31 to mask off the garbage 
bits, that should no longer be an issue.

> Furthermore, if this turns out to be the 
> case, the LVI IRQ handler uses dmabuf->count to determine whether to 
> call stop_dac, and needs to call update_ptr to update dmabuf->count... 
> so an explicit stop_dac might be needed elsewhere.


I don't think so.  See above.


> Even if the LVI interrupt comes at the beginning of the buffer, those 
> 2048 bytes will play in 10.67 ms. Can we really guarantee that kind of 
> latency?
> 

We don't need to.  This is also where the spurious DMA Overrun on write 
errors were coming from.  We *expect* to have a dma overrun on write if the 
last block was not completely filled (notice in i810_write() that we filled 
the remainder of the block with silence).  So, we check if LVI == CIV when 
we appear to have an overrun.  If they are the same, then no overrun, we 
just played the silence until the end of the buffer, then things stopped 
because this was the LVI, and all is good and right in the world.  If they 
aren't the same (which they aren't if you are getting garbage in the upper 3 
bits that is random), then we print out spurious messages.  I think a lot of 
the problems that people have been chasing with the SiS chipset are this 
exact kind of thing.  You'll also notice that support for the NVIDIA nForce 
Audio is now in 0.15.  Based upon the fact that the guy from NVIDIA that 
contacted me had been seeing the same sort of random DMA Overrun on write 
messages, I'm guessing that both the SiS and the NVIDIA audio devices have 
this same garbage in the upper 3 bits of CIV register problem.




-- 

  Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
       Please check my web site for aic7xxx updates/answers before
                       e-mailing me about problems

