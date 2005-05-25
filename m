Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261933AbVEYN7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261933AbVEYN7P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 09:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262350AbVEYN7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 09:59:12 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:49578 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S261933AbVEYN6z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 09:58:55 -0400
Message-ID: <429484F2.8080401@hp.com>
Date: Wed, 25 May 2005 10:00:18 -0400
From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050228)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Lynch, Rusty" <rusty.lynch@intel.com>
Cc: Keith Owens <kaos@sgi.com>,
       "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>, akpm@osdl.org,
       "Luck, Tony" <tony.luck@intel.com>,
       "Seth, Rohit" <rohit.seth@intel.com>, prasanna@in.ibm.com,
       ananth@in.ibm.com, systemtap@sources.redhat.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/4] Kprobes support for IA64
References: <032EB457B9DBC540BFB1B7B519C78B0E07340747@orsmsx404.amr.corp.intel.com>
In-Reply-To: <032EB457B9DBC540BFB1B7B519C78B0E07340747@orsmsx404.amr.corp.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Isn't the real issue here that if kprobes attempts to put in a 'break 
0x80200' into a B-slot that it instead becomes a 'break.b 0' -- as the 
break.b does not accept an immediate value? Which probably means that 
either kprobes (a) should not rely on the immediate value of the break 
at all (always put in an immediate value of 0), or (b) kprobes should 
not allow a probe on a B-slot of an instruction bundle.

Kprobes does have the two cases covered in traps.c (case 0 - when a 
B-slot break is used, and case 0x80200 for a non-B-slot break). But this 
doesn't seem very clean. (If it was decided that one should not overload 
the break 0 case, and instead use a uniquely defined break number, then 
it fails on a B-slot probe. If it is OK to overload the break 0 case, 
why have another break number at all?)

I started doing a port of kprobes, ran into this, and decided to try a 
different mechanism that replaced the whole instruction bundle - so that 
I could format the instruction bundle to allow a break instruction with 
an immediate value (and thus uniquely identify KPROBE breaks). 
[Basically put the break in the 1st slot (all the time), and then go 
execute the original instruction *bundle* elsewhere when the break is hit.]

PS. I don't see the 0x80300 defined __IA64_BREAK_JPROBE being used 
anywhere...

Alan D. Brunelle
Hewlett-Packard


Lynch, Rusty wrote:

>>From: Keith Owens [mailto:kaos@sgi.com]
>>Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com> wrote:
>>    
>>
>>>This patch adds the kdebug die notification mechanism needed by
>>>      
>>>
>Kprobes.
>  
>
>>>	      case 0: /* unknown error (used by GCC for
>>>      
>>>
>__builtin_abort()) */
>  
>
>>>+		if (notify_die(DIE_BREAK, "kprobe", regs, break_num,
>>>      
>>>
>>TRAP_BRKPT, SIGTRAP)
>>    
>>
>>>+			       	== NOTIFY_STOP) {
>>>+			return;
>>>+		}
>>>		die_if_kernel("bugcheck!", regs, break_num);
>>>		sig = SIGILL; code = ILL_ILLOPC;
>>>		break;
>>>      
>>>
>>Nit pick.  Any break instruction in a B slot will set break_num 0, so
>>you cannot tell if the break was inserted by kprobe or by another
>>debugger.  Setting the string to "kprobe" is misleading here, change it
>>to "break 0".
>>    
>>
>
>Good catch.  We'll update the informational string.
>
>    --rusty
>-
>To unsubscribe from this list: send the line "unsubscribe linux-ia64" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>  
>

