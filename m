Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030370AbWGFRwb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030370AbWGFRwb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 13:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030371AbWGFRwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 13:52:31 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:1040 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1030370AbWGFRwb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 13:52:31 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 06 Jul 2006 17:52:26.0719 (UTC) FILETIME=[F160DEF0:01C6A124]
Content-class: urn:content-classes:message
Subject: Re: [patch] spinlocks: remove 'volatile'
Date: Thu, 6 Jul 2006 13:52:25 -0400
Message-ID: <Pine.LNX.4.61.0607061333450.11071@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.64.0607060911530.12404@g5.osdl.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch] spinlocks: remove 'volatile'
thread-index: AcahJPFo2LAa7ez1RPayp1cblJwxeA==
References: <20060705114630.GA3134@elte.hu> <20060705101059.66a762bf.akpm@osdl.org> <20060705193551.GA13070@elte.hu> <20060705131824.52fa20ec.akpm@osdl.org> <Pine.LNX.4.64.0607051332430.12404@g5.osdl.org> <20060705204727.GA16615@elte.hu> <Pine.LNX.4.64.0607051411460.12404@g5.osdl.org> <20060705214502.GA27597@elte.hu> <Pine.LNX.4.64.0607051458200.12404@g5.osdl.org> <Pine.LNX.4.64.0607051555140.12404@g5.osdl.org> <20060706081639.GA24179@elte.hu> <Pine.LNX.4.61.0607060756050.8312@chaos.analogic.com> <Pine.LNX.4.64.0607060856080.12404@g5.osdl.org> <Pine.LNX.4.64.0607060911530.12404@g5.osdl.org>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Cc: "Ingo Molnar" <mingo@elte.hu>, "Andrew Morton" <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <arjan@infradead.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 6 Jul 2006, Linus Torvalds wrote:

>
>
> On Thu, 6 Jul 2006, Linus Torvalds wrote:
>>
>> Any other use of "volatile" is almost certainly a bug, or just useless.
>
> Side note: it's also totally possible that a volatiles _hides_ a bug, ie
> removing the volatile ends up having bad effects, but that's because the
> software itself isn't actually following the rules (or, more commonly, the
> rules are broken, and somebody added "volatile" to hide the problem).
>
> That's not just a theoretical notion, btw. We had _tons_ of these kinds of
> "volatile"s in the original old networking code. They were _all_ wrong.
> Every single one.
>
> 			Linus
>

Linus, you may have been reading too many novels.

If I have some code that does:

extern int spinner;

funct(){
     while(spinner)
         ;

The 'C' compiler has no choice but to actually make that memory access
and read the variable because the variable is in another module (a.k.a.
file).

However, if I have the same code, but the variable is visible during
compile time, i.e.,

int spinner=0;

funct(){
     while(spinner)
         ;

... the compiler may eliminate that code altogether because it
'knows' that spinner is FALSE, having initialized it to zero
itself.

Since spinner is global in scope, somebody surely could have
changed it before funct() was even called, but the current gcc
'C' compiler doesn't care and may optimize it away entirely. To
prevent this, you must declare the variable volatile. To do
otherwise is a bug.

Reading between the lines of your text, you are trying to say
that object 'spinner' should remain an integer, but any access
should be cast, like:

funct() {
     while((volatile)spinner)
         ;

This is just a matter of style. It substitutes a number of casts
for a simple declaration. That said, I think that the current
implementation of 'volatile' is broken because the compiler
seems to believe that the variable has moved! It recalculates
the address of the variable as well as accessing its value.
This is what makes the code generation problematical.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.88 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
