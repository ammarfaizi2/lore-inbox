Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261715AbVBEJJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261715AbVBEJJx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 04:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266512AbVBEJI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 04:08:27 -0500
Received: from postfix3-1.free.fr ([213.228.0.44]:31205 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S263925AbVBEJHJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 04:07:09 -0500
Message-ID: <42048CBC.8070700@free.fr>
Date: Sat, 05 Feb 2005 10:07:08 +0100
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: matthieu castet <castet.matthieu@free.fr>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Len Brown <len.brown@intel.com>, acpi-devel@lists.sourceforge.net
Subject: Re: [PATCH] PNPACPI parser fix
References: <4203AFC5.8070308@free.fr>
In-Reply-To: <4203AFC5.8070308@free.fr>
Content-Type: multipart/mixed;
 boundary="------------000704070800050502040905"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000704070800050502040905
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

matthieu castet wrote:
> Hi,
> 
> This patch is very old (11/2004), but never get merged even if acked by 
> Shaohua Li.
> As you can see in the bugzilla report 
> (http://bugzilla.kernel.org/show_bug.cgi?id=3912), it solve parsing 
> issue in the pnpacpi core : the pnpacpi parser supposed that are no
> resource after EndDependentFn.
> 
> Please apply this patch.
> Thanks.
> 
> Matthieu CASTET

oops, the attachement was wrong.

Here is the patch.


Regards,

Matthieu

--------------000704070800050502040905
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
+	struct pnp_option *option_independent;
 	struct pnp_dev *dev;
 };
 
@@ -506,7 +507,15 @@
 			parse_data->option = option;	
 			break;
 		case ACPI_RSTYPE_END_DPF:
-			return AE_CTRL_TERMINATE;
+			/*only one EndDependentFn is allowed*/
+			if (!parse_data->option_independent) {
+				pnp_warn("PnPACPI: more than one EndDependentFn");
+				return AE_ERROR;
+			}
+			parse_data->option = parse_data->option_independent;
+			parse_data->option_independent = NULL;
+			break;
 		default:
 			pnp_warn("PnPACPI:Option type: %d not handle", res->id);
 			return AE_ERROR;
@@ -524,6 +533,7 @@
 	parse_data.option = pnp_register_option_independent(dev);
 	if (!parse_data.option)
 		return AE_ERROR;
+	parse_data.option_independent = parse_data.option;
 	parse_data.dev = dev;
 	status = acpi_walk_resources(handle, METHOD_NAME__PRS, 
 		pnpacpi_option_resource, &parse_data);

--------------000704070800050502040905--
