Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261382AbVD0KmP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261382AbVD0KmP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 06:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbVD0KmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 06:42:15 -0400
Received: from mailfe08.swip.net ([212.247.154.225]:23785 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261382AbVD0KmA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 06:42:00 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: 2.6.12-rc2-mm3
From: Alexander Nyberg <alexn@telia.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, vgoyal@in.ibm.com
In-Reply-To: <20050411012532.58593bc1.akpm@osdl.org>
References: <20050411012532.58593bc1.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 27 Apr 2005 12:41:53 +0200
Message-Id: <1114598513.886.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The two functions:
crash_kexec()
smp_send_stop()

called from panic() wants preempt to be disabled which it may not be if
coming from a direct panic assertion (and not via the do_exit
assertions...).

Signed-off-by: Alexander Nyberg <alexn@telia.com> 

Index: mm/kernel/panic.c
===================================================================
--- mm.orig/kernel/panic.c	2005-04-26 11:15:29.000000000 +0200
+++ mm/kernel/panic.c	2005-04-26 23:18:07.000000000 +0200
@@ -64,6 +64,12 @@
         unsigned long caller = (unsigned long) __builtin_return_address(0);
 #endif
 
+	/* It's possible to come here directly from a panic-assertion and not
+	 * have preempt disabled. Some functions called from here want
+	 * preempt to be disabled. No point enabling it later though...
+	 */
+	preempt_disable();
+	
 	bust_spinlocks(1);
 	va_start(args, fmt);
 	vsnprintf(buf, sizeof(buf), fmt, args);


