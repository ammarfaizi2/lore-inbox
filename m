Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261611AbUEVRpg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbUEVRpg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 13:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbUEVRpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 13:45:36 -0400
Received: from hera.cwi.nl ([192.16.191.8]:11246 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261611AbUEVRpd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 13:45:33 -0400
Date: Sat, 22 May 2004 19:45:23 +0200
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>, akpm@osdl.org,
       torvalds@osdl.org
Cc: Andries Brouwer <Andries.Brouwer@cwi.nl>, linux-kernel@vger.kernel.org
Subject: [PATCH] Re: rfc: test whether a device has a partition table
Message-ID: <20040522174523.GA1475@apps.cwi.nl>
References: <16559.14090.6623.563810@hertz.ikp.physik.tu-darmstadt.de> <20040522125633.GA4777@apps.cwi.nl> <16559.28240.860047.83057@hertz.ikp.physik.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16559.28240.860047.83057@hertz.ikp.physik.tu-darmstadt.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 22, 2004 at 05:14:24PM +0200, Uwe Bonnes wrote:

> Yes, the test for 0x80/0 is sufficant.

Good.

> +	  if ( (p->boot_ind != 0x80) &&  (p->boot_ind!= 0x0))
> +	    return 0;

You'll need a "put_dev_sector(sect);" as well. Say,

--- msdos.c~	2003-12-18 03:58:58
+++ msdos.c	2004-05-22 19:38:00
@@ -389,8 +389,23 @@
 		put_dev_sector(sect);
 		return 0;
 	}
+
+	/*
+	 * Now that the 55aa signature is present, this is probably
+	 * either the boot sector of a FAT filesystem or a DOS-type
+	 * partition table. Reject this in case the boot indicator
+	 * is not 0 or 0x80.
+	 */
 	p = (struct partition *) (data + 0x1be);
+	for (slot = 1; slot <= 4; slot++, p++) {
+		if (p->boot_ind != 0 && p->boot_ind != 0x80) {
+			put_dev_sector(sect);
+			return 0;
+		}
+	}
+
 #ifdef CONFIG_EFI_PARTITION
+	p = (struct partition *) (data + 0x1be);
 	for (slot = 1 ; slot <= 4 ; slot++, p++) {
 		/* If this is an EFI GPT disk, msdos should ignore it. */
 		if (SYS_IND(p) == EFI_PMBR_OSTYPE_EFI_GPT) {
@@ -398,8 +413,8 @@
 			return 0;
 		}
 	}
-	p = (struct partition *) (data + 0x1be);
 #endif
+	p = (struct partition *) (data + 0x1be);
 
 	/*
 	 * Look for partitions in two passes:

Andries


[Linus, Andrew - I have no objections against this.]

