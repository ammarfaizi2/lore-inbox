Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265175AbTLROOx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 09:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265182AbTLROOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 09:14:53 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54917 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265175AbTLROOt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 09:14:49 -0500
Date: Thu, 18 Dec 2003 14:14:48 +0000
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: [PATCH] adjust_resource()
Message-ID: <20031218141448.GG15674@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus.

I need something along these lines to cope with some devices on PA-RISC
and Russell also needs something like it for PCMCIA.  What do you think?

diff -urpNX dontdiff linus-2.6/include/linux/ioport.h parisc-2.6/include/linux/ioport.h
--- linus-2.6/include/linux/ioport.h	Thu Dec 18 06:10:09 2003
+++ parisc-2.6/include/linux/ioport.h	Thu Dec 18 05:48:57 2003
@@ -99,6 +99,8 @@ extern int allocate_resource(struct reso
 			     void (*alignf)(void *, struct resource *,
 					    unsigned long, unsigned long),
 			     void *alignf_data);
+int adjust_resource(struct resource *res, unsigned long start,
+		    unsigned long size);
 
 /* Convenience shorthand with allocation */
 #define request_region(start,n,name)	__request_region(&ioport_resource, (start), (n), (name))
diff -urpNX dontdiff linus-2.6/kernel/resource.c parisc-2.6/kernel/resource.c
--- linus-2.6/kernel/resource.c	Thu Dec 18 06:10:10 2003
+++ parisc-2.6/kernel/resource.c	Thu Dec 18 05:48:59 2003
@@ -359,6 +361,49 @@ int insert_resource(struct resource *par
 }
 
 EXPORT_SYMBOL(insert_resource);
+
+/*
+ * Given an existing resource, change its start and size to match the
+ * arguments.  Returns -EBUSY if it can't fit.  Existing children of
+ * the resource are assumed to be immutable.
+ */
+int adjust_resource(struct resource *res, unsigned long start, unsigned long size)
+{
+	struct resource *tmp, *parent = res->parent;
+	unsigned long end = start + size - 1;
+	int result = -EBUSY;
+
+	write_lock(&resource_lock);
+
+	if ((start < parent->start) || (end > parent->end))
+		goto out;
+
+	for (tmp = res->child; tmp; tmp = tmp->sibling) {
+		if ((tmp->start < start) || (tmp->end > end))
+			goto out;
+	}
+
+	if (res->sibling && (res->sibling->start <= end))
+		goto out;
+
+	tmp = parent->child;
+	if (tmp != res) {
+		while (tmp->sibling != res)
+			tmp = tmp->sibling;
+		if (start <= tmp->end)
+			goto out;
+	}
+
+	res->start = start;
+	res->end = end;
+	result = 0;
+
+ out:
+	write_unlock(&resource_lock);
+	return result;
+}
+
+EXPORT_SYMBOL(adjust_resource);
 
 /*
  * This is compatibility stuff for IO resources.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
