Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272895AbTG3OLY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 10:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272894AbTG3OLL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 10:11:11 -0400
Received: from ifi.informatik.uni-stuttgart.de ([129.69.211.1]:45523 "EHLO
	ifi.informatik.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id S272904AbTG3OIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 10:08:45 -0400
Date: Wed, 30 Jul 2003 16:07:22 +0200
From: "Marcelo E. Magallon" <mmagallo@debian.org>
To: linux-kernel@vgers.kernel.org
Subject: [PATCH] [2.4] AGPGART maximum memory computed incorrectly
Message-ID: <20030730140722.GB9076@informatik.uni-stuttgart.de>
Mail-Followup-To: "Marcelo E. Magallon" <mmagallo@debian.org>,
	linux-kernel@vgers.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux techno 2.4.21-ck1
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 the following patch fixes a problem that shows up on machines with 4GB
 of physical RAM.  The operation num_physpages << PAGE_SHIFT overflows
 and the maximum memory is reported as 0.  Please apply before releasing
 2.4.22.

 Thanks,

 Marcelo

--- linux-2.4.22-pre6-ac1+p4+4gb/drivers/char/agp/agpgart_be.c.orig	2003-07-30 12:26:18.000000000 +0200
+++ linux-2.4.22-pre6-ac1+p4+4gb/drivers/char/agp/agpgart_be.c	2003-07-30 12:29:03.000000000 +0200
@@ -5655,7 +5655,11 @@
 {
 	long memory, index, result;
 
-	memory = (num_physpages << PAGE_SHIFT) >> 20;
+#if PAGE_SHIFT < 20
+	memory = num_physpages >> (20 - PAGE_SHIFT);
+#else
+	memory = num_physpages << (PAGE_SHIFT - 20);
+#endif
 	index = 1;
 
 	while ((memory > maxes_table[index].mem) &&
