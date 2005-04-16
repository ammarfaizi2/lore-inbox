Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262580AbVDPCeo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262580AbVDPCeo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 22:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262582AbVDPCea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 22:34:30 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:40191 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262580AbVDPCdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 22:33:22 -0400
Subject: Re: FUSYN and RT
From: Steven Rostedt <rostedt@goodmis.org>
To: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Cc: Bill Huey <bhuey@lnxw.com>, dwalker@mvista.com, mingo@elte.hu,
       linux-kernel@vger.kernel.org, Esben Nielsen <simlo@phys.au.dk>
In-Reply-To: <16992.28724.665847.46695@sodium.jf.intel.com>
References: <Pine.OSF.4.05.10504130056271.6111-100000@da410.phys.au.dk>
	 <1113352069.6388.39.camel@dhcp153.mvista.com>
	 <1113407200.4294.25.camel@localhost.localdomain>
	 <20050415225137.GA23222@nietzsche.lynx.com>
	 <16992.20513.551920.826472@sodium.jf.intel.com>
	 <1113614062.4294.102.camel@localhost.localdomain>
	 <16992.26700.512551.833614@sodium.jf.intel.com>
	 <1113615510.4294.113.camel@localhost.localdomain>
	 <16992.28724.665847.46695@sodium.jf.intel.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Fri, 15 Apr 2005 22:31:53 -0400
Message-Id: <1113618713.4294.126.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-15 at 18:53 -0700, Inaky Perez-Gonzalez wrote:
> >>>>> Steven Rostedt <rostedt@goodmis.org> writes:
> 
> > On Fri, 2005-04-15 at 18:20 -0700, Inaky Perez-Gonzalez wrote:
> 
> >> Back to my example before: in fusyn, a user space lock is a kernel
> >> space lock with a wrapper, that provides all that is necessary for
> >> doing the fast path and handling user-space specific issues.
> 
> > ...
> 
> > So, to answer your question. Looking forward, I kind of see two
> > different structures for locking.  The rt_mutex and something that
> > is used by fusyn, then there being some common structure (or ops)
> > that they both use to implement the PI.  But the implementation of
> > how the locks work may as well be different. But this may not be the
> > case, and there still be two structures but the fusyn just contain a
> > rt_mutex lock to do the actual locking and the rest of the structure
> > be used for showing information or what not back up to user
> > space. This stuff wouldn't be necessary for the rt_mutex. We need to
> > keep rt_mutex small since it is used all over the place.
> 
> I see--would the following fit your view?
> 

I think it's time that I take a look at the fusyn code. I don't have all
the emails on this thread, could you point out to me where I can see the
latest fusyn patch. Thanks.


> This would be a kernel lock [from the fusyn patch, linux/fulock.h]:
> 
> 	/** A fulock, mutex usable from the kernel. */
> 	struct fulock {
> 	        struct fuqueue fuqueue;
> 	        struct task_struct *owner;
> 	        unsigned flags;
> 	        struct plist olist_node;
> 	};
> 

It's getting late where I am, and I'm getting tired, so I'm a little
slow right now.  Is what you are showing me here what is currently in
fusyn or a proposal with the merging of Ingo's rt_mutex?   Reason why
I'm asking, is what's the difference between the owner here and in
fuqueue's spin_lock?

> This has an in kernel API so you can use it from modules or kernel
> code.
> 
> And this would be kernel representation of a user space lock [from
> linux/fulock_kernel.h]:
> 
> 	struct ufulock {
> 	        struct fulock fulock;
> 	        struct vlocator vlocator;
> 	        struct page *page;
> 	};
> 
> This is exposed via system calls with fast-path as an option.
> 

This above structure would represent the user space wrapper structure
that I meant with the fusyn structure containing the rt_mutex lock.
Right?

> This is basically the kernel lock that provides the functionality and
> an structure to keep a tab to where the thing is in user space (hash
> queues a la futex). The ops are hidden in fulock.fuqueue.ops [fuqueue
> is the waitqueue--just for reference, from linux/fuqueue.h].
> 
> 	/** A fuqueue, a prioritized wait queue usable from kernel space. */
> 	struct fuqueue {
> 	        spinlock_t lock;        
> 	        struct plist wlist;
> 	        struct fuqueue_ops *ops;
> 	};
> 

Would the above spinlock_t be a raw_spinlock_t? This goes back to my
first question. I'm not sure how familiar you are with Ingo's work, but
he has turned all spinlocks into mutexes, and when you really need an
original spinlock, you declare it with raw_spinlock_t.  

Also in the above, is the fuqueue_ops the ops we mentioned earlier as
the links into PI?

Sorry about being totally ignorant here, but it's the end of the day for
me, and I'm starting to feel burnt out.

Thanks,

-- Steve


