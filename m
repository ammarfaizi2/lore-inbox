Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262024AbULCGPa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262024AbULCGPa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 01:15:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262025AbULCGPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 01:15:30 -0500
Received: from news.suse.de ([195.135.220.2]:12677 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262024AbULCGPY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 01:15:24 -0500
Date: Fri, 3 Dec 2004 07:15:20 +0100
From: Andi Kleen <ak@suse.de>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 32-bit syscalls from 64-bit process on x86-64?
Message-ID: <20041203061520.GG31767@wotan.suse.de>
References: <1102004520.8707.10.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102004520.8707.10.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2004 at 08:22:00AM -0800, Jeremy Fitzhardinge wrote:
> Hi Andi,
> 
> Is it possible for a 64-bit process to invoke the 32-bit syscall
> compatibility layer?  I'm thinking this might be useful for Valgrind,
> since if it is running on an x86-64 host, it can take advantage of
> having more registers and a larger address space to do a better
> emulation of plain ia32.  But this is only practical if I can reuse the
> kernel's 32-bit emulation layer, since duplicating it in Valgrind would
> be silly (particularly ioctls).

It has been done actually (in the intel ia32el JIT)
> 
> >From a quick look at the code, it seems to me that int 0x80 might still
> work in 64-bit mode, but connect to 32-bit syscalls.  Is that right?  If
> not, could it be made to be right?  Alternatively, something like adding
> a constant offset to the syscall numbers would work for me (ie, 0-N are
> 64-bit syscalls, 0x10000-N are 32-bit).  Hm, no, it looks like int 0x80
> just calls normal 64-bit syscalls....

int 0x80 from 64bit will call 32bit syscalls. But some things
will not work properly, e.g. signals because they test the 32bit
flag in the task_struct. So you would still get 64bit signal frames.
There are some other such tests, but they probably wont affect you.

There were some plans at one point to allow to toggle the flag 
using personality or prctl, but so far it hasn't been implemented.
There is also no way to do 64bit calls from a 32bit executable.
> 
> And does the 32-bit layer keep any private state?  For example, if I
> modify the signal state with 32-syscalls in one place, and 64-bit
> syscalls elsewhere, will that cause a problem or inconsistencies?

64bit processes always get 64bit signals.

-Andi
