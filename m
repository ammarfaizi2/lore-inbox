Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030533AbWAHIxe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030533AbWAHIxe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 03:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030569AbWAHIxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 03:53:34 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:5518 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030533AbWAHIxd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 03:53:33 -0500
Date: Sun, 8 Jan 2006 09:53:32 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Arjan van de Ven <arjan@infradead.org>
Cc: ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com,
       perex@suse.cz, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: Badness in __mutex_unlock_slowpath
Message-ID: <20060108085332.GA12084@elte.hu>
References: <20060107052221.61d0b600.akpm@osdl.org> <200601071551.20344.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com> <1136668423.2936.39.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136668423.2936.39.camel@laptopd505.fenrus.org>
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


* Arjan van de Ven <arjan@infradead.org> wrote:

> this looks like a really evil alsa bug:
> 
> (pre mutex code below)

>         up(&file->f_dentry->d_inode->i_sem);
>         result = snd_pcm_oss_write1(substream, buf, count);
>         down(&file->f_dentry->d_inode->i_sem);

> this is a .write method of a driver, which doesn't run with i_sem held 
> at all. Best guess I have is that this code has up() and down() 
> confused and switched...

well snd_pcm_oss_read1() is not using the mutex at all - nor any other 
functions here. So the patch below removes the i_mutex use. _If_ some 
synchronization is needed it would be needed in the read1 case too: it 
is destructive to a sound stream when it is 'read' and when it is 
'written' just as much.

the bug could cause inode corruption on the VFS level: one thread 
unlocks an inode it doesnt own - this could surprise another thread 
holding that mutex and could allow a third thread to lock it and thus 
two threads would be in a critical section - bad.

	Ingo

--
remove bogus i_mutex use from sound/core/oss/pcm_oss.c.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

 sound/core/oss/pcm_oss.c |    2 --
 1 files changed, 2 deletions(-)

Index: linux/sound/core/oss/pcm_oss.c
===================================================================
--- linux.orig/sound/core/oss/pcm_oss.c
+++ linux/sound/core/oss/pcm_oss.c
@@ -2135,9 +2135,7 @@ static ssize_t snd_pcm_oss_write(struct 
 	substream = pcm_oss_file->streams[SNDRV_PCM_STREAM_PLAYBACK];
 	if (substream == NULL)
 		return -ENXIO;
-	mutex_unlock(&file->f_dentry->d_inode->i_mutex);
 	result = snd_pcm_oss_write1(substream, buf, count);
-	mutex_lock(&file->f_dentry->d_inode->i_mutex);
 #ifdef OSS_DEBUG
 	printk("pcm_oss: write %li bytes (wrote %li bytes)\n", (long)count, (long)result);
 #endif
