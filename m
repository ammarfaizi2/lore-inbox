Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964920AbWDMOQj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964920AbWDMOQj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 10:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964922AbWDMOQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 10:16:39 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:27312 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S964920AbWDMOQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 10:16:38 -0400
Date: Thu, 13 Apr 2006 16:16:31 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: [PATCH] Improve parameter parsing for block2mtd
Message-ID: <20060413141631.GB30574@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Expand the parameter parsing for block2mtd.  It now accepts:
Ki, Mi, Gi	- the official prefixes for binary multiples,
		  see http://physics.nist.gov/cuu/Units/binary.html,
ki		- mistake on my side and analog to "k" for decimal multiples,
KiB, MiB, GiB	- for people that prefer to add a "B" for byte,
kiB		- combination of the above.

There were complaints about not accepting "k" for 1024.  This has long
been common practice, but is known to lead to confusion.  Hence the new
SI units and hence block2mtd only accepts units that cannot be confused
with decimal units.  Diverging from common practice doesn't always please
people, even if the change is for the better.

Signed-off-by: Jörn Engel <joern@wohnheim.fh-wedel.de>
---

 drivers/mtd/devices/block2mtd.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--- block2mtd/drivers/mtd/devices/block2mtd.c~block2mtd_interface	2006-04-04 10:55:45.000000000 +0200
+++ block2mtd/drivers/mtd/devices/block2mtd.c	2006-04-12 13:58:53.000000000 +0200
@@ -4,7 +4,7 @@
  * block2mtd.c - create an mtd from a block device
  *
  * Copyright (C) 2001,2002	Simon Evans <spse@secret.org.uk>
- * Copyright (C) 2004,2005	Jörn Engel <joern@wh.fh-wedel.de>
+ * Copyright (C) 2004-2006	Jörn Engel <joern@wh.fh-wedel.de>
  *
  * Licence: GPL
  */
@@ -351,6 +351,12 @@ devinit_err:
 }
 
 
+/* This function works similar to reguler strtoul.  In addition, it
+ * allows some suffixes for a more human-readable number format:
+ * ki, Ki, kiB, KiB	- multiply result with 1024
+ * Mi, MiB		- multiply result with 1024^2
+ * Gi, GiB		- multiply result with 1024^3
+ */
 static int ustrtoul(const char *cp, char **endp, unsigned int base)
 {
 	unsigned long result = simple_strtoul(cp, endp, base);
@@ -359,11 +365,15 @@ static int ustrtoul(const char *cp, char
 		result *= 1024;
 	case 'M':
 		result *= 1024;
+	case 'K':
 	case 'k':
 		result *= 1024;
 	/* By dwmw2 editorial decree, "ki", "Mi" or "Gi" are to be used. */
 		if ((*endp)[1] == 'i')
-			(*endp) += 2;
+			if ((*endp)[2] == 'B')
+				(*endp) += 3;
+			else
+				(*endp) += 2;
 	}
 	return result;
 }
