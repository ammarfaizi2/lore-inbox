Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751689AbWJELcY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751689AbWJELcY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 07:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751692AbWJELcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 07:32:24 -0400
Received: from mout0.freenet.de ([194.97.50.131]:3274 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S1751688AbWJELcX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 07:32:23 -0400
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [Alsa-devel] [PATCH] Reset file->f_op =?iso-8859-1?q?in=09snd=5Fcard=5Ffile=5Fremove?=(). Take 2
Date: Thu, 5 Oct 2006 13:33:12 +0200
User-Agent: KMail/1.9.4
Cc: mingo@elte.hu, alsa-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
References: <200609282228.02611.annabellesgarden@yahoo.de> <200610050141.47847.annabellesgarden@yahoo.de> <s5hmz8boxeh.wl%tiwai@suse.de>
In-Reply-To: <s5hmz8boxeh.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610051333.12574.annabellesgarden@yahoo.de>
X-Warning: yahoo.de is listed at abuse.rfc-ignorant.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 5. Oktober 2006 12:43 schrieb Takashi Iwai:
> > here is rc1, will test later.
Just posted rc2 to alsa-devel, see also at the end of mail.

> > Feel free to pick it apart ;-)
> 
> Any special reason to make it separate instead of patching init.c?
> Most of codes (e.g. dummy callbacks) are already in init.c.
> 
Maybe there are other usecases for this. Then it'd be easier to move.

> > struct snd_disconnected_file {
> > 	struct file *file;
> > 	int (*release) (struct inode *, struct file *);
> > 	struct snd_disconnected_file *next;
> 
> We can use a standard list here.
struct list_head?
I thought we'd use one pointer less this way.
If there are benefits that outweight one pointer more per instance,
I'll use standard list.

> 
> > };
> > 
> > static struct snd_disconnected_file *disconnecting_files;
> > static struct file_operations snd_disconnect_f_ops;
> > static DEFINE_MUTEX(mutex);
> > 
> > void snd_disconnect_file(struct file *file, int (*release) (struct inode *, struct file *))
> > {
> > 	struct snd_disconnected_file *df, **_dfs;
> > 	df = kmalloc(sizeof(struct snd_disconnected_file), GFP_ATOMIC);
> > 	if (df == NULL)
> > 		panic("Atomic allocation failed for snd_disconnected_file!");
> 
> IIRC, the reason that snd_card_disconnect() uses GFP_ATOMIC is that
> (usb-)disconnection was atomic in the earlier time.
> You're using mutex here, hence no reason to allocate with GFP_ATOMIC.
Ah ok.

> 
> > 	df->file = file;
> > 	df->release = release;
> > 	df->next = NULL;
> > 
> > 	mutex_lock(&mutex);
> > 	_dfs = &disconnecting_files;
> > 	while (*_dfs != NULL)
> > 		_dfs = &(*_dfs)->next;
> > 	*_dfs = df;
> 
> You can add to the item to head :)  The order doesn't matter.
benefit here

> 
> > 	mutex_unlock(&mutex);
> > 
> > 	{
> > 		const struct file_operations *old_f_op = file->f_op;
> > 		fops_get(&snd_disconnect_f_ops);
> > 		file->f_op = &snd_disconnect_f_ops;
> > 		fops_put(old_f_op);
> 
> I wonder whether the old release might be called during this
> operation.  Then df won't be freed.
this looks better in rc2, I hope.

> 
> 
> > static int snd_disconnect_release(struct inode *inode, struct file *file)
> > {
> > 	struct snd_disconnected_file *df, **_dfs, **__dfs;
> > 	int err = 0;
> > 	__dfs = _dfs = &disconnecting_files;
> > 
> > 	mutex_lock(&mutex);
> > 	while ((df = *_dfs))
> > 		if (df->file == file) {
> > 			*__dfs = df->next;
> > 			break;
> > 		} else {
> > 			__dfs = _dfs;
> > 			_dfs = &df->next;
> > 		}
> > 	mutex_unlock(&mutex);
> 
> A standard list would make the code more readable (unless you use too
> many underscores ;)
Will post rc3 :-)

      Karsten


rc2:
-------------------------------------------------------------
snd_disconnected_file, virtual device

On response to "usb disconnect" an usb-soundcard manipulates
that snd_card's file's f_ops to only allow release
by calling this virtual device's 
   void snd_disconnect_file(struct file *file).
After release is actually called, the virtual device instance is freeed.

Signed-off-by: Karsten Wiese <fzu@wemgehoertderstaat.de>


--- alsa-kernel/core/_disconnected.c	2006-10-05 12:16:34.000000000 +0200
+++ alsa-kernel/core/disconnected.c	2006-10-05 11:47:43.000000000 +0200
@@ -0,0 +1,147 @@
+/* virtual device
+   hides a real device's f_ops,
+   exept for release
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
+#include <linux/poll.h>
+#include <linux/module.h>
+
+struct snd_disconnected_file {
+	struct file *file;
+	const struct file_operations *f_op;
+	struct snd_disconnected_file *next;
+};
+
+static struct snd_disconnected_file *disconnecting_files;
+static struct file_operations snd_disconnect_f_ops;
+static DEFINE_MUTEX(mutex);
+
+void snd_disconnect_file(struct file *file)
+{
+	struct snd_disconnected_file *df, **_dfs;
+	df = kmalloc(sizeof(struct snd_disconnected_file), GFP_ATOMIC);
+	if (df == NULL)
+		panic("Atomic allocation failed for snd_disconnected_file!");
+
+	df->file = file;
+	df->f_op = file->f_op;
+	df->next = NULL;
+
+	mutex_lock(&mutex);
+	_dfs = &disconnecting_files;
+	while (*_dfs != NULL)
+		_dfs = &(*_dfs)->next;
+	*_dfs = df;
+	mutex_unlock(&mutex);
+
+	fops_get(&snd_disconnect_f_ops);
+	file->f_op = &snd_disconnect_f_ops;
+	printk(KERN_INFO "%s\n", __FUNCTION__);
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
+	struct snd_disconnected_file *df, **_dfs, **__dfs;
+	int err = 0;
+	__dfs = _dfs = &disconnecting_files;
+
+	mutex_lock(&mutex);
+	while ((df = *_dfs))
+		if (df->file == file) {
+			*__dfs = df->next;
+			break;
+		} else {
+			__dfs = _dfs;
+			_dfs = &df->next;
+		}
+	mutex_unlock(&mutex);
+
+	if (df)	{
+		err = df->f_op->release(inode, file);
+		fops_put(df->f_op);
+		kfree(df);
+		printk(KERN_INFO "%s\n", __FUNCTION__);
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
+/*
+
+ */
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
