Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbTKQVCQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 16:02:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261806AbTKQVCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 16:02:16 -0500
Received: from natsmtp00.rzone.de ([81.169.145.165]:1949 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S261802AbTKQVCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 16:02:14 -0500
Message-ID: <3FB9373D.6010300@softhome.net>
Date: Mon, 17 Nov 2003 22:01:49 +0100
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
Organization: Home Sweet Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030927
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Q] jiffies overflow & timers.
References: <3FB91527.50007@softhome.net> <Pine.LNX.4.53.0311171347540.24608@chaos>
In-Reply-To: <Pine.LNX.4.53.0311171347540.24608@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> 
> Use jiffies as other modules use it:
> 
>         tim = jiffies + TIMEOUT_IN_HZ;
>         while(time_before(jiffies, tim))
>         {
>             if(what_im_waiting_for())
>                 break;
>             current->policy |= SCHED_YIELD;
>             schedule();
>         }
> //
> // Note that somebody could have taken the CPU for many seconds
> // causing a 'timeout', therefore, you need to add one more check
> // after loop-termination:
> //
>             if(what_im_waiting_for())
>                 good();
>             else
>                 timed_out();
> 
> Overflow is handled up to one complete wrap of jiffies + TIMEOUT. It's
> only the second wrap that will fail and if you are waiting several
> months for something to happen in your code, the code is broken.
> 

   Thanks! Looks & sounds sane.

   Will try to apply this to my case.
   what_im_waiting_for() == 'any expired timer'. I'm generating event to 
upper layer, if timer wasn't canceled before. This is network layer 
implementation - e.g. if line is Okay for some specified time, we need 
to generate event that line is 'up'. Or if we didn't get positive ack 
for some specified time resend payload. Something like this.

   And sure you example needs to be enhanced for the case when timer 
gets canceled before. Doable in anyway.

   You example implies I have to have something I can call schedule() on 
- currently I'm running without any user space part. To follow your 
advice I will need to create process a la kswapd/keventd?

P.S. BTW it looks like that tcp_timer.c does exactly what I do right now 
- this is 2.4.22 - hope 2.6 handles this correctly? I had enlightenment 
to take a look into tcp - tcp has to have timers - but found (as it 
seems) bug...

-- 
Ihar 'Philips' Filipau  / with best regards from Saarbruecken.
--                                                           _ _ _
  "... and for $64000 question, could you get yourself       |_|*|_|
    vaguely familiar with the notion of on-topic posting?"   |_|_|*|
                                 -- Al Viro @ LKML           |*|*|*|

