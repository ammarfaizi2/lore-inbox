Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbTFHLFo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 07:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261454AbTFHLFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 07:05:44 -0400
Received: from mail.ithnet.com ([217.64.64.8]:51471 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S261450AbTFHLFm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 07:05:42 -0400
Date: Sun, 8 Jun 2003 13:19:01 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: willy@w.ods.org, gibbs@scsiguy.com, marcelo@conectiva.com.br,
       green@namesys.com
Subject: Re: Undo aic7xxx changes (now rc7+aic20030603)
Message-Id: <20030608131901.7cadf9ea.skraw@ithnet.com>
In-Reply-To: <20030605181423.GA17277@alpha.home.local>
References: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva>
	<2804790000.1052441142@aslan.scsiguy.com>
	<20030509120648.1e0af0c8.skraw@ithnet.com>
	<20030509120659.GA15754@alpha.home.local>
	<20030509150207.3ff9cd64.skraw@ithnet.com>
	<20030605181423.GA17277@alpha.home.local>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

looking at code around my problem I discovered this:

static inline void * __kmem_cache_alloc (kmem_cache_t *cachep, int flags)
{
        unsigned long save_flags;
        void* objp;

        kmem_cache_alloc_head(cachep, flags);
try_again:
        local_irq_save(save_flags);
#ifdef CONFIG_SMP
        {
                cpucache_t *cc = cc_data(cachep);

                if (cc) {
                        if (cc->avail) {
                                STATS_INC_ALLOCHIT(cachep);
                                objp = cc_entry(cc)[--cc->avail];
                        } else {
                                STATS_INC_ALLOCMISS(cachep);
                                objp = kmem_cache_alloc_batch(cachep,cc,flags);
                                if (!objp)
                                        goto alloc_new_slab_nolock;
                        }
                } else {
                        spin_lock(&cachep->spinlock);
                        objp = kmem_cache_alloc_one(cachep);
                        spin_unlock(&cachep->spinlock);
                }
        }
#else
        objp = kmem_cache_alloc_one(cachep);
#endif
        local_irq_restore(save_flags);
        return objp;
alloc_new_slab:  
#ifdef CONFIG_SMP
        spin_unlock(&cachep->spinlock);
alloc_new_slab_nolock:
#endif
        local_irq_restore(save_flags);
        if (kmem_cache_grow(cachep, flags))
                /* Someone may have stolen our objs.  Doesn't matter, we'll
                 * just come back here again.
                 */
                goto try_again;
        return NULL;
} 
  

I suggest it for most-absurd-goto-usage-award.

1) There seems to be no reference for symbol "alloc_new_slab"
2) "spin_unlock" (right below) is never reached
3) The not-ifdef'ed code below is only used if CONFIG_SMP
4) The code "alloc_new_slab_nolock" is referenced only once by a goto
   (why not simply pasted there?)

This does not look like a problem, it only is damn ugly. I have no idea 
what this code actually does, but it looks patched-to-the-limit. Has 
anybody reviewed slab regarding CONFIG_SMP?

Regards,
Stephan
