Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261560AbTHaTTk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 15:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbTHaTTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 15:19:39 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:46608 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP id S261560AbTHaTTi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 15:19:38 -0400
Date: Sun, 31 Aug 2003 20:19:37 +0100
From: John Levon <levon@movementarian.org>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] OProfile: correct CPU type for x86-64
Message-ID: <20030831191937.GA32426@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: King of Woolworths - L'Illustration Musicale
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19tXjd-000HmK-SM*817T4TWH.fw*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Enable the Hammer specific events by giving the correct cpu string.
From, and tested by, Will Cohen.

diff -Naur -X dontdiff linux-cvs/arch/i386/oprofile/nmi_int.c linux-fixes/arch/i386/oprofile/nmi_int.c
--- linux-cvs/arch/i386/oprofile/nmi_int.c	2003-08-29 16:56:24.000000000 +0100
+++ linux-fixes/arch/i386/oprofile/nmi_int.c	2003-08-29 17:02:20.000000000 +0100
@@ -364,10 +364,21 @@
 	switch (vendor) {
 		case X86_VENDOR_AMD:
 			/* Needs to be at least an Athlon (or hammer in 32bit mode) */
-			if (family < 6)
+
+			switch (family) {
+			default:
 				return -ENODEV;
-			model = &op_athlon_spec;
-			nmi_ops.cpu_type = "i386/athlon";
+			case 6:
+				model = &op_athlon_spec;
+				nmi_ops.cpu_type = "i386/athlon";
+				break;
+#if defined(CONFIG_X86_64)
+			case 0xf:
+				model = &op_athlon_spec;
+				nmi_ops.cpu_type = "x86-64/hammer";
+				break;
+#endif /* CONFIG_X86_64 */
+			}
 			break;
  
 #if !defined(CONFIG_X86_64)
