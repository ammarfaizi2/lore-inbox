Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262596AbVCPONz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262596AbVCPONz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 09:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262597AbVCPONz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 09:13:55 -0500
Received: from alog0570.analogic.com ([208.224.223.107]:47320 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262596AbVCPONw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 09:13:52 -0500
Date: Wed, 16 Mar 2005 09:11:46 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Ian Campbell <ijc@hellion.org.uk>
cc: Tom Felker <tfelker2@uiuc.edu>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Bogus buffer length check in linux-2.6.11  read()
In-Reply-To: <1110979800.3057.69.camel@icampbell-debian>
Message-ID: <Pine.LNX.4.61.0503160848420.16718@chaos.analogic.com>
References: <Pine.LNX.4.61.0503151257450.12264@chaos.analogic.com> 
 <200503152056.16287.tfelker2@uiuc.edu>  <Pine.LNX.4.61.0503160724120.16304@chaos.analogic.com>
 <1110979800.3057.69.camel@icampbell-debian>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Mar 2005, Ian Campbell wrote:

>
> On Wed, 2005-03-16 at 07:29 -0500, linux-os wrote:
>
>> This means that the read() is no longer perfectly happy
>> to corrupt all of the user's memory which is the defacto
>> correct response for a bad buffer as shown. Instead, some
>> added "check in software" claims to prevent this, but
>> is wrong anyway because it can't possibly know how much
>> data area is available.
>
> The manpage for read(2) that I've got says
>
>       EFAULT buf is outside your accessible address space.
>
> which is exactly what it would appear
>        if (unlikely(!access_ok(VERIFY_WRITE, buf, count)))
>                return -EFAULT;
> checks for. Assuming this is the check you are bitching about -- you
> could be a little more precise if you are going to complain about stuff.
>
> Ian.


I don't know how much more precise I could have been. I show the
code that will cause the observed condition. I explain that this
condition is new, that it doesn't correspond to the previous
behavior.

Never before was some buffer checked for length before some data
was written to it. The EFAULT is supposed to occur IFF a write
attempt occurs outside the caller's accessible address space.
This used to be done by hardware during the write to user-space.
This had zero impact upon performance. Now there is some
software added that adds CPU cycles, subtracts performance,
and cannot possibly do anything useful.

Also, the code was written to show the problem. The code
is not designed to be an example of good coding practice.

The actual problem observed with the new kernel was
when some legacy code used gets() instead of fgets().
The call returned immediately with an EFAULT because
the 'C' runtime library put some value that the kernel
didn't 'like' (4096 bytes) in the subsequent read.

This is code for which there are no sources available
and it is required to be used, cannot be replaced,
cannot be thrown away and costs about US$ 10,000
from a company that is no longer in business.

Somebody's arbitrary and capricious addition of spook
code destroyed an application's functionality.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
