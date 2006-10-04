Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161214AbWJDPfg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161214AbWJDPfg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 11:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161236AbWJDPff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 11:35:35 -0400
Received: from mout2.freenet.de ([194.97.50.155]:4486 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S1161214AbWJDPff (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 11:35:35 -0400
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH] Reset file->f_op in snd_card_file_remove(). Take 2
Date: Wed, 4 Oct 2006 17:36:37 +0200
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net,
       mingo@elte.hu
References: <200609282228.02611.annabellesgarden@yahoo.de> <200610041247.19624.annabellesgarden@yahoo.de> <s5h1wpokvvj.wl%tiwai@suse.de>
In-Reply-To: <s5h1wpokvvj.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610041736.37639.annabellesgarden@yahoo.de>
X-Warning: yahoo.de is listed at abuse.rfc-ignorant.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 4. Oktober 2006 16:18 schrieb Takashi Iwai:
> At Wed, 4 Oct 2006 12:47:19 +0200,
> Karsten Wiese wrote:
> > 
> > Am Mittwoch, 4. Oktober 2006 11:22 schrieb Takashi Iwai:
> > > 
> > > It should call snd_card_free_when_closed() instead.
> > > 
> > IMHO, that would just make sure that the bug happens.
> > Please see my annotations, starting with // in:
> > 
> > void fastcall __fput(struct file *file)
> > {
> > 	struct dentry *dentry = file->f_dentry;
> > 	struct vfsmount *mnt = file->f_vfsmnt;
> > 	struct inode *inode = dentry->d_inode;
> > 
> > 	might_sleep();
> > 
> > 	fsnotify_close(file);
> > 	/*
> > 	 * The function eventpoll_release() should be the first called
> > 	 * in the file cleanup chain.
> > 	 */
> > 	eventpoll_release(file);
> > 	locks_remove_flock(file);
> > 
> > 	if (file->f_op && file->f_op->release)
> > 		file->f_op->release(inode, file);
> > // Here snd_hwdep_release() is called.
> > // snd_hwdep_release() calls snd_card_file_remove().
> > // snd_card_file_remove() sees card->free_on_last_close ist set,
> > // calls snd_card_do_free().
> > // snd_card_do_free frees file->f_op but doesn't set it NULL.
> > //
> > 	security_file_free(file);
> > 	if (unlikely(inode->i_cdev != NULL))
> > 		cdev_put(inode->i_cdev);
> > 	fops_put(file->f_op);
> > // file->f_op has already been freeed!
> > // fops_put(file->f_op) is likely to oops.
> 
> Yes, this looks like an invalid access.
> 
> The problem is that we use kmalloc for allocating a dummy f_op.
> IMO, the simlest solution is to use a static dummy f_op.
> 
That'd take 1 static dummy f_op per snd_*_release().
I prefer the patch at the start of this thread :-)

      Karsten
