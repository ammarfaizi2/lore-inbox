Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129211AbQKMQ0r>; Mon, 13 Nov 2000 11:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129060AbQKMQ01>; Mon, 13 Nov 2000 11:26:27 -0500
Received: from ns.caldera.de ([212.34.180.1]:34821 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S129044AbQKMQ0V>;
	Mon, 13 Nov 2000 11:26:21 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14864.5656.706778.275865@ns.caldera.de>
Date: Mon, 13 Nov 2000 17:26:00 +0100 (CET)
To: Gregory Maxwell <greg@linuxpower.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Modprobe local root exploit
In-Reply-To: <20001113093727.C1918@xi.linuxpower.cx>
In-Reply-To: <20001113093727.C1918@xi.linuxpower.cx>
X-Mailer: VM 6.72 under 21.1 (patch 10) "Capitol Reef" XEmacs Lucid
From: Torsten Duwe <duwe@caldera.de>
Reply-to: Torsten.Duwe@caldera.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Gregory" == Gregory Maxwell <greg@linuxpower.cx> writes:

    Gregory> After seeing the modprobe local root exploit today, I asked
    Gregory> myself why kmod executes modprobe with full root and doesn't
    Gregory> drop some capabilities first.

    Gregory> Why? It wouldn't close the hole, but it would narrow it down.

This might also be a good idea; but my suggestion is to not allow arbitrary
strings as module names in the first place. As far as I can see, all valid
strings for KMOD requests consist of alphanumeric chars plus dash and
underscore. Anybody with autoloaded modules that don't fit this pattern even
after /etc/modules.conf translation please object !

Here's the patch...

	Torsten

--- linux/kernel/kmod.c.orig	Tue Sep 26 01:18:55 2000
+++ linux/kernel/kmod.c	Mon Nov 13 16:57:02 2000
@@ -168,6 +168,22 @@
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
+	  if ((*p & 0xdf) >= 'a' && (*p & 0xdf) <= 'z')
+	    continue;
+	  if (*p >= '0' && *p <= '9')
+	    continue;
+	  if (*p == '_' || *p == '-')
+	    continue;
+	  return -EINVAL;
+	}
 
 	/* Don't allow request_module() before the root fs is mounted!  */
 	if ( ! current->fs->root ) {

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
