Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752585AbWAGVNw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752585AbWAGVNw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 16:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752588AbWAGVNw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 16:13:52 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:27805 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1752585AbWAGVNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 16:13:51 -0500
Subject: Re: Badness in __mutex_unlock_slowpath
From: Arjan van de Ven <arjan@infradead.org>
To: ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com
Cc: perex@suse.cz, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       mingo@redhat.com
In-Reply-To: <200601071551.20344.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
References: <20060107052221.61d0b600.akpm@osdl.org>
	 <200601071551.20344.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
Content-Type: text/plain
Date: Sat, 07 Jan 2006 22:13:42 +0100
Message-Id: <1136668423.2936.39.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-01-07 at 15:51 -0500, Andrew James Wade wrote:
> Hello,
> 
> I got this when "amaroK" started playing:
> 
> Badness in __mutex_unlock_slowpath at kernel/mutex.c:214
>  [<c03538e8>] __mutex_unlock_slowpath+0x56/0x1a2
>  [<c0302f08>] snd_pcm_oss_write+0x0/0x1e0
>  [<c0302f3c>] snd_pcm_oss_write+0x34/0x1e0
>  [<c0302f08>] snd_pcm_oss_write+0x0/0x1e0
>  [<c0148221>] vfs_write+0x83/0x122
>  [<c0148a36>] sys_write+0x3c/0x63
>  [<c0102ba3>] sysenter_past_esp+0x54/0x75
> 
> (2.6.15-mm2)


this looks like a really evil alsa bug:

(pre mutex code below)

static ssize_t snd_pcm_oss_write(struct file *file, const char __user *buf, size_t count, loff_t *offset)
{
        snd_pcm_oss_file_t *pcm_oss_file;
        snd_pcm_substream_t *substream;
        long result;

        pcm_oss_file = file->private_data;
        substream = pcm_oss_file->streams[SNDRV_PCM_STREAM_PLAYBACK];
        if (substream == NULL)
                return -ENXIO;
        up(&file->f_dentry->d_inode->i_sem);
        result = snd_pcm_oss_write1(substream, buf, count);
        down(&file->f_dentry->d_inode->i_sem);


this is a .write method of a driver, which doesn't run with i_sem helt at all.
Best guess I have is that this code has up() and down() confused and switched...



