Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261331AbUKFH7f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261331AbUKFH7f (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 02:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbUKFH7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 02:59:35 -0500
Received: from sweetums.bluetronic.net ([24.199.150.42]:27579 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S261331AbUKFH7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 02:59:33 -0500
Date: Sat, 6 Nov 2004 02:57:18 -0500 (EST)
From: Ricky Beam <jfbeam@bluetronic.net>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
cc: <linux-kernel@vger.kernel.org>, <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, <arjanv@redhat.com>
Subject: Re: breakage: flex mmap patch for x86-64
In-Reply-To: <200411060026.48571.rjw@sisk.pl>
Message-ID: <Pine.GSO.4.33.0411060252370.9358-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Nov 2004, Rafael J. Wysocki wrote:
>> Looks like checking for PER_LINUX32 might fix it...
>>
>> >>>      if (current->personality & (ADDR_COMPAT_LAYOUT|PER_LINUX32))
>
>It does not seem to work either.

... because the personality isn't set (as one might expect.)  TIF_IA32 is
set, however.

The second diff (processor.h) isn't necessary to fix the bug, but does
remove some duplication that I don't trust gcc to do on it's own.

--Ricky

===== arch/x86_64/mm/mmap.c 1.1 vs edited =====
--- 1.1/arch/x86_64/mm/mmap.c   2004-11-02 09:40:35 -05:00
+++ edited/arch/x86_64/mm/mmap.c        2004-11-05 23:31:40 -05:00
@@ -49,6 +49,9 @@

 static inline int mmap_is_legacy(void)
 {
+       if (test_thread_flag(TIF_IA32))
+               return 1;
+
        if (current->personality & ADDR_COMPAT_LAYOUT)
                return 1;

===== include/asm-x86_64/processor.h 1.43 vs edited =====
--- 1.43/include/asm-x86_64/processor.h 2004-11-02 09:40:35 -05:00
+++ edited/include/asm-x86_64/processor.h       2004-11-05 22:13:24 -05:00
@@ -170,7 +170,7 @@
  */
 #define IA32_PAGE_OFFSET ((current->personality & ADDR_LIMIT_3GB) ? 0xc0000000 : 0xFFFFe000)
 #define TASK_UNMAPPED_32 PAGE_ALIGN(IA32_PAGE_OFFSET/3)
-#define TASK_UNMAPPED_64 PAGE_ALIGN(TASK_SIZE/3)
+#define TASK_UNMAPPED_64 PAGE_ALIGN(TASK_SIZE_64/3)
 #define TASK_UNMAPPED_BASE     \
        (test_thread_flag(TIF_IA32) ? TASK_UNMAPPED_32 : TASK_UNMAPPED_64)


