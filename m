Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261690AbVDBEvn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261690AbVDBEvn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 23:51:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261691AbVDBEvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 23:51:43 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:57654 "EHLO
	pd2mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S261690AbVDBEvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 23:51:05 -0500
Date: Fri, 01 Apr 2005 22:50:45 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: AMD64 Machine hardlocks when using memset
In-reply-to: <20050401201105.4a03bda1.pj@engr.sgi.com>
To: Paul Jackson <pj@engr.sgi.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <424E24A5.4040102@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <3NZDp-4yY-7@gated-at.bofh.it> <3OmgF-6HV-17@gated-at.bofh.it>
 <3OmgF-6HV-15@gated-at.bofh.it> <3Oy8m-74-15@gated-at.bofh.it>
 <424E0424.7080308@shaw.ca> <20050401201105.4a03bda1.pj@engr.sgi.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> The x86_64 memset(), both in user space and the kernel, for whatever gcc
> I have, and for a current kernel, uses the "repz stos" or "rep stosq"
> prefixed instruction for the bulk of the copy.  This combination is a
> long running, interruptible Intel string instruction that loops on
> itself until the CX register decrements to zero.
> 
> Was your windows app using "stos"?
> 
> I'll wager a nickel that the actual crash you see comes when the
> processor has to handle an interrupt while in the middle of this
> instruction.
> 
> I'll wager a dime it's hardware, though interrupt activity may be
> required to provoke it.

I ended up making a test program which essentially did the same thing 
except not using memset (just moving an int* up repeatedly and setting 
the value there to 0). That worked fine on both Windows and Linux. I 
then tried such a program using a long* compiled as 64-bit on Linux, 
that also worked fine. It seems like I can only reproduce it when memset 
is actually used..

I don't remember exactly what the Windows memset was using, that was on 
my work machine - it was inline assembly though, and I do know that it 
had only one instruction for the whole set, so it was likely "repz stos" 
or something similar to that.

As it turns out, the memset in my version of glibc x86_64 is not using 
such a string instruction though - it seems to be using two different 
sets of instructions depending on the size of the memset (not sure 
exactly how they're calculating the threshold between these..) For sizes 
below the treshold, this is the inner loop - it's using normal mov 
instructions:

3:	/* Copy 64 bytes.  */
	mov	%r8,(%rcx)
	mov	%r8,0x8(%rcx)
	mov	%r8,0x10(%rcx)
	mov	%r8,0x18(%rcx)
	mov	%r8,0x20(%rcx)
	mov	%r8,0x28(%rcx)
	mov	%r8,0x30(%rcx)
	mov	%r8,0x38(%rcx)
	add	$0x40,%rcx
	dec	%rax
	jne	3b

For sizes above the threshold though, this is the inner loop. It's using 
movnti which is an SSE cache-bypasssing store:

11:	/* Copy 64 bytes without polluting the cache.  */
	/* We could use	movntdq    %xmm0,(%rcx) here to further
	   speed up for large cases but let's not use XMM registers.  */
	movnti	%r8,(%rcx)
	movnti  %r8,0x8(%rcx)
	movnti  %r8,0x10(%rcx)
	movnti  %r8,0x18(%rcx)
	movnti  %r8,0x20(%rcx)
	movnti  %r8,0x28(%rcx)
	movnti  %r8,0x30(%rcx)
	movnti  %r8,0x38(%rcx)
	add	$0x40,%rcx
	dec	%rax
	jne	11b

I'm wondering if one does a ton of these cache-bypassing stores whether 
something gets hosed because of that. Not sure what that could be 
though. I don't imagine the chipset is involved with any of that on the 
Athlon 64 - either the CPU or RAM seems the most likely suspect to me

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

