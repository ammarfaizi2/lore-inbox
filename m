Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751173AbWCOV0l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbWCOV0l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 16:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbWCOV0l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 16:26:41 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:59144 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751173AbWCOV0k convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 16:26:40 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
in-reply-to: <46E23BE4-4353-472B-90E6-C9E7A3CFFC15@kernel.crashing.org>
x-originalarrivaltime: 15 Mar 2006 21:26:21.0812 (UTC) FILETIME=[1B02E340:01C64877]
Content-class: urn:content-classes:message
Subject: Re: [RFC][PATCH] Expanding the size of "start" and "end" field in "struct resource"
Date: Wed, 15 Mar 2006 16:26:16 -0500
Message-ID: <Pine.LNX.4.61.0603151617010.4346@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC][PATCH] Expanding the size of "start" and "end" field in "struct resource"
Thread-Index: AcZIdxsMGm2YtpMoQV6XE+3TKjO0dA==
References: <20060315193114.GA7465@in.ibm.com> <20060315205306.GC25361@kvack.org> <46E23BE4-4353-472B-90E6-C9E7A3CFFC15@kernel.crashing.org>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: "Benjamin LaHaise" <bcrl@kvack.org>, "Vivek Goyal" <vgoyal@in.ibm.com>,
       "linux kernel mailing list" <linux-kernel@vger.kernel.org>,
       "Fastboot mailing list" <fastboot@lists.osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       "Morton Andrew Morton" <akpm@osdl.org>, <gregkh@suse.de>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 15 Mar 2006, Kumar Gala wrote:

>
> On Mar 15, 2006, at 2:53 PM, Benjamin LaHaise wrote:
>
>> On Wed, Mar 15, 2006 at 02:31:14PM -0500, Vivek Goyal wrote:
>>> Is there a reason why "start" and "end" field of "struct resource"
>>> are of
>>> type unsigned long. My understanding is that "struct resource" can
>>> be used
>>> to represent any system resource including physical memory. But
>>> unsigned
>>> long is not suffcient to represent memory more than 4GB on PAE
>>> systems.
>>> and compiler starts throwing warnings.
>>
>> Please make this depend on the kernel being compiled with PAE.  We
>> don't
>> need to bloat 32 bit kernels needlessly.
>
> I disagree.  I think we need to look to see what the "bloat" is
> before we go and make start/end config dependent.
>
> It seems clear that drivers dont handle the fact that "start"/"end"
> change an 32-bit vs 64-bit archs to begin with.  By making this even
> more config dependent seems to be asking for more trouble.
>
> - kumar

ix86 machines need to make many operations just to increment
or decrement a 64-bit variable, plus the operations are not
atomic so they need to be protected. The bloat of using 64-bit
objects in 32-bit machines is very real and a tremendous problem.
That's why all the stuff in the kernel wasn't 'long long' to
begin with. It's execution bloat, a.k.a., time expansion that
is the problem.

Bump a 32-bit variable, addressed from an index register:

 	incl	(%ebx)

Bump a 64-bit variable, addressed the same way.

 	addl	$1,(%ebx)	; Need to add because inc doesn't carry
 	adcl	$0,4(%ebx)	; Add 0 plus the carry-flag

If an interrupt or context-switch comes between the two operations,
the result is undefined, NotGood(tm).

Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.54 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
