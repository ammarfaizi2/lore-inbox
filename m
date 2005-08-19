Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932197AbVHWPRV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbVHWPRV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 11:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbVHWPRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 11:17:20 -0400
Received: from smtp2.rz.tu-harburg.de ([134.28.205.13]:2852 "EHLO
	smtp2.rz.tu-harburg.de") by vger.kernel.org with ESMTP
	id S932197AbVHWPRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 11:17:17 -0400
Message-ID: <4305D040.1050301@tu-harburg.de>
Date: Fri, 19 Aug 2005 14:27:44 +0200
From: Jan Blunck <j.blunck@tu-harburg.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: linux-scsi@vger.kernel.org
CC: Andrew Morton <akpm@osdl.org>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] sg.c: fix a memory leak in devices seq_file implementation
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/mixed;
 boundary="------------040904050300090802050903"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040904050300090802050903
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

I know that scsi procfs is legacy code but this is a fix for a memory leak.

While reading through sg.c I realized that the implementation of
/proc/scsi/sg/devices with seq_file is leaking memory due to freeing the
pointer returned by the next() iterator method. Since next() might
return NULL or an error this is wrong. This patch fixes it through using
the seq_files private field for holding the reference to the iterator
object.

Here is a small bash script to trigger the leak. Use slabtop to watch
the size-32 usage grow and grow.

[--snipp--]
#!/bin/sh

while true; do
	cat /proc/scsi/sg/devices > /dev/null
done

[--snipp--]

Signed-off-by: Jan Blunck <j.blunck@tu-harburg.de>


--------------040904050300090802050903
Content-Type: text/x-patch;
 name="scsi_sg.c-dev_seq_file-fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="scsi_sg.c-dev_seq_file-fix.diff"

 drivers/scsi/sg.c |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

Index: experimental-jb/drivers/scsi/sg.c
===================================================================
--- experimental-jb.orig/drivers/scsi/sg.c
+++ experimental-jb/drivers/scsi/sg.c
@@ -2971,23 +2971,22 @@ static void * dev_seq_start(struct seq_f
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
@@ -2995,7 +2994,10 @@ static void * dev_seq_next(struct seq_fi
 
 static void dev_seq_stop(struct seq_file *s, void *v)
 {
-	kfree (v);
+	struct sg_proc_deviter *it = s->private;
+
+	if (it)
+		kfree (it);
 }
 
 static int sg_proc_open_dev(struct inode *inode, struct file *file)

--------------040904050300090802050903--

