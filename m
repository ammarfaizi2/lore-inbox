Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286137AbSAHUCD>; Tue, 8 Jan 2002 15:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287459AbSAHUBx>; Tue, 8 Jan 2002 15:01:53 -0500
Received: from odin.allegientsystems.com ([208.251.178.227]:6273 "EHLO
	lasn-001.allegientsystems.com") by vger.kernel.org with ESMTP
	id <S286137AbSAHUBs>; Tue, 8 Jan 2002 15:01:48 -0500
Message-ID: <3C3B501D.7050508@allegientsystems.com>
Date: Tue, 08 Jan 2002 15:01:33 -0500
From: Nathan Bryant <nbryant@allegientsystems.com>
Organization: Allegient Systems
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us
MIME-Version: 1.0
To: Doug Ledford <dledford@redhat.com>
CC: Thomas Gschwind <tom@infosys.tuwien.ac.at>, linux-kernel@vger.kernel.org
Subject: Re: i810_audio
In-Reply-To: <20020105031329.B6158@infosys.tuwien.ac.at> <3C3A2B5D.8070707@allegientsystems.com> <3C3A301A.2050501@redhat.com> <3C3AA6F9.5090407@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Ledford wrote:

>>  Added stop_dac at the end.  Otherwise the system gets locked up 
>> sometimes.
>
>
>
> This is (I think) a red herring.  I would suspect that the lockup you 
> are seeing is more likely to have something to do with the changes in 
> i810_get_dma_address().  I'm referring to the change to the do 
> {}while() loop in particular.  Also, if the change you made in 
> i810_get_dma_address() is needed for the SiS chipset, then there would 
> appear to be a hardware bug that needs worked around.  However, I 
> think this is the wrong way to solve it.  In prog_dmabuf(), we set the 
> control bits on the device such that when it finishes the LVI, it's 
> *suppossed* to stop playback.  Now, the only way I can think of that 
> the CIV register would update as fast as you can read it in 
> i810_get_dma_address() is if at the end of LVI, the card went into a 
> loop and the CIV is essentially running from 0 to 31 and going round 
> and round without doing anything.  In that case, the proper fix may 
> actually be to go into the interrupt handler and on LVI interrupt with 
> count==0 (for playback) call stop_dac and do similarly for record.  
> This is because I suspect that we aren't ever getting the DCH Stopped 
> interrupt on the SiS card.  Of course, the DCH Stop interrupt causes 
> us to call stop_{dac,adc} as appropriate, so the call to stop_dac in 
> drain_dac is redundant if this code is working as advertised.  I 
> suspect that fixing things in the interrupt handler will make the 
> stop_dac call in drain_dac and the change in i810_get_dma_address() 
> both unnecessary.  Can you test that for me? 

1) Is the LVI interrupt supposed to arrive when the chip *starts* 
playing the last buffer?
2) Does SiS actually do it this way?

If your theory on why the registers are spinning is correct, and if we 
receive the LVI interrupt with too much latency, your code will still 
deadlock, Doug. (The LVI interrupt handler calls update_ptr first thing, 
which calls get_dma_address.) Furthermore, if this turns out to be the 
case, the LVI IRQ handler uses dmabuf->count to determine whether to 
call stop_dac, and needs to call update_ptr to update dmabuf->count... 
so an explicit stop_dac might be needed elsewhere.

Even if the LVI interrupt comes at the beginning of the buffer, those 
2048 bytes will play in 10.67 ms. Can we really guarantee that kind of 
latency?

