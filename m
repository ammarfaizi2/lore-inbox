Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261190AbVF2RYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbVF2RYX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 13:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261285AbVF2RVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 13:21:54 -0400
Received: from dsl.dynamic851009584.ttnet.net.tr ([85.100.95.84]:45496 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262641AbVF2ROd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 13:14:33 -0400
From: Ismail Donmez <ismail@kde.org.tr>
Organization: Bogazici University
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: 2.6.13-rc1 problems
Date: Wed, 29 Jun 2005 20:15:11 +0300
User-Agent: KMail/1.8.50
References: <200506291934.32909.ismail@kde.org.tr> <Pine.LNX.4.61.0506291805090.3940@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0506291805090.3940@goblin.wat.veritas.com>
Cc: randy_dunlap <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200506292015.11494.ismail@kde.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 29 June 2005 20:06, you wrote:
> On Wed, 29 Jun 2005, Ismail Donmez wrote:
> > I upgraded to 2.6.13-rc1 and kjournald now takes 100% CPU and I see
> > worrying problems in syslog :
> >
> > Jun 29 19:15:05 localhost kernel: Badness in blk_remove_plug at
> > drivers/block/ll_rw_blk.c:1424
>
> I don't know about kjournald, but for the Badness, you want patch I posted:
>
> get_request is now expected to be holding on to queue_lock, with interrupts
> disabled, when it returns NULL; but one path forgot that, causing all kinds
> of nastiness under swap load - badness backtraces, strange failures, BUGs.
>
> Signed-off-by: Hugh Dickins <hugh@veritas.com>
>
> --- 2.6.13-rc1/drivers/block/ll_rw_blk.c	2005-06-29 11:54:08.000000000
> +0100 +++ linux/drivers/block/ll_rw_blk.c	2005-06-29 14:41:04.000000000
> +0100 @@ -1917,10 +1917,9 @@ get_rq:
>  	 * limit of requests, otherwise we could have thousands of requests
>  	 * allocated with any setting of ->nr_requests
>  	 */
> -	if (rl->count[rw] >= (3 * q->nr_requests / 2)) {
> -		spin_unlock_irq(q->queue_lock);
> +	if (rl->count[rw] >= (3 * q->nr_requests / 2))
>  		goto out;
> -	}
> +
>  	rl->count[rw]++;
>  	rl->starved[rw] = 0;
>  	if (rl->count[rw] >= queue_congestion_on_threshold(q))

Thank you both!. Any idea about this part? :

Jun 29 19:16:32 localhost kernel: Badness in __kfree_skb at 
net/core/skbuff.c:290
Jun 29 19:16:32 localhost kernel:
Jun 29 19:16:32 localhost kernel: Call 
Trace:<ffffffff8027a997>{__kfree_skb+183} 
<ffffffff880024ad>{:unix:unix_dgram_recvmsg+557}
Jun 29 19:16:32 localhost kernel:        <ffffffff80273c4e>{sock_recvmsg+238} 
<ffffffff8015d982>{__alloc_pages+242}
Jun 29 19:16:32 localhost kernel:        
<ffffffff80148770>{autoremove_wake_function+0} 
<ffffffff8018efd5>{poll_freewait+85}
Jun 29 19:16:32 localhost kernel:        <ffffffff8027498a>{sockfd_lookup+26} 
<ffffffff8027526a>{sys_recvfrom+218}
Jun 29 19:16:32 localhost kernel:        <ffffffff8018eff0>{__pollwait+0} 
<ffffffff8018fcdd>{sys_select+893}
Jun 29 19:16:32 localhost kernel:        <ffffffff8010eb6e>{system_call+126}


ismail

-- 
Animals use pee to mark their territories. Humans use others' girl friends
