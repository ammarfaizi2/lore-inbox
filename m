Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262357AbVBXOdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262357AbVBXOdZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 09:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262358AbVBXOdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 09:33:25 -0500
Received: from rproxy.gmail.com ([64.233.170.192]:5722 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262357AbVBXOdS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 09:33:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=AekEj5TBgw5MXNAgWUKQ4epuVvtq/VmB4UHuyo5iXY46jIb5g/jF/XHuhVC2u3jVFqBGG0Cb2CKhk+XjEIHu+ZBOwHYfWaEWTcIyhD/ijvGhFA6LPS7shRx/6PE8gm5ULtfVFUOqcHB0RyU9oS4v8Tx0gq/KZQOkUgEFFdEWlTI=
Message-ID: <61d439b050224063362ab1465@mail.gmail.com>
Date: Thu, 24 Feb 2005 15:33:17 +0100
From: Jordi Brinquez <jordi.brinquez@gmail.com>
Reply-To: Jordi Brinquez <jordi.brinquez@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Possible bug on signal.h
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I think I found a possible bug on file signal.h.

The problem comes when you define a struct sigaction on a user program
and then you use the function sigaction to remap a signal handler (in
my case a page_fault) for my own function, this system call is
compiled as __NR_sigaction system call (by default this routine is
managed by sys_sigaction routine) and if the architecture defines
__ARCH_WANT_SYS_RT_SIGACTION kernel uses the routine sys_rt_sigaction
on the file kernel/signal.c that instead of copying the fields from
one structure to the other it just uses copy_from_user and
copy_to_user with the consequent mess with the fields.

One possible solution will be to change the field order in all struct
sigaction under arch/ folder and reorder the fields exactly the same
as in the kernel definition (on kernel mode are defined in this order
sa_handler, sa_flags, sa_restorer, sa_mask and on user mode
_sa_handler | _sa_sigaction, sa_mask, sa_flags, sa_restorer).

Another solution will be change the copy_to_user and copy_from_user
for calls like in arch/i386/kernel/signal.c (__get_user(...) and
__put_user(...)).

Or what I think it will be better change both.

I've been searching and I think that the affected architectures are
those ones, but I may forgot some:

- arm
- arm26
- cris
- i386
- m32r
- m68k
- m68knommu
- s390
- sh
- sh64
- sparc64
- um
- v850

Hope I explained the problem quite clear if not please ask for more
info and I'll give you all that you need.

Greets,

Jordi
