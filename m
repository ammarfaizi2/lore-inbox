Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267139AbSKSUY2>; Tue, 19 Nov 2002 15:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267149AbSKSUY2>; Tue, 19 Nov 2002 15:24:28 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:7178 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267139AbSKSUY1>; Tue, 19 Nov 2002 15:24:27 -0500
Date: Tue, 19 Nov 2002 20:31:29 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: ARM kernel module loader.
Message-ID: <20021119203128.E5535@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Rusty Russell <rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, here's the problem I'm currently facing.

KAO's insmod used to do various fixups (trampolines of 8 bytes in length)
before inserting modules into the kernel on ARM to make sure the PC24
branch relocations were able to reach the kernel binary image in memory.
PC24 relocations have a maximum range of +/- 32MB, and the kernel may be
(on current architectures) up to 256MB to 512MB away.

With Rusty's in-kernel module linker, there's a catch-22 situation here.
The module linker has callouts to architecture code to ask for the size
of various sections before allocating an area.

This is perfect in this situation, since all you need to do is calculate
how many trampolines you'd need to reach the main kernel binary, and add
that onto the core module size.

However, to know how many trampolines you'd need, you need to scan the
relocations and symbols, counting the number of symbols that need
trampolines.  The problem here is that we haven't read any of the module
into kernel space, so this information isn't available.

What is available though is the total number of relocations in the file,
which could be massively larger than the number of trampolines required.

(For the time being, ARM has the code implemented that performs the
basic linking, but obviously without the trampolines.  Since this
effectively means modules will never work, I've also made module_alloc
always return NULL to force failure until we have a solution.)

Comments?  Ideas?  Solutions that don't require:

- rewriting the core module loading code
- introducing a vrealloc() function
- wasting lots of memory on trampoline entries that won't be used

Ideally, I'd like to be able to allocate a trampoline table for one
module and re-use trampoline entries for many modules to minimise the
cache impacts.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

