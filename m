Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262845AbVG3BdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262845AbVG3BdY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 21:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262745AbVG2TSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 15:18:21 -0400
Received: from mail.kroah.org ([69.55.234.183]:17071 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262661AbVG2TRA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 15:17:00 -0400
Date: Fri, 29 Jul 2005 12:16:17 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, jonsmirl@gmail.com
Subject: [patch 14/29] PCI: Adjust PCI rom code to handle more broken ROMs
Message-ID: <20050729191617.GP5095@kroah.com>
References: <20050729184950.014589000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050729191255.GA5095@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jon Smirl <jonsmirl@gmail.com>

There are ROMs reporting that their size exceeds their PCI ROM
resource window. This patch returns the minimum of the resource window
size or the size in the ROM.  An example of this breakage is the XGI
Volari Z7.

Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/pci/rom.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

--- gregkh-2.6.orig/drivers/pci/rom.c	2005-07-29 11:29:50.000000000 -0700
+++ gregkh-2.6/drivers/pci/rom.c	2005-07-29 11:36:22.000000000 -0700
@@ -125,7 +125,9 @@
 		image += readw(pds + 16) * 512;
 	} while (!last_image);
 
-	*size = image - rom;
+	/* never return a size larger than the PCI resource window */
+	/* there are known ROMs that get the size wrong */
+	*size = min((size_t)(image - rom), *size);
 
 	return rom;
 }

--
