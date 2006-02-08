Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161035AbWBHGsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161035AbWBHGsu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 01:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161014AbWBHGst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 01:48:49 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:7808 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1161023AbWBHGnG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 01:43:06 -0500
Message-Id: <20060208064914.260076000@sorel.sous-sol.org>
References: <20060208064503.924238000@sorel.sous-sol.org>
Date: Tue, 07 Feb 2006 22:45:20 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       "Andi Kleen" <ak@suse.de>
Subject: [PATCH 17/23] [PATCH] x86_64: Let impossible CPUs point to reference per cpu data
Content-Disposition: inline; filename=x86_64-let-impossible-cpus-point-to-reference-per-cpu-data.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

Don't mark the reference per cpu data init data (so it stays
around after boot) and point all impossible CPUs to it. This way
they reference some valid - although shared memory. Usually
this is only initialization like INIT_LIST_HEADs and there
won't be races because these CPUs never run. Still somewhat hackish.

Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 arch/x86_64/kernel/vmlinux.lds.S |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

Index: linux-2.6.15.3/arch/x86_64/kernel/vmlinux.lds.S
===================================================================
--- linux-2.6.15.3.orig/arch/x86_64/kernel/vmlinux.lds.S
+++ linux-2.6.15.3/arch/x86_64/kernel/vmlinux.lds.S
@@ -170,13 +170,15 @@ SECTIONS
   . = ALIGN(4096);
   __initramfs_start = .;
   .init.ramfs : AT(ADDR(.init.ramfs) - LOAD_OFFSET) { *(.init.ramfs) }
-  __initramfs_end = .;	
-  . = ALIGN(32);
+  __initramfs_end = .;
+  /* temporary here to work around NR_CPUS. If you see this comment in 2.6.17+
+   complain */
+  . = ALIGN(4096);	
+  __init_end = .;	
+  . = ALIGN(128);
   __per_cpu_start = .;
   .data.percpu  : AT(ADDR(.data.percpu) - LOAD_OFFSET) { *(.data.percpu) }
   __per_cpu_end = .;
-  . = ALIGN(4096);
-  __init_end = .;
 
   . = ALIGN(4096);
   __nosave_begin = .;

--
