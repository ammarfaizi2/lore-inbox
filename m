Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262482AbVCPC4Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262482AbVCPC4Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 21:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262484AbVCPC4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 21:56:25 -0500
Received: from ns1.flexabit.net ([64.198.230.130]:31936 "EHLO ns1.flexabit.net")
	by vger.kernel.org with ESMTP id S262482AbVCPC4P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 21:56:15 -0500
From: Tom Felker <tfelker2@uiuc.edu>
To: linux-os@analogic.com
Subject: Re: Bogus buffer length check in linux-2.6.11  read()
Date: Tue, 15 Mar 2005 20:56:16 -0600
User-Agent: KMail/1.7.2
Cc: Linux kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.61.0503151257450.12264@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0503151257450.12264@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503152056.16287.tfelker2@uiuc.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 March 2005 11:59 am, linux-os wrote:
> The attached file shows that the kernel thinks it's doing
> something helpful by checking the length of the input
> buffer for a read(). It will return "Bad Address" until
> the length is 1632 bytes.  Apparently the kernel thinks
> 1632 is a good length!
>
> Did anybody consider the overhead necessary to do this
> and the fact that the kernel has no way of knowing if
> the pointer to the buffer is valid until it actually
> does the write. What was wrong with copy_to_user()?
> Why is there the additional bogus check?

I don't think that's what's happening.  The kernel is perfectly happy to read 
data into any virtual address range that your process can legally write to - 
this includes any part of the heap and any part of the stack.  The kernel 
can't check whether writing to the given address would clobber the stack or 
heap - it's your memory, you manage it.  The kernel's notion of an "invalid 
address" is very simple, and doesn't include every address that you would 
consider invalid from a C perspective.

So what's probably happening is that your stack is (1632+256) bytes tall, 
including the buffer you allocated.  (Stack grows downward on i386.)  So 
ideally you read less than 256 bytes.  If you read more than 256 but less 
than 1888 bytes, the read would damage other elements on the stack, but it is 
OK as far as the kernel is concerned.  But if you read more than that, you're 
asking the kernel to write to an address that is higher than the highest 
address of the stack (the address of the bottom element), and this address 
isn't mapped into your process, so you get EINVAL.

If you were to type more than 256 (but less than 1888) characters before 
pressing enter, the read would silently overflow the buffer, thus clobbering 
the stack, including the return address of main().  So when main tried to 
return, you'd get a segfault.  Somebody with assembly skills could probably 
craft a string which, when your program reads it, would take control of the 
program.

-- 
Tom Felker, <tcfelker@mtco.com>
<http://vlevel.sourceforge.net> - Stop fiddling with the volume knob.

No army can withstand the strength of an idea whose time has come.
