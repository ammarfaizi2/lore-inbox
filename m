Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263028AbUE2TXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263028AbUE2TXj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 15:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263775AbUE2TXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 15:23:39 -0400
Received: from mx1.redhat.com ([66.187.233.31]:47264 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263028AbUE2TXh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 15:23:37 -0400
Date: Sat, 29 May 2004 12:23:19 -0700
From: "David S. Miller" <davem@redhat.com>
To: arnd@arndb.de
Cc: linux-kernel@vger.kernel.org
Subject: compat syscall args
Message-Id: <20040529122319.49eaafe1.davem@redhat.com>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Arnd asked:

> If sparc64 has this problem only for the fifth syscall argument, 
> does that mean that e.g. compat_sys_futex and 
> compat_sys_mq_timed{send,receive} have the same bug? If this is
> a more general, i.e. not limited to the last argument, there is a
> potential problem in lots of syscalls.

Here is the issue.  In the sparc64 C calling conventions, it is
assumed that 32-bit signed values are sign extended by the
caller.

This means that, at syscall invocation time, we have to choose
between either:

1) sign extending all syscall args for the C code, then explicitly
   zero-extending all non-signed syscall args.  This would require
   the most amount of compat layer code help.

2) zero extending all syscall args for the C code, then expliticly
   sign-extending all signed syscall args.

3) some mixture of 1 and 2

#3 is what sparc64 does, it hits the highest number of system
call arguments correctly.  Specifically we:

arg0: zero-extend
arg1: zero-extend
arg2: zero-extend
arg3: zero-extend
arg4: leave as-is
arg5: leave as-is

I remember discussing this with Andi Kleen before.

Each platform is going to behave differently in this area, so
I suppose the right thing to do really is to have the arch
specific code use little zero/sign extender stubs when necessary
so that the compat layer can assume that the args are properly
sign/zero extended already.  I guess this is how I'll fix this
up on sparc64 for now.

Comments?
