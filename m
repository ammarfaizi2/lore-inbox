Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263267AbUCRWwo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 17:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263192AbUCRWwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 17:52:44 -0500
Received: from ns.suse.de ([195.135.220.2]:48838 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263267AbUCRWwg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 17:52:36 -0500
Subject: Re: CONFIG_PREEMPT and server workloads
From: Chris Mason <mason@suse.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Takashi Iwai <tiwai@suse.de>, andrea@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <20040318143205.6a9c4e89.akpm@osdl.org>
References: <40591EC1.1060204@geizhals.at>
	 <20040318060358.GC29530@dualathlon.random> <s5hlllycgz3.wl@alsa2.suse.de>
	 <20040318143205.6a9c4e89.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1079650437.11058.31.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 18 Mar 2004 17:54:55 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-03-18 at 17:32, Andrew Morton wrote:
> Takashi Iwai <tiwai@suse.de> wrote:
> >
> > --- linux-2.6.4-8/fs/jbd/commit.c-dist	2004-03-16 23:00:40.000000000 +0100
> > +++ linux-2.6.4-8/fs/jbd/commit.c	2004-03-18 02:42:41.043448624 +0100
> > @@ -290,6 +290,9 @@ write_out_data_locked:
> >  			commit_transaction->t_sync_datalist = jh;
> >  			break;
> >  		}
> > +
> > +		if (need_resched())
> > +			break;
> >  	} while (jh != last_jh);
> >  
> >  	if (bufs || need_resched()) {
> 
> Yup, this has problems.
> 
> What we're doing here is walking (under spinlock) a ring of buffers
> searching for unlocked dirty ones to write out.
> 
> Suppose the ring has thousands of locked buffers and there is a RT task
> scheduling at 1kHz.  Each time need_resched() comes true we break out of
> the search, schedule away and then restart the search from the beginning.
> 
Why not just put all the locked buffers onto a different list as you
find them or lock them.  That way you can always make progress...

-chris


