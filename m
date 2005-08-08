Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932193AbVHHSuN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbVHHSuN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 14:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932194AbVHHSuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 14:50:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:55424 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932193AbVHHSuL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 14:50:11 -0400
Date: Mon, 8 Aug 2005 14:49:55 -0400
From: Dave Jones <davej@redhat.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: obsolete modparam change busted.
Message-ID: <20050808184955.GA18779@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Circa 2.6.10, the module loader started barfing if
modprobe.conf contained obsolete parameters.

However this change was broken, and if the modprobe.conf
has trailing whitespace, modules fail to load with the
following helpful message..

snd_intel8x0: Unknown parameter `'

This ends up screwing over people who upgrade from previously
working configurations, so we've been backing out that change
in Fedora for a while with the patch below.

It doesn't look like the right thing to do, but it has got
things working again at least. Probably we should just check
explicity for whitespace and ignore it somewhere else in
the module loader.  Rusty?

		Dave


diff -urNp --exclude-from=/home/davej/.exclude linux-1503/kernel/module.c linux-1700/kernel/module.c
--- linux-1503/kernel/module.c
+++ linux-1700/kernel/module.c
@@ -1707,8 +1707,6 @@ static struct module *load_module(void _
 				 / sizeof(struct kernel_param),
 				 NULL);
 	}
-	if (err < 0)
-		goto arch_cleanup;
 
 	err = mod_sysfs_setup(mod, 
 			      (struct kernel_param *)
