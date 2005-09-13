Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964772AbVIMNqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964772AbVIMNqX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 09:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964773AbVIMNqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 09:46:23 -0400
Received: from spirit.analogic.com ([208.224.221.4]:64781 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S964772AbVIMNqW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 09:46:22 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <4326CAB3.6020109@compro.net>
References: <4326CAB3.6020109@compro.net>
X-OriginalArrivalTime: 13 Sep 2005 13:46:20.0149 (UTC) FILETIME=[858B1A50:01C5B869]
Content-class: urn:content-classes:message
Subject: Re: HZ question
Date: Tue, 13 Sep 2005 09:46:19 -0400
Message-ID: <Pine.LNX.4.61.0509130919390.29445@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: HZ question
Thread-Index: AcW4aYWShMX64CBJTle8gONaqqd6Nw==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Mark Hounschell" <markh@compro.net>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 13 Sep 2005, Mark Hounschell wrote:

> I need to know the kernels value of HZ in a userland app.
>
> getconf CLK_TCK
>      and
> hz = sysconf (_SC_CLK_TCK)
>
> both seem to return CLOCKS_PER_SEC which is defined as USER_HZ which is
> defined as 100.
>
> include/asm/param.h:
>
> #ifdef __KERNEL__
> # define HZ       1000   /* Internal kernel timer frequency */
> # define USER_HZ  100    /* .. some user interfaces are in "ticks" */
> # define CLOCKS_PER_SEC  (USER_HZ)       /* like times() */
> #endif
>
> Thanks in advance for any help
> Mark

You are not supposed to 'tear apart' user-mode headers. In particular
you are not supposed to use anything in /usr/include/bits, /usr/include/asm,
or /usr/include/linux in user-mode programs. These are not POSIX headers.

Therefore, HZ is not something that is defined for user-mode programs.
the ANSI spec requires that things like clock() return a value that
can be divided by CLOCKS_PER_SEC to get CPU time. Nothing in user-mode
uses HZ.  That's the reason why later versions of the kernel are
able to use dynamic HZ.

You will not find HZ in /usr/include/time.h or /usr/include/sys/time.h
because it's not supposed to be there, but these headers may reference
something that you are not supposed to look at in your programs.

If a user-mode program needs to know HZ, it is very, very, broken.
HZ is some kernel timeout tick which doesn't relate to anything
a user program needs to know.

If you are making a program that accesses /proc (therefore non-
standard and non portable), to obtain some kernel information,
some of which may be in HZ, you need to access the kernel headers
for the kernel that is running at the time that /proc is accessed.

This is a problem and is why we should have a kernel system-call
that returns the HZ value. I asked about this several years ago
and its inclusion was flatly refused because of what I quoted
above. Perhaps now that HZ are dynamic, it would be posasible to
add that system call.

Note, that on this particular kernel, at this phase of the moon...
This program returns the HZ value.

#include <stdio.h>
#include <unistd.h>

int main()
{
     printf("%d\n", sysconf(_SC_CLK_TCK));
     return 0;
}



Cheers,
Dick Johnson
Penguin : Linux version 2.6.13 on an i686 machine (5589.53 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
