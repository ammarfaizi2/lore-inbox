Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265772AbTG1NuY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 09:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265870AbTG1NuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 09:50:24 -0400
Received: from mx1.it.wmich.edu ([141.218.1.89]:8098 "EHLO mx1.it.wmich.edu")
	by vger.kernel.org with ESMTP id S265772AbTG1NuO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 09:50:14 -0400
Message-ID: <3F22FB33.5080703@wmich.edu>
Date: Sat, 26 Jul 2003 18:05:39 -0400
From: Ed Sweetman <ed.sweetman@wmich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030722
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@arcor.de>
CC: Andrew Morton <akpm@osdl.org>, eugene.teo@eugeneteo.net,
       linux-kernel@vger.kernel.org, kernel@kolivas.org
Subject: Re: Ingo Molnar and Con Kolivas 2.6 scheduler patches
References: <1059211833.576.13.camel@teapot.felipe-alfaro.com> <200307271046.30318.phillips@arcor.de> <20030726113522.447578d8.akpm@osdl.org> <200307271517.55549.phillips@arcor.de>
In-Reply-To: <200307271517.55549.phillips@arcor.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




My comment was towards the fact that although playing audio is a 
realtime priority, decoding audio is not, and is not coded that way in 
many programs, in fact, many programs will sleep() in order to decode 
only when the output buffer is getting low.  This means it can have cpu 
suddenly a lot less than it needs if load is added during this sleep() 
because it was written assuming you could decode the necessary amount of 
audio within the time it restarts the decode thread to the time the 
output buffer can run out.
Simply put, try a few wav playing programs just playing wav files and 
see how that performs skip-wise as the benchmark for realtime scheduling 
performance instead of this xmms/whatever mp3 crap. I can cause 
scheduling starvation-like performance by using certain decoders but not 
others, this means using them at all is not acceptable to measure 
anything kernel related. Just because what these decoders do worked 
before doesn't mean that they are correct and the kernel is now wrong. 
Stick with simple wav's since it's decode process is negliable, and no 
gui.  Too many ways for the user app to be causing the problems and 
we'll never get any worthwhile results.

if the kernel is having a schedular issue with realtime processes, you 
should be able to get aplay to skip at a niceness of -20 by loading up 
the machine with normal niced processes.  Technically, you shouldn't be 
able to get aplay to skip at all as long as no other processes are at an 
equal or higher nice value.









Daniel Phillips wrote:
> On Saturday 26 July 2003 13:35, Andrew Morton wrote:
> 
>>Daniel Phillips <phillips@arcor.de> wrote:
>>
>>>Audio players fall into a special category of application, the kind where
>>>it's not unreasonable to change the code around to take advantage of new
>>>kernel features to make them work better.
>>
>>One shouldn't even need to modify the player application to start using a
>>new scheduler policy - policy is inherited, so a wrapper will suffice:
>>
>>	sudo /bin/run-something-as-softrr mplayer
> 
> 
> True, and that's roughly what I do now (except just with elevated priority as 
> opposed to a realtime scheduler policy).  However, it's more friendly to the 
> system if the realtime priority is limited to just the thread that needs it, 
> and that's why the application itself needs to provide the hint.
> 
> Zinf already does try to provide such a hint by setting a higher priority for 
> its sound servicing thread.  Unfortunately, this is ignored unless zinf is 
> running as root.  Given the number of bugs in Zinf, I am uncomfortable 
> running the whole application as root.  It's altogether more conservative to 
> limit the risk to a single, simple thread that can be easily audited.
> 
> 
>>>Remember this word: audiophile.
>>
>>That is one problem space, and I guess if we fix that, we fix the X11
>>problems too.
>>
>>Let us not lose sight of the other problem: particular sleep/run patterns
>>as demonstrated in irman are causing extremem starvation.  Arguably we
>>should be addressing this as the higher priority problem.
> 
> 
> I agree it's the more important problem, but there are also more people 
> already working on it, whereas over here in the audio corner, there are just 
> Davide and me (sorry if I left anyone out, please feel free to flame me so I 
> know who you are).
> 
> 
>>It is interesting that Felipe says that stock 2.5.69 was the best CPU
>>scheduler of the 2.5 series.  Do others agree with that?
> 
> 
> I never tried audio until 2.5.73.  With Con's patches, life has been pretty 
> good for me from then on, from the non-starvation point of view.
> 
> 
>>And what about the O(1) backports?  RH and UL and -aa kernels?  Are people
>>complaining about those kernels?  If not, why?  What is different?
> 
> 
> In case anybody wants to hearken back to the good old days of 2.4, forget it. 
> It is only good for sound if you are lucky enough to have a configuration it 
> likes.  My unlucky wife on the other hand, who gets by with a 233 MHz K6 
> (because she can) is running 2.4 and says sound skips whenever she does 
> anything with the machine other that just letting it sit and play.  Now that 
> I think of it, this will be an ideal machine for testing audio robustness, 
> and scheduler robustness in general.
> 
> Regards,
> 
> Daniel
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


