Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751194AbWIMU7J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbWIMU7J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 16:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbWIMU7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 16:59:09 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:5258 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751194AbWIMU7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 16:59:08 -0400
Message-ID: <4508711B.6060905@vmware.com>
Date: Wed, 13 Sep 2006 13:59:07 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Arjan van de Ven <arjan@infradead.org>, Linus Torvalds <torvalds@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@suse.de>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Michael A Fetterman <Michael.Fetterman@cl.cam.ac.uk>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Assignment of GDT entries
References: <450854F3.20603@goop.org> <1158175001.3054.7.camel@laptopd505.fenrus.org> <4508681E.3070708@goop.org>
In-Reply-To: <4508681E.3070708@goop.org>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Fitzhardinge wrote:
> Arjan van de Ven wrote:
>> I don't know the exact details on these; I do know that several GDT
>> entries tend to be used by BIOSes in their APM implementations and thus
>> are better of not being used. That might be the underlying reason
>> here....
>>   
>
> Hm, I see.
>
> Also, thinking about this a bit more, it would be most helpful to move 
> the PDA descriptor onto the same cache line as the other descriptors 
> used in the kernel - ie, somewhere in the range of 8-15 (assuming 64 
> byte line size):
>
> *   8 - TLS segment #3
> *   9 - reserved
> *  10 - reserved
> *  11 - reserved
> *
> *  ------- start of kernel segments:
> *
> *  12 - kernel code segment
> *  13 - kernel data segment
> *  14 - default user CS
> *  15 - default user DS
>
> This seems pretty wasteful of the GDT cache line, since the 
> kernel+user cs/ds are shared a cache line with 3 reserved entries and 
> the never-used TLS #3 descriptor.    If it were OK to put the PDA in 
> one of 9,10,11, then that would be

TLS #3 overlaps BIOS 0x40, but code which calls borken APM / PnP BIOS 
and sets up protected mode 0x40 GDT segment does so by swapping out the 
TLS segment with the identity simulation of physical 0x400 offset, 
swapping it back afterwards.  Short of bugs in that code (which there 
are, btw), you shouldn't need to be concerned with it.

I believe 9,10,11 are reserved for future users like yourself or 
expanded TLS segments.  I think a bank of 3 TLS segments in the GDT is 
working fine now (does NPTL even use more than one?).

> good.  Unfortunately the next cache line is clogged up with PNP and 
> APM stuff, which I presume not movable.

Totally movable, actually, just means breaking module dependencies.

>
> In fact, if we assume that "reserved" means "unusable", it looks like 
> none of the GDT's cache lines can be freed up to lay out the most 
> commonly used descriptors into a single cache line:
>
>    line 0: NULL descriptor, 3 reserved, 2 unused, 2 TLS
>    line 1: 1 TLS, 3 reserved, kernel+user code+data
>    line 2: TSS, LDT, PNPBIOS, APMBIOS
>    line 3: APMBIOS, ESPFIX, 4 unused, doublefault TSS
>
> Otherwise line 1 would be ideal for putting 3 TLS, kernel+user 
> code+data and PDA into, thereby making 99.999% of GDT descriptor uses 
> come from one cache line.

That change is visible to userspace, unfortunately.

>
> But anyway, what breaks if I put the PDA in 11?

Nothing.

Zach
