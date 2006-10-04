Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751198AbWJDXkk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbWJDXkk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 19:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbWJDXkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 19:40:40 -0400
Received: from mout1.freenet.de ([194.97.50.132]:32681 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S1751198AbWJDXkj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 19:40:39 -0400
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH] Reset file->f_op in snd_card_file_remove(). Take 2
Date: Thu, 5 Oct 2006 01:41:47 +0200
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net,
       mingo@elte.hu
References: <200609282228.02611.annabellesgarden@yahoo.de> <200610042201.53337.annabellesgarden@yahoo.de> <s5hvemzq1lg.wl%tiwai@suse.de>
In-Reply-To: <s5hvemzq1lg.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610050141.47847.annabellesgarden@yahoo.de>
X-Warning: yahoo.de is listed at abuse.rfc-ignorant.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 4. Oktober 2006 22:15 schrieb Takashi Iwai:
> 
> This looks like a good optoin.  But one thing we have to be careful
> about is the module counter since the owner is different between the
> old f_op and disconnect_f_op...
> 
here is rc1, will test later.
Feel free to pick it apart ;-)

-----------------------------------------------
/* virtual device
   hides a real device's f_ops,
   except for release

 *  Copyright (c) by Karsten Wiese <fzu@wemgehoertderstaat.de>
 *
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation; either version 2 of the License, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with this program; if not, write to the Free Software
 *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
 *
 */


#include <linux/fs.h>
#include <linux/poll.h>
#include <linux/module.h>

struct snd_disconnected_file {
	struct file *file;
	int (*release) (struct inode *, struct file *);
	struct snd_disconnected_file *next;
};

static struct snd_disconnected_file *disconnecting_files;
static struct file_operations snd_disconnect_f_ops;
static DEFINE_MUTEX(mutex);

void snd_disconnect_file(struct file *file, int (*release) (struct inode *, struct file *))
{
	struct snd_disconnected_file *df, **_dfs;
	df = kmalloc(sizeof(struct snd_disconnected_file), GFP_ATOMIC);
	if (df == NULL)
		panic("Atomic allocation failed for snd_disconnected_file!");

	df->file = file;
	df->release = release;
	df->next = NULL;

	mutex_lock(&mutex);
	_dfs = &disconnecting_files;
	while (*_dfs != NULL)
		_dfs = &(*_dfs)->next;
	*_dfs = df;
	mutex_unlock(&mutex);

	{
		const struct file_operations *old_f_op = file->f_op;
		fops_get(&snd_disconnect_f_ops);
		file->f_op = &snd_disconnect_f_ops;
		fops_put(old_f_op);
	}
}
EXPORT_SYMBOL(snd_disconnect_file);

static loff_t snd_disconnect_llseek(struct file *file, loff_t offset, int orig)
{
	return -ENODEV;
}

static ssize_t snd_disconnect_read(struct file *file, char __user *buf,
				   size_t count, loff_t *offset)
{
	return -ENODEV;
}

static ssize_t snd_disconnect_write(struct file *file, const char __user *buf,
				    size_t count, loff_t *offset)
{
	return -ENODEV;
}

static int snd_disconnect_release(struct inode *inode, struct file *file)
{
	struct snd_disconnected_file *df, **_dfs, **__dfs;
	int err = 0;
	__dfs = _dfs = &disconnecting_files;

	mutex_lock(&mutex);
	while ((df = *_dfs))
		if (df->file == file) {
			*__dfs = df->next;
			break;
		} else {
			__dfs = _dfs;
			_dfs = &df->next;
		}
	mutex_unlock(&mutex);

	if (df != NULL)	{
		err = df->release(inode, file);
		kfree(df);
		return err;
	}

	panic("%s(%p, %p) failed!", __FUNCTION__, inode, file);
}

static unsigned int snd_disconnect_poll(struct file * file, poll_table * wait)
{
	return POLLERR | POLLNVAL;
}

static long snd_disconnect_ioctl(struct file *file,
				 unsigned int cmd, unsigned long arg)
{
	return -ENODEV;
}

static int snd_disconnect_mmap(struct file *file, struct vm_area_struct *vma)
{
	return -ENODEV;
}

static int snd_disconnect_fasync(int fd, struct file *file, int on)
{
	return -ENODEV;
}

static struct file_operations snd_disconnect_f_ops =
{
	.owner = 	THIS_MODULE,
	.llseek =	snd_disconnect_llseek,
	.read = 	snd_disconnect_read,
	.write =	snd_disconnect_write,
	.release =	snd_disconnect_release,
	.poll =		snd_disconnect_poll,
	.unlocked_ioctl = snd_disconnect_ioctl,
	.compat_ioctl = snd_disconnect_ioctl,
	.mmap =		snd_disconnect_mmap,
	.fasync =	snd_disconnect_fasync
};
--------------------------------------------------------

      Karsten
