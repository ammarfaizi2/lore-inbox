Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbTLTX3j (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 18:29:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbTLTX3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 18:29:39 -0500
Received: from mail-03.iinet.net.au ([203.59.3.35]:34697 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261868AbTLTX3f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 18:29:35 -0500
Message-ID: <3FE4DB58.6020604@cyberone.com.au>
Date: Sun, 21 Dec 2003 10:29:28 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Christian Meder <chris@onestepahead.de>
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: 2.6 vs 2.4 regression when running gnomemeeting
References: <1071864709.1044.172.camel@localhost>	 <1071885178.1044.227.camel@localhost> <3FE3B61C.4070204@cyberone.com.au>	 <200312201355.08116.kernel@kolivas.org>	 <1071891168.1044.256.camel@localhost> <3FE3C6FC.7050401@cyberone.com.au>	 <1071893802.1363.21.camel@localhost> <3FE3D0CB.603@cyberone.com.au>	 <1071897314.1363.43.camel@localhost>  <20031220111917.GA18267@elte.hu> <1071938978.1025.48.camel@localhost>
In-Reply-To: <1071938978.1025.48.camel@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Christian Meder wrote:

>On Sat, 2003-12-20 at 12:19, Ingo Molnar wrote:
>
>>* Christian Meder <chris@onestepahead.de> wrote:
>>
>>
>>>That would leave me with two possibilities: 2.6. is doing something
>>>different in the gnomemeeting case or gnomemeeting is doing something
>>>different in the 2.6 case. A cursory look at the gnomemeeting sources
>>>didn't give me the impression that it's doing anything which would be
>>>affected by 2.6 deployment but I'll ask on the gnomemeeting-devel list
>>>for advice.
>>>
>>yep, i've looked at the source too and it doesnt do anything that 
>>changed in 2.6 from an interactivity POV.
>>
>
>Stefan Bruens pointed out on the gnomemeeting-devel list that pwlib
>which gnomemeeting is using executes sched_yield and that perhaps there
>is a problem akin to the openoffice busy-loop on sched_yield() problem
>earlier this year. I found the following sched_yield code in pwlib 1.5.2
>in src/ptlib/unix/tlibthrd.cxx:
>
>
>
>>static BOOL PAssertThreadOp(int retval,
>>                            unsigned & retry,
>>                            const char * funcname,
>>                            const char * file,
>>                            unsigned line)
>>{
>>  if (retval == 0) {
>>    PTRACE_IF(2, retry > 0, "PWLib\t" << funcname << " required " << retry << "
>>retries!");
>>    return FALSE;
>>  }
>>                                                                                
>>  if (errno == EINTR || errno == EAGAIN) {
>>    if (++retry < 1000) {
>>#if defined(P_RTEMS)
>>      sched_yield();
>>#else
>>      usleep(10000); // Basically just swap out thread to try and clear blockage
>>#endif
>>      return TRUE;   // Return value to try again
>>    }
>>    // Give up and assert
>>  }
>>                                                                                
>>  PAssertFunc(file, line, NULL, psprintf("Function %s failed", funcname));
>>  return FALSE;
>>}
>>
>
>Is this obviously broken for 2.6 usage ?
>

Most probably, yes. That will cause the program to give up its entire
timeslice, so then all processes of any priority will be able to use
their entire timeslices before it.

If it gets called often, that would be the cause of your problem. Try
just using the usleep. You could even reduce the usleep timeout to
1000 or so, which 2.6 can take advantage of.


