Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261195AbVBGRBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbVBGRBK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 12:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbVBGRBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 12:01:10 -0500
Received: from canuck.infradead.org ([205.233.218.70]:59912 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261195AbVBGRA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 12:00:56 -0500
Subject: Re: [PATCH] PCI Hotplug: remove incorrect rpaphp firmware
	dependency
From: David Woodhouse <dwmw2@infradead.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: johnrose@austin.ibm.com, greg@kroah.com.torvalds, akpm@osdl.org
In-Reply-To: <200502031908.j13J8ggb031915@hera.kernel.org>
References: <200502031908.j13J8ggb031915@hera.kernel.org>
Content-Type: text/plain
Date: Mon, 07 Feb 2005 17:00:37 +0000
Message-Id: <1107795637.19262.426.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-02-03 at 08:41 +0000, Linux Kernel Mailing List wrote:
>         [PATCH] PCI Hotplug: remove incorrect rpaphp firmware dependency
>         
>         The RPA PCI Hotplug module incorrectly uses a certain firmware property when
>         determining the hotplug capabilities of a slot.  Recent firmware changes have
>         demonstrated that this property should not be referenced or depended upon by
>         the OS.  This patch removes the dependency, and implements a correct set of
>         logic for determining hotplug capabilities.
>         
>         Signed-off-by: John Rose <johnrose@austin.ibm.com>
>         Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>
>         
> +       rc = get_children_props(dn, indexes, names, &drc_types, power_domains);
> +       if (rc) {
> +               if (is_php_type((char *) &drc_types[1])) {
> +                       *types = drc_types;
> +                       return 1;
> +               }
> +       }

Er, use the result of the get_children_props() call only if it _failed_?
I suspect that wasn't your intention. This makes my G5 boot again:

--- linux-2.6.10/drivers/pci/hotplug/rpaphp_core.c.orig	2005-02-07 16:41:45.830990208 +0000
+++ linux-2.6.10/drivers/pci/hotplug/rpaphp_core.c	2005-02-07 16:46:15.495868912 +0000
@@ -307,7 +307,7 @@ static int is_php_dn(struct device_node 
 	int rc;
 
 	rc = get_children_props(dn, indexes, names, &drc_types, power_domains);
-	if (rc) {
+	if (!rc) {
 		if (is_php_type((char *) &drc_types[1])) {
 			*types = drc_types;
 			return 1;




-- 
dwmw2

