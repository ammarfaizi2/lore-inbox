Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751109AbWAUHs0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbWAUHs0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 02:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbWAUHs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 02:48:26 -0500
Received: from liaag2af.mx.compuserve.com ([149.174.40.157]:37842 "EHLO
	liaag2af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751109AbWAUHsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 02:48:25 -0500
Date: Sat, 21 Jan 2006 02:43:25 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: set_bit() is broken on i386?
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, mingo@redhat.com, ak@suse.de,
       linux-kernel@vger.kernel.org, trond.myklebust@fys.uio.no,
       Andreas Schwab <schwab@suse.de>
Message-ID: <200601210245_MC3-1-B656-5DCD@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060120183857.188ef516.akpm@osdl.org>

On Fri, 20 Jan 2006, Andrew Morton wrote:

> We need to somehow tell the compiler "this assembly statement altered
> memory and you can't cache memory contents across it".  That's what
> "memory" (ie: barrier()) does.  I don't think there's a way of telling gcc
> _what_ memory was clobbered - just "all of memory".

I think you can do that by specifying an output operand that you
never use in your assembler code, e.g. changing this:

|       __asm__ __volatile__( "lock ; "
|               "btsl %1,%0"
|               :"=m" (ADDR)
|               :"Ir" (nr));

to this:

| #define LONGBITS (8 * sizeof(unsigned long))
|
|       __asm__ __volatile__( "lock ; "
|               "btsl %2,%1"
|               :"=m"(*(&ADDR + nr/LONGBITS))
|               :"m" (ADDR), "Ir" (nr));

fixes my example program by telling the compiler what memory location
is altered.  (Note that %0 is never used inside the asm code.)
So iff 'nr' is a constant you can clobber specific memory locations.
-- 
Chuck
Currently reading: _Sun Of Suns_ by Karl Schroeder
