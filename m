Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261796AbUKUT1B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261796AbUKUT1B (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 14:27:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261801AbUKUT1B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 14:27:01 -0500
Received: from postfix3-2.free.fr ([213.228.0.169]:64720 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S261796AbUKUT05
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 14:26:57 -0500
Message-ID: <41A0EC04.6070100@free.fr>
Date: Sun, 21 Nov 2004 20:27:00 +0100
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [Patch] PnPacpi parser fix
Content-Type: multipart/mixed;
 boundary="------------070005000902040508080904"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070005000902040508080904
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

this patch fix a bug in the pnpacpi parser : the pnpacpi parser supposed 
that are no resource after EndDependentFn.

Please apply.


Signed-Off-By: Matthieu Castet <castet.matthieu@free.fr>

--------------070005000902040508080904
Content-Type: text/x-patch;
 name="pnpacpi_parser.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pnpacpi_parser.patch"

--- linux-2.6.9/drivers/pnp/pnpacpi/rsparser.c.old	2004-11-12 22:55:10.000000000 +0100
+++ linux-2.6.9/drivers/pnp/pnpacpi/rsparser.c	2004-11-20 10:44:36.000000000 +0100
@@ -443,6 +443,7 @@
 
 struct acpipnp_parse_option_s {
 	struct pnp_option *option;
+	struct pnp_option *independent_option;
 	struct pnp_dev *dev;
 };
 
@@ -506,7 +507,15 @@
 			parse_data->option = option;	
 			break;
 		case ACPI_RSTYPE_END_DPF:
-			return AE_CTRL_TERMINATE;
+			/*only one EndDependentFn is allowed*/
+			if (!parse_data->independent_option) {
+				pnp_warn("PnPACPI: more than one EndDependentFn");
+				return AE_ERROR;
+			}
+			parse_data->option = parse_data->independent_option;
+			parse_data->independent_option = NULL;
+			break;
 		default:
 			pnp_warn("PnPACPI:Option type: %d not handle", res->id);
 			return AE_ERROR;
@@ -524,6 +533,7 @@
 	parse_data.option = pnp_register_independent_option(dev);
 	if (!parse_data.option)
 		return AE_ERROR;
+	parse_data.independent_option = parse_data.option;
 	parse_data.dev = dev;
 	status = acpi_walk_resources(handle, METHOD_NAME__PRS, 
 		pnpacpi_option_resource, &parse_data);

--------------070005000902040508080904--
