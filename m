Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261830AbUEGA45@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261830AbUEGA45 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 20:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262020AbUEGA45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 20:56:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:28839 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261830AbUEGA4x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 20:56:53 -0400
Date: Thu, 6 May 2004 17:56:35 -0700
From: Chris Wright <chrisw@osdl.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org,
       Manfred Spraul <manfred@colorfullife.com>,
       Andrew Morton <akpm@osdl.org>, Jakub Jelinek <jakub@redhat.com>
Subject: Re: [PATCH] per-user signal pending and message queue limits
Message-ID: <20040506175635.B21045@build.pdx.osdl.net>
References: <20040421203456.GC16891@logos.cnet> <40875944.4060405@colorfullife.com> <20040427145424.GA10530@logos.cnet> <408EA1DF.6050303@colorfullife.com> <20040428170932.GA14993@logos.cnet> <20040428183315.T22989@build.pdx.osdl.net> <20040429121739.GB18352@logos.cnet> <20040429125820.O21045@build.pdx.osdl.net> <20040505170811.W22989@build.pdx.osdl.net> <20040506123222.GC3133@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040506123222.GC3133@logos.cnet>; from marcelo.tosatti@cyclades.com on Thu, May 06, 2004 at 09:32:22AM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Marcelo Tosatti (marcelo.tosatti@cyclades.com) wrote:
> > This BUG() is too easy to trigger, e.g. user creates mqueue, logs out,
> > root comes by later and cleans up...BUG().  Simply caching user directly
> > eliminates this altogether.
> 
> And with user_struct->__count you deal with that, yes?

Yes, exactly.

> Caching the user_struct directly is indeed much nicer.
> 
> > Some inconsistent use of p and current below.
> > 
> > >  	struct msg_msg **msgs = NULL;
> > >  	struct mq_attr attr;
> > >  	int ret;
> > > @@ -553,15 +578,26 @@
> > >  					attr.mq_msgsize > msgsize_max)
> > >  				return ERR_PTR(-EINVAL);
> > >  		}
> > > +	  	if(p->user->msg_queues+ ((attr.mq_maxmsg * sizeof(struct msg_msg *)
> > > +				+ (attr.mq_maxmsg * attr.mq_msgsize)))
> > > +			  >= p->rlim[RLIMIT_MSGQUEUE].rlim_cur)
> > 
> > Hrm, this thing can overflow.  Seems like the hard maxes should be
> > smaller.  As it stands, looks like the hard max mq_msgsize that root
> > could setup is INT_MAX.
> 
> Eek. Just decreasing max mq_msgsize to something _much_ smaller is ok, isnt it? 
> Like, say, 64MB.

I think so.  I've no idea what a good max is, but last night I simply
added some overflow detection to handle this.

> > > +			return ERR_PTR(-ENOMEM);
> > > +
> > >  		msgs = kmalloc(attr.mq_maxmsg * sizeof(*msgs), GFP_KERNEL);
> > >  		if (!msgs)
> > >  			return ERR_PTR(-ENOMEM);
> > > +
> > > +		spin_lock(&mq_lock);
> > > +		current->user->msg_queues += (attr.mq_maxmsg * sizeof(*msgs) +
> > > +					(attr.mq_maxmsg * attr.mq_msgsize));
> > > +		spin_unlock(&mq_lock);
> > 
> > This path means the user is penalized for the mq_attr sized accounting,
> > plus the default sized accounting which happens later in mqueue_get_inode().
> > It is removed below, but as mentioned above, this could incorrectly
> > cause mq_open() to fail.
> 
> OK!
> 
> > >  	} else {
> > >  		msgs = NULL;
> > >  	}
> > >  
> > >  	ret = vfs_create(dir->d_inode, dentry, mode, NULL);
> > >  	if (ret) {
> > > +		/* kfree(msgs): msgs can be NULL -mt */
> > >  		kfree(msgs);
> > >  		return ERR_PTR(ret);
> > >  	}
> > > @@ -572,8 +608,17 @@
> > >  	if (msgs) {
> > >  		info->attr.mq_maxmsg = attr.mq_maxmsg;
> > >  		info->attr.mq_msgsize = attr.mq_msgsize;
> > > +		spin_lock(&mq_lock);
> > > +		current->user->msg_queues -= (info->attr.mq_maxmsg 
> > > +						* sizeof (struct msg_msg *) +
> > > +						(info->attr.mq_maxmsg * 
> > > +						info->attr.mq_msgsize));
> > > +		if (current->user->msg_queues < 0)
> > > +			current->user->msg_queues = 0;	
> > 
> > Oops, I think the subtraction is slightly wrong here.  Should be before
> > the info->attr is updated, else you are actually carrying accounting for
> > the default size (minus the actually allocated size).  Should be
> > subtracting off the recently added default size.
> > 
> > New patch below (based on 2.6.6-rc3-bk).  Couple known issues are the
> > possible mq_bytes caluclation overflow (not yet fixed in this patch),
> > and setuid issue on signal side.  All other known issues have been
> > addressed.
> 
> The setuid issue on signal side is pretty harmless though. It only affects the
> users which are setuid() capable, and which do so with signal pending.

Yes.  It's part of why I left it for now.

> I see no other way to fix it than cache the user struct in "struct sigqueue". 
> Thats not good news for performance (not sure how bad it would matter).

My thoughts exactly.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
