Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261888AbTEMU63 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 16:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261890AbTEMU63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 16:58:29 -0400
Received: from beppo.feral.com ([192.67.166.79]:1803 "EHLO beppo.feral.com")
	by vger.kernel.org with ESMTP id S261888AbTEMU61 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 16:58:27 -0400
Date: Tue, 13 May 2003 14:11:12 -0700 (PDT)
From: Matthew Jacob <mjacob@feral.com>
X-X-Sender: mjacob@mailhost.quaver.net
Reply-To: mjacob@quaver.net
To: linux-kernel@vger.kernel.org
Subject: [patch] 2.4 fix to allow vmalloc at interrupt time
In-Reply-To: <20030512225654.GA27358@cm.nu>
Message-ID: <20030513140629.I83125@mailhost.quaver.net>
References: <20030512225654.GA27358@cm.nu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This fixes a buglet wrt doing vmalloc at interrupt time for 2.4.

get_vm_area should call kmalloc with GFP_ATOMIC- after all, it's
set up to allow for an allocation failure. As best as I read
the 2.4 code, the rest of the path through _kmem_cache_alloc
should be safe.

===== vmalloc.c 1.15 vs edited =====
--- 1.15/mm/vmalloc.c	Wed Feb 12 05:30:56 2003
+++ edited/vmalloc.c	Fri May  9 23:42:09 2003
@@ -173,7 +173,7 @@
 	unsigned long addr, next;
 	struct vm_struct **p, *tmp, *area;

-	area = (struct vm_struct *) kmalloc(sizeof(*area), GFP_KERNEL);
+	area = (struct vm_struct *) kmalloc(sizeof(*area), GFP_ATOMIC);
 	if (!area)
 		return NULL;

