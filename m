Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261607AbVCFXEZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261607AbVCFXEZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 18:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261609AbVCFXAQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 18:00:16 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:50896 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261595AbVCFW5n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 17:57:43 -0500
Date: Sun, 6 Mar 2005 23:57:30 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
Cc: barryn@pobox.com
Subject: Re: [Bug 4298] swsusp fails to suspend if CONFIG_DEBUG_PAGEALLOC is also enabled
Message-ID: <20050306225730.GA1414@elf.ucw.cz>
References: <20050306030852.23eb59db.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050306030852.23eb59db.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Problem Description:
> swsusp normally works, but if I enable CONFIG_DEBUG_PAGEALLOC, it breaks --
> after "PM: snapshotting memory", swsusp never gets to the "critical section" and
> it kind of bounces back from the suspend attempt, for lack of a better way for
> me to describe the effect.

Okay, that is because low-level assembly requires PSE (4mb pages for
kernel) and DEBUG_PAGEALLOC disables that capability.

If you feel like rewriting assembly code to turn off paging (and thus
working with PSE), go ahead, but I do not think it is worth the
trouble.

OTOH we should at least tell people what went wrong, some people seen
same problem on VIA cpus... Please apply,

Signed-off-by: Pavel Machek <pavel@suse.cz>

								Pavel

--- clean/include/asm-i386/suspend.h	2004-12-25 13:35:02.000000000 +0100
+++ linux/include/asm-i386/suspend.h	2005-03-02 01:05:33.000000000 +0100
@@ -10,10 +10,12 @@
 arch_prepare_suspend(void)
 {
 	/* If you want to make non-PSE machine work, turn off paging
-           in do_magic. swsusp_pg_dir should have identity mapping, so
+           in swsusp_arch_suspend. swsusp_pg_dir should have identity mapping, so
            it could work...  */
-	if (!cpu_has_pse)
+	if (!cpu_has_pse) {
+		printk(KERN_ERR "PSE is required for swsusp.\n");
 		return -EPERM;
+	}
 	return 0;
 }
 
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
