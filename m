Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261755AbVCSUjm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261755AbVCSUjm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 15:39:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261772AbVCSUjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 15:39:42 -0500
Received: from mx1.redhat.com ([66.187.233.31]:5565 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261755AbVCSUjj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 15:39:39 -0500
Date: Sat, 19 Mar 2005 15:39:33 -0500
From: Jeff Garzik <jgarzik@redhat.com>
To: rth@redhat.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] _raw_read_trylock for alpha
Message-ID: <20050319203933.GD7404@devserv.devel.redhat.com>
Reply-To: jgarzik@pobox.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


alpha SMP doesn't build, due to lack of _raw_read_trylock().

Patch below completely untested...  needs review and testing.

One could also use the arch-neutral generic_raw_read_trylock(),
but that implementation is rather lame (it spins).  I'm amazed at the
number of arches that use the generic implementation, since the generic
version isn't really a "trylock".

Don't send this patch upstream until its been verified to actually work.

Signed-off-by: Jeff Garzik <jgarzik@pobox.com>


diff -ur ../kernel-2.6.11.orig/linux-2.6.11/include/asm-alpha/spinlock.h linux-2.6.11/include/asm-alpha/spinlock.h
--- ../kernel-2.6.11.orig/linux-2.6.11/include/asm-alpha/spinlock.h	2005-03-02 02:38:12.000000000 -0500
+++ linux-2.6.11/include/asm-alpha/spinlock.h	2005-03-19 03:26:11.000000000 -0500
@@ -153,6 +153,29 @@
 }
 #endif /* CONFIG_DEBUG_RWLOCK */
 
+static inline int _raw_read_trylock(rwlock_t * lock)
+{
+	long regx;
+	int success;
+
+	__asm__ __volatile__(
+	"1:	ldl_l	%1,%0\n"
+	"	lda	%2,0\n"
+	"	blbs	%1,6f\n"
+	"	subl	%1,2,%1\n"
+	"	stl_c	%1,%0\n"
+	"	beq	%1,6f\n"
+	"	lda	%2,1\n"
+	"4:	mb\n"
+	".subsection 2\n"
+	"6:	br	1b\n"
+	".previous"
+	: "=m" (*lock), "=&r" (regx), "=&r" (success)
+	: "m" (*lock) : "memory");
+
+	return success;
+}
+
 static inline int _raw_write_trylock(rwlock_t * lock)
 {
 	long regx;
