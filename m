Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932085AbWBVObO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbWBVObO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 09:31:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbWBVObO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 09:31:14 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:64015 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S932085AbWBVObN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 09:31:13 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <Pine.LNX.4.61.0602221504120.11432@yvahk01.tjqt.qr>
x-originalarrivaltime: 22 Feb 2006 14:31:11.0621 (UTC) FILETIME=[A0B4A350:01C637BC]
Content-class: urn:content-classes:message
Subject: Re: Mapping to 0x0
Date: Wed, 22 Feb 2006 09:31:11 -0500
Message-ID: <Pine.LNX.4.61.0602220920060.10177@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Mapping to 0x0
Thread-Index: AcY3vKC7qBa1ieglTYyvAGR8nnPF3Q==
References: <Pine.LNX.4.61.0602221504120.11432@yvahk01.tjqt.qr>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Jan Engelhardt" <jengelh@linux01.gwdg.de>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 22 Feb 2006, Jan Engelhardt wrote:

> Hello,
>
>
>
> from somewhere in my INBOX, this claim was made:
>
>>> (also note that userland processes can map 0x00000000 and the kernel
>>> would jump to it ...)
>
> In C code:
>
> #include <sys/mman.h>
> #include <sys/ioctl.h>
> #include <fcntl.h>
> #include <stdio.h>
> int main(void) {
>    int fd   = open("badcode.bin", O_RDONLY);
      int fd   = open("/dev/mem", O_RDWR);


>    mmap(NULL, 4096, PROT_READ | PROT_EXEC, MAP_FIXED, fd, 0);
> }
>
> The mmap() usually succeeds and maps something at address 0x00000000. Now
> what if the kernel would try to execute this (of course badly programmed)
> code in the context of this very process?
>
>    int (*callback)(int xyz) = NULL;
>    callback();
>
> Would not be the badcode be executed with kernel privileges?
> Jan Engelhardt
> --

No. In your demo code, page 0 gets memory-mapped into user space.
This allows user-mode code to access the first page of memory
and even read/write offset 0, still in user mode, with the
root privs that allowed you access to that page in the
first place. Everything you do, is still in user-mode.
You just own some physical memory that the kernel didn't
care about anyway. FYI, the only "strange" thing is that
you can dereference a NULL pointer without error IFF the
"hint" passed to mmap() was a NULL. Mmap()s failure is
depicted by returning (void *) -1, not (void *) 0, so
a returned pointer value of 0 is perfectly okay and can
be used without a seg-fault. To prevent certain 'C'
runtime library functions from refusing to dereference
the pointer, it is best to give mmap() a "hint" of
some valid pointer value like 0x10000000. That will
prevent it from returning the (perfectly legal) NULL.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.54 BogoMips).
Warning : 98.36% of all statistics are fiction.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
