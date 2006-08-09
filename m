Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751339AbWHIUEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbWHIUEW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 16:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbWHIUEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 16:04:22 -0400
Received: from mx1.redhat.com ([66.187.233.31]:22155 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751339AbWHIUEV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 16:04:21 -0400
Date: Wed, 9 Aug 2006 16:06:42 -0400
From: Don Zickus <dzickus@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: fastboot@osdl.org, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       linux-kernel@vger.kernel.org, vgoyal@in.ibm.com
Subject: Re: [Fastboot] [CFT] ELF Relocatable x86 and x86_64 bzImages
Message-ID: <20060809200642.GD7861@redhat.com>
References: <m1d5c92yv4.fsf@ebiederm.dsl.xmission.com> <m1u04x4uiv.fsf_-_@ebiederm.dsl.xmission.com> <20060804210826.GE16231@redhat.com> <m164h8p50c.fsf@ebiederm.dsl.xmission.com> <20060804234327.GF16231@redhat.com> <m1hd0rmaje.fsf@ebiederm.dsl.xmission.com> <20060807174439.GJ16231@redhat.com> <m17j1kctb8.fsf@ebiederm.dsl.xmission.com> <20060807235727.GM16231@redhat.com> <m1ejvrakhq.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1ejvrakhq.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Looking at my build it appears bytes_out is being placed in the .bss.
> A little odd since it is zero initialized but no big deal.
> Could you confirm that bytes_out is being placed in the .bss section 
> by inspecting arch/x86_64/boot/compresssed/misc.o and
> arch/x86_64/boot_compressed/vmlinux.   "readelf -a $file" and then
> looking up the section number and looking at the section table to see
> which section it is was my technique.
> 
> If bytes_out is in the .bss for you then I suspect something is not
> correctly zeroing the .bss.  Or else the .bss is being stomped.
> 
> I'm not certain how rep stosb can be done wrong but some bad pointer
> math could have done it.
> 
> Eric

It seems Vivek came up with a solution that works.  He sent it to me this
morning.  We tested a bunch of machines and things seem to work now.  It
looks like it mimics the i386 behaviour now.

Cheers,
Don

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 arch/x86_64/boot/compressed/head.S |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -puN arch/x86_64/boot/compressed/head.S~x86_64-bss-clearing-test
arch/x86_64/boot/compressed/head.S
---
linux-2.6.18-rc3-1M/arch/x86_64/boot/compressed/head.S~x86_64-bss-clearing-test
2006-08-09 09:43:17.000000000 -0400
+++ linux-2.6.18-rc3-1M-root/arch/x86_64/boot/compressed/head.S 2006-08-09
09:43:34.000000000 -0400
@@ -235,8 +235,8 @@ relocated:
 /*
  * Clear BSS
  */
-       movq    $_edata, %rdi
-       movq    $_end, %rcx
+        leaq    _edata(%rbx), %rdi
+        leaq    _end(%rbx), %rcx
        subq    %rdi, %rcx
        cld
        rep
_

