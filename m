Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750850AbWAKNmt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbWAKNmt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 08:42:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbWAKNmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 08:42:49 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:38787 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750850AbWAKNms
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 08:42:48 -0500
Date: Wed, 11 Jan 2006 19:12:30 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: vgoyal@in.ibm.com, Stephen Hemminger <shemminger@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Crash with SMP on post 2.6.15 -git kernel
Message-ID: <20060111134230.GE4990@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060110165457.42ed2087@dxpl.pdx.osdl.net> <20060110184903.790d1a2c@localhost.localdomain> <20060111093212.GA15281@in.ibm.com> <200601111212.40989.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601111212.40989.ak@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2006 at 12:12:40PM +0100, Andi Kleen wrote:
> On Wednesday 11 January 2006 10:32, Vivek Goyal wrote:
> 
> > Few x86_64 APIC related kexec changes are still in Andi's tree and have not
> > been pushed to Linus tree. So there are no new x86_64 kexec patches in latest
> > git repository.
> > 
> > Andrew has pushed x86_64 kdump related patches to Linus tree. And these become
> > effective only under CONFIG_CRASH_DUMP. These patches are very less likely
> > to botch with this stuff.
> 
> Yes, it was only a very quick look through the change log. Sorry for
> hitting on you. I have no clue what could have broken. And my machines boot 
> too with -git7 and his config.
> 
> Stephen, can you please do a binary search?
> 

Andi,

While testing this I ran into another problem with same symtoms. If 
I compile my kernel for physical location greater than or equal to 
16MB then only BP boots and applicatoin processors don't come up. I had
noticed this problem in i386 and posted a patch. Here is the similar  patch 
for x86_64.

Though the symtoms are same but this does not seem to be related to the
problem which Stephen is facing as he seems to be compiling the kernel
for 1MB location only.

Thanks
Vivek




o This fix was posted for i386 long back. Posting it for x86_64.

  http://marc.theaimsgroup.com/?l=linux-kernel&m=110380103229830&w=2

o This patch fixes the problem of secondary cpus boot up. This situation
  is faced when kernel is built for non default locations like 16MB and
  onwards. In this configuration, only primary cpu (BP) comes and
  secondary cpus don't boot.
                                                                                
o Problem occurs because in trampoline code, lgdt is not able to load the
  GDT as it happens to be situated beyond 16MB. This is due to the fact
  that cpu is still in real mode and default operand size is 16bit.
                                                                                
o This patch uses lgdtl instead of lgdt to force operand size to 32
  instead of 16.


Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---


diff -puN arch/x86_64/kernel/trampoline.S~x86_64-non-default-location-smp-kernel-boot-fix arch/x86_64/kernel/trampoline.S
--- linux-2.6.15-git7/arch/x86_64/kernel/trampoline.S~x86_64-non-default-location-smp-kernel-boot-fix	2006-01-11 10:32:30.000000000 -0800
+++ linux-2.6.15-git7-root/arch/x86_64/kernel/trampoline.S	2006-01-11 10:34:42.000000000 -0800
@@ -42,8 +42,15 @@ r_base = .
 	movl	$0xA5A5A5A5, trampoline_data - r_base
 				# write marker for master knows we're running
 
-	lidt	idt_48 - r_base	# load idt with 0, 0
-	lgdt	gdt_48 - r_base	# load gdt with whatever is appropriate
+	/*
+	 * GDT tables in non default location kernel can be beyond 16MB and
+	 * lgdt will not be able to load the address as in real mode default
+	 * operand size is 16bit. Use lgdtl instead to force operand size
+	 * to 32 bit.
+	 */
+
+	lidtl	idt_48 - r_base	# load idt with 0, 0
+	lgdtl	gdt_48 - r_base	# load gdt with whatever is appropriate
 
 	xor	%ax, %ax
 	inc	%ax		# protected mode (PE) bit
_
