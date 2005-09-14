Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932570AbVINTJq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932570AbVINTJq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 15:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932572AbVINTJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 15:09:46 -0400
Received: from spirit.analogic.com ([208.224.221.4]:46086 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S932570AbVINTJp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 15:09:45 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <BB99A175-9BC7-4004-896D-7A5A22349861@mac.com>
References: <C670AD22-97CF-46AA-A527-965036D78667@mac.com> <20050902134108.GA16374@codepoet.org> <22D79100-00B5-44F6-992C-FFFEACA49E66@mac.com> <20050902235833.GA28238@codepoet.org> <dfapgu$dln$1@terminus.zytor.com> <4328299C.9020904@tmr.com> <BB99A175-9BC7-4004-896D-7A5A22349861@mac.com>
X-OriginalArrivalTime: 14 Sep 2005 19:09:25.0149 (UTC) FILETIME=[D2511CD0:01C5B95F]
Content-class: urn:content-classes:message
Subject: Re: [RFC] Splitting out kernel<=>userspace ABI headers
Date: Wed, 14 Sep 2005 15:09:09 -0400
Message-ID: <Pine.LNX.4.61.0509141458380.19578@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC] Splitting out kernel<=>userspace ABI headers
Thread-Index: AcW5X9JajkfNo8YbRw6Q9qCYZ279aA==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Kyle Moffett" <mrmacman_g4@mac.com>
Cc: "Bill Davidsen" <davidsen@tmr.com>, "H. Peter Anvin" <hpa@zytor.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 14 Sep 2005, Kyle Moffett wrote:

> On Sep 14, 2005, at 09:46:04, Bill Davidsen wrote:
>> H. Peter Anvin wrote:
>>> Followup to:  <20050902235833.GA28238@codepoet.org>
>>> By author:    Erik Andersen <andersen@codepoet.org>
>>> In newsgroup: linux.dev.kernel
>>>> <uClibc maintainer hat on>
>>>> That would be wonderful.
>>>> </off>
>>>>
>>>> It would be especially nice if everything targeting user space
>>>> were to use only all the nice standard ISO C99 types as defined
>>>> in include/stdint.h such as uint32_t and friends...
>>> Absolutely not.  This would be a POSIX namespace violation; they
>>> *must* use double-underscore types.
>>
>> Could you explain why you think it would be a violation to use
>> POSIX types instead of defining our own? That's what the types are
>> for, to avoid having everyone define some slightly conflicting types.
>>
>> The kernel predates C99, sort of, and it would be a massive but
>> valuable  task to figure out where a type is really, for instance,
>> 32 bits rather than "size of default int" in length, etc, and use
>> POSIX types where they are correct. Fewer things to maintain, and
>> would make it clear when something is 32 bits by default and when
>> it really must be 32 bits.
>
> Argh, it seems I'm going to be giving this example forever!  Here's
> why this won't work.  We want to have sys/stat.h do something like
> the following:
>
> # define __kabi_stat64 stat
> # include <kabi/stat.h>
> /* Now we expect struct stat to be defined with correct types */
>
> Since struct stat in that case uses fixed-bit-size types, the header
> fine <kabi/stat.h> needs to include a file providing those types.  If
> it used stdint.h types, such as uint32_t, then it would need to
> #include <stdint.h> or provide the stdint.h types itself.  In order
> to remain POSIX compliant, sys/stat.h must not include stdint.h or
> assume that stdint.h is included or that those types were defined by
> the user program.  Therefore, kabi/*.h cannot use the stdint.h types
> at all!  The solution is a separate file, kabi/types.h, which
> properly defines __kabi_[su]{8,16,32,64} which are safe to include
> and reuse anywhere.  Then sys/types.h would look like this:
>

No No. The solution is to do it right. If the standard says that
the header file can't include a header file defining the types used
within that header file (and I don't think the "standard" says that
at all), then the correct solution is to include the correct header file
in the user program. It is truly just that simple.

The whole purpose of POSIX types, a.k.a. ISO C99: 7.18 Integer types,
<stdint.h> was to PREVENT the crap like you describe. We do NOT
need, for instance....

 	uint8, u8, u8_t, __u8, _u8, -> inf., to
correctly define an unsigned 8-bit char type. All we need is the
POSIX type, uint8_t, nothing else.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13 on an i686 machine (5589.53 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
