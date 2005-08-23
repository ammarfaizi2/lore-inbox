Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932372AbVHWUZ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372AbVHWUZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 16:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932373AbVHWUZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 16:25:29 -0400
Received: from smtp2.rz.tu-harburg.de ([134.28.205.13]:35941 "EHLO
	smtp2.rz.tu-harburg.de") by vger.kernel.org with ESMTP
	id S932372AbVHWUZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 16:25:28 -0400
Message-ID: <430B862A.4000009@tu-harburg.de>
Date: Tue, 23 Aug 2005 22:25:14 +0200
From: Jan Blunck <j.blunck@tu-harburg.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Ingo Oeser <ioe-lkml@rameria.de>
CC: linux-scsi@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sg.c: fix a memory leak in devices seq_file implementation
 (2nd)
References: <4305D040.1050301@tu-harburg.de> <200508232057.50334.ioe-lkml@rameria.de>
In-Reply-To: <200508232057.50334.ioe-lkml@rameria.de>
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/mixed;
 boundary="------------050507080302090903010609"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050507080302090903010609
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Ingo Oeser schrieb:
> 
> kfree() checks its argument, so instead of
> 
> if (pointer)
> 	kfree(pointer);
> 
> just do
> 
> kfree(pointer);
> 

This is an updated patch. Removed the unnecessary if.

Signed-off-by: Jan Blunck <j.blunck@tu-harburg.de>


--------------050507080302090903010609
Content-Type: text/x-patch;
 name="scsi_sg.c-dev_seq_file-fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="scsi_sg.c-dev_seq_file-fix.diff"

 drivers/scsi/sg.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

Index: linux-2.6/drivers/scsi/sg.c
===================================================================
--- linux-2.6.orig/drivers/scsi/sg.c
+++ linux-2.6/drivers/scsi/sg.c
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
@@ -2995,7 +2994,9 @@ static void * dev_seq_next(struct seq_fi
 
 static void dev_seq_stop(struct seq_file *s, void *v)
 {
-	kfree (v);
+	struct sg_proc_deviter * it = s->private;
+
+	kfree (it);
 }
 
 static int sg_proc_open_dev(struct inode *inode, struct file *file)

--------------050507080302090903010609--
