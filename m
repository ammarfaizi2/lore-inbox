Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbWGVLI0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbWGVLI0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 07:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbWGVLI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 07:08:26 -0400
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:58202 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1750715AbWGVLIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 07:08:25 -0400
Date: Sat, 22 Jul 2006 13:06:01 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org
Subject: [patch] slab: always follow arch requested alignments
Message-ID: <20060722110601.GA9572@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

In kmem_cache_create(): always check if BYTES_PER_WORD is less than
ARCH_SLAB_MINALIGN and disable debug options that would set the
alignment to BYTES_PER_WORD.
This will make sure that all slab caches will have at least an
ARCH_SLAB_MINALIGN alignment.

In addition make sure that a caller mandated align which is greater
than BYTES_PER_WORD also disables the same debug options.
This makes sure that ARCH_KMALLOC_MINALIGN also has an effect if
CONFIG_DEBUG_SLAB is set.

Cc: Christoph Lameter <clameter@sgi.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 mm/slab.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/slab.c b/mm/slab.c
index 0f20843..1f6fc04 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -2103,12 +2103,18 @@ #endif
 		if (ralign > BYTES_PER_WORD)
 			flags &= ~(SLAB_RED_ZONE | SLAB_STORE_USER);
 	}
+	if (BYTES_PER_WORD < ARCH_SLAB_MINALIGN)
+		flags &= ~(SLAB_RED_ZONE | SLAB_STORE_USER);
+
 	/* 3) caller mandated alignment: disables debug if necessary */
 	if (ralign < align) {
 		ralign = align;
 		if (ralign > BYTES_PER_WORD)
 			flags &= ~(SLAB_RED_ZONE | SLAB_STORE_USER);
 	}
+	if (align > BYTES_PER_WORD)
+		flags &= ~(SLAB_RED_ZONE | SLAB_STORE_USER);
+
 	/*
 	 * 4) Store it. Note that the debug code below can reduce
 	 *    the alignment to BYTES_PER_WORD.
