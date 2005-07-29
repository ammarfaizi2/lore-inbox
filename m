Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262840AbVG2VFr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262840AbVG2VFr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 17:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262557AbVG2VDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 17:03:32 -0400
Received: from hqemgate03.nvidia.com ([216.228.112.143]:12104 "EHLO
	HQEMGATE03.nvidia.com") by vger.kernel.org with ESMTP
	id S262809AbVG2VCn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 17:02:43 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] i386 io_apic.c: Memorize at bootup where the i8259 is connected
Date: Fri, 29 Jul 2005 14:02:28 -0700
Message-ID: <8E5ACAE05E6B9E44A2903C693A5D4E8A091D18B7@hqemmail02.nvidia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] i386 io_apic.c: Memorize at bootup where the i8259 is connected
Thread-Index: AcWUefyXalrH1UrzQHeozzCRPmhu5gABAd5Q
From: "Andy Currid" <ACurrid@nvidia.com>
To: "Linus Torvalds" <torvalds@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 29 Jul 2005 21:02:28.0640 (UTC) FILETIME=[D42D7200:01C59480]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
> Linus Torvalds
> Sent: Friday, July 29, 2005 13:09
> To: Eric W. Biederman
> Cc: Andrew Morton; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] i386 io_apic.c: Memorize at bootup where 
> the i8259 is connected
> 
> 
> 
> On Fri, 29 Jul 2005, Eric W. Biederman wrote:
> > 
> > Since the acpi MADT table does not provide the location 
> where the i8259
> > is connected we have to look at the hardware to figure it out.
> 
> I'm not really happy with this.
> 
> First off, it kind of assumes that extINT is always the 8259. 
> Maybe that's true, maybe it's not.

Since this code is the i386 architecture branch, I think it's safe to
assume that ExtINT always emanates from something that is 8259A
compatible. The Intel APIC / IOAPIC and MP specifications which govern
this architecture are quite specific on this point. The same is true for
x86_64.

> Maybe there is hardware out there that has a
> specialty interrupt controller that also uses extInt? 
> Secondly, why always
> just on IO-APIC 0? This would make a lot more sense to do inside the
> loop-over-apics in enable_IO_APIC, no?

Agreed. Any IO-APIC is fair game for virtual wire routing.
 
> Especially since that one already calculates the number of 
> entries, and
> does it a lot more nicely than you do.. (ie no shifting and 
> masking with
> magic constants).
> 
> Finally, the third issue I have is that _if_ the MP table is correct,
> we'll never know. Wouldn't it be better to query the MP table 
> regardless,
> and see if it agrees with what we found, and if it doesn't, 
> at least print
> a message so that it is easier to debug things if sh*t happens?

MP tables on IA32 / AMD64 systems are frequently wrong when it comes to
interrupt mappings. That's an indirect consequence of Microsoft
mandating ACPI  since 2000: system vendors tend to test the hell out of
that configuration and nothing else.

But I think it's a good idea to cross check as Linus suggests, and
notify the user of any discrepancy. After all, the only *guaranteed* way
to get back into virtual wire mode on a platform is to do a reset; the
original MP spec didn't envisage supporting this mode of operation.

Andy
--
