Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbTIZMjJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 08:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261780AbTIZMjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 08:39:09 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25301 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261779AbTIZMjF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 08:39:05 -0400
Date: Fri, 26 Sep 2003 13:39:04 +0100
From: Matthew Wilcox <willy@debian.org>
To: linux-kernel@vger.kernel.org
Subject: [RFC] expand_resource()
Message-ID: <20030926123904.GI24824@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We have a situation where we descend through the resource tree and
figure out that firmware has set up the resources wrongly.  This patch
allows us to grow our parent's resource to accommodate our requirements.

I'm looking for feedback at this point, not application, so I've mangled
the patch to make it hard to apply.

diff -u -p -r1.2 resource.c
--- kernel/resource.c   12 Aug 2003 19:11:29 -0000      1.2
+++ kernel/resource.c   26 Sep 2003 02:28:45 -0000
@@ -250,6 +252,62 @@ int allocate_resource(struct resource *r
                err = -EBUSY;
        write_unlock(&resource_lock);
        return err;
+}
+
+/*
+ * Expand an existing resource by size amount.
+ */
+int expand_resource(struct resource *res, unsigned long size,
+                          unsigned long align)
+{
+       unsigned long start, end;
+
+       /* see if we can expand above */
+       end = (res->end + size + align - 1) & ~(align - 1);
+
+       write_lock(&resource_lock);
+       if (res->sibling) {
+               if (res->sibling->start > end)
+                       goto end;
+       } else {
+               if (res->parent->end >= end)
+                       goto end;
+       }
+
+       /* now try below */
+       start = ((res->start - size + align) & ~(align - 1)) - align;
+
+       if (res->parent->child == res) {
+               if (res->start <= start)
+                       goto start;
+       } else {
+               struct resource *prev = res->parent->child;
+               while (prev->sibling != res)
+                       prev = prev->sibling;
+               if (prev->end < start)
+                       goto start;
+       }
+
+       write_unlock(&resource_lock);
+       return -ENOMEM;
+
+ start:
+       res->start = start;
+       write_unlock(&resource_lock);
+       return 0;
+ end:
+       res->end = end;
+       write_unlock(&resource_lock);
+       return 0;
 }


-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
