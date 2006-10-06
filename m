Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422776AbWJFXRJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422776AbWJFXRJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 19:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423000AbWJFXRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 19:17:09 -0400
Received: from gw.goop.org ([64.81.55.164]:62401 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1422776AbWJFXRH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 19:17:07 -0400
Message-ID: <4526E3F5.9040400@goop.org>
Date: Fri, 06 Oct 2006 16:17:09 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20061004)
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: Vara Prasad <prasadav@us.ibm.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Frank Ch. Eigler" <fche@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       Paul Mundt <lethal@linux-sh.org>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       systemtap <systemtap@sourceware.org>
Subject: Re: tracepoint maintainance models
References: <20060917143623.GB15534@elte.hu>	 <20060917153633.GA29987@Krystal> <20060918000703.GA22752@elte.hu>	 <450DF28E.3050101@opersys.com> <20060918011352.GB30835@elte.hu>	 <20060918122527.GC3951@redhat.com> <20060918150231.GA8197@elte.hu>	 <1158594491.6069.125.camel@localhost.localdomain>	 <20060918152230.GA12631@elte.hu>	 <1158596341.6069.130.camel@localhost.localdomain>	 <20060918161526.GL3951@redhat.com>	 <1158598927.6069.141.camel@localhost.localdomain>	 <450EEF2E.3090302@us.ibm.com>	 <1158608981.6069.167.camel@localhost.localdomain>	 <450F0180.1040606@us.ibm.com> <1160112791.30146.12.camel@localhost.localdomain>
In-Reply-To: <1160112791.30146.12.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> Coming into this really late, and I'm still behind in reading this and
> related threads, but I want to throw this idea out, and it's getting
> late.
>
> On Mon, 2006-09-18 at 13:28 -0700, Vara Prasad wrote:
>   
>> Alan Cox wrote:
>>
>>     
>>>> This still doesn't solve the problem of compiler optimizing such that a 
>>>> variable i would like to read in my probe not being available at the 
>>>> probe point.
>>>>    
>>>>
>>>>         
>>> Then what we really need by the sound of it is enough gcc smarts to do
>>> something of the form
>>>
>>> 	.section "debugbits"
>>> 	
>>> 	.asciiz 'hook_sched'
>>> 	.dword l1	# Address to probe
>>> 	.word 1		# Argument count
>>> 	.dword gcc_magic_whatregister("next"); [ reg num or memory ]
>>> 	.dword gcc_magic_whataddress("next"); [ address if exists]
>>>
>>>
>>> Can gcc do any of that for us today ?
>>>
>>>  
>>>
>>>       
>> No, gcc doesn't do that today.
>>
>>
>>     
>
>
> ---- cut here ----
> #include <stdio.h>
>
> #define MARK(label, var)			\
> 	asm ("debug_" #label ":\n"		\
> 	     ".section .data\n"			\
> 	     #label "_" #var ": xor %0,%0\n"	\
> 	     ".previous" : : "r"(var))
>   

That's a nice idea.  As Frank pointed out, it does force things into 
register.  You could use "rm" as a constraint, so you can also get the 
location wherever it exists.  It will still force gcc into keeping the 
value around at all, but presumably if its interesting for a mark, its 
interesting to keep:

	asm volatile("..."		\
	    #label "_" #var ": mov %0,%%eax\n"	\
	".previous" : : "rm" (var))

and, aside from the naming issues, it could be a general expression 
rather than a specific variable.

Of course, this requires a more complex addressing mode decoder, but it 
does give gcc more flexibility.  And in principle this is all redundant, 
since DWARF should be able to encode all this too, and if you make use 
of the variable as an asm argument, gcc really should be outputting the 
debug info about it.

    J
