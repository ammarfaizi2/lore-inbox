Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261300AbSI3TDX>; Mon, 30 Sep 2002 15:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261305AbSI3TDX>; Mon, 30 Sep 2002 15:03:23 -0400
Received: from mxall.mxgrp.airmail.net ([209.196.77.98]:31762 "EHLO
	mx1.airmail.net") by vger.kernel.org with ESMTP id <S261300AbSI3TDU>;
	Mon, 30 Sep 2002 15:03:20 -0400
Date: Mon, 30 Sep 2002 14:08:39 -0500
From: Art Haas <ahaas@neosoft.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] vmalloc.c fix for 2.4.20-pre8-ac2
Message-ID: <20020930190839.GA1584@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I noticed this when building 2.4.20-pre8-ac2 ...

gcc -D__KERNEL__ -I/usr/src/linux-2.4.20-pre8-ac2/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i586
-nostdinc -iwithprefix include -DKBUILD_BASENAME=vmalloc  -c -o
vmalloc.o vmalloc.c
vmalloc.c: In function `get_vm_area':
vmalloc.c:182: warning: passing arg 1 of `kfree' makes pointer from
integer without a cast
vmalloc.c:173: warning: `addr' might be used uninitialized in this
function

I peek at vmalloc.c shows what looks to be a typo. The variable
'area' is allocated by kmalloc(), and 'addr' is a local variable
that hasn't been set. Trying to kfree() it would probably be
a bad thing.

Art Haas

--- linux-2.4.20-pre8-ac2/mm/vmalloc.c.ac2	2002-09-30 11:49:32.000000000 -0500
+++ linux-2.4.20-pre8-ac2/mm/vmalloc.c	2002-09-30 13:59:30.000000000 -0500
@@ -179,7 +179,7 @@
 
 	size += PAGE_SIZE;
 	if (!size) {
-		kfree (addr);
+		kfree (area);
 		return NULL;
 	}
 
-- 
They that can give up essential liberty to obtain a little temporary safety
deserve neither liberty nor safety.
 -- Benjamin Franklin, Historical Review of Pennsylvania, 1759
