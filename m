Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261354AbVBHAYA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261354AbVBHAYA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 19:24:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261355AbVBHAYA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 19:24:00 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:52441 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261354AbVBHAX4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 19:23:56 -0500
Subject: Re: [PATCH] PCI Hotplug: remove incorrect rpaphp firmware
	dependency
From: John Rose <johnrose@austin.ibm.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, greg@kroah.com,
       akpm@osdl.org, torvalds@osdl.org, Mike Wortman <wortman@us.ibm.com>
In-Reply-To: <1107795637.19262.426.camel@hades.cambridge.redhat.com>
References: <200502031908.j13J8ggb031915@hera.kernel.org>
	 <1107795637.19262.426.camel@hades.cambridge.redhat.com>
Content-Type: text/plain
Message-Id: <1107822110.31219.51.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 07 Feb 2005 18:21:50 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Er, use the result of the get_children_props() call only if it _failed_?
> I suspect that wasn't your intention. This makes my G5 boot again:

Here's an alternate fix for the ppc64 crash during boot.  This corrects
the offending function to use more conventional error codes.  I'll
follow up with return code cleanups for the entire module, and for RTAS
code, since these are probably too big for 2.6.11.

Please apply, if appropriate.

Thanks-
John

Signed-off-by: John Rose <johnrose@austin.ibm.com>

diff -puN drivers/pci/hotplug/rpaphp_core.c~01_rpaphp_is_php_fix drivers/pci/hotplug/rpaphp_core.c
--- 2_6_linus/drivers/pci/hotplug/rpaphp_core.c~01_rpaphp_is_php_fix	2005-02-07 18:06:29.000000000 -0600
+++ 2_6_linus-johnrose/drivers/pci/hotplug/rpaphp_core.c	2005-02-07 18:10:15.000000000 -0600
@@ -224,7 +224,7 @@ static int get_children_props(struct dev
 
 	if (!indexes || !names || !types || !domains) {
 		/* Slot does not have dynamically-removable children */
-		return 1;
+		return -EINVAL;
 	}
 	if (drc_indexes)
 		*drc_indexes = indexes;
@@ -260,7 +260,7 @@ int rpaphp_get_drc_props(struct device_n
 	}
 
 	rc = get_children_props(dn->parent, &indexes, &names, &types, &domains);
-	if (rc) {
+	if (rc < 0) {
 		return 1;
 	}
 
@@ -307,7 +307,7 @@ static int is_php_dn(struct device_node 
 	int rc;
 
 	rc = get_children_props(dn, indexes, names, &drc_types, power_domains);
-	if (rc) {
+	if (rc >= 0) {
 		if (is_php_type((char *) &drc_types[1])) {
 			*types = drc_types;
 			return 1;
@@ -331,7 +331,7 @@ static int is_dr_dn(struct device_node *
 
 	rc = get_children_props(dn->parent, indexes, names, types,
 				power_domains);
-	return (rc == 0);
+	return (rc >= 0);
 }
 
 static inline int is_vdevice_root(struct device_node *dn)

_

