Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287955AbSAHIAQ>; Tue, 8 Jan 2002 03:00:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287959AbSAHIAG>; Tue, 8 Jan 2002 03:00:06 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:46518 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S287955AbSAHH7z>; Tue, 8 Jan 2002 02:59:55 -0500
Message-ID: <3C3AA6F9.5090407@redhat.com>
Date: Tue, 08 Jan 2002 02:59:53 -0500
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020103
X-Accept-Language: en-us
MIME-Version: 1.0
To: Thomas Gschwind <tom@infosys.tuwien.ac.at>
CC: Doug Ledford <dledford@redhat.com>,
        Nathan Bryant <nbryant@allegientsystems.com>,
        linux-kernel@vger.kernel.org
Subject: Re: i810_audio
In-Reply-To: <20020105031329.B6158@infosys.tuwien.ac.at> <3C3A2B5D.8070707@allegientsystems.com> <3C3A301A.2050501@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Thomas.  I've been looking over the patch and trying to evaluate the 
various bug fixes that you mention against the patch.  My comments are 
inline (and ignore the fact that I'm positive my cut and past job will 
mangle the patch itself, this is for comments, not for applying).  I'm also 
replying to your comments.


Tom wrote:

> Doug,
> 
> attched you can find the latest SiS7012 patch.  This one is relative
> to your i810_audio.c driver.
> 
> Fixes it applies except for the SiS integration:
> * drain_dac
>   Use interruptible_sleep_on_timeout instead of schedule_timeout.
>   I think this is cleaner. 


This is fine.

> Set the timeout to
>   (dmabuf->count * HZ * 2) / (dmabuf->rate * 4)
>   since we play dmabuf->rate*4 bytes per second (16bit samples stereo).


This is fine as well.


>   Added stop_dac at the end.  Otherwise the system gets locked up sometimes.


This is (I think) a red herring.  I would suspect that the lockup you are 
seeing is more likely to have something to do with the changes in 
i810_get_dma_address().  I'm referring to the change to the do {}while() 
loop in particular.  Also, if the change you made in i810_get_dma_address() 
is needed for the SiS chipset, then there would appear to be a hardware bug 
that needs worked around.  However, I think this is the wrong way to solve 
it.  In prog_dmabuf(), we set the control bits on the device such that when 
it finishes the LVI, it's *suppossed* to stop playback.  Now, the only way I 
can think of that the CIV register would update as fast as you can read it 
in i810_get_dma_address() is if at the end of LVI, the card went into a loop 
and the CIV is essentially running from 0 to 31 and going round and round 
without doing anything.  In that case, the proper fix may actually be to go 
into the interrupt handler and on LVI interrupt with count==0 (for playback) 
call stop_dac and do similarly for record.  This is because I suspect that 
we aren't ever getting the DCH Stopped interrupt on the SiS card.  Of 
course, the DCH Stop interrupt causes us to call stop_{dac,adc} as 
appropriate, so the call to stop_dac in drain_dac is redundant if this code 
is working as advertised.  I suspect that fixing things in the interrupt 
handler will make the stop_dac call in drain_dac and the change in 
i810_get_dma_address() both unnecessary.  Can you test that for me?

Something else you might want to check into on the SiS chipset.  I actually 
wish Intel had done the i810 with the SR and PICB registers swapped because 
you are suppossed to be able to do a 32bit read from the CIV register 
location and get CIV, LVI, and SR all in one go.  With the SiS that means 
you could get CIV, LVI, and PCIB all in one go, making the while loop in 
i810_get_dma_address totally unnecessary on the SiS chipset (and making a 
slight boost to performance as well) as long as the SiS also supports a 
32bit read from CIV.


> * i810_read, i810_write
>   Set the timeout to (dmabuf->size * HZ * 2) / (dmabuf->rate * 4)
>   since we record / play dmabuf->rate*4 bytes per second (16bit samples
>   stereo).


Again, fine.


> * SNDCTL_DSP_GETxPTR
>   Don't change the recording / playback buffer.  A detailed explanation
>   can be found within the patch


As commented on by Nathan, this isn't right.


> Please correct me, if any of the above is wrong.
> 
> Thomas
> 


Now, I've been talking with Ben LaHaise here at Red Hat and he pointed out 
to me that the wait queue handling in i810_read and likely also in 
i810_write are both wrong.  Ben and I are looking into that and I'll put out 
a new version of the file that fixes those (obvious) problems shortly.  When 
I've got my 0.14 version out, could you please repatch your stuff against it 
and look into the items I've mentioned here?








-- 

  Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
       Please check my web site for aic7xxx updates/answers before
                       e-mailing me about problems

