Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbWF0I1g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbWF0I1g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 04:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751062AbWF0I1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 04:27:36 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:2475 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750749AbWF0I1f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 04:27:35 -0400
Date: Tue, 27 Jun 2006 10:22:40 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nathan Scott <nathans@sgi.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Steven Whitehouse <swhiteho@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>,
       David Teigland <teigland@redhat.com>,
       Patrick Caulfield <pcaulfie@redhat.com>,
       Kevin Anderson <kanderso@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: GFS2 and DLM
Message-ID: <20060627082240.GA672@elte.hu>
References: <1150805833.3856.1356.camel@quoit.chygwyn.com> <20060623144928.GA32694@infradead.org> <20060626200300.GA15424@elte.hu> <20060627063339.GA27938@elte.hu> <20060627181632.A1297906@wobbly.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060627181632.A1297906@wobbly.melbourne.sgi.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5004]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nathan Scott <nathans@sgi.com> wrote:

> >           */
> >          buf = (xfs_caddr_t) kmem_zalloc(NBPP, KM_SLEEP);
> >  [...]
> > 
> > where kmem_zalloc() may fail!!!
> 
> Not with the flags it was given.

yeah, you are right - sorry about that.

XFS instead loops infinitely:

 void *
 kmem_alloc(size_t size, unsigned int __nocast flags)
 {
         int     retries = 0;
         gfp_t   lflags = kmem_flags_convert(flags);
         void    *ptr;

         do {
                 if (size < MAX_SLAB_SIZE || retries > MAX_VMALLOCS)
                         ptr = kmalloc(size, lflags);
                 else
                         ptr = __vmalloc(size, lflags, PAGE_KERNEL);
                 if (ptr || (flags & (KM_MAYFAIL|KM_NOSLEEP)))
                         return ptr;
                 if (!(++retries % 100))
                         printk(KERN_ERR "XFS: possible memory allocation "
                                         "deadlock in %s (mode:0x%x)\n",
                                         __FUNCTION__, lflags);
                 blk_congestion_wait(WRITE, HZ/50);
         } while (1);
 }

which is in essence an open-coded GFP_NOFAIL implementation. Here's what 
__GFP_NOFAIL does:

                        if (gfp_mask & __GFP_NOFAIL) {
                                blk_congestion_wait(WRITE, HZ/50);
                                goto nofail_alloc;
                        }

and since XFS makes use of KM_SLEEP in 130+ callsites, that means it is 
in essence using GFP_NOFAIL massively!

	Ingo
