Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269998AbUJSTEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269998AbUJSTEm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 15:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269916AbUJSTCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 15:02:09 -0400
Received: from brown.brainfood.com ([146.82.138.61]:7552 "EHLO
	gradall.private.brainfood.com") by vger.kernel.org with ESMTP
	id S269584AbUJSSw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 14:52:57 -0400
Date: Tue, 19 Oct 2004 13:52:53 -0500 (CDT)
From: Adam Heath <doogie@debian.org>
X-X-Sender: adam@gradall.private.brainfood.com
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U6
In-Reply-To: <20041019173510.GA18323@elte.hu>
Message-ID: <Pine.LNX.4.58.0410191351550.1219@gradall.private.brainfood.com>
References: <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu>
 <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu>
 <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu>
 <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu>
 <20041019124605.GA28896@elte.hu> <Pine.LNX.4.58.0410191222050.1216@gradall.private.brainfood.com>
 <20041019173510.GA18323@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Oct 2004, Ingo Molnar wrote:

>
> * Adam Heath <doogie@debian.org> wrote:
>
> > I am still having the same bug(repeatable by running liquidwar) as I
> > reported with -U5(see my earlier email).
>
> ok, this seems to be some questionable code in OSS. It really has no
> business up()-ing the inode semaphore - nobody down()-ed it before! This
> could be either a bad workaround for a bug/hang someone saw, or an old
> VFS assumption that doesnt hold anymore. In any case, could you try the
> patch below, does it fix liquidwar?

Yup, the below fixes it.  However, this problem *only* started occuring in
-U5.  I've been running liquidwar on all versions(it's my current
game-to-play-when-I-feel-stupid program).

>
> 	Ingo
>
> --- linux/sound/core/oss/pcm_oss.c.orig
> +++ linux/sound/core/oss/pcm_oss.c
> @@ -2120,9 +2120,7 @@ static ssize_t snd_pcm_oss_write(struct
>  	substream = pcm_oss_file->streams[SNDRV_PCM_STREAM_PLAYBACK];
>  	if (substream == NULL)
>  		return -ENXIO;
> -	up(&file->f_dentry->d_inode->i_sem);
>  	result = snd_pcm_oss_write1(substream, buf, count);
> -	down(&file->f_dentry->d_inode->i_sem);
>  #ifdef OSS_DEBUG
>  	printk("pcm_oss: write %li bytes (wrote %li bytes)\n", (long)count, (long)result);
>  #endif
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
