Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262434AbUEQVzX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262434AbUEQVzX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 17:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262438AbUEQVzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 17:55:23 -0400
Received: from fw.osdl.org ([65.172.181.6]:22422 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262434AbUEQVzS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 17:55:18 -0400
Date: Mon, 17 May 2004 14:46:03 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, jejb <james.bottomley@steeleye.com>
Subject: [PATCH] init. mca_bus_type even if !MCA_bus
Message-Id: <20040517144603.1c63895f.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


// Linux 2.6.6
// need to call mca_system_init() to register MCA bus struct,
// otherwise find_mca_adapter() oopses with a NULL ptr.
// Fixes this oops reported last week:
//	http://marc.theaimsgroup.com/?l=linux-kernel&m=108455738606747&w=2
// Thanks to James Bottomley for pointing this out.

diffstat:=
 arch/i386/kernel/mca.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)


diff -Naurp ./arch/i386/kernel/mca.c~check_mca_bus ./arch/i386/kernel/mca.c
--- ./arch/i386/kernel/mca.c~check_mca_bus	2004-05-09 19:33:05.000000000 -0700
+++ ./arch/i386/kernel/mca.c	2004-05-17 14:50:32.000000000 -0700
@@ -258,16 +258,16 @@ static int __init mca_init(void)
 
 	/* Make sure the MCA bus is present */
 
-	if(!MCA_bus)
-		return -ENODEV;
-
-	printk(KERN_INFO "Micro Channel bus detected.\n");
-
-	if(mca_system_init()) {
+	if (mca_system_init()) {
 		printk(KERN_ERR "MCA bus system initialisation failed\n");
 		return -ENODEV;
 	}
 
+	if (!MCA_bus)
+		return -ENODEV;
+
+	printk(KERN_INFO "Micro Channel bus detected.\n");
+
 	/* All MCA systems have at least a primary bus */
 	bus = mca_attach_bus(MCA_PRIMARY_BUS);
 	if (!bus)


--
~Randy
