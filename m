Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751309AbWCKXzT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbWCKXzT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 18:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbWCKXzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 18:55:19 -0500
Received: from gate.crashing.org ([63.228.1.57]:64968 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751309AbWCKXzT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 18:55:19 -0500
Subject: Re: [PATCH] powerpc: enable NAP only on cpus who support it to
	avoid memory corruption
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
Cc: Paul Mackeras <paulus@samba.org>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060311215840.GA22766@suse.de>
References: <20060311215840.GA22766@suse.de>
Content-Type: text/plain
Date: Sun, 12 Mar 2006 10:55:01 +1100
Message-Id: <1142121302.4057.52.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.92 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-03-11 at 22:58 +0100, Olaf Hering wrote:
> commit 51d3082fe6e55aecfa17113dbe98077c749f724c enabled NAP unconditinally
> on all powermacs. Early G3 cpus can not use it, the result is memory corruption.

Ok, here is what I think is a proper fix: Just remove the code from
setup.c since feature.c will already set powersave_nap when needed.

Can you test asap please ? If it fixes the problem for you, I'll send
the patch to Linus/Andrew with hopes that it will make it in 2.6.16 

---

This patch fixes incorrect setting of powersave_nap to 1 on all
PowerMac's potentially causing memory corruption on some models. This
bug was introuced by me during the 32/64 bits merge.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/powerpc/platforms/powermac/setup.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/powermac/setup.c	2006-02-13 14:10:43.000000000 +1100
+++ linux-work/arch/powerpc/platforms/powermac/setup.c	2006-03-12 10:47:39.000000000 +1100
@@ -621,10 +621,6 @@
 	/* Probe motherboard chipset */
 	pmac_feature_init();
 
-	/* We can NAP */
-	powersave_nap = 1;
-	printk(KERN_INFO "Using native/NAP idle loop\n");
-
 	/* Initialize debug stuff */
 	udbg_scc_init(!!strstr(cmd_line, "sccdbg"));
 	udbg_adb_init(!!strstr(cmd_line, "btextdbg"));
Index: linux-work/arch/powerpc/platforms/powermac/feature.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/powermac/feature.c	2006-03-01 11:48:27.000000000 +1100
+++ linux-work/arch/powerpc/platforms/powermac/feature.c	2006-03-12 10:51:31.000000000 +1100
@@ -2491,9 +2491,7 @@
 			pmac_mb.model_id = PMAC_TYPE_COMET;
 		iounmap(mach_id_ptr);
 	}
-#endif /* CONFIG_POWER4 */
 
-#ifdef CONFIG_6xx
 	/* Set default value of powersave_nap on machines that support it.
 	 * It appears that uninorth rev 3 has a problem with it, we don't
 	 * enable it on those. In theory, the flush-on-lock property is
@@ -2522,10 +2520,11 @@
 	 * NAP mode
 	 */
 	powersave_lowspeed = 1;
-#endif /* CONFIG_6xx */
-#ifdef CONFIG_POWER4
+
+#else /* CONFIG_POWER4 */
 	powersave_nap = 1;
-#endif
+#endif  /* CONFIG_POWER4 */
+
 	/* Check for "mobile" machine */
 	if (model && (strncmp(model, "PowerBook", 9) == 0
 		   || strncmp(model, "iBook", 5) == 0))


