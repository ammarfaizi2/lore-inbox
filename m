Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261836AbTKMAyy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 19:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261850AbTKMAyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 19:54:54 -0500
Received: from mail-05.iinet.net.au ([203.59.3.37]:52434 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261836AbTKMAyw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 19:54:52 -0500
Message-ID: <3FB2D656.60008@cyberone.com.au>
Date: Thu, 13 Nov 2003 11:54:46 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: bill davidsen <davidsen@tmr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: So, Poll is not scalable... what to do?
References: <Pine.LNX.4.44.0311121548470.2017-100000@bigblue.dev.mdolabs.com>
In-Reply-To: <Pine.LNX.4.44.0311121548470.2017-100000@bigblue.dev.mdolabs.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Davide Libenzi wrote:

>On 12 Nov 2003, bill davidsen wrote:
>
>
>>In article <20031112053207.GA9634@alpha.home.local>,
>>Willy Tarreau  <willy@w.ods.org> wrote:
>>| On Tue, Nov 11, 2003 at 05:52:42PM -0600, kirk bae wrote:
>>| > If poll is not scalable, which method should I use when writing 
>>| > multithreaded socket server?
>>| 
>>| Honnestly, if you're using threads (I mean lots of threads, such as one
>>| per connection), I don't think that poll performance will be your worst
>>| ennemy. The first thing to do is to handle the task switching yourself
>>| either with a publicly available coroutine library or with one of your own.
>>
>>It's not clear that with 2.6 this is necessary or desirable. I'll let
>>someone who worked on the new thread and/or futex development say more
>>if they will, but I'm reasonable convinced that in most cases the kernel
>>will do it better.
>>
>
>Pros & Cons:
>
>*) Coroutines cost is basically its stack (8-16Kb). Threads there's a 
>little bit more under the hood
>
>*) No locks at all with coroutines
>
>*) Coroutine context switch time was about 20 times faster last time I 
>tried. I used this:
>

According to lmbench, 2.4 does a context switch in 0.67us (on one type
of uniprocessor cpu - the machines at osdl). 2.6.0-test9 manages 1.17us
(174% longer). I have some patches that brings this to 0.80us (119%).
This is with 2 active tasks, so O(1) doesn't get to show its advantage.

If you remove the realtime priority array (disable RT scheduling support)
you could probably drop this figure below 2.4's. I should get some numbers

Perhaps if there is demand I could make RT scheduling a config option in
my patchset. I think Andrea does something fancy like that. I'll have to
take a look at his code.


That said, I'd be inclined to think an application that it context switch
bound is broken by design. Although maybe there are some special cases.


2.4: http://khack.osdl.org/stp/282982/results/summary_report
2.6: http://khack.osdl.org/stp/282354/results/summary_report
np:  http://khack.osdl.org/stp/283054/results/summary_report


