Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263961AbTDWG3X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 02:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263965AbTDWG3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 02:29:23 -0400
Received: from holomorphy.com ([66.224.33.161]:55455 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263961AbTDWG3W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 02:29:22 -0400
Date: Tue, 22 Apr 2003 23:41:03 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.68-mm1
Message-ID: <20030423064103.GL8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20030419231320.52b2b2ef.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030419231320.52b2b2ef.akpm@digeo.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 19, 2003 at 11:13:20PM -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.68/2.5.68-mm1
> A few fixes for various things.  mainly a resync with 2.5.68.

arch/i386/lib/kgdb_serial.c needs a fixup for CONFIG_DISCONTIGMEM:


diff -urpN mm1-2.5.68-1/arch/i386/lib/kgdb_serial.c mm1-2.5.68-1B/arch/i386/lib/kgdb_serial.c
--- mm1-2.5.68-1/arch/i386/lib/kgdb_serial.c	2003-04-20 00:24:45.000000000 -0700
+++ mm1-2.5.68-1B/arch/i386/lib/kgdb_serial.c	2003-04-22 23:24:15.000000000 -0700
@@ -25,6 +25,7 @@
 #include <linux/ioport.h>
 #include <linux/mm.h>
 #include <linux/init.h>
+#include <linux/highmem.h>
 #include <asm/system.h>
 #include <asm/io.h>
 #include <asm/segment.h>
@@ -397,6 +398,18 @@ kgdb_enable_ints(void)
 void shutdown_for_kgdb(struct async_struct *gdb_async_info);
 #endif
 
+#ifdef CONFIG_DISCONTIGMEM
+static inline int kgdb_mem_init_done(void)
+{
+	return highmem_start_page != NULL;
+}
+#else
+static inline int kgdb_mem_init_done(void)
+{
+	return max_mapnr != 0;
+}
+#endif
+
 static void
 kgdb_enable_ints_now(void)
 {
@@ -404,7 +417,8 @@ kgdb_enable_ints_now(void)
 		return;
 	if (!ints_disabled)
 		goto exit;
-	if (max_mapnr && ints_disabled) {	/* don't try till mem init */
+	if (kgdb_mem_init_done() &&
+			ints_disabled) {	/* don't try till mem init */
 #ifdef CONFIG_SERIAL_8250
 		/*
 		 * The ifdef here allows the system to be configured
