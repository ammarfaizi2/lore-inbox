Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbUCBOJT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 09:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbUCBOJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 09:09:19 -0500
Received: from ns.suse.de ([195.135.220.2]:15319 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261654AbUCBOJN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 09:09:13 -0500
Date: Tue, 2 Mar 2004 15:09:10 +0100
From: Karsten Keil <kkeil@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: small ISDN fixes
Message-ID: <20040302140910.GA24599@pingi3.kke.suse.de>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Organization: SuSE Linux AG
X-Operating-System: Linux 2.4.21-166-default i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

here are small ISDN fixes for the 2.6.4-rc1-bk2 tree.

The first one is only a C99 versus GNU style initializer
change for newer compiler happiness (Thanks to Art Haas)
(Andrew this one is allready in your tree).

The other fix a compiler inlining/optimation problem with
strpbrk, if it has only a one character search string.
(result on missing strchr because the compiler internaly
replace strpbrk with strchr in this case, but after inline
handling stage).


diff -ur linux-2.6.4-rc1-bk2.org/drivers/isdn/hisax/hisax_fcpcipnp.c linux-2.6.4-rc1-bk2.clean/drivers/isdn/hisax/hisax_fcpcipnp.c
--- linux-2.6.4-rc1-bk2.org/drivers/isdn/hisax/hisax_fcpcipnp.c	2004-03-02 11:24:21.000000000 +0100
+++ linux-2.6.4-rc1-bk2.clean/drivers/isdn/hisax/hisax_fcpcipnp.c	2004-03-02 13:46:14.000000000 +0100
@@ -971,10 +971,10 @@
 }
 
 static struct pnp_driver fcpnp_driver = {
-	name:     "fcpnp",
-	probe:    fcpnp_probe,
-	remove:   __devexit_p(fcpnp_remove),
-	id_table: fcpnp_ids,
+	.name		= "fcpnp",
+	.probe		= fcpnp_probe,
+	.remove		= __devexit_p(fcpnp_remove),
+	.id_table	= fcpnp_ids,
 };
 #endif
 
@@ -988,10 +988,10 @@
 }
 
 static struct pci_driver fcpci_driver = {
-	name:     "fcpci",
-	probe:    fcpci_probe,
-	remove:   __devexit_p(fcpci_remove),
-	id_table: fcpci_ids,
+	.name		= "fcpci",
+	.probe		= fcpci_probe,
+	.remove		= __devexit_p(fcpci_remove),
+	.id_table	= fcpci_ids,
 };
 
 static int __init hisax_fcpcipnp_init(void)
diff -ur linux-2.6.4-rc1-bk2.org/drivers/isdn/icn/icn.c linux-2.6.4-rc1-bk2.clean/drivers/isdn/icn/icn.c
--- linux-2.6.4-rc1-bk2.org/drivers/isdn/icn/icn.c	2003-12-18 03:59:59.000000000 +0100
+++ linux-2.6.4-rc1-bk2.clean/drivers/isdn/icn/icn.c	2004-03-02 13:18:59.000000000 +0100
@@ -504,19 +504,19 @@
 		case 3:
 			{
 				char *t = status + 6;
-				char *s = strpbrk(t, ",");
+				char *s = strchr(t, ',');
 
 				*s++ = '\0';
 				strlcpy(cmd.parm.setup.phone, t,
 					sizeof(cmd.parm.setup.phone));
-				s = strpbrk(t = s, ",");
+				s = strchr(t = s, ',');
 				*s++ = '\0';
 				if (!strlen(t))
 					cmd.parm.setup.si1 = 0;
 				else
 					cmd.parm.setup.si1 =
 					    simple_strtoul(t, NULL, 10);
-				s = strpbrk(t = s, ",");
+				s = strchr(t = s, ',');
 				*s++ = '\0';
 				if (!strlen(t))
 					cmd.parm.setup.si2 = 0;
diff -ur linux-2.6.4-rc1-bk2.org/drivers/isdn/isdnloop/isdnloop.c linux-2.6.4-rc1-bk2.clean/drivers/isdn/isdnloop/isdnloop.c
--- linux-2.6.4-rc1-bk2.org/drivers/isdn/isdnloop/isdnloop.c	2003-12-18 03:57:58.000000000 +0100
+++ linux-2.6.4-rc1-bk2.clean/drivers/isdn/isdnloop/isdnloop.c	2004-03-02 13:20:06.000000000 +0100
@@ -122,17 +122,17 @@
 isdnloop_parse_setup(char *setup, isdn_ctrl * cmd)
 {
 	char *t = setup;
-	char *s = strpbrk(t, ",");
+	char *s = strchr(t, ',');
 
 	*s++ = '\0';
 	strlcpy(cmd->parm.setup.phone, t, sizeof(cmd->parm.setup.phone));
-	s = strpbrk(t = s, ",");
+	s = strchr(t = s, ',');
 	*s++ = '\0';
 	if (!strlen(t))
 		cmd->parm.setup.si1 = 0;
 	else
 		cmd->parm.setup.si1 = simple_strtoul(t, NULL, 10);
-	s = strpbrk(t = s, ",");
+	s = strchr(t = s, ',');
 	*s++ = '\0';
 	if (!strlen(t))
 		cmd->parm.setup.si2 = 0;

-- 
Karsten Keil
SuSE Labs
ISDN development
