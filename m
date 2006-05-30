Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751502AbWE3OZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502AbWE3OZF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 10:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751513AbWE3OZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 10:25:05 -0400
Received: from spirit.analogic.com ([204.178.40.4]:32787 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S932288AbWE3OZE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 10:25:04 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 30 May 2006 14:24:37.0761 (UTC) FILETIME=[C8041F10:01C683F4]
Content-class: urn:content-classes:message
Subject: Re: memcpy_toio on i386 using byte writes even when n%2==0
Date: Tue, 30 May 2006 10:24:37 -0400
Message-ID: <Pine.LNX.4.61.0605301002530.24540@chaos.analogic.com>
In-Reply-To: <1148997301.4376.88.camel@emerson.licor.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: memcpy_toio on i386 using byte writes even when n%2==0
Thread-Index: AcaD9MgLWobQkJGkS0yAzqLeBRlzEA==
References: <6gMqr-8uW-23@gated-at.bofh.it>  <44779358.9010703@shaw.ca> <1148997301.4376.88.camel@emerson.licor.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Chris Lesiak" <chris.lesiak@licor.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>,
       "Robert Hancock" <hancockr@shaw.ca>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 30 May 2006, Chris Lesiak wrote:

> On Fri, 2006-05-26 at 17:46 -0600, Robert Hancock wrote:
>> It does seem a little bit less efficient, but I don't know think it's
>> necessarily a bug. There's no guarantee of what size writes will be used
>> with the memcpy_to/fromio functions.
>
> I shouldn't have made that assumption in the first place, but I suspect
> that I am not the only one to have done so.  Probably other hardware
> also gets caught not supporting byte enables.
> --
> Chris Lesiak
> chris.lesiak@licor.com
>

If byte writes are used, they should always be last for any
odd byte. I think you found a bug in spite of the fact that
whoever made the revision to memcpy probably thinks they
did something 'cool'. This is an example of cute code causing
problems. The classic example of a proper memcpy() that uses
the ix86 built-in macros runs like this:

 		pushl	%esi		# Save precious registers
 		pushl	%edi
 		movl	COUNT(%esp),%ecx
 		movl	SOURCE(%esp),%esi
 		movl	DEST(%esp),%edi
 		cld
 		shrl	$1,%ecx		# Make WORDS, possibly set carry
 		rep	movsw		# Copy the words
 		adcl	%ecx,%ecx	# Any spare byte
 		rep	movsb		# Copy any spare byte
 		popl	%edi		# Restore precious registers
 		popl	%esi

Note that there isn't any code for moving dwords because the
chances of gaining anything are slim (alignment may hurt).
This kind of code results in the principle of least surprise.
More sophisticated code usually takes longer to execute although
it often looks 'cute' as the designer attempts to create some
sort of alignment, at least for one of the elements. The jumps
in such code usually negate the advantages of any such cuteness.

I've found that it's often necessary to create private functions
to get around the disadvantages of some of the recent cute code.
You can always make a MemcpyTo_io().... It won't ever change
unless you change it! That way, your modules will compile and
work forever, regardless of any "improvements" made in the
source-code tree.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.73 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
