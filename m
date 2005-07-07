Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261369AbVGGVJK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbVGGVJK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 17:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261393AbVGGVJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 17:09:10 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:32746 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261369AbVGGVJC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 17:09:02 -0400
Message-Id: <200507072108.j67L8v4v031436@d01av03.pok.ibm.com>
Subject: [PATCH 1/1] cdev: cdev_put oops
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       brking@us.ibm.com
From: brking@us.ibm.com
Date: Thu, 07 Jul 2005 16:08:56 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


While fixing an oops in the st driver in a dirty release path,
I encountered an oops in cdev_put for cdevs allocated using
cdev_alloc. If cdev_del is called when the cdev kobject still
has an open user, when the last cdev_put is called, the cdev_put
will call kobject_put, which will end up ultimately releasing the cdev
in cdev_dynamic_release. Patch fixes the oops by preventing cdev_put
from accessing freed memory.

Signed-off-by: Brian King <brking@us.ibm.com>
---

 linux-2.6-bjking1/fs/char_dev.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)

diff -puN fs/char_dev.c~cdev_put_oops fs/char_dev.c
--- linux-2.6/fs/char_dev.c~cdev_put_oops	2005-07-07 08:20:09.000000000 -0500
+++ linux-2.6-bjking1/fs/char_dev.c	2005-07-07 08:20:09.000000000 -0500
@@ -276,9 +276,12 @@ static struct kobject *cdev_get(struct c
 
 void cdev_put(struct cdev *p)
 {
+	struct module *owner;
+
 	if (p) {
+		owner = p->owner;
 		kobject_put(&p->kobj);
-		module_put(p->owner);
+		module_put(owner);
 	}
 }
 
_
