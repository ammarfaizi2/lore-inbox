Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264559AbTLQVlf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 16:41:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264563AbTLQVlf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 16:41:35 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:26353 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S264559AbTLQVl2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 16:41:28 -0500
Message-ID: <3FE0CD81.406@mvista.com>
Date: Wed, 17 Dec 2003 13:41:21 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ross@datscreative.com.au, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: linux-kernel@vger.kernel.org
Subject: Re: Catching NForce2 lockup with NMI watchdog
References: <200312180414.17925.ross@datscreative.com.au>
In-Reply-To: <200312180414.17925.ross@datscreative.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I really want to thank you both for all this information.  It will make the code 
and comments much easier to understand.

Thanks again

George

Ross Dickson wrote:
>>On Tue, 16 Dec 2003, George Anzinger wrote: 
> 
>  
> 
> 
> 
>>>How confusing :( Could you give me some idea how this works? I have tried 
>>>disable_irq(0) and, as best as I can tell, it does not do the trick. The 
>>>confusion I have is understanding where in the chain of hardware each of these 
>>>thing is taking place. 
> 
> 
> Here is where to find Intel's MP arch spec Maceij mentions.
> I had to find it recently wrt nforce2 issues
> 
> http://www.intel.com/design/pentium/datashts/24201606.pdf
> 
> Section 3.6.1 Apic Architecture is relevant
> particularly
> Section 3.6.2.2 Virtual Wire Mode
> 
> <snip>
> great diagram!
> 
> <snip>
> 
>>If the above variant does not work, as a last resort, the path for the 
>>8254 timer interrupt is via the 8259 reconfigured back into its usual mode 
>>and then LINT0 of the BSP reconfigured for an ExtINTA APIC interrupt. 
>>Additionally, since at this point the glue logic has probably already 
>>locked up due to the messing done above, a few artiffical sets of double 
>>INTA cycles are sent to the system bus using the RTC chip and INTIN8 
>>reconfigured temporarily to send ExtINTA APIC interrupts via the 
>>inter-APIC bus. 
> 
>  
> 
>>I do hope a thorough read of the description will make the available 
>>variants clear. The I/O APIC input numbers may differ but so far they are 
>>almost always as noted above. 
> 
>  
> 
>> Maciej 
> 
> 
> All good.
> 
> I would like to add a footnote to highlight a potential gotcha as I understand it.
> 
> To clarify, the xt pic 8259A does not in itself have a transparent mode as would
> a logic buffer or inverter. It always needs inta cycles to function. In PIC mode
> it is wired to processor pins as per old 8086 and original cpu architecture
> provides the inta cycles to it (bypasses apic, apic seems off).
> 
> In virtual wire mode with the 8259A output wired either to a local apic pin on cpu
> or through the io-apic. In this mode it is the local apic which has to provide the 
> inta cycles on the bus back to the 8259A for it to function correctly. 
> 
> The delivery mode has to be set to ExtInt for the register associated with the pin
> that the 8259A output (int on Maceij diagram) is connected to. This is the only
> way to force the apic to deliver the inta cycles to the 8259A and that is how it
> appears transparent to the system. Spec says there can only be one source 
> register (local apic) or redirection register (ioapic) of mode ExtInt per system
> regardless of how many local apic and io-apic pins it (int on Maceij diagram)
> is connected to. 
> 
> Gotcha: If none are set to ExtInt then the 8259A will hang for lack of IntA 
> cycles.
> 
> Section 7.5.11 covers it
> 24319202.pdf available here
> 
> http://www.intel.com/design/pentiumii/manuals/243192.htm
> 
> Why only one Extint source in virtual wire mode?:
> 
> The 8259A in X86 architecture systems needs two inta cycles per interrupt event.
> Do not confuse them with the EOI which is software, the inta is purely hardware.
> It only works properly with one source causing inta cycles. Docs I have do not
> say what happens with more than one source.
> 
> How 8259A works in a nutshell (it is more complex in cascade mode).
> 
> First the 8259A gets a request from H/ware and if unmasked etc generates its int 
> (int on Maceij diagram) out.  8259A then sits there waiting for Inta from cpu 
> (PIC mode) or local apic (Virtual wire mode). When the inta arrives the 8259A
> latches its internal ISR bit and waits for second inta. When second inta arrives
> it outputs a vector onto the data bus indicating which ISR bit was set. 
> 
> If the request from H/ware is still active when the first inta arrives then we get
> the correct vector number.
> 
> If it is NOT still exerted then its tough luck and the vector we get 7 for the first
> 8259A or 15 for the second 8259A and it is too late to try and find out where
> the real source was, hence the spurious irq7 messages and corresponding
> irq 7 count increase.
> 
> It is pretty bad when the apic system that is handling the 8259A in virtual
> wire mode cannot get the inta to the 8259A in time while the int request
> hardware is still exerting but it happens.
> 
> I certainly agree with Marceij's comments that mixed mode of having 8254 PIT
> routed via the 8259A was never meant to occur alongside ioapic handling of
> the other interrupts. It is very problematic not to mention confusing. 
> 
> I do not know how smoothly the apic handles the 8259A if you would be turning
> that source on and off frequently.
> 
> Regards
> Ross Dickson
> 
> 
> 
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

