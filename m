Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269954AbUJSRhH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269954AbUJSRhH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 13:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269938AbUJSRhD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 13:37:03 -0400
Received: from mx1.elte.hu ([157.181.1.137]:10148 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S269954AbUJSRen (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 13:34:43 -0400
Date: Tue, 19 Oct 2004 19:35:10 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Adam Heath <doogie@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U6
Message-ID: <20041019173510.GA18323@elte.hu>
References: <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <Pine.LNX.4.58.0410191222050.1216@gradall.private.brainfood.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410191222050.1216@gradall.private.brainfood.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Adam Heath <doogie@debian.org> wrote:

> I am still having the same bug(repeatable by running liquidwar) as I
> reported with -U5(see my earlier email).

ok, this seems to be some questionable code in OSS. It really has no
business up()-ing the inode semaphore - nobody down()-ed it before! This
could be either a bad workaround for a bug/hang someone saw, or an old
VFS assumption that doesnt hold anymore. In any case, could you try the
patch below, does it fix liquidwar?

	Ingo

--- linux/sound/core/oss/pcm_oss.c.orig
+++ linux/sound/core/oss/pcm_oss.c
@@ -2120,9 +2120,7 @@ static ssize_t snd_pcm_oss_write(struct 
 	substream = pcm_oss_file->streams[SNDRV_PCM_STREAM_PLAYBACK];
 	if (substream == NULL)
 		return -ENXIO;
-	up(&file->f_dentry->d_inode->i_sem);
 	result = snd_pcm_oss_write1(substream, buf, count);
-	down(&file->f_dentry->d_inode->i_sem);
 #ifdef OSS_DEBUG
 	printk("pcm_oss: write %li bytes (wrote %li bytes)\n", (long)count, (long)result);
 #endif
