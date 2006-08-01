Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161033AbWHAUZs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161033AbWHAUZs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 16:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161039AbWHAUZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 16:25:48 -0400
Received: from relay02.pair.com ([209.68.5.16]:38411 "HELO relay02.pair.com")
	by vger.kernel.org with SMTP id S1161033AbWHAUZq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 16:25:46 -0400
X-pair-Authenticated: 71.197.50.189
Date: Tue, 1 Aug 2006 15:25:38 -0500 (CDT)
From: Chase Venters <chase.venters@clientec.com>
X-X-Sender: root@turbotaz.ourhouse
To: torvalds@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: Re: lib/errno.c
In-Reply-To: <Pine.LNX.4.64.0608011316340.12077@turbotaz.ourhouse>
Message-ID: <Pine.LNX.4.64.0608011516140.12077@turbotaz.ourhouse>
References: <Pine.LNX.4.64.0608011316340.12077@turbotaz.ourhouse>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Aug 2006, Chase Venters wrote:

> I'm curious if there's a reason we're still carrying "lib/errno.c". The 
> string "errno" is used pretty heavily but from a grep glance it seems any 
> users define it locally (and indeed, the concurrency issues with a global 
> 'errno' symbol mean it would be worthless except during boot, or maybe under 
> BKL).

OK, I think I figured out why it's still there -- an old bit of legacy 
that is now a hack to deal with _syscall macros? I'm guessing here, so it 
would be nice if someone told me if I'm on the right track:

  1. linux/unistd.h defines the extern for errno (perhaps for old export to 
user-space?)
  2. lib/errno.c defines the variable itself
  3. __syscall_return sets errno, probably for the benefit of old 
user-space

I'm wondering if we should drop lib/errno.c, #ifndef __KERNEL__ around the 
extern in unistd.h, and then fix up __syscall_return in 
include/asm-*/unistd.h to have two versions -- one when in __KERNEL__ that 
doesn't muck with errno, and one when not that does?

Alternatively / additionally, investigate changing execve() callers to use 
sys_execve() or do_execve(), rather than pounding back in through an 
interrupt?

Having a global 'errno' in the kernel just seems wrong -- if someone were 
to include unistd.h and then decide to use an 'int errno' in some 
function, then proceeds to forget to declare it on the stack, the code 
would build and leave a nice race condition hiding out.

Would a patch along these lines be acceptable, or is there something I am 
missing?

Thanks,
Chase
