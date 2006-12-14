Return-Path: <linux-kernel-owner+w=401wt.eu-S1751679AbWLNQkz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751679AbWLNQkz (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 11:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751727AbWLNQkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 11:40:55 -0500
Received: from spirit.analogic.com ([204.178.40.4]:2348 "EHLO
	spirit.analogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751679AbWLNQky convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 11:40:54 -0500
X-Greylist: delayed 1802 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2006 11:40:54 EST
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 14 Dec 2006 16:10:49.0613 (UTC) FILETIME=[6BBA13D0:01C71F9A]
Content-class: urn:content-classes:message
Subject: Re: Userspace I/O driver core
Date: Thu, 14 Dec 2006 11:10:49 -0500
Message-ID: <Pine.LNX.4.61.0612141110310.31046@chaos.analogic.com>
In-Reply-To: <20061214010608.GA13229@kroah.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Userspace I/O driver core
thread-index: AccfmmvBAQ71oz11QH6bYBYNgm5Cig==
References: <20061214010608.GA13229@kroah.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Greg KH" <greg@kroah.com>
Cc: <linux-kernel@vger.kernel.org>, <tglx@linutronix.de>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 13 Dec 2006, Greg KH wrote:

> A large number of people have expressed interest recently in the
> userspace i/o driver core which allows userspace drivers to be written
> to handle some types of hardware.
>
> Right now the UIO core is working and in the -mm releases.  It's been
> rewritten from the last time patches were posted to lkml and is much
> simpler.  It also includes full documentation and two example drivers
> and two example userspace programs that test those drivers.
>
> But in order to get this core into the kernel tree, we need to have some
> "real" drivers written that use it.  So, for anyone that wants to see
> this go into the tree, now is the time to step forward and post your
> patches for hardware that this kind of driver interface is needed.
>
> If no such drivers appear, then there is a very slim chance that this
> interface will be accepted into the tree.
>
> The patches can be found in the -mm releases or at:
>  http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-01-driver/uio.patch
>    - UIO core
>  http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-01-driver/uio-documentation.patch
>    - UIO documentation
>  http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-01-driver/uio-dummy.patch
>  http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-01-driver/uio-irq.patch
>    - two example kernel modules and userspace programs showing how to
>      use the UIO interface.
>
> If anyone has any questions on how to use this interface, or anything
> else about it, please let me and Thomas know.
>
> thanks,
>
> greg k-h

Exposing device hardware registers to user-space in contrary to good standards of engineering practice, violates some basic tenets of operating system design, and certainly has no place within a Unix emulation such as Linux. Please understand that even though certain graphical interfaces violate these standards, this does not mean that any such violations are acceptable.

There are well thought-out methods of creating hardware interfaces that have a successfully history of implementation both in Linux and Unix. There are well established APIs that are used to expose devices to user-space with controlled privilege, access mechanisms, and built-in locking to provide atomic access to the functionality of the devices without user-space code needing to understand the device intricacies (and probably getting it wrong).

I recently returned from a conference where somebody had designed a driver that exposes PCI registers and FPGA device registers to user-space. Their problem was how to provide "call-backs" when an interrupt occurred. They were convinced that all they had to do was to have some user-space procedure that could be called when an interrupt occurred. Then their so-called driver would work. They had no clue about the fact that an interrupt can occur at any time not just when somebody is ready and waiting for it, that one usually has sections of code that must not be interrupted, etc. This information was completely lost when talking to this engineer. He had learned that an interrupt service routine is just some code. That's all. Synchronization and atomic operations meant nothing to him. We was a recent college graduate with as Masters Degree so he wasn't uneducated. What he was was uneducated, regardless of his degrees. Driver code needs to be protected from undue user-space interference otherwise the device can't be synchronized, shared, or accessed through the operating system's APIs.

Every time I showed how the driver couldn't work properly, the designer so convinced of his superior methods, would devise a work-around. For instance, to protect a section of code from being modified in an interrupt, the user-space driver was to be executed with iopl(3) and interrupts disabled. To protect the kernel from the ISR being modified or replaced, the code would be checksummed every time an interrupt occurred, etc. I could go on. Drivers have no place user space.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.24 on an i686 machine (5592.72 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
