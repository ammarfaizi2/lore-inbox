Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932077AbWH3VZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbWH3VZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 17:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932082AbWH3VZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 17:25:57 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:16658 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S932077AbWH3VZ4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 17:25:56 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
x-originalarrivaltime: 30 Aug 2006 21:25:46.0543 (UTC) FILETIME=[DB6343F0:01C6CC7A]
Content-class: urn:content-classes:message
Subject: Re: [RFC] Simple userspace interface for PCI drivers
Date: Wed, 30 Aug 2006 17:25:45 -0400
Message-ID: <Pine.LNX.4.61.0608301707130.26205@chaos.analogic.com>
In-Reply-To: <44F5FCA7.3080509@citd.de>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC] Simple userspace interface for PCI drivers
Thread-Index: AcbMettsMVBw4uTeS4GTNG/dxvI+JQ==
References: <20060830062338.GA10285@kroah.com> <20060830143410.GB19477@gate.crashing.org> <20060830175529.GB6258@kroah.com> <44F5FCA7.3080509@citd.de>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Matthias Schniedermeyer" <ms@citd.de>
Cc: "Greg KH" <greg@kroah.com>, "Matt Porter" <mporter@embeddedalley.com>,
       <linux-kernel@vger.kernel.org>, "Thomas Gleixner" <tglx@linutronix.de>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 30 Aug 2006, Matthias Schniedermeyer wrote:

> Greg KH wrote:
>> On Wed, Aug 30, 2006 at 09:34:10AM -0500, Matt Porter wrote:
>>> Well, if it's focused on industrial controls like it appears from
>>> the code here then the name is fine. If it's a starting point to
>>> become someting more generic then User Space Driver (USD) subsystem
>>> might be nice.
>>>
>> It's not focused on industrial controls at all, that just happens to be
>> the name of it right now, as that is why it was written.  It is much
>> more generic than that.
>>
>> "USD" is a bit too close to "USB" for a name.  Any other ideas?
>
> DFU - Drivers for Userspace
> DFU - Driver from Userspace
> DFUF - Drivers for Userspace Framework
> DIFUS - Drive It From Userspace :-)
> FUD - Framework (for) Userspace Drivers ;-)
> GUDI - Generic Userspace Driver Interface
> UDF - Userspace Driver Framework :-)
> UDI - Userspace Driver Interface :-)
> UUDI - Unified Userspace Driver Interface
> UFD - Userspace Framework (for) Drivers
>
> Bis denn
>

Something to consider if/when you expose PCI to user-space is
that protection on ix86 extends to PAGE_SIZE pages. This means
that when you ioremap() some PCI addresses to user-space, user-mode
code can write (or read) well beyond the few bytes that you may
think that you have mapped! When you make a driver in the kernel,
your code can check to see if the read or write is going to be
out-of-bounds. When you mmap() something to user-space, its the
user-space code that needs to protect hardware and/or the kernel.
This is not good.

Let's say that I mapped() 512 bytes to access my controller. If
I have a another controller, perhaps one for my SCSI disk, that's
within that allocated page, I can easily "deprogram" the controller
and fail the system, file-system, or both.

User mode drivers are NOT good. For them to work, too much stuff
needs to be exposed. Then there is the problem of interrupts.
You are not going to be able to make an interrupt 'thunker' like
you could in the old DOS days. The kernel isn't going to call
user-mode code because nobody is going to provide such a potentially
destructive interface. If you think you can handle hardware interrupt
requests with the poll() interface, you are going to be in a world of
hurt for throughput.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.24 on an i686 machine (5592.62 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
