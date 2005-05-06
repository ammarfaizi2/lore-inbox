Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261166AbVEFLsS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261166AbVEFLsS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 07:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbVEFLsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 07:48:18 -0400
Received: from fire.osdl.org ([65.172.181.4]:37045 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261166AbVEFLsC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 07:48:02 -0400
Date: Fri, 6 May 2005 04:47:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
Cc: aebr@win.tue.nl, hubert.tonneau@fullpliant.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc3 fails to read partition table
Message-Id: <20050506044720.2bb95792.akpm@osdl.org>
In-Reply-To: <20050506111445.GC25418@apps.cwi.nl>
References: <055UDZ711@server5.heliogroup.fr>
	<20050505161610.GA4604@pclin040.win.tue.nl>
	<20050505194342.5ecde856.akpm@osdl.org>
	<20050506111445.GC25418@apps.cwi.nl>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer <Andries.Brouwer@cwi.nl> wrote:
>
> Discussion:

Thanks for that.

> 
> (iv) If I were maintainer of 2.6 - would I revert it?
> 
> Hmm... Not sure... Maybe, yes.
> 

How about the old fallback?


From: Andrew Morton <akpm@osdl.org>

Since early March we've been skipping partitions which have a signature byte
of zero - this was to accomodate an incorrectly manufactured USB stick.

But it broke a few people's setups because it caused device renumbering.

So add a new boot option `msdos_skip_null_part' to enable this workaround.

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 Documentation/kernel-parameters.txt |    6 ++++++
 fs/partitions/msdos.c               |   14 ++++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff -puN fs/partitions/msdos.c~msdos-partitions-null-handling-boot-option fs/partitions/msdos.c
--- 25/fs/partitions/msdos.c~msdos-partitions-null-handling-boot-option	2005-05-06 04:37:32.000000000 -0700
+++ 25-akpm/fs/partitions/msdos.c	2005-05-06 04:46:16.000000000 -0700
@@ -20,6 +20,7 @@
  */
 
 #include <linux/config.h>
+#include <linux/init.h>
 
 #include "check.h"
 #include "msdos.h"
@@ -53,6 +54,15 @@ static inline int is_extended_partition(
 #define MSDOS_LABEL_MAGIC1	0x55
 #define MSDOS_LABEL_MAGIC2	0xAA
 
+static int skip_null_part;
+
+static int __init msdos_skip_null_part(char *str)
+{
+	skip_null_part = 1;
+	return 0;
+}
+__setup("msdos_skip_null_part", msdos_skip_null_part);
+
 static inline int
 msdos_magic_present(unsigned char *p)
 {
@@ -115,7 +125,7 @@ parse_extended(struct parsed_partitions 
 		for (i=0; i<4; i++, p++) {
 			u32 offs, size, next;
 
-			if (SYS_IND(p) == 0)
+			if (skip_null_part && SYS_IND(p) == 0)
 				continue;
 			if (!NR_SECTS(p) || is_extended_partition(p))
 				continue;
@@ -433,7 +443,7 @@ int msdos_partition(struct parsed_partit
 	for (slot = 1 ; slot <= 4 ; slot++, p++) {
 		u32 start = START_SECT(p)*sector_size;
 		u32 size = NR_SECTS(p)*sector_size;
-		if (SYS_IND(p) == 0)
+		if (skip_null_part && SYS_IND(p) == 0)
 			continue;
 		if (!size)
 			continue;
diff -puN Documentation/kernel-parameters.txt~msdos-partitions-null-handling-boot-option Documentation/kernel-parameters.txt
--- 25/Documentation/kernel-parameters.txt~msdos-partitions-null-handling-boot-option	2005-05-06 04:43:52.000000000 -0700
+++ 25-akpm/Documentation/kernel-parameters.txt	2005-05-06 04:45:43.000000000 -0700
@@ -808,6 +808,12 @@ running once the system is up.
 	mpu401=		[HW,OSS]
 			Format: <io>,<irq>
 
+	msdos_skip_null_part
+			Make the MSDOS partition parsing code skip partitions
+			which have a signature of zero.  This can help with
+			mounting some incorrectly manufactured USB memory
+			devices.
+
 	MTD_Partition=	[MTD]
 			Format: <name>,<region-number>,<size>,<offset>
 
_

