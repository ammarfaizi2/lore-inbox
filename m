Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751013AbWJDUAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbWJDUAr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 16:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbWJDUAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 16:00:47 -0400
Received: from mout2.freenet.de ([194.97.50.155]:54997 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S1751012AbWJDUAq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 16:00:46 -0400
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH] Reset file->f_op in snd_card_file_remove(). Take 2
Date: Wed, 4 Oct 2006 22:01:53 +0200
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net,
       mingo@elte.hu
References: <200609282228.02611.annabellesgarden@yahoo.de> <200610041736.37639.annabellesgarden@yahoo.de> <s5hmz8cjcp6.wl%tiwai@suse.de>
In-Reply-To: <s5hmz8cjcp6.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200610042201.53337.annabellesgarden@yahoo.de>
X-Warning: yahoo.de is listed at abuse.rfc-ignorant.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 4. Oktober 2006 17:57 schrieb Takashi Iwai:
> > > 
> > > The problem is that we use kmalloc for allocating a dummy f_op.
> > > IMO, the simlest solution is to use a static dummy f_op.
> > > 
> > That'd take 1 static dummy f_op per snd_*_release().
> 
> Yes, but it'll remove extra codes at the same time, too.
> Well, OTOH, it requires more additions for assignment of dummy ops...
> 
> > I prefer the patch at the start of this thread :-)
> 
> I think it's not good to set NULL always there.  The NULL is necessary

I disagree. In snd_card_file_remove() the file has already been
released. Is file->f_op still used anywhere later on
except from __fput()'s call to fops_put(file->f_op); ?
First glance didn't show.... 

> only when the card is freed.  So, I prefer the patch like below.  Is
> it OK?
> 
IMO not:
Lets assume 2 cpus CA, CB and two processes PA, PB,
closing their file's after usb disconnect of 1 snd_card.
PA running on CA going through snd_card_file_remove() first would not
have it's file->f_op set NULL.
Now PA is back in __fput() right after the
	file->f_op->release(inode, file);
Some third process happens to be scheduled an CA.
Meanwhile PB running on CB goes through snd_card_file_remove()
and calls snd_card_do_free(card).
snd_card_do_free(card) frees PA's file->f_op.
PA is scheduled again and has a freed, non NULL file->f_op.
> 
> Takashi
> 
> diff -r f38b12373137 sound/core/init.c
> --- a/sound/core/init.c	Wed Oct 04 17:17:32 2006 +0200
> +++ b/sound/core/init.c	Wed Oct 04 17:50:11 2006 +0200
> @@ -721,8 +721,14 @@ int snd_card_file_remove(struct snd_card
>  	spin_unlock(&card->files_lock);
>  	if (last_close) {
>  		wake_up(&card->shutdown_sleep);
> -		if (card->free_on_last_close)
> +		if (card->free_on_last_close) {
> +			/* release and clear f_op here since the dummy f_ops will
> +			 * be freed in snd_card_do_free().
> +			 */
> +			fops_put(file->f_op);
> +			file->f_op = NULL;
>  			snd_card_do_free(card);
> +		}
>  	}
>  	if (!mfile) {
>  		snd_printk(KERN_ERR "ALSA card file remove problem (%p)\n", file);
> 

How about a "disconnecting device" that can emulate a real one
for diconnect reasons?
I've sketched one here:

-------------------------------------------------------------------
/* virtual device
   hides a real device's f_ops,
   exept for release
*/

struct snd_disconnected_file {
	struct file *file;
	int (*release) (struct inode *, struct file *);
	struct snd_disconnected_file *next;
};

static struct snd_disconnected_file *disconnecting_files;
static struct file_operations snd_disconnect_f_ops;

int snd_disconnect_file(struct file *file, int (*release) (struct inode *, struct file *))
{
	int err;
// TODO:	zmalloc and initialize struct snd_disconnected_file,
//		rechain
	return err;

	file->f_op = snd_disconnect_f_ops;
	return 0;
}

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
	struct snd_disconnected_file * df = disconnecting_files;
	int err = 0;
	while (df)
		if (df->file == file) {
			err = df->release(inode, file);
// TODO: free df, rechain
		}
	return err;
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
	.ioctl =	snd_disconnect_ioctl,
	.mmap =		snd_disconnect_mmap,
	.fasync =	snd_disconnect_fasync
};

----------------------------------------

snd_card_disconnect() would call 
  int snd_disconnect_file(file,	file->f_op->release)
instead of allocating/initing the special f_ops by itself.
We'd win memory by the difference
 sizeof(struct snd_shutdown_f_ops) - sizeof(struct snd_disconnected_file)
.
And play safe.
We would need to be sure, a file->f_op's
	int (*release) (struct inode *, struct file *);
id called exactly one time during a file's life though.

      Karsten
