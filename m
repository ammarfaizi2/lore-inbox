Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263075AbVHETjS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263075AbVHETjS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 15:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262823AbVHETjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 15:39:11 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:19205 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S263071AbVHETi1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 15:38:27 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <20050805122301.A30003@unix-os.sc.intel.com>
References: <20050805135007.GA6985@vana.vc.cvut.cz> <20050805115329.45889ef8.akpm@osdl.org> <20050805122301.A30003@unix-os.sc.intel.com>
X-OriginalArrivalTime: 05 Aug 2005 19:38:26.0028 (UTC) FILETIME=[3F702AC0:01C599F5]
Content-class: urn:content-classes:message
Subject: Re: [PATCH 2.6.13-rc5-gitNOW] msleep() cannot be used from interrupt
Date: Fri, 5 Aug 2005 15:37:46 -0400
Message-ID: <Pine.LNX.4.61.0508051532280.6245@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6.13-rc5-gitNOW] msleep() cannot be used from interrupt
thread-index: AcWZ9T95rhH7JIaPRT2GjRmfJiAU2g==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Venkatesh Pallipadi" <venkatesh.pallipadi@intel.com>
Cc: "Andrew Morton" <akpm@osdl.org>, "Petr Vandrovec" <vandrove@vc.cvut.cz>,
       <torvalds@osdl.org>, <linux-kernel@vger.kernel.org>,
       "Shaohua Li" <shaohua.li@intel.com>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 5 Aug 2005, Venkatesh Pallipadi wrote:

> On Fri, Aug 05, 2005 at 11:53:29AM -0700, Andrew Morton wrote:
>>
>> That's all pretty sad stuff.  I guess for now we can go back to the busy
>> loop.  Longer-term it would be nice if we could tune up the HPET driver in
>> some manner so we can avoid this busy-wait-in-interrupt.
>>
>> I'm not sure who the HPET maintainer/expert is nowadays.  Robert Picco did
>> the original work but I haven't seen Robert around for a long time?
>
> Actually there are two parts in HPET.
> 1) Using HPET for kernel timer and RTC emulation
> 2) HPET driver to export timers to user(/dev/hpet) and kernel drivers
>
> We did the part (1) for i386 and I think Andi/Vojtech did (1) for x86_64. And
> Robert Picco did (2).
>
> So, using rtc_get_rtc_time() in an interrupt handler will be my code. In this
> part we try to emulate RTC interrupt using HPET and we have to read the current
> RTC time in the interrupt handler. I can't think of any way of not doing
> rtc_get_rtc_time here.
>
> I think we should have two versions of rtc_get_rtc_time. One which does msleep,
> that can be called from process context (in drivers/char/rtc.c) and one that
> can be called from interrupt context (i386 and x86_64 hpet time routines). Or
> same routine behaving differently depending on where it is called from.
>
> And for the hpet rtc emulation routines it should be OK even if the time is
> slightly off and not exact. So, probably we should be able to force read
> rtc even when update is in progress. That way we can avoid the busy loop.
> Unless RTC returns grossly wrong time values while UIP flag is set. I need to
> look at RTC specs to verify that.
>
> Thanks,
> Venki

The usual way is to read all time registers, save those values.
Read all registers again. Do this until the two consecutive reads
return the same values. You never have to busy-wait at all.
When I do this, I put the values read in two arrays, I memcmp()
them and, if not the same use memcpy() to copy new to old and
try again.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
