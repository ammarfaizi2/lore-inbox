Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750941AbWHBJGx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750941AbWHBJGx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 05:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750934AbWHBJGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 05:06:53 -0400
Received: from ozlabs.tip.net.au ([203.10.76.45]:6116 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750809AbWHBJGw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 05:06:52 -0400
Subject: [PATCH 1/2] Allow early_param and identical __setup to exist
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Xen-devel <xen-devel@lists.xensource.com>,
       Ian Pratt <ian.pratt@xensource.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Christoph Lameter <clameter@sgi.com>
In-Reply-To: <200608020724.23583.ak@suse.de>
References: <0adfc39039c79e4f4121.1154462446@ezr>
	 <200608020636.58133.ak@suse.de>
	 <1154496058.2570.57.camel@localhost.localdomain>
	 <200608020724.23583.ak@suse.de>
Content-Type: text/plain
Date: Wed, 02 Aug 2006 19:06:47 +1000
Message-Id: <1154509608.10326.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We currently assume that boot parameters which are handled by
early_param() will not overlap boot parameters handled by __setup: if
they do, behaviour is dependent on link order, usually meaning __setup
will not get called.

ACPI wants to use early_param("pci"), and pci uses __setup("pci="), so
we modify the core to let them coexist: "pci=noacpi" will now get
passed to both.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.18-rc2-mm1/init/main.c working-2.6.18-rc2-mm1-i386-parse_early_param/init/main.c
--- linux-2.6.18-rc2-mm1/init/main.c	2006-08-01 14:12:11.000000000 +1000
+++ working-2.6.18-rc2-mm1-i386-parse_early_param/init/main.c	2006-08-02 16:48:39.000000000 +1000
@@ -182,16 +182,19 @@ extern struct obs_kernel_param __setup_s
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
@@ -201,7 +204,8 @@ static int __init obsolete_checksetup(ch
 		}
 		p++;
 	} while (p < __setup_end);
-	return 0;
+
+	return had_early_param;
 }
 
 /*

-- 
Help! Save Australia from the worst of the DMCA: http://linux.org.au/law

