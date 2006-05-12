Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751249AbWELLmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbWELLmO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 07:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbWELLmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 07:42:14 -0400
Received: from spirit.analogic.com ([204.178.40.4]:6663 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1751249AbWELLmN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 07:42:13 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 12 May 2006 11:42:12.0159 (UTC) FILETIME=[1BBFC4F0:01C675B9]
Content-class: urn:content-classes:message
Subject: Re: Linux poll() <sigh> again
Date: Fri, 12 May 2006 07:42:07 -0400
Message-ID: <Pine.LNX.4.61.0605120735550.8670@chaos.analogic.com>
In-Reply-To: <20060511211615.GA8485@us.ibm.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Linux poll() <sigh> again
Thread-Index: AcZ1uRvJO98qLENCRoSJvOLUc7BzsA==
References: <Pine.LNX.4.61.0605111023030.3729@chaos.analogic.com> <20060511204741.GG22741@us.ibm.com> <Pine.LNX.4.61.0605111659580.5484@chaos.analogic.com> <20060511211615.GA8485@us.ibm.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Nishanth Aravamudan" <nacc@us.ibm.com>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>, <staubach@redhat.com>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 11 May 2006, Nishanth Aravamudan wrote:

> On 11.05.2006 [17:04:46 -0400], linux-os (Dick Johnson) wrote:
>>
>> On Thu, 11 May 2006, Nishanth Aravamudan wrote:
>>
>>> On 11.05.2006 [10:25:29 -0400], linux-os (Dick Johnson) wrote:
>>>>
>>>>
>>>> Hello,
>>>>
>>>> I'm trying to fix a long-standing bug which has a
>>>> work-around that has been working for a year or
>>>> so.
>>>
>>> <snip valiant efforts>
>>>
>>>> Here is relevent code:
>>>>
>>>>              for(;;) {
>>>>                  mem->pfd.fd = fd;
>>>>                  mem->pfd.events = POLLIN|POLLERR|POLLHUP|POLLNVAL;
>>>>                  mem->pfd.revents = 0x00;
>>>
>>> Hrm, in looking at the craziness that is sys_poll() for a bit, I think
>>> it's the underlying f_ops that are responsible for not setting POLLHUP,
>>> that is:
>>>
>>>                        if (file != NULL) {
>>>                                mask = DEFAULT_POLLMASK;
>>>                                if (file->f_op && file->f_op->poll)
>>>                                        mask = file->f_op->poll(file, *pwait);
>>>                                mask &= fdp->events | POLLERR | POLLHUP;
>>>                                fput_light(file, fput_needed);
>>>                        }
>>>
>>> and file->f_op->poll(file, *pwait) is not setting POLLHUP on the
>>> disconnect. What filesystem is this?
>>
>> I think that's the problem. A socket isn't a file-system and the
>> code won't set either bits if it isn't. Perhaps, the kernel code
>> needs to consider a socket as a virtual file of some kind? Surely
>> one needs to use poll() on sockets, no?
>
> Duh, I'm not reading well today -- for sockets, we do
>
> file->f_op->poll() -> (socket_file_ops) sock_poll() -> sock->ops->poll()
>
> So, now I need to know what kind of socket is this to go from there ..
>
> Thanks,
> Nish

A stream socket can be "connected". Anything that can be connected
needs to know when the connection is broken.

     socket(AF_INET, SOCK_STREAM, IPPROTO_IP);
     ip_sock.sin_family = AF_INET;

Such a socket is bound to an address and port using bind(), listen()
is established, the accept() is called to accept connections. Accept
returns a socket (fd) of the connected host. It's this fd that needs
to "know" if/when the host disconnects.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.89 BogoMips).
New book: http://www.lymanschool.com
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
