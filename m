Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262559AbVCPMc1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262559AbVCPMc1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 07:32:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262563AbVCPMc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 07:32:27 -0500
Received: from alog0049.analogic.com ([208.224.220.64]:9601 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262559AbVCPMb4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 07:31:56 -0500
Date: Wed, 16 Mar 2005 07:29:42 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Tom Felker <tfelker2@uiuc.edu>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Bogus buffer length check in linux-2.6.11  read()
In-Reply-To: <200503152056.16287.tfelker2@uiuc.edu>
Message-ID: <Pine.LNX.4.61.0503160724120.16304@chaos.analogic.com>
References: <Pine.LNX.4.61.0503151257450.12264@chaos.analogic.com>
 <200503152056.16287.tfelker2@uiuc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Mar 2005, Tom Felker wrote:

> On Tuesday 15 March 2005 11:59 am, linux-os wrote:
>> The attached file shows that the kernel thinks it's doing
>> something helpful by checking the length of the input
>> buffer for a read(). It will return "Bad Address" until
>> the length is 1632 bytes.  Apparently the kernel thinks
>> 1632 is a good length!
>>
>> Did anybody consider the overhead necessary to do this
>> and the fact that the kernel has no way of knowing if
>> the pointer to the buffer is valid until it actually
>> does the write. What was wrong with copy_to_user()?
>> Why is there the additional bogus check?
>

Again. Assume NOTHING. Execute the code. There is NO data
being obtained from standard input. The blocking read from
standard input returns immediately without anybody hitting
any keys whatsover. No data are generated or read.

This is because somebody wrongly added code that they
wrongly thought would prevent writing beyond a user's
allocated space.

This means that the read() is no longer perfectly happy
to corrupt all of the user's memory which is the defacto
correct response for a bad buffer as shown. Instead, some
added "check in software" claims to prevent this, but
is wrong anyway because it can't possibly know how much
data area is available.

> I don't think that's what's happening.  The kernel is perfectly happy to read
> data into any virtual address range that your process can legally write to -
> this includes any part of the heap and any part of the stack.  The kernel
> can't check whether writing to the given address would clobber the stack or
> heap - it's your memory, you manage it.  The kernel's notion of an "invalid
> address" is very simple, and doesn't include every address that you would
> consider invalid from a C perspective.
>
> So what's probably happening is that your stack is (1632+256) bytes tall,
> including the buffer you allocated.  (Stack grows downward on i386.)  So
> ideally you read less than 256 bytes.  If you read more than 256 but less
> than 1888 bytes, the read would damage other elements on the stack, but it is
> OK as far as the kernel is concerned.  But if you read more than that, you're
> asking the kernel to write to an address that is higher than the highest
> address of the stack (the address of the bottom element), and this address
> isn't mapped into your process, so you get EINVAL.
>
> If you were to type more than 256 (but less than 1888) characters before
> pressing enter, the read would silently overflow the buffer, thus clobbering
> the stack, including the return address of main().  So when main tried to
> return, you'd get a segfault.  Somebody with assembly skills could probably
> craft a string which, when your program reads it, would take control of the
> program.
>
> -- 
> Tom Felker, <tcfelker@mtco.com>
> <http://vlevel.sourceforge.net> - Stop fiddling with the volume knob.
>
> No army can withstand the strength of an idea whose time has come.
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
