Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262602AbVCPOmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262602AbVCPOmN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 09:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262601AbVCPOkd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 09:40:33 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:5434 "EHLO
	pd2mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S262606AbVCPOjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 09:39:05 -0500
Date: Wed, 16 Mar 2005 08:37:48 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Bogus buffer length check in linux-2.6.11  read()
In-reply-to: <3IHxD-4Gb-5@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <423844BC.3010707@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <3IoOm-5M2-49@gated-at.bofh.it> <3IwVv-4kD-17@gated-at.bofh.it>
 <3IFYO-3eg-37@gated-at.bofh.it> <3IGUS-46t-27@gated-at.bofh.it>
 <3IHxD-4Gb-5@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os wrote:
> I don't know how much more precise I could have been. I show the
> code that will cause the observed condition. I explain that this
> condition is new, that it doesn't correspond to the previous
> behavior.
> 
> Never before was some buffer checked for length before some data
> was written to it. The EFAULT is supposed to occur IFF a write
> attempt occurs outside the caller's accessible address space.
> This used to be done by hardware during the write to user-space.
> This had zero impact upon performance. Now there is some
> software added that adds CPU cycles, subtracts performance,
> and cannot possibly do anything useful.
> 
> Also, the code was written to show the problem. The code
> is not designed to be an example of good coding practice.
> 
> The actual problem observed with the new kernel was
> when some legacy code used gets() instead of fgets().
> The call returned immediately with an EFAULT because
> the 'C' runtime library put some value that the kernel
> didn't 'like' (4096 bytes) in the subsequent read.
> 
> This is code for which there are no sources available
> and it is required to be used, cannot be replaced,
> cannot be thrown away and costs about US$ 10,000
> from a company that is no longer in business.
> 
> Somebody's arbitrary and capricious addition of spook
> code destroyed an application's functionality.

It appears this was added by the patch shown here:

http://lwn.net/Articles/122581/

The reason given was that if the read or write doesn't use all of the 
available space due to end-of-file, etc. the remaining part of the 
buffer given by the user is not checked for accessibility, thereby 
hiding bugs. It makes little sense for an app to do a read or write with 
a buffer larger than the space that they've actually allocated.

I can see how this might be a problem when using gets, since there is no 
way to know how big the buffer that has been allocated by the 
application is.

Note that access_ok only does a rudimentary check to determine if the 
address might be a valid user-space address, it does not check every 
page to determine if it is accessible or not like verify_area did (and 
copy_to/from_user does).

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

