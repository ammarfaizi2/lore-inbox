Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbUAMAp6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 19:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262652AbUAMAp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 19:45:58 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:20370 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262598AbUAMAp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 19:45:56 -0500
Subject: Re: [PATCH] Intel Alder IOAPIC fix
From: James Bottomley <James.Bottomley@steeleye.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0401121452340.2031@evo.osdl.org>
References: <1073876117.2549.65.camel@mulgrave> 
	<Pine.LNX.4.58.0401121152070.1901@evo.osdl.org>
	<1073948641.4178.76.camel@mulgrave> 
	<Pine.LNX.4.58.0401121452340.2031@evo.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 12 Jan 2004 19:45:50 -0500
Message-Id: <1073954751.4178.98.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, with the patch below (to insert_resource) I know get the IO APIC
successfully inserted under the reserved fixmap resources:

/proc/iomem still looks very odd:

fec00000-fec08fff : reserved
  fec01000-fec013ff : 0000:00:0f.0
fffffc00-ffffffff : 0000:00:0f.0
  fffffc00-ffffffff : 0000:00:0f.0
    fffffc00-ffffffff : 0000:00:0f.0
      fffffc00-ffffffff : 0000:00:0f.0
        fffffc00-ffffffff : 0000:00:0f.0
          ffe80000-ffffffff : reserved

unfortunately, because BARs 1-5 cover the same region.

I also think insert_resource needs to be fixed to insert these resources
*under* the reserved resource, since it's larger than they are.

I can make these changes and send them to you, if you think this is the
correct thing to do?

James

===== kernel/resource.c 1.18 vs edited =====
--- 1.18/kernel/resource.c	Wed Nov 19 01:40:49 2003
+++ edited/kernel/resource.c	Mon Jan 12 18:34:00 2004
@@ -318,6 +318,7 @@
 	struct resource *first, *next;
 
 	write_lock(&resource_lock);
+ begin:
 	first = __request_resource(parent, new);
 	if (!first)
 		goto out;
@@ -331,8 +332,10 @@
 			break;
 
 	/* existing resource overlaps end of new resource */
-	if (next->end > new->end)
-		goto out;
+	if (next->end > new->end) {
+		parent = next;
+		goto begin;
+	}
 
 	result = 0;
 

