Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264183AbUF0U1c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264183AbUF0U1c (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 16:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264202AbUF0U1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 16:27:32 -0400
Received: from damned.travellingkiwi.com ([81.6.239.220]:47966 "EHLO
	ballbreaker.travellingkiwi.com") by vger.kernel.org with ESMTP
	id S264183AbUF0U11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 16:27:27 -0400
Message-ID: <40DF2D99.6030704@travellingkiwi.com>
Date: Sun, 27 Jun 2004 21:27:05 +0100
From: Hamie <hamish@travellingkiwi.com>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040605)
X-Accept-Language: en-us, en
MIME-Version: 1.0
Cc: Alexander Gran <alex@zodiac.dnsalias.org>, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] No APIC interrupts after ACPI suspend
References: <1088160505.3702.4.camel@tyrosine> <40DDBA7A.6010404@travellingkiwi.com> <40DF0A98.9040604@travellingkiwi.com> <200406272052.43326@zodiac.zodiac.dnsalias.org> <40DF1D22.2010406@travellingkiwi.com>
In-Reply-To: <40DF1D22.2010406@travellingkiwi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hamie wrote:

> Alexander Gran wrote:
>
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> Am Sonntag, 27. Juni 2004 19:57 schrieb Hamie:
>>  
>>
>>> FWIW the sound & networking appear to run fine for a while after
>>> resuming. But I just started a DVD. It ran fine for about 30 seconds 
>>> and
>>> then the sound went. About 30 seconds later the video froze and the app
>>> (xine) has frozen also. (kill -9 time...).
>>>   
>>
>> <>
>> I can confirm that here:
>> after resuming, network completely works (yeah!).
>> Sound doesn't.
>> unloading/reloading the sound driver does not help.
>> USB works jumpy (perhaps 5-10hz)
>> Reloading does the trick for usb.
>>
>
> Since it sounds like a different bug to 2643, (Similiar but the patch 
> that fixes the ethernet doesn't appear to doa  lot for the sound). 
> I've opened a new one... #2965.
>

Seeing as sound was on IRQ5 and the patch for 2643 fixed the ethernet, I added a
(big hack here :) call to 

                acpi_pic_sci_set_trigger(5, acpi_sci_flags.trigger);

in  acpi_pm_finish(u32 state); just after the call to set the IRQ trigger for
the acpi irq... 

Results in (kern.log) 

Jun 27 21:15:28 ballbreaker kernel: ACPI: IRQ9 SCI: Edge set to Level Trigger.
Jun 27 21:15:28 ballbreaker kernel: ACPI: IRQ5 SCI: Edge set to Level Trigger.


and then sound works after resume... Obviously not a very good fix as it won't
fix anything that uses somethign other than IRQ5.

So... What should the correct fix be? Obviously some IRQ's triggers aren't
surviving the resume... But why... The timer (IRQ 0) obviously does... 


