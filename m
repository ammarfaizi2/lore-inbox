Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262244AbVAZEqS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262244AbVAZEqS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 23:46:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262254AbVAZEqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 23:46:18 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:62176 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262244AbVAZEqO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 23:46:14 -0500
Subject: [PATCH] ppc64: fix use kref for device_node refcounting
From: Nathan Lynch <nathanl@austin.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, paulus@samba.org
In-Reply-To: <20050124021516.5d1ee686.akpm@osdl.org>
References: <20050124021516.5d1ee686.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 25 Jan 2005 22:44:35 -0600
Message-Id: <1106714675.9855.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-24 at 02:15 -0800, Andrew Morton wrote:
> ppc64-use-kref-for-device_node-refcounting.patch
>   ppc64: use kref for device_node refcounting

This introduced an unbalanced get/put in of_add_node which would cause
newly-added device nodes to be prematurely freed.  Sorry for the
screwup, a more rigorously tested fix follows.

Signed-off-by: Nathan Lynch <nathanl@austin.ibm.com>


---


diff -puN arch/ppc64/kernel/prom.c~fix-kref-devnode arch/ppc64/kernel/prom.c
--- linux-2.6.11-rc2-mm1/arch/ppc64/kernel/prom.c~fix-kref-devnode	2005-01-25 21:10:50.000000000 -0600
+++ linux-2.6.11-rc2-mm1-nathanl/arch/ppc64/kernel/prom.c	2005-01-25 21:14:02.000000000 -0600
@@ -1771,6 +1771,7 @@ int of_add_node(const char *path, struct
 	np->properties = proplist;
 	OF_MARK_DYNAMIC(np);
 	kref_init(&np->kref);
+	of_node_get(np);
 	np->parent = derive_parent(path);
 	if (!np->parent) {
 		kfree(np);

_


