Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289295AbSAIJ1b>; Wed, 9 Jan 2002 04:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289298AbSAIJ1X>; Wed, 9 Jan 2002 04:27:23 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:46220 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S289295AbSAIJ1E>; Wed, 9 Jan 2002 04:27:04 -0500
Message-ID: <3C3C0CE5.5010005@redhat.com>
Date: Wed, 09 Jan 2002 04:27:01 -0500
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020103
X-Accept-Language: en-us
MIME-Version: 1.0
To: John Fremlin <john@fremlin.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: i810 kernel driver vs 7012
In-Reply-To: <86k7ut5qb2.fsf@notus.ireton.fremlin.de>	<861yh0lczs.fsf_-_@notus.ireton.fremlin.de>	<3C3B6D67.6050409@redhat.com> <86itach48q.fsf@notus.ireton.fremlin.de>	<3C3B72EE.8010803@redhat.com> <864rlwh328.fsf@notus.ireton.fremlin.de>	<3C3B79BB.6090601@redhat.com> <86vgecfnec.fsf@notus.ireton.fremlin.de>	<3C3B8C14.60508@redhat.com> <86u1twe3sw.fsf@notus.ireton.fremlin.de>	<3C3B9B60.4010308@redhat.com> <86ofk4e2gz.fsf@notus.ireton.fremlin.de>	<3C3BA00D.7020203@redhat.com> <86d70ke0rs.fsf@notus.ireton.fremlin.de>	<3C3BA5E2.7050703@redhat.com> <861yh0dzlc.fsf@notus.ireton.fremlin.de>	<3C3BB0B6.2070401@redhat.com> <867kqsmd05.fsf@notus.ireton.fremlin.de>	<3C3BCAAD.50308@redhat.com> <861yh0m7ic.fsf@notus.ireton.fremlin.de>	<3C3BD44A.4080008@redhat.com> <86vgeckrg4.fsf@notus.ireton.fremlin.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Fremlin wrote:

> Doug Ledford <dledford@redhat.com> writes:
> 
> 
>>I think we are chasing one last bit of "flaky" behaviour on the SiS
>>chipset. 
>>
> 
> To my untutored eye it looks like some sort of timing issue. I had
> more trouble getting hold of a dma overrun with debugging compiled
> in. My IRQ is shared with eth0 but I once ifdowned eth0 and got
> broadly similar sound effects and problems
> 
> 
>>Tomorrow, can you rerun this same test 
>>
> 
> You might say today is already tomorrow <groan>
> 
>>with debug interrupts enabled and send me the output.  All I need is
>>one dma overrun to be able to track it I think.  The other thing
>>that might be helpful is debug2.  A run with both interrupt and
>>debug2 enabled would probably pinpoint the real problem.
>>
>>BTW, I don't get *any* overruns here doing anything with xmms, artsd,
>>esd, or using sox or cat to play a wav file.
>>
> 
> I had to play my beetle file a few times to get one this time :-( This
> trace is just of the beetle file being played. For your enjoyment I
> also attach the beetle file


Problem identified.  It was a combination of two things.  In drain_dac() we 
were calling update_ptr() *after* setting our task state to 
TASK_INTERRUPTIBLE.  Well, the way that wait queues work is that when 
update_ptr() kept calling wake_up() because we had more than 1 userfragsize 
of space available to write it would clear our task state back to 
TASK_RUNNING before we would ever call schedule_timeout().  The result is 
that in drain_dac() we would go into a very tight loop of never sleeping and 
always updating things waiting for the dma to finish.  That was problem 1. 
Problem 2 was that in get_hardware_addr() we were finding a bug the SiS 
hardware.  Basically on the SiS stuff we were catching the hardware in 
updates to the sg segment it was dma'ing.  With a slight change to the 
routine to cause it to delay slightly and then recheck the hardware to make 
sure that what it reads is consistent, the problem should be solved. 
Anyway, a new 0.18 version of the driver is up on my site.  It should solve 
*all* of the particular problems you were seeing.  Let me know how it works.

Also, thanks for spending soooo much time getting me the traces and stuff 
you did John.  It was what allowed me to find these two issues.

(For the people on linux-kernel's benefit, the site again is 
http://people.redhat.com/dledford/i810_audio.c.gz)

 



-- 

  Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
       Please check my web site for aic7xxx updates/answers before
                       e-mailing me about problems

