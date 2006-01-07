Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030427AbWAGMmH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030427AbWAGMmH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 07:42:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030428AbWAGMmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 07:42:07 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:58839 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030427AbWAGMmF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 07:42:05 -0500
Date: Sat, 7 Jan 2006 13:42:10 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] sound: remove BKL from sound/core/info.c
Message-ID: <20060107124210.GA24601@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

remove the final instance of BKL use within the sound code, by converting
snd_info_entry_ioctl to an unlocked ioctl. It is obviously safe, because
the sound code already dropped the BKL in this function.

built and booted on x86.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

 sound/core/info.c |   33 +++++++++++----------------------
 1 files changed, 11 insertions(+), 22 deletions(-)

Index: linux/sound/core/info.c
===================================================================
--- linux.orig/sound/core/info.c
+++ linux/sound/core/info.c
@@ -444,8 +444,8 @@ static unsigned int snd_info_entry_poll(
 	return mask;
 }
 
-static inline int _snd_info_entry_ioctl(struct inode *inode, struct file *file,
-					unsigned int cmd, unsigned long arg)
+static long snd_info_entry_ioctl(struct file *file, unsigned int cmd,
+				unsigned long arg)
 {
 	struct snd_info_private_data *data;
 	struct snd_info_entry *entry;
@@ -465,17 +465,6 @@ static inline int _snd_info_entry_ioctl(
 	return -ENOTTY;
 }
 
-/* FIXME: need to unlock BKL to allow preemption */
-static int snd_info_entry_ioctl(struct inode *inode, struct file *file,
-				unsigned int cmd, unsigned long arg)
-{
-	int err;
-	unlock_kernel();
-	err = _snd_info_entry_ioctl(inode, file, cmd, arg);
-	lock_kernel();
-	return err;
-}
-
 static int snd_info_entry_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct inode *inode = file->f_dentry->d_inode;
@@ -499,15 +488,15 @@ static int snd_info_entry_mmap(struct fi
 
 static struct file_operations snd_info_entry_operations =
 {
-	.owner =	THIS_MODULE,
-	.llseek =	snd_info_entry_llseek,
-	.read =		snd_info_entry_read,
-	.write =	snd_info_entry_write,
-	.poll =		snd_info_entry_poll,
-	.ioctl =	snd_info_entry_ioctl,
-	.mmap =		snd_info_entry_mmap,
-	.open =		snd_info_entry_open,
-	.release =	snd_info_entry_release,
+	.owner =		THIS_MODULE,
+	.llseek =		snd_info_entry_llseek,
+	.read =			snd_info_entry_read,
+	.write =		snd_info_entry_write,
+	.poll =			snd_info_entry_poll,
+	.unlocked_ioctl =	snd_info_entry_ioctl,
+	.mmap =			snd_info_entry_mmap,
+	.open =			snd_info_entry_open,
+	.release =		snd_info_entry_release,
 };
 
 /**
