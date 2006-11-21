Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031350AbWKUTmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031350AbWKUTmO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 14:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031351AbWKUTmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 14:42:14 -0500
Received: from mis011-1.exch011.intermedia.net ([64.78.21.128]:30063 "EHLO
	mis011-1.exch011.intermedia.net") by vger.kernel.org with ESMTP
	id S1031345AbWKUTmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 14:42:09 -0500
Message-ID: <45635681.2040504@qumranet.com>
Date: Tue, 21 Nov 2006 21:41:53 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: Jeremy Fitzhardinge <jeremy@goop.org>, Arnd Bergmann <arnd@arndb.de>,
       kvm-devel@lists.sourceforge.net, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [kvm-devel] [PATCH] KVM: Avoid using vmx instruction directly
References: <20061109110852.A6B712500F7@cleopatra.q> <200611091429.42040.arnd@arndb.de> <45532EE3.4000104@qumranet.com> <200611091542.31101.arnd@arndb.de> <455340B8.2080206@qumranet.com> <4553BC18.6090207@goop.org> <45634704.8020407@zytor.com>
In-Reply-To: <45634704.8020407@zytor.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Nov 2006 19:42:08.0266 (UTC) FILETIME=[214ABEA0:01C70DA5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Jeremy Fitzhardinge wrote:
>> Avi Kivity wrote:
>>>> Or gcc
>>>> might move the assignment of phys_addr to after the inline assembly.
>>>>   
>>> "asm volatile" prevents that (and I'm not 100% sure it's necessary).
>>
>> No, it won't necessarily.  "asm volatile" simply forces gcc to emit the
>> assembler, even if it thinks its output doesn't get used.  It makes no
>> ordering guarantees with respect to other code (or even other "asm
>> volatiles").   The "memory" clobbers should fix the ordering of the asms
>> though.
>>
>
> I think you're wrong about that; in particular, I'm pretty sure "asm 
> volatiles" are ordered among themselves.  What the "volatile" means is 
> "this has side effects you (the compiler) don't understand", and gcc 
> can't assume that it can reorder such side effects.

The gcc manual has this to say:

   Similarly, you can't expect a sequence of volatile `asm' instructions
  to remain perfectly consecutive.  If you want consecutive output, use a
  single `asm'.  Also, GCC will perform some optimizations across a
  volatile `asm' instruction; GCC does not "forget everything" when it
  encounters a volatile `asm' instruction the way some other compilers do.

I wonder how we are supposed to code the following sequence:


    asm volatile ("blah")  /* sets funky processor mode */

    some_c_code();

    asm volatile ("unblah");

Let's say "blah" disables floating point exceptions, and some_c_code() 
must run without exceptions.  Is is possible to code this in gcc without 
putting functions in another translation unit?  Is a memory clobber 
sufficient?  I'd certainly hate to use it.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

