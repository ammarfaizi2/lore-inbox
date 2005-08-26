Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030215AbVHZTYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030215AbVHZTYY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 15:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030223AbVHZTYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 15:24:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10967 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030215AbVHZTYS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 15:24:18 -0400
Message-Id: <20050826191942.444423000@localhost.localdomain>
References: <20050826191755.052951000@localhost.localdomain>
Date: Fri, 26 Aug 2005 12:18:01 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       Ingo Oeser <ioe-lkml@rameria.de>
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, linux-scsi@vger.kernel.org,
       Jan Blunck <j.blunck@tu-harburg.de>, Chris Wright <chrisw@osdl.org>
Subject: [PATCH 6/7] [PATCH] sg.c: fix a memory leak in devices seq_file implementation (2nd)
Content-Disposition: inline; filename=fix-memory-leak-in-sg.c-seq_file.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any  objections, please let us know.
------------------

I know that scsi procfs is legacy code but this is a fix for a memory leak.

While reading through sg.c I realized that the implementation of
/proc/scsi/sg/devices with seq_file is leaking memory due to freeing the
pointer returned by the next() iterator method. Since next() might
return NULL or an error this is wrong. This patch fixes it through using
the seq_files private field for holding the reference to the iterator
object.

Here is a small bash script to trigger the leak. Use slabtop to watch
the size-32 usage grow and grow.

#!/bin/sh

while true; do
	cat /proc/scsi/sg/devices > /dev/null
done

Signed-off-by: Jan Blunck <j.blunck@tu-harburg.de>
Signed-off-by: Chris Wright <chrisw@osdl.org>
---
 drivers/scsi/sg.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

Index: linux-2.6.12.y/drivers/scsi/sg.c
===================================================================
--- linux-2.6.12.y.orig/drivers/scsi/sg.c
+++ linux-2.6.12.y/drivers/scsi/sg.c
@@ -2969,23 +2969,22 @@ static void * dev_seq_start(struct seq_f
 {
 	struct sg_proc_deviter * it = kmalloc(sizeof(*it), GFP_KERNEL);
 
+	s->private = it;
 	if (! it)
 		return NULL;
+
 	if (NULL == sg_dev_arr)
-		goto err1;
+		return NULL;
 	it->index = *pos;
 	it->max = sg_last_dev();
 	if (it->index >= it->max)
-		goto err1;
+		return NULL;
 	return it;
-err1:
-	kfree(it);
-	return NULL;
 }
 
 static void * dev_seq_next(struct seq_file *s, void *v, loff_t *pos)
 {
-	struct sg_proc_deviter * it = (struct sg_proc_deviter *) v;
+	struct sg_proc_deviter * it = s->private;
 
 	*pos = ++it->index;
 	return (it->index < it->max) ? it : NULL;
@@ -2993,7 +2992,9 @@ static void * dev_seq_next(struct seq_fi
 
 static void dev_seq_stop(struct seq_file *s, void *v)
 {
-	kfree (v);
+	struct sg_proc_deviter * it = s->private;
+
+	kfree (it);
 }
 
 static int sg_proc_open_dev(struct inode *inode, struct file *file)

--
