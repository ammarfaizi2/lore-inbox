Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316070AbSFYT34>; Tue, 25 Jun 2002 15:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316079AbSFYT3z>; Tue, 25 Jun 2002 15:29:55 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:28346 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S316070AbSFYT3y>;
	Tue, 25 Jun 2002 15:29:54 -0400
Message-ID: <3D18C4DA.9030405@colorfullife.com>
Date: Tue, 25 Jun 2002 21:30:34 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en, de
MIME-Version: 1.0
To: davej@suse.de, mochel@osdl.org, linux-kernel@vger.kernel.org
Subject: 2.5.24-dj2: oops in finalize_mtrr_state with bochs
Content-Type: multipart/mixed;
 boundary="------------000202080702000500080905"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000202080702000500080905
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The bochs cpu emulator (tries to emulate Pentium cpus) oopses in 
finalize_mtrr_state():

mtrr_if is NULL, and thus use_intel() crashes.

Patch attached. I've modified is_cpu() as well, without checking if this 
macro could be used if mtrr_if is not initialized.

Partially tested - bochs now hangs at the first access to the ide 
interface :-(
--
	Manfred

--------------000202080702000500080905
Content-Type: text/plain;
 name="patch-mtrr-dj2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-mtrr-dj2"

diff -u 2.5/arch/i386/kernel/cpu/mtrr/mtrr.h build-2.5/arch/i386/kernel/cpu/mtrr/mtrr.h
--- 2.5/arch/i386/kernel/cpu/mtrr/mtrr.h	Tue Jun 25 20:27:47 2002
+++ build-2.5/arch/i386/kernel/cpu/mtrr/mtrr.h	Tue Jun 25 21:22:15 2002
@@ -88,8 +88,8 @@
 extern u32 size_or_mask, size_and_mask;
 extern struct mtrr_ops * mtrr_if;
 
-#define is_cpu(vnd)	(mtrr_if->vendor == X86_VENDOR_##vnd)
-#define use_intel()	(mtrr_if->use_intel_if == 1)
+#define is_cpu(vnd)	(mtrr_if && mtrr_if->vendor == X86_VENDOR_##vnd)
+#define use_intel()	(mtrr_if && mtrr_if->use_intel_if == 1)
 
 extern unsigned int num_var_ranges;
 

--------------000202080702000500080905--


