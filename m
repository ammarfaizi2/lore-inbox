Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750953AbWJEOLA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbWJEOLA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 10:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbWJEOLA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 10:11:00 -0400
Received: from mout2.freenet.de ([194.97.50.155]:13480 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S1750953AbWJEOK7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 10:10:59 -0400
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [Alsa-devel] [PATCH] Reset file->f_op =?iso-8859-1?q?in=09snd=5Fcard=5Ffile=5Fremove?=(). Take 2
Date: Thu, 5 Oct 2006 16:12:07 +0200
User-Agent: KMail/1.9.4
Cc: mingo@elte.hu, alsa-devel@lists.sourceforge.net
References: <200609282228.02611.annabellesgarden@yahoo.de> <s5hmz8boxeh.wl%tiwai@suse.de> <200610051333.12574.annabellesgarden@yahoo.de>
In-Reply-To: <200610051333.12574.annabellesgarden@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610051612.07770.annabellesgarden@yahoo.de>
X-Warning: yahoo.de is listed at abuse.rfc-ignorant.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

here is rc3.

Anything to fix?

We've lots of things disconnectable...
Is this useful in the kernel global?

      Karsten

rc3:
---------------------------------------------------------------------------
snd_disconnected_file, virtual device

On response to "usb disconnect" an usb-soundcard manipulates
that snd_card's file's f_ops to only allow release
by calling this virtual device's 
   void snd_disconnect_file(struct file *file).
After release is actually called, the virtual device instance is freeed.

Signed-off-by: Karsten Wiese <fzu@wemgehoertderstaat.de>


--- alsa-kernel/core/_disconnected.c	2006-10-05 12:16:34.000000000 +0200
+++ alsa-kernel/core/disconnected.c	2006-10-05 15:15:06.000000000 +0200
@@ -0,0 +1,141 @@
+/* virtual device
+   hides a real device's f_ops,
+   except for release
+
+ *  Copyright (c) by Karsten Wiese <fzu@wemgehoertderstaat.de>
+ *
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ */
+
+
+#include <linux/fs.h>
+#include <linux/list.h>
+#include <linux/poll.h>
+#include <linux/module.h>
+
+static DEFINE_MUTEX(mutex);
+static LIST_HEAD(disconnected_files);
+
+struct snd_disconnected_file {
+	struct file *file;
+	const struct file_operations *f_op;
+	struct list_head list;
+};
+
+static struct file_operations snd_disconnect_f_ops;
+
+void snd_disconnect_file(struct file *file)
+{
+	struct snd_disconnected_file *df;
+	df = kmalloc(sizeof(struct snd_disconnected_file), GFP_KERNEL);
+	if (df == NULL)
+		panic("Atomic allocation failed for snd_disconnected_file!");
+
+	df->file = file;
+	df->f_op = file->f_op;
+
+	mutex_lock(&mutex);
+	list_add(&df->list, &disconnected_files);
+	mutex_unlock(&mutex);
+
+	fops_get(&snd_disconnect_f_ops);
+	file->f_op = &snd_disconnect_f_ops;
+	printk(KERN_INFO "%s rc3\n", __FUNCTION__);
+}
+
+
+static loff_t snd_disconnect_llseek(struct file *file, loff_t offset, int orig)
+{
+	return -ENODEV;
+}
+
+static ssize_t snd_disconnect_read(struct file *file, char __user *buf,
+				   size_t count, loff_t *offset)
+{
+	return -ENODEV;
+}
+
+static ssize_t snd_disconnect_write(struct file *file, const char __user *buf,
+				    size_t count, loff_t *offset)
+{
+	return -ENODEV;
+}
+
+static int snd_disconnect_release(struct inode *inode, struct file *file)
+{
+	struct snd_disconnected_file *df = NULL;
+	struct list_head *entry;
+
+	mutex_lock(&mutex);
+	list_for_each(entry, &disconnected_files) {
+		struct snd_disconnected_file *_df;
+		_df = list_entry(entry, struct snd_disconnected_file, list);
+		if (_df->file == file) {
+			list_del(entry);
+			df = _df;
+			break;
+		}
+	}
+	mutex_unlock(&mutex);
+
+	if (likely(df != NULL))	{
+		int err = df->f_op->release(inode, file);
+		fops_put(df->f_op);
+		kfree(df);
+		printk(KERN_INFO "%s rc3\n", __FUNCTION__);
+		return err;
+	}
+
+	panic("%s(%p, %p) failed!", __FUNCTION__, inode, file);
+}
+
+static unsigned int snd_disconnect_poll(struct file * file, poll_table * wait)
+{
+	return POLLERR | POLLNVAL;
+}
+
+static long snd_disconnect_ioctl(struct file *file,
+				 unsigned int cmd, unsigned long arg)
+{
+	return -ENODEV;
+}
+
+static int snd_disconnect_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	return -ENODEV;
+}
+
+static int snd_disconnect_fasync(int fd, struct file *file, int on)
+{
+	return -ENODEV;
+}
+
+static struct file_operations snd_disconnect_f_ops =
+{
+	.owner = 	THIS_MODULE,
+	.llseek =	snd_disconnect_llseek,
+	.read = 	snd_disconnect_read,
+	.write =	snd_disconnect_write,
+	.release =	snd_disconnect_release,
+	.poll =		snd_disconnect_poll,
+	.unlocked_ioctl = snd_disconnect_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl = snd_disconnect_ioctl,
+#endif
+	.mmap =		snd_disconnect_mmap,
+	.fasync =	snd_disconnect_fasync
+};
