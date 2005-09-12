Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932104AbVILRXv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbVILRXv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 13:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932115AbVILRXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 13:23:51 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:1028 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S932104AbVILRXu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 13:23:50 -0400
Message-ID: <4325BAB3.8090303@tmr.com>
Date: Mon, 12 Sep 2005 13:28:19 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Chuck Ebbert <76306.1226@compuserve.com>,
       "P @ Draig Brady" <P@draigBrady.com>, Ben Dooks <ben-linux@fluff.org>,
       Dimitry Andric <dimitry.andric@tomtom.com>, Olaf Hering <olh@suse.de>,
       Deepak Saxena <dsaxena@plexity.net>,
       Christer Weinigel <wingel@nano-system.com>
Subject: Re: [WATCHDOG] v2.6.13 watchdog-patches
References: <20050903200443.GO19487@infomag.infomag.iguana.be> <1125778302.3223.29.camel@laptopd505.fenrus.org>
In-Reply-To: <1125778302.3223.29.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Sat, 2005-09-03 at 22:04 +0200, Wim Van Sebroeck wrote:
> 
>>Author: Chuck Ebbert <76306.1226@compuserve.com>
>>Date:   Fri Aug 19 14:14:07 2005 +0200
>>
>>    [WATCHDOG] softdog-timer-running-oops.patch
>>    
>>    The softdog watchdog timer has a bug that can create an oops:
>>    
>>    1.  Load the module without the nowayout option.
>>    2.  Open the driver and close it without writing 'V' before close.
>>    3.  Unload the module.  The timer will continue to run...
>>    4.  Oops happens when timer fires.
>>    
>>    Reported Sun, 10 Oct 2004, by Michael Schierl <schierlm@gmx.de>
>>    
>>    Fix is easy: always take a reference on the module on open.
>>    Release it only when the device is closed and no timer is running.
>>    Tested on 2.6.13-rc6 using the soft_noboot option.  While the
>>    timer is running and the device is closed, the module use count
>>    stays at 1.  After the timer fires, it drops to 0.  Repeatedly
>>    opening and closing the driver caused no problems.  Please apply.
> 
> 
> 
> this looks ENTIRELY like the wrong solution!
> Isn't it a LOT easier to just del_timer_sync() the timer from the module
> exit code? Mucking with module refcounts in a driver is almost always a
> sign of a bug or at least really bad design, and I think that is the
> case here.....
>  
Perhaps you misunderstood the problem. The problem is that the timer 
module can be unloaded with a timer running. The solution is not to 
silently stop the timer and allow the module to be unloaded, having a 
timer running is, in a sense, a ref, and the ref count can and should 
reflect that.

If the admin wants to stop the timer there are tools to do that now, 
then the module can be removed.

I'm generally against the Windows approach of "do you really want to do 
that?" paranoia about letting the user do certain things, but locking in 
the module if I have started a timer sounds like a good safety precaution.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
