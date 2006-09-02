Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750905AbWIBIyA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbWIBIyA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 04:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750899AbWIBIx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 04:53:59 -0400
Received: from mta5.srv.hcvlny.cv.net ([167.206.4.200]:5972 "EHLO
	mta5.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S1750890AbWIBIx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 04:53:56 -0400
Date: Sat, 02 Sep 2006 04:53:57 -0400
From: Lee Trager <Lee@PicturesInMotion.net>
Subject: Re: HPA Resume patch
In-reply-to: <20060829091200.GF12257@kernel.dk>
To: Jens Axboe <axboe@kernel.dk>
Cc: Pavel Machek <pavel@ucw.cz>, B.Zolnierkiewicz@elka.pw.edu.pl,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       seife@suse.de
Message-id: <44F946A5.20501@PicturesInMotion.net>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
References: <44F15ADB.5040609@PicturesInMotion.net>
 <20060827150608.GA4534@ucw.cz> <20060827170501.GD30609@kernel.dk>
 <44F3A30A.3090509@PicturesInMotion.net> <20060829091200.GF12257@kernel.dk>
User-Agent: Thunderbird 1.5.0.5 (X11/20060731)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Mon, Aug 28 2006, Lee Trager wrote:
>   
>> Jens Axboe wrote:
>>     
>>> On Sun, Aug 27 2006, Pavel Machek wrote:
>>>   
>>>       
>>>> Hi!
>>>>
>>>>     
>>>>         
>>>>> This patch fixes a problem with computers that have HPA on their hard
>>>>> drive and not being able to come out of resume from RAM or disk. I've
>>>>> tested this patch on 2.6.17.x and 2.6.18-rc4 and it works great on both
>>>>> of these. This patch also fixes the bug #6840. This is my first patch to
>>>>> the kernel and I was told to e-mail the above people to get my patch
>>>>> into the kernel.
>>>>>       
>>>>>           
>>>> Congratulations for a first patch.
>>>>
>>>>     
>>>>         
>>>>> If I made a mistake please be gentle and correct me ;)
>>>>>       
>>>>>           
>>>> We'll need signed-off-by: line next time.
>>>>
>>>> Stefan, can we get this some testing? Or anyone else with thinkpad
>>>> with host-protected area still enabled?
>>>>     
>>>>         
>>> It has design issues, at someone else already noticed. hpa restore needs
>>> to be a driver private step, included in the resume state machine. The
>>> current patch is a gross layering violation.
>>>
>>> But thanks to Lee for taking a stab at this, I hope he'll continue and
>>> get it polished :-)
>>>
>>>   
>>>       
>> Ok I redid the patch following exactly what Sergey and Randy said. This
>> problem happens on any computer that has HPA on their drive when they
>> come back from resume so I don't think you have to only test this with
>> Thinkpad users. Anyway my only question is how to I get my patched
>> signed off by someone?
>>
>> Thanks for all your help!
>>     
>
> While this is a _lot_ better than your previous patch, I don't think you
> quite understood my suggestion. Which is probably fault, so I'll try to
> be a little more verbose.
>
> If you look at the suspend state machine, it goes through a (small)
> sequence of steps (see drivers/ide/ide-io.c:ide_complete_power_step())
> and get the device suspended. Same thing for resume, just not that many
> steps there. My suggestion was to continue using this infrastructure and
> just add the HPA restore as a resume state. Right now it does:
>
>         ide_pm_state_start_resume (== idedisk_pm_idle)
>                 complete that
>         ide_pm_restore_dma
>                 complete that
>
> and we are done. Your patch basically puts more actions into a single
> resume state switch, not ideal. What you want to do is have the HPA
> restore as an additional state.
>
> Is that clearer? If not, let me know...
>
>   
Ok I've been looking through the source to see how to do this properly.
I can't figure out where ide_generic_resume() is called from. It doesn't
look like its called from ide_complete_power_step() I want to know
because I want the HPA stuff to be done right after ide_generic_resume()
is called. I'll do some testing to see if it works to get called before
and after the DMA stuff.

Thanks,

Lee

-- 
VGER BF report: U 0.5
