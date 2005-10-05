Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030289AbVJERkF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030289AbVJERkF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 13:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030291AbVJERkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 13:40:05 -0400
Received: from spirit.analogic.com ([204.178.40.4]:57871 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1030290AbVJERkD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 13:40:03 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <4343F412.8070208@wincor-nixdorf.com>
References: <43301BC4.9080305@wincor-nixdorf.com> <1127230327.6276.1.camel@localhost.localdomain> <4343F412.8070208@wincor-nixdorf.com>
X-OriginalArrivalTime: 05 Oct 2005 17:40:01.0805 (UTC) FILETIME=[D03083D0:01C5C9D3]
Content-class: urn:content-classes:message
Subject: Re: kernel error in system call accept() under kernel 2.6.8
Date: Wed, 5 Oct 2005 13:39:57 -0400
Message-ID: <Pine.LNX.4.61.0510051323001.5790@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: kernel error in system call accept() under kernel 2.6.8
Thread-Index: AcXJ09A3uORMFVkEQ0yAD/nwiy9hdg==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Peter Duellings" <Peter.Duellings@wincor-nixdorf.com>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 5 Oct 2005, Peter Duellings wrote:

> Alan,
>
> meanwhile we could generate a strace for the problem.
> However, I guess that the strace does not give the desired
> information (see parts below).
>
> Additionally we added in the program the output of the return
> value of the accept() system call . The return value is -512
> and the errno value is 0!
> Usually the return value should be -1 and the errno  should
> contain the value without the sign of the error.
>
>
> Any idea or comment on this ?
>
> Thanks,
>

If you run an ordinary 'C' runtime library, not something
that you wrote to interface with the kernel, then a return
value of -512 with a 0 errno value is not possible unless
you have code that is trashing something in user-space.

The interface, whether a sys-call or an interrupt, takes
the return value, negates it, and puts it into errno if
it was negative, then it sets the return value to -1.
This is common code for all system-calls, therefore
nothing you can turn off for a particular system call.

A possible problem may be that you are not using the
proper 'C' runtime library headers to define what
errno actually is. On many (most) runtime libraries
'errno' is NOT 'extern int errno'. Instead it is
actually a de-reference of the return-value of a
function that located the proper variable for your
particular thread! You can't create your own global
errno and have it magically updated.

>
> Peter Düllings
>
> ---------<strace>------------
> 2682  09:25:29.238663 accept(21,  <unfinished ...>
> 2688  09:25:29.263486 accept(33, {sa_family=AF_INET, sin_port=htons(32811),
> sin_addr=inet_addr("127.0.0.1")}, [16]) = 40 <27.171270>
> 2688  09:25:56.589969 accept(33, 0x82fa7e0, [16]) = ? ERESTARTSYS (To be
> restarted) <0.385453>
> 2688  09:25:56.975563 --- SIGCHLD (Child exited) @ 0 (0) ---
> 2688  09:25:56.975676 accept(33, 0x82fa7e0, [16]) = ? ERESTARTSYS (To be
> restarted) <0.205963>
> 2688  09:25:57.181770 --- SIGCHLD (Child exited) @ 0 (0) ---
> 2688  09:25:57.181842 accept(33,  <unfinished ...>
> 2682  09:25:57.231961 <... accept resumed> {sa_family=AF_INET,
> sin_port=htons
> (32882), sin_addr=inet_addr("127.0.0.1")}, [16]) = 43 <27.993066>
> 2682  09:25:57.234320 accept(21,  <unfinished ...>
> 2688  09:25:57.538314 <... accept resumed> 0x82fa7e0, [16]) = ? ERESTARTSYS
> (To be restarted) <0.356435>
> 2688  09:25:57.538429 --- SIGCHLD (Child exited) @ 0 (0) ---
> 2688  09:25:57.538488 accept(33, 0x82fa7e0, [16]) = ? ERESTARTSYS (To be
> restarted) <0.015688>
> 2688  09:25:57.554315 --- SIGCHLD (Child exited) @ 0 (0) ---
> 2688  09:25:57.554370 accept(33, 0x82fa7e0, [16]) = ? ERESTARTSYS (To be
> restarted) <0.192660>
> 2688  09:25:57.747151 --- SIGCHLD (Child exited) @ 0 (0) ---
> 2688  09:25:57.747236 accept(33, 0x82fa7e0, [16]) = ? ERESTARTSYS (To be
> restarted) <0.097813>
> ....
> .
> ---------</strace>------------
>
>
>
> Alan Cox wrote:
>
>> On Maw, 2005-09-20 at 16:25 +0200, Peter Duellings wrote:
>>
>>> Obviously there are some cases where the accept() system call does
>>> not set the errno variable if the accept() system call returns
>>> with a value less than zero:
>>
>>
>> Not actually possible. The kernel returns a positive value, zero or a
>> negative value which is the errno code negated. It has no mechanism to
>> return a negative value and not error.
>>
>> What does strace show for the failing case ?
>>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
