Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751644AbVIZPka@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751644AbVIZPka (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 11:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751643AbVIZPka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 11:40:30 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:16795 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751088AbVIZPka (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 11:40:30 -0400
Subject: [PATCH] fixup bogus e820 entry with mem=
From: Dave Hansen <haveblue@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       John Stultz <jstultz@alumni.cmu.edu>, Dale Mosby <k7fw@us.ibm.com>
Content-Type: text/plain
Date: Mon, 26 Sep 2005 08:40:01 -0700
Message-Id: <1127749201.26894.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This was reported because someone was getting oopses
reading /proc/iomem.  It was tracked down to a zero-sized 'struct
resource' entry which was located right at 4GB.  

You need two conditions to hit this bug: a BIOS E820_RAM area starting
at exactly the boundary where you specify mem= (to get a zero-sized
entry), and for the legacy_init_iomem_resources() loop to skip  that
resource (which only happens at exactly 4G).

I think the killing zero-sized e820 entry is the easiest way to fix
this.  

-- Dave

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>

 linux/arch/i386/kernel/setup.c |   24 +++++++++++++++++-------
 1 files changed, 17 insertions(+), 7 deletions(-)

diff -puN arch/i386/kernel/setup.c~e820-empty arch/i386/kernel/setup.c
--- linux.orig/arch/i386/kernel/setup.c~e820-empty	2005-09-13 16:08:40.000000000 -0700
+++ linux/arch/i386/kernel/setup.c	2005-09-13 16:14:20.000000000 -0700
@@ -388,14 +388,24 @@ static void __init limit_regions(unsigne
 		}
 	}
 	for (i = 0; i < e820.nr_map; i++) {
-		if (e820.map[i].type == E820_RAM) {
-			current_addr = e820.map[i].addr + e820.map[i].size;
-			if (current_addr >= size) {
-				e820.map[i].size -= current_addr-size;
-				e820.nr_map = i + 1;
-				return;
-			}
+		current_addr = e820.map[i].addr + e820.map[i].size;
+		if (current_addr < size)
+			continue;
+
+		if (e820.map[i].type != E820_RAM)
+			continue;
+
+		if (e820.map[i].addr >= size) {
+			/*
+			 * This region starts past the end of the
+			 * requested size, skip it completely.
+			 */
+			e820.nr_map = i;
+		} else {
+			e820.nr_map = i + 1;
+			e820.map[i].size -= current_addr - size;
 		}
+		return;
 	}
 }
 
_


