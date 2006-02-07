Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932300AbWBGInE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbWBGInE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 03:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbWBGInE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 03:43:04 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:39610
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932300AbWBGInD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 03:43:03 -0500
Date: Tue, 07 Feb 2006 00:43:01 -0800 (PST)
Message-Id: <20060207.004301.35467668.davem@davemloft.net>
To: sfr@canb.auug.org.au
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, torvalds@osdl.org, ak@suse.de
Subject: Re: [PATCH] compat: add compat functions for *at syscalls
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060207112713.7cd0a61c.sfr@canb.auug.org.au>
References: <20060207105631.39a1080c.sfr@canb.auug.org.au>
	<20060206.160140.59716704.davem@davemloft.net>
	<20060207112713.7cd0a61c.sfr@canb.auug.org.au>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 7 Feb 2006 11:27:13 +1100

> *If* we do get is_compat_task(), what would be you reaction to something
> like this:
...
> +	if (is_compat_task())
> +		dfd = compat_sign_extend(dfd);

A load and a test is more expensive than the assembler
stubs where we _know_ we are compat.

The alternative suggestions get less and less efficient :-) My whole
desire is to optimize this as much as possible, without the overhead
of an extra stack frame or "is_compat_task()" kinds of runtime tests.

Really, the way to do this is to have a description header file, that
does stuff like:

SIGN1(STUB_NAME, REAL_SYSCALL, ARG1_TO_EXTEND)
SIGN2(STUB_NAME, REAL_SYSCALL, ARG1_TO_EXTEND, ARG2_TO_EXTEND)

etc. etc. for each syscall that only needs sign extension compat
handling, and the platform provides definitions of these macros which
expand the above as appropriate.  Use arch/sparc64/kernel/sys32.S as a
guide.

So for sys_exit_group you'd list something like:

SIGN1(sys32_exit_group, sys_exit_group, ARG0)

"ARG0" would get defined to whatever register mnemonic the
first argument to a function gets passed into, ARG1 to the
second, etc.  So on Sparc64 that would be:

#define ARG0	%o0
#define ARG1	%o1
#define ARG2	%o2
#define ARG3	%o3
#define ARG4	%o4
#define ARG5	%o5

and you'd use "sys32_exit_group" in the compat syscall table.  The
SIGN1 definition on sparc64 would be exactly what it is right now
in that sys32.S file.

Such a header can be use to generate stubs on every platform.
