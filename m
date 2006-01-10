Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932533AbWAJTw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932533AbWAJTw4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 14:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932540AbWAJTw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 14:52:56 -0500
Received: from fmr24.intel.com ([143.183.121.16]:36999 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S932524AbWAJTwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 14:52:55 -0500
Message-Id: <20060110204045.894417221@csdlinux-2.jf.intel.com>
References: <20060110203912.007577046@csdlinux-2.jf.intel.com>
Date: Tue, 10 Jan 2006 12:39:14 -0800
From: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
Cc: tony.luck@intel.com, "Systemtap" <systemtap@sources.redhat.com>,
       "Jim Keniston" <jkenisto@us.ibm.com>, "Keith Owens" <kaos@sgi.com>,
       Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Subject: [patch 2/2] Link new module to the tail of module list
Content-Disposition: inline; filename=module_link_order.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Link new module to the tail of module list

When we are linking/adding a new module, it would be
better to insert the new module to the tail of the
module list. 

The reason is when kallsyms_lookup_name(name)
looks for the text address corresponding to the name
from the head of the module list, we always hit the
module exporting the text address first and then the
module using the text address later. This helps
kallsyms_lookup_name() search which indeed need
the text address.

Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
-------------------------------------------------------------------

 kernel/module.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletion(-)

Index: linux-2.6.15-mm1/kernel/module.c
===================================================================
--- linux-2.6.15-mm1.orig/kernel/module.c
+++ linux-2.6.15-mm1/kernel/module.c
@@ -1911,7 +1911,12 @@ static struct module *load_module(void _
 static int __link_module(void *_mod)
 {
 	struct module *mod = _mod;
-	list_add(&mod->list, &modules);
+	/* Insert the new modules at the tail of the list,
+	 * so kallsyms_lookup_name finds the module exporting
+	 * the text address of a function first and quickens
+	 * the search when searching based on function name
+	 */
+	list_add_tail(&mod->list, &modules);
 	return 0;
 }
 

--

