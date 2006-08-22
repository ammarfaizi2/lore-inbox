Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751300AbWHVVy4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbWHVVy4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 17:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbWHVVy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 17:54:56 -0400
Received: from gw.goop.org ([64.81.55.164]:49127 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751300AbWHVVyz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 17:54:55 -0400
Message-ID: <44EB7D2D.7000006@goop.org>
Date: Tue, 22 Aug 2006 14:54:53 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Paul Drynoff <pauldrynoff@gmail.com>
CC: Andrew Morton <akpm@osdl.org>, Jeremy Fitzhardinge <jeremy@xensource.com>,
       linux-kernel@vger.kernel.org, Zachary Amsden <zach@vmware.com>
Subject: Re: [BUG] Can not boot linux-2.6.18-rc4-mm2
References: <20060822125118.12ba1ed4.pauldrynoff@gmail.com>	 <20060822123850.bdb09717.akpm@osdl.org> <36e6b2150608221413h3b6baf24lf670a2aed61c0c57@mail.gmail.com>
In-Reply-To: <36e6b2150608221413h3b6baf24lf670a2aed61c0c57@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Drynoff wrote:
> I made bisection, here is results:
>
> add-efi-e820-memory-mapping-on-x86.patch - GOOD
> #
> i386-adds-smp_call_function_single-fix.patch
> fix-boot-on-efi-32-bit-machines.patch - GOOD
> kill-default_ldt.patch - BAD
>
> Wihtout last patch all works ok. 

Hm.  Try this:

From: Zachary Amsden <zach@vmware.com>

Fix kill-default_ldt.patch

--- a/arch/i386/kernel/paravirt.c
+++ b/arch/i386/kernel/paravirt.c
@@ -262,7 +262,7 @@ static fastcall void native_set_ldt(cons
 	u32 low, high;
 
 	pack_descriptor(&low, &high, (unsigned long)addr,
-			entries * sizeof(struct desc_struct) - 1,
+			entries * sizeof(struct desc_struct),
 			DESCTYPE_LDT, 0);
 	write_gdt_entry(get_cpu_gdt_table(cpu), GDT_ENTRY_LDT, low, high);
 
===================================================================
--- a/include/asm-i386/desc.h
+++ b/include/asm-i386/desc.h
@@ -97,7 +97,7 @@ static inline void set_ldt(const void *a
 	__u32 low, high;
 
 	pack_descriptor(&low, &high, (unsigned long)addr,
-			entries * sizeof(struct desc_struct) - 1,
+			entries * sizeof(struct desc_struct),
 			DESCTYPE_LDT, 0);
 	write_gdt_entry(get_cpu_gdt_table(cpu), GDT_ENTRY_LDT, low, high);
 


