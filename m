Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129060AbQKMSMy>; Mon, 13 Nov 2000 13:12:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129130AbQKMSMo>; Mon, 13 Nov 2000 13:12:44 -0500
Received: from ns.caldera.de ([212.34.180.1]:13063 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S129060AbQKMSM2>;
	Mon, 13 Nov 2000 13:12:28 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14864.12007.216381.254700@ns.caldera.de>
Date: Mon, 13 Nov 2000 19:11:51 +0100 (CET)
To: Chris Evans <chris@scary.beasts.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Modprobe local root exploit
In-Reply-To: <Pine.LNX.4.21.0011131655430.22139-100000@ferret.lmh.ox.ac.uk>
In-Reply-To: <14864.6812.849398.988598@ns.caldera.de>
	<Pine.LNX.4.21.0011131655430.22139-100000@ferret.lmh.ox.ac.uk>
X-Mailer: VM 6.72 under 21.1 (patch 10) "Capitol Reef" XEmacs Lucid
From: Torsten Duwe <duwe@caldera.de>
Reply-to: Torsten.Duwe@caldera.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Chris" == Chris Evans <chris@scary.beasts.org> writes:

    Chris> What's wrong with isalnum() ?

Hm, must admit that I wasn't 100% sure if that's in the kernel lib or an evil
gcc expands it inline to some static array lookup. Now I see that it's
already in the kernel. Do some of you also sometimes wonder why the kernel is
so big ;-) ?

OK, so let's go for the isalnum() version, and don't forget to
#include <linux/ctype.h>
above...

	Torsten

For those who joined the program late here's the complete patch:

--- linux/kernel/kmod.c.orig	Tue Sep 26 01:18:55 2000
+++ linux/kernel/kmod.c	Mon Nov 13 19:09:11 2000
@@ -18,6 +18,7 @@
 #include <linux/config.h>
 #include <linux/sched.h>
 #include <linux/unistd.h>
+#include <linux/ctype.h>
 #include <linux/smp_lock.h>
 
 #include <asm/uaccess.h>
@@ -168,6 +169,19 @@
 	static atomic_t kmod_concurrent = ATOMIC_INIT(0);
 #define MAX_KMOD_CONCURRENT 50	/* Completely arbitrary value - KAO */
 	static int kmod_loop_msg;
+	const char * p;
+
+	/* For security reasons ensure the requested name consists
+	 * only of allowed characters. Especially whitespace and
+	 * shell metacharacters might confuse modprobe.
+	 */
+	for (p = module_name; *p; p++)
+	{
+	  if (isalnum(*p) || *p == '_' || *p == '-')
+	    continue;
+
+	  return -EINVAL;
+	}
 
 	/* Don't allow request_module() before the root fs is mounted!  */
 	if ( ! current->fs->root ) {
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
