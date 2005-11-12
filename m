Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751329AbVKLC0D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbVKLC0D (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 21:26:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbVKLC0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 21:26:03 -0500
Received: from fmr22.intel.com ([143.183.121.14]:12508 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751329AbVKLC0B convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 21:26:01 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: IO-APIC problem with 2.6.14-rt9
Date: Fri, 11 Nov 2005 18:25:48 -0800
Message-ID: <88056F38E9E48644A0F562A38C64FB60064B7DDC@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: IO-APIC problem with 2.6.14-rt9
Thread-Index: AcXmQEI518mbB9vUSpCrFKQLKeVekAA7xUPw
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "john stultz" <johnstul@us.ibm.com>, "Ingo Molnar" <mingo@elte.hu>
Cc: <dino@in.ibm.com>, <linux-kernel@vger.kernel.org>,
       "Thomas Gleixner" <tglx@linutronix.de>
X-OriginalArrivalTime: 12 Nov 2005 02:25:51.0200 (UTC) FILETIME=[6660E600:01C5E730]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org 
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of john stultz
>Sent: Thursday, November 10, 2005 1:43 PM
>To: Ingo Molnar
>Cc: dino@in.ibm.com; linux-kernel@vger.kernel.org; Thomas Gleixner
>Subject: Re: IO-APIC problem with 2.6.14-rt9
>
>On Thu, 2005-11-10 at 22:04 +0100, Ingo Molnar wrote:
>> * john stultz <johnstul@us.ibm.com> wrote:
>> 
>> > > > //#define ARCH_HAS_READ_CURRENT_TIMER  1
>> > > > 
>> > > > to:
>> > > > 
>> > > > #define ARCH_HAS_READ_CURRENT_TIMER  1
>> > > > 
>> > > > ?
>> > > 
>> > > It works !!  Thanks Ingo for the immediate response
>> > 
>> > Hrm. Could you post the value for BogoMIPS that you're getting now?
>> > 
>> > My patches touch the __delay() code, since using the TSC 
>based delay 
>> > has just as many, if not more, problems as the loop based 
>delay. So I 
>> > want to be careful that my changes are not further causing 
>problems.
>> > 
>> > Ingo, did you commented out ARCH_HAS_READ_CURRENT_TIMER because of 
>> > problems with the new calibration code?
>> 
>> yes. traces show that the new calibration code results in a bogomips 
>> value on Athlon64 CPUs that halve the timeout. I.e. udelay(100) now 
>> takes 50 usecs (!). The calibration code seems to assume the 
>number of 
>> cycles == number of loops in __delay() - that is not valid.
>
>Yea, that makes sense, because the READ_CURRENT_TIMER 
>calibration is all
>TSC based and with my code we use the loop based delay (since the TSC
>based one can have a number of problems). So that doesn't mesh 
>well when
>the loop/cycle values are not equivalent.
>
>That still leaves open the question why Dinakar is seeing issues w/ the
>loop based calibration, but I've got some similar hardware in 
>my lab, so
>I can probably work that out.

The reason ARCH_HAS_READ_CURRENT_TIMER and related code was added is:
Due to SMIs happening during the calibration we were seeing calibration
returning
very low values with previous calibrate_delay() algorithm. With this low
value, 
we don't wait long enough during the timer initialization and we expect
some 
number of timer interrupts and we panic() when we don't see that many
interrupts.

All the above was with TSC based delay. 
I think we can keep calibrate_delay() do the calibration using
READ_CURRENT_TIMER 
(giving TSC per jiffy) and then convert it to some number of TSCs per
loop and 
use it in loop based delay.

Thanks,
Venki
