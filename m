Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933291AbWF0JI7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933291AbWF0JI7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 05:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933394AbWF0JI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 05:08:58 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:59549 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S933291AbWF0JI5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 05:08:57 -0400
Date: Tue, 27 Jun 2006 11:04:08 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: hch@infradead.org, swhiteho@redhat.com, torvalds@osdl.org,
       teigland@redhat.com, pcaulfie@redhat.com, kanderso@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: GFS2 and DLM
Message-ID: <20060627090408.GA2382@elte.hu>
References: <1150805833.3856.1356.camel@quoit.chygwyn.com> <20060623144928.GA32694@infradead.org> <20060626200300.GA15424@elte.hu> <20060627063339.GA27938@elte.hu> <20060627000633.91e06155.akpm@osdl.org> <20060627083544.GA32761@elte.hu> <20060627015005.21c20186.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060627015005.21c20186.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5028]
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> > it is relevant to a certain degree, because it creates a (IMO) false 
> > impression of merging showstoppers. After months of being in -mm, 
> > and after addressing all issues that were raised (and there was a 
> > fair amount of review activity December last year iirc), one week 
> > prior the close of the merge window a 'huge' list of issues are 
> > raised. (after belovingly calling the GFS2 code a "huge mess", to 
> > create a positive and productive tone for the review discussion i 
> > guess.)
> 
> It's a general problem - our reviewing resources do not have the 
> capacity to cover our coding resources.  This is especially the case 
> on filesystems.  We'd have merged (a very different) reiser4 a year 
> ago if things were in balance.

and just this very minute what gets merged upstream? A chunk of OCFS2 
code that has this comment in it:

 * NOTE: the allocation error cases here are scary
 * we really cannot afford to fail an alloc in recovery
 * do we spin?  returning an error only delays the problem really

plus this code:

                        /* sleep for a bit in hopes that we can avoid
                         * another ENOMEM */
                        msleep(100);
                        goto retry;

and this:

                        /* TODO Look into replacing msleep with cond_resched() */
                        msleep(100);
                        goto retry;

and this:

                /* yield a bit to allow any final network messages
                 * to get handled on remaining nodes */
                msleep(100);

and this:

                if (status < 0) {
                        mlog(ML_ERROR, "%s: failed to alloc recovery area, "
                             "retrying\n", dlm->name);
                        msleep(1000);
                }

and this:

                                } else {
                                        /* -ENOMEM on the other node */
                                        mlog(0, "%s: node %u returned "
                                             "%d during recovery, retrying "
                                             "after a short wait\n",
                                             dlm->name, ndata->node_num,
                                             status);
                                        msleep(100);
                                }

and that's just from a 60 seconds scan.

and we are not merging GFS2 that does an honest __GFP_NOFAIL for a hard 
to solve problem? (Btw., __GFP_NOFAIL is actually more robust due to the 
congestion sleep it does, it is more reviewable and more fixable thing 
than an open-coded msleep() or cond_resched().)

"Hypocrisy", "double standard", "pot calling the kettle black" is pretty 
much the nicest words that come to mind :-(

[and again, i'm not blaming XFS or OCFS2 here.]

	Ingo
