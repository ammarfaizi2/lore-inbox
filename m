Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261419AbVFHXM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261419AbVFHXM1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 19:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261420AbVFHXM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 19:12:27 -0400
Received: from ozlabs.org ([203.10.76.45]:6034 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261419AbVFHXMV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 19:12:21 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17063.31568.618739.165823@cargo.ozlabs.ibm.com>
Date: Thu, 9 Jun 2005 09:12:16 +1000
From: Paul Mackerras <paulus@samba.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: akpm@osdl.org, anton@samba.org, linux-kernel@vger.kernel.org,
       jk@blackdown.de
Subject: Re: [PATCH] ppc64: Fix PER_LINUX32 behaviour
In-Reply-To: <Pine.LNX.4.58.0506081022030.2286@ppc970.osdl.org>
References: <17062.56723.535978.961340@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.58.0506081022030.2286@ppc970.osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:

> I think this is a feature, not a bug, and I suspect you just broke
> compiling a 64-bit kernel by default on ppc64.

No... I have been running with this patch for a while, and I do
actually compile up ppc64 kernels from time to time... :)

> Dammit, the system _is_ ppc64. The fact that the uname binary is not is
> neither here nor there. It's like x86 that reports i386/i486/.. depending 
> on what the machine is. If uname wants to make it clear that uname has 
> been compiled for 32-bit ppc, then it can damn well output "ppc" on its 
> own without asking the kernel what the kernel is.

Interestingly, PER_LINUX32 has nothing whatsoever to do with whether a
process is running in 32-bit or 64-bit mode.  In fact, the *only*
thing that PER_LINUX32 affects is the machine name reported by uname.
So you can have a 32-bit process without PER_LINUX32, and a 64-bit
process with PER_LINUX32.

For 32-bit processes on ppc64 we have 3 uname system calls - olduname,
uname and newuname.  For 64-bit we have just newuname.  The newuname
system call had code to return "ppc" for the machine name if the
personality was PER_LINUX32, but that code wasn't working, because it
was looking at the whole current->personality value and getting
confused if there were high bits set.  The 32-bit uname and olduname
system calls were ignoring the personality and just returning what was
in system_utsname.machine, i.e. "ppc64".  The patch makes all three
check if personality(current->personality) == PER_LINUX32 and return
"ppc" if so.

There is still a point of difference between ppc64 and x86_64: on
ppc64 (and on sparc64), if the personality is PER_LINUX32, the
personality(0xffffffffUL) system call returns PER_LINUX, and attempts
to set the personality to PER_LINUX don't change the personality
(i.e. it stays set to PER_LINUX32), for both 32-bit and 64-bit
processes.  On x86_64 this is true for 32-bit processes but not for
64-bit processes AFAICT.  Does anyone know why we do this at all, and
whether doing it for 64-bit processes makes sense?

Paul.
