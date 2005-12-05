Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932414AbVLENbW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414AbVLENbW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 08:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbVLENbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 08:31:22 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:61193 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751118AbVLENbV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 08:31:21 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <1133572199.32583.93.camel@localhost.localdomain>
X-OriginalArrivalTime: 05 Dec 2005 13:31:19.0911 (UTC) FILETIME=[2D3EEF70:01C5F9A0]
Content-class: urn:content-classes:message
Subject: Re: copy_from_user/copy_to_user question
Date: Mon, 5 Dec 2005 08:31:19 -0500
Message-ID: <Pine.LNX.4.61.0512050820390.27133@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: copy_from_user/copy_to_user question
Thread-Index: AcX5oC1IGLypJEuNQDuHw57zW0N9yg==
References: <20051202224025.39396.qmail@web32108.mail.mud.yahoo.com> <1133572199.32583.93.camel@localhost.localdomain>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Steven Rostedt" <rostedt@goodmis.org>
Cc: "Vinay Venkataraghavan" <raghavanvinay@yahoo.com>,
       <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 2 Dec 2005, Steven Rostedt wrote:

> On Fri, 2005-12-02 at 14:40 -0800, Vinay Venkataraghavan wrote:
>> I have a question regarding copy_to_user and
>> copy_from_user, specifically the conditons and
>> situations when they can be used.
>>
>> Firstly, I guess it is always safe to use these
>> funtions when making an ioctl call.
>
> It's basically safe whenever you can schedule, and you are running on
> behalf of a user task (as appose to a kernel thread).
>
>>
>> But my question is: Are there any specific
>> circumstances or conditions when these functions don't
>> have to be used, but at the same time ensure that no
>> page fault occurs and crashes the system.
>
> Sure, they don't need to be used if you don't need to get data to or
> from user context.
>
>>
>> The reason I ask is, there is some software that I am
>> dealing with that just don't use these functions.
>
> What is this code and what is it doing?
>
>>
>> Secondly, they seem to use memcpy as opposed to using
>> copy_to_user/copy_from_user which is also very
>> dangerous.
>
> If they are grabbing data from user context into kernel (or vise versa)
> that could easily cause an oops.  Not to mention it is a security risk.
>
> -- Steve
>

The kernel has the privileges to trash anything from kernel-space.
This means that an incorrect pointer or length-variable, passed
from user-mode code could trash everything including the kernel
if the kernel code just used memcpy().

So, copy_to/from_user was developed so that the user's privs and
page ownership would be used during the copy operation. This means
that if the user provides the wrong location or byte-count, the
improper operation is trapped and the kernel code can return
an error code, usually -EFAULT.

Drivers that use memcpy() when accessing user-provided space
(such as in read(), write(), ioctl(), etc.) are simply broken
and should not be used. They can cause other modules and/or
kernel functions to fail in mysterious ways.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.44 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
