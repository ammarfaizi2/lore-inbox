Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965073AbWHULhy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965073AbWHULhy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 07:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965066AbWHULhy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 07:37:54 -0400
Received: from exprod6og54.obsmtp.com ([64.18.1.189]:52414 "HELO
	exprod6og54.obsmtp.com") by vger.kernel.org with SMTP
	id S965073AbWHULhx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 07:37:53 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: Two "bugletts" on SPARC 64 @ kernel 2.4
Date: Mon, 21 Aug 2006 13:37:51 +0200
Message-ID: <DA6197CAE190A847B662079EF7631C060156928D@OEKAW2EXVS03.hbi.ad.harman.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Two "bugletts" on SPARC 64 @ kernel 2.4
Thread-Index: AcbFFj0VGIISFjhRQiyQ4e+I/Kr4rw==
From: "Jurzitza, Dieter" <DJurzitza@harmanbecker.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 21 Aug 2006 11:37:51.0914 (UTC) 
    FILETIME=[3C5A48A0:01C6C516]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear listmembers,
please find attached two small patches against kernel 2.4.33 for (at least) SPARC 64:

--- linux/include/linux/module.h	2004-12-15 08:34:44.000000000 +0100
+++ linux/include/linux/module.h	2004-12-15 08:45:32.000000000 +0100
@@ -31,7 +31,11 @@
 /* Used by get_kernel_syms, which is obsolete.  */
 struct kernel_sym
 {
-	unsigned long value;
+#ifdef __ARCH_SPARC64_ATOMIC__
+	  unsigned int value;
+#else
+          unsigned long value;
+#endif
 	char name[60];		/* should have been 64-sizeof(long); oh well */
 };
 
--- linux/arch/sparc64/kernel/sparc64_ksyms.c.original	2005-11-16 20:12:54.000000000 +0100
+++ linux/arch/sparc64/kernel/sparc64_ksyms.c	2006-08-14 12:55:48.000000000 +0200
@@ -357,6 +357,7 @@
 EXPORT_SYMBOL_NOVERS(__ret_efault);
 
 /* No version information on these, as gcc produces such symbols. */
+EXPORT_SYMBOL_NOVERS(memchr);
 EXPORT_SYMBOL_NOVERS(memcmp);
 EXPORT_SYMBOL_NOVERS(memcpy);
 EXPORT_SYMBOL_NOVERS(memset);
--- linux/arch/sparc/kernel/sparc_ksyms.c.original	2006-08-14 12:59:04.000000000 +0200
+++ linux/arch/sparc/kernel/sparc_ksyms.c	2006-08-14 12:59:04.000000000 +0200
@@ -293,6 +293,7 @@
 EXPORT_SYMBOL_NOVERS(__ret_efault);
 
 /* No version information on these, as gcc produces such symbols. */
+EXPORT_SYMBOL_NOVERS(memchr);
 EXPORT_SYMBOL_NOVERS(memcmp);
 EXPORT_SYMBOL_NOVERS(memcpy);
 EXPORT_SYMBOL_NOVERS(memset);


1.) due to the fact that sizeof(unsigned long) is larger on SPARC 64 (8 byte vs. 4 byte) than on some other architectures, the size of the structure kernel_sym grows accordingly. This results in the fact that on SPARC 64 less many kernel syms may be read by get_kernel_syms() than on other architectures due to the limitation in memory available. On 32-bit arches sizeof(kernel_sym) is 64. On SPARC64 it is initially 68, due to the need for word alignment we end up at 72 Byte per struct. Therefore we can read 2048 structs of type kernel_sym on x32 in contrast to only 1820 structs on SPARC64. The define shown above replacing the unsigned long by an unsigned int in case of SPARC64 fixes this (without any harm).

2.) with kernel 2.4.33 the call to memcpy has been introduced in the smbfs-module. Because there is no native function for this on SPARC, one needs to EXPORT_SYM_NOVERS for this (TX to Dave Miller who helped me finding this out). To avoid unneccessary questions on this issue the patch above is mentioned.

Take care



Dieter Jurzitza


-- 
________________________________________________

HARMAN BECKER AUTOMOTIVE SYSTEMS

Dr.-Ing. Dieter Jurzitza
Manager Hardware Systems
   System Development

Industriegebiet Ittersbach
Becker-Göring Str. 16
D-76307 Karlsbad / Germany

Phone: +49 (0)7248 71-1577
Fax:   +49 (0)7248 71-1216
eMail: DJurzitza@harmanbecker.com
Internet: http://www.becker.de
 


*******************************************
Diese E-Mail enthaelt vertrauliche und/oder rechtlich geschuetzte Informationen. Wenn Sie nicht der richtige Adressat sind oder diese E-Mail irrtuemlich erhalten haben, informieren Sie bitte sofort den Absender und loeschen Sie diese Mail. Das unerlaubte Kopieren sowie die unbefugte Weitergabe dieser Mail ist nicht gestattet.
 
This e-mail may contain confidential and/or privileged information. If you are not the intended recipient (or have received this e-mail in error) please notify the sender immediately and delete this e-mail. Any unauthorized copying, disclosure or distribution of the contents in this e-mail is strictly forbidden.
*******************************************

