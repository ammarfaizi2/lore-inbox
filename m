Return-Path: <linux-kernel-owner+w=401wt.eu-S1751775AbWLNWF2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751775AbWLNWF2 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 17:05:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751834AbWLNWF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 17:05:28 -0500
Received: from mail-placeholder.iinet.net.au ([203.59.1.157]:19649 "EHLO
	customer-domains.icp-qv1-irony12.iinet.net.au" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751775AbWLNWF1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 17:05:27 -0500
X-Greylist: delayed 595 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2006 17:05:26 EST
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgAAAHtXgUXKoQMBdGdsb2JhbAANjU8B
X-IronPort-AV: i="4.12,171,1165161600"; 
   d="scan'208"; a="84557675:sNHT15534414"
Message-ID: <4581C84E.3080209@iinet.net.au>
Date: Fri, 15 Dec 2006 08:55:26 +1100
From: Ben Nizette <ben.nizette@iinet.net.au>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
CC: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: Userspace I/O driver core
References: <20061214010608.GA13229@kroah.com> <Pine.LNX.4.61.0612141110310.31046@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0612141110310.31046@chaos.analogic.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:
> On Wed, 13 Dec 2006, Greg KH wrote:
>>
>> If anyone has any questions on how to use this interface, or anything
>> else about it, please let me and Thomas know.
>>
>> thanks,
>>
>> greg k-h
[snip]
> There are well thought-out methods of creating hardware interfaces that 
 > have a successfully history of implementation both in Linux and Unix.
 > There are well established APIs that are used to expose devices to
 > user-space with controlled privilege, access mechanisms, and built-in
 > locking to provide atomic access to the functionality of the devices
 > without user-space code needing to understand the device intricacies
 > (and probably getting it wrong).
> 
> I recently returned from a conference where somebody had designed a 
 > driver that exposes PCI registers and FPGA device registers to
 > user-space. Their problem was how to provide "call-backs" when an
 > interrupt occurred. They were convinced that all they had to do was
 > to have some user-space procedure that could be called when an
 > interrupt occurred. Then their so-called driver would work. They had
 > no clue about the fact that an interrupt can occur at any time not
 > just when somebody is ready and waiting for it, that one usually has
 > sections of code that must not be interrupted, etc.

This is almost exactly the situation I find myself in and a situation 
for which UIO is perfect.  UIO is not a hole through the kernel in to 
memory, it is a well defined API of the type you describe above (albeit 
not 'established' yet).  UIO interrupts are _handled_ in kernel space 
but subsequently _signalled_ in userspace.  There are no issues of 
kernel code directly calling any userspace functionallity.
 >
 > Driver code needs to be protected from undue user-space interference
 > otherwise the device can't be synchronized, shared, or accessed
 > through the operating system's APIs.

And this is what UIO does, it allows userspace interaction without 
userspace interference.  It provides a safe an sanitized view of the 
hardware to processes which make more sense in userland.
> 
> Every time I showed how the driver couldn't work properly, the 
 > designer so convinced of his superior methods, would devise a
 > work-around. For instance, to protect a section of code from being
 > modified in an interrupt, the user-space driver was to be executed
 > with iopl(3) and interrupts disabled. To protect the kernel from the
 > ISR being modified or replaced, the code would be checksummed every
 > time an interrupt occurred, etc. I could go on. Drivers have no place
 > user space.
> 
No, dumb drivers with dodgy kernel interfaces don't have a place 
_anywhere_.  If this under-educated person was using UIO there would be 
no need for any of his hacks, a userspace driver would be feasible, 
clean, neat and perfectly allowable.

Regards,
	Ben
