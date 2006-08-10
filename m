Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932263AbWHJUEQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbWHJUEQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbWHJUDx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:03:53 -0400
Received: from ns.suse.de ([195.135.220.2]:63888 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932643AbWHJTgr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:36:47 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [89/145] x86_64: Allow early_param and identical __setup to exist
Message-Id: <20060810193646.7174C13C0B@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:36:46 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

From: Rusty Russell <rusty@rustcorp.com.au>
We currently assume that boot parameters which are handled by
early_param() will not overlap boot parameters handled by __setup: if
they do, behaviour is dependent on link order, usually meaning __setup
will not get called.

ACPI wants to use early_param("pci"), and pci uses __setup("pci="), so
we modify the core to let them coexist: "pci=noacpi" will now get
passed to both.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Andi Kleen <ak@suse.de>

---
 init/main.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

Index: linux/init/main.c
===================================================================
--- linux.orig/init/main.c
+++ linux/init/main.c
@@ -162,16 +162,19 @@ extern struct obs_kernel_param __setup_s
 static int __init obsolete_checksetup(char *line)
 {
 	struct obs_kernel_param *p;
+	int had_early_param = 0;
 
 	p = __setup_start;
 	do {
 		int n = strlen(p->str);
 		if (!strncmp(line, p->str, n)) {
 			if (p->early) {
-				/* Already done in parse_early_param?  (Needs
-				 * exact match on param part) */
+				/* Already done in parse_early_param?
+				 * (Needs exact match on param part).
+				 * Keep iterating, as we can have early
+				 * params and __setups of same names 8( */
 				if (line[n] == '\0' || line[n] == '=')
-					return 1;
+					had_early_param = 1;
 			} else if (!p->setup_func) {
 				printk(KERN_WARNING "Parameter %s is obsolete,"
 				       " ignored\n", p->str);
@@ -181,7 +184,8 @@ static int __init obsolete_checksetup(ch
 		}
 		p++;
 	} while (p < __setup_end);
-	return 0;
+
+	return had_early_param;
 }
 
 /*
