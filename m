Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261243AbULWOKm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbULWOKm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 09:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbULWOKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 09:10:42 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:29659 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261243AbULWOKg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 09:10:36 -0500
Subject: Re: [PATCH] Secondary cpus boot-up for non defalut location built
	kernels
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: lkml <linux-kernel@vger.kernel.org>, fastboot <fastboot@lists.osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       dipankar sarma <dipankar@in.ibm.com>
In-Reply-To: <m1k6r9ur3h.fsf@ebiederm.dsl.xmission.com>
References: <1103802944.8123.114.camel@2fwv946.in.ibm.com>
	 <m1k6r9ur3h.fsf@ebiederm.dsl.xmission.com>
Content-Type: multipart/mixed; boundary="=-c/B5/e5uunYxO1i4co6c"
Organization: 
Message-Id: <1103813102.8123.141.camel@2fwv946.in.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Dec 2004 20:15:02 +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-c/B5/e5uunYxO1i4co6c
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


> > This patch fixes the problem of secondary cpus boot up. This situation
> > is faced when kernel is built for non default locations like 16MB and
> > onwards. In this configuration, only primary cpu (BP) comes and
> > secondary cpus don't boot.
> > 
> > Problem occurs because in trampoline code, lgdt is not able to load the
> > GDT as it happens to be situated beyond 16MB. This is due to the fact
> > that cpu is still in real mode and default operand size is 16bit.
> 
> Which means that the cpu will load a 24bit linear address (3 bytes)
> because it is acting like a 286.
>  
> > This patch uses lgdtl instead of lgdt to force operand size to 32
> > instead of 16.
> 
> Sounds sane looking at the trampoline I suspect that people thought
> it was using a 32bit address all along.  And the code only worked
> because the data was stored little endian.  

> We probably want to apply
> the same fix to the ldt instruction just about it.  Just in case
> we ever decide to populate an idt at that point.


Sounds good. Sending the patch again with suggested change included.

> 
> But the fix certainly looks good from here.
> 
> Eric
> 

-- 
Vivek Goyal
Linux Technology Center
India Software Labs
IBM India, Bangalore

--=-c/B5/e5uunYxO1i4co6c
Content-Disposition: attachment; filename=boot_ap_for_nondefault_kernel.patch
Content-Type: text/plain; name=boot_ap_for_nondefault_kernel.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit


This patch fixes the problem of secondary cpus not coming up over a reboot. 
This problem was seen when a kernel compiled for non default (16MB) location 
is booted.

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 linux-2.6.10-rc3-mm1-changes-root/arch/i386/kernel/trampoline.S |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff -puN arch/i386/kernel/trampoline.S~boot_ap_for_nondefault_kernel arch/i386/kernel/trampoline.S
--- linux-2.6.10-rc3-mm1-changes/arch/i386/kernel/trampoline.S~boot_ap_for_nondefault_kernel	2004-12-22 16:36:50.000000000 +0530
+++ linux-2.6.10-rc3-mm1-changes-root/arch/i386/kernel/trampoline.S	2004-12-22 21:51:35.000000000 +0530
@@ -51,8 +51,14 @@ r_base = .
 	movl	$0xA5A5A5A5, trampoline_data - r_base
 				# write marker for master knows we're running
 
-	lidt	boot_idt - r_base	# load idt with 0, 0
-	lgdt	boot_gdt - r_base	# load gdt with whatever is appropriate
+	/* GDT tables in non default location kernel can be beyond 16MB and
+	 * lgdt will not be able to load the address as in real mode default
+	 * operand size is 16bit. Use lgdtl instead to force operand size
+	 * to 32 bit.
+	 */
+
+	lidtl	boot_idt - r_base	# load idt with 0, 0
+	lgdtl	boot_gdt - r_base	# load gdt with whatever is appropriate
 
 	xor	%ax, %ax
 	inc	%ax		# protected mode (PE) bit
_

--=-c/B5/e5uunYxO1i4co6c--

