Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbWEKVEt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbWEKVEt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 17:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbWEKVEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 17:04:49 -0400
Received: from spirit.analogic.com ([204.178.40.4]:18950 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1750763AbWEKVEs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 17:04:48 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 11 May 2006 21:04:47.0269 (UTC) FILETIME=[88F30D50:01C6753E]
Content-class: urn:content-classes:message
Subject: Re: Linux poll() <sigh> again
Date: Thu, 11 May 2006 17:04:46 -0400
Message-ID: <Pine.LNX.4.61.0605111659580.5484@chaos.analogic.com>
In-Reply-To: <20060511204741.GG22741@us.ibm.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Linux poll() <sigh> again
Thread-Index: AcZ1Poj8Cw2G6ow7R1u4sByqQSz9Jw==
References: <Pine.LNX.4.61.0605111023030.3729@chaos.analogic.com> <20060511204741.GG22741@us.ibm.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Nishanth Aravamudan" <nacc@us.ibm.com>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>, <staubach@redhat.com>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 11 May 2006, Nishanth Aravamudan wrote:

> On 11.05.2006 [10:25:29 -0400], linux-os (Dick Johnson) wrote:
>>
>>
>> Hello,
>>
>> I'm trying to fix a long-standing bug which has a
>> work-around that has been working for a year or
>> so.
>
> <snip valiant efforts>
>
>> Here is relevent code:
>>
>>              for(;;) {
>>                  mem->pfd.fd = fd;
>>                  mem->pfd.events = POLLIN|POLLERR|POLLHUP|POLLNVAL;
>>                  mem->pfd.revents = 0x00;
>
> Hrm, in looking at the craziness that is sys_poll() for a bit, I think
> it's the underlying f_ops that are responsible for not setting POLLHUP,
> that is:
>
>                        if (file != NULL) {
>                                mask = DEFAULT_POLLMASK;
>                                if (file->f_op && file->f_op->poll)
>                                        mask = file->f_op->poll(file, *pwait);
>                                mask &= fdp->events | POLLERR | POLLHUP;
>                                fput_light(file, fput_needed);
>                        }
>
> and file->f_op->poll(file, *pwait) is not setting POLLHUP on the
> disconnect. What filesystem is this?

I think that's the problem. A socket isn't a file-system and the
code won't set either bits if it isn't. Perhaps, the kernel code
needs to consider a socket as a virtual file of some kind? Surely
one needs to use poll() on sockets, no?

>
> On an independent note, it seems like the relatively recent cleanups to
> sys_poll() made the negative case a bit inefficient (and reliant on
> msecs_to_jiffies() dealing with negative values, which I don't think it
> was really ever designed to (it's mostly used for converting time
> values, which can never go negative)). Maybe the following would make
> sense? Peter, I know you had been looking at poll() issues earlier, does
> this change make sense?
>
> Description: Rather than make msecs_to_jiffies() deal with negative
> values, just send them on to do_sys_poll(), which (eventually in
> do_poll()) explicitly checks for them.
>
> Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
>
> diff -urpN 2.6.17-rc3-git18/fs/select.c 2.6.17-rc3-git18-dev/fs/select.c
> --- 2.6.17-rc3-git18/fs/select.c	2006-05-11 12:17:15.000000000 -0700
> +++ 2.6.17-rc3-git18-dev/fs/select.c	2006-05-11 12:38:16.000000000 -0700
> @@ -727,9 +727,9 @@ out_fds:
> asmlinkage long sys_poll(struct pollfd __user *ufds, unsigned int nfds,
> 			long timeout_msecs)
> {
> -	s64 timeout_jiffies = 0;
> +	s64 timeout_jiffies;
>
> -	if (timeout_msecs) {
> +	if (timeout_msecs > 0) {
> #if HZ > 1000
> 		/* We can only overflow if HZ > 1000 */
> 		if (timeout_msecs / 1000 > (s64)0x7fffffffffffffffULL / (s64)HZ)
> @@ -737,6 +737,8 @@ asmlinkage long sys_poll(struct pollfd _
> 		else
> #endif
> 			timeout_jiffies = msecs_to_jiffies(timeout_msecs);
> +	} else {
> +		timeout_jiffies = timeout_msecs;
> 	}
>
> 	return do_sys_poll(ufds, nfds, &timeout_jiffies);
>
> --
> Nishanth Aravamudan <nacc@us.ibm.com>
> IBM Linux Technology Center
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.89 BogoMips).
New book: http://www.lymanschool.com
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
