Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbTDQSzz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 14:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261883AbTDQSzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 14:55:55 -0400
Received: from havoc.daloft.com ([64.213.145.173]:34196 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261863AbTDQSzy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 14:55:54 -0400
Date: Thu, 17 Apr 2003 15:07:49 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Arjan van de Ven <arjanv@redhat.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [BK+PATCH] remove __constant_memcpy
Message-ID: <20030417190749.GF25696@gtf.org>
References: <1050569207.1412.1.camel@laptop.fenrus.com> <Pine.LNX.4.44.0304170903001.1530-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0304170903001.1530-100000@home.transmeta.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 17, 2003 at 09:07:45AM -0700, Linus Torvalds wrote:
> 
> On 17 Apr 2003, Arjan van de Ven wrote:
> > 
> > it can do that ANYWAY for all kinds of things.
> > We really should ask the gcc folks to add a
> > -fdontyoudareusefloatingpoint flag (well different name probably)
> 
> Well, _most_ architectures actually have that flag already. It's not 
> called -fdontyoudareusefloatingpoint on any of them, though ;)
> 
> It's most commonly called "-mno-fpu", but sh calls it "-mno-implicit-fp",
> and alpha calls it "-mno-fp-regs".
> 
> On x86, gcc doesn't have such an option, although "-mno-sse" and
> "-mno-sse2" probably come closest (and we should probably use them, but
> since older gcc's don't know about it and it hasn't been an issue yet we
> haven't).

gcc on x86 definitely wants a -fdontyoudareusefloatingpoint... The
following snippet from the -msoft-float docs isn't encouraging:

     On machines where a function returns floating point results in the
     80387 register stack, some floating point opcodes may be emitted
     even if `-msoft-float' is used.
[yes, I realize it's an ABI constraint in this case, but IMO it's also
indicative in general of the difficulty in getting gcc to _never_
generate fp opcodes on x86, now or in the future]

Anyway, if you wanna play it safe WRT gcc future, the following
patch works.

-mno-3dnow is probably over-paranoia, because (IIRC) it doesn't contain
any integer instructions, but maybe I'm wrong.  It can't hurt... :)


===== arch/i386/Makefile 1.49 vs edited =====
--- 1.49/arch/i386/Makefile	Thu Apr  3 14:24:40 2003
+++ edited/arch/i386/Makefile	Thu Apr 17 14:55:34 2003
@@ -27,6 +27,9 @@
 # prevent gcc from keeping the stack 16 byte aligned
 CFLAGS += $(call check_gcc,-mpreferred-stack-boundary=2,)
 
+# force gcc to always use general registers (only)
+CFLAGS += $(call check_gcc,-mno-mmx -mno-sse -mno-sse2 -mno-3dnow,)
+
 align := $(subst -functions=0,,$(call check_gcc,-falign-functions=0,-malign-functions=0))
 
 cflags-$(CONFIG_M386)		+= -march=i386
