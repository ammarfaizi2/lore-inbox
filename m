Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422913AbWJaICl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422913AbWJaICl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 03:02:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422918AbWJaICl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 03:02:41 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:36952 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1422913AbWJaICj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 03:02:39 -0500
Date: Tue, 31 Oct 2006 09:03:08 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Andy Whitcroft <apw@shadowen.org>, Martin Bligh <mbligh@google.com>,
       Andrew Morton <akpm@osdl.org>, Steve Fox <drfickle@us.ibm.com>
Subject: Re: 2.6.19-rc3-mm1 -- missing network adaptors
Message-ID: <20061031090308.1435295a@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <20061030211432.6ed62405@gondolin.boeblingen.de.ibm.com>
References: <20061029160002.29bb2ea1.akpm@osdl.org>
	<45461977.3020201@shadowen.org>
	<45461E74.1040408@google.com>
	<20061030084722.ea834a08.akpm@osdl.org>
	<454631C1.5010003@google.com>
	<45463481.80601@shadowen.org>
	<20061030211432.6ed62405@gondolin.boeblingen.de.ibm.com>
X-Mailer: Sylpheed-Claws 2.5.6 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2006 21:14:32 +0100,
Cornelia Huck <cornelia.huck@de.ibm.com> wrote:

> With CONFIG_SYSFS_DEPRECATED set, you'll get errors for devices which
> have no parent set. The kobject's parent is set to the class
> subsystem's kobject, meaning there is a child with name bus_id (e.
> g. /sys/class/net/lo). Unfortunately, we also try to create a link
> named bus_id in /sys/class/<foo>, which will fail with -EEXIST... We
> should probably drop that link if we have no parent.

You can use the following as a band-aid (everything looks sane on my
system), although you will still have problems if your setup tools
can't cope with symlinks :/ (a link is still created for devices with
real parents).

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

---
 drivers/base/core.c |   19 ++++++++++++++-----
 1 files changed, 14 insertions(+), 5 deletions(-)

--- linux-2.6-CH.orig/drivers/base/core.c
+++ linux-2.6-CH/drivers/base/core.c
@@ -368,6 +368,12 @@ static void klist_children_put(struct kl
 static int device_add_class_symlinks(struct device *dev)
 {
 	int error;
+	int create_link =
+#ifdef CONFIG_SYSFS_DEPRECATED
+		dev->parent ? 1 : 0;
+#else
+	1;
+#endif
 
 	if (!dev->class)
 		return 0;
@@ -375,10 +381,12 @@ static int device_add_class_symlinks(str
 				  "subsystem");
 	if (error)
 		goto out;
-	error = sysfs_create_link(&dev->class->subsys.kset.kobj, &dev->kobj,
-				  dev->bus_id);
-	if (error)
-		goto out_subsys;
+	if (create_link) {
+		error = sysfs_create_link(&dev->class->subsys.kset.kobj,
+					  &dev->kobj, dev->bus_id);
+		if (error)
+			goto out_subsys;
+	}
 #ifdef CONFIG_SYSFS_DEPRECATED
 	if (dev->parent) {
 		char *class_name;
@@ -407,7 +415,8 @@ out_device:
 		sysfs_remove_link(&dev->kobj, "device");
 out_busid:
 #endif
-	sysfs_remove_link(&dev->class->subsys.kset.kobj, dev->bus_id);
+	if (create_link)
+		sysfs_remove_link(&dev->class->subsys.kset.kobj, dev->bus_id);
 out_subsys:
 	sysfs_remove_link(&dev->kobj, "subsystem");
 out:
