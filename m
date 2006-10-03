Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965285AbWJCG4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965285AbWJCG4A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 02:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965277AbWJCG4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 02:56:00 -0400
Received: from ozlabs.org ([203.10.76.45]:49352 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S965285AbWJCGz7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 02:55:59 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17698.2424.528747.211313@cargo.ozlabs.ibm.com>
Date: Tue, 3 Oct 2006 16:55:52 +1000
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@muc.de>, Hugh Dickens <hugh@veritas.com>,
       Michael Ellerman <michael@ellerman.id.au>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 5/6] From: Andrew Morton <akpm@osdl.org>
In-Reply-To: <20061002225053.46be0324.akpm@osdl.org>
References: <20061003010842.438670755@goop.org>
	<20061003010933.392428107@goop.org>
	<17697.58794.113796.925995@cargo.ozlabs.ibm.com>
	<20061002213347.8229b6fc.akpm@osdl.org>
	<17697.62198.476469.265990@cargo.ozlabs.ibm.com>
	<20061002225053.46be0324.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:

> I still get crap all over the screen when xmon is tring to print something
> (at least, I assume that's what causes it).  See
> http://userweb.kernel.org/~akpm/s5000334.jpg

That is because the nvidia console driver has changed the line pitch
from what the firmware set it to.  This should fix it by making the
nvidia driver inform the btext engine (which xmon uses if the screen
is its output device) about changes to display resolution.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
diff --git a/drivers/video/nvidia/nvidia.c b/drivers/video/nvidia/nvidia.c
index d4f8501..18b9101 100644
--- a/drivers/video/nvidia/nvidia.c
+++ b/drivers/video/nvidia/nvidia.c
@@ -28,6 +28,9 @@ #ifdef CONFIG_PPC_OF
 #include <asm/prom.h>
 #include <asm/pci-bridge.h>
 #endif
+#ifdef CONFIG_BOOTX_TEXT
+#include <asm/btext.h>
+#endif
 
 #include "nv_local.h"
 #include "nv_type.h"
@@ -681,6 +684,13 @@ #endif
 
 	nvidia_vga_protect(par, 0);
 
+#ifdef CONFIG_BOOTX_TEXT
+	/* Update debug text engine */
+	btext_update_display(info->fix.smem_start,
+			     info->var.xres, info->var.yres,
+			     info->var.bits_per_pixel, info->fix.line_length);
+#endif
+
 	NVTRACE_LEAVE();
 	return 0;
 }
