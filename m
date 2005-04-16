Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262563AbVDPB4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262563AbVDPB4L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 21:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262569AbVDPB4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 21:56:11 -0400
Received: from fmr17.intel.com ([134.134.136.16]:42980 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S262563AbVDPBz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 21:55:58 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16992.28724.665847.46695@sodium.jf.intel.com>
Date: Fri, 15 Apr 2005 18:53:56 -0700
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Bill Huey <bhuey@lnxw.com>, dwalker@mvista.com, mingo@elte.hu,
       linux-kernel@vger.kernel.org, Esben Nielsen <simlo@phys.au.dk>
Subject: Re: FUSYN and RT
In-Reply-To: <1113615510.4294.113.camel@localhost.localdomain>
References: <Pine.OSF.4.05.10504130056271.6111-100000@da410.phys.au.dk>
	<1113352069.6388.39.camel@dhcp153.mvista.com>
	<1113407200.4294.25.camel@localhost.localdomain>
	<20050415225137.GA23222@nietzsche.lynx.com>
	<16992.20513.551920.826472@sodium.jf.intel.com>
	<1113614062.4294.102.camel@localhost.localdomain>
	<16992.26700.512551.833614@sodium.jf.intel.com>
	<1113615510.4294.113.camel@localhost.localdomain>
X-Mailer: VM 7.19 under Emacs 21.3.1
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Steven Rostedt <rostedt@goodmis.org> writes:

> On Fri, 2005-04-15 at 18:20 -0700, Inaky Perez-Gonzalez wrote:

>> Back to my example before: in fusyn, a user space lock is a kernel
>> space lock with a wrapper, that provides all that is necessary for
>> doing the fast path and handling user-space specific issues.

> ...

> So, to answer your question. Looking forward, I kind of see two
> different structures for locking.  The rt_mutex and something that
> is used by fusyn, then there being some common structure (or ops)
> that they both use to implement the PI.  But the implementation of
> how the locks work may as well be different. But this may not be the
> case, and there still be two structures but the fusyn just contain a
> rt_mutex lock to do the actual locking and the rest of the structure
> be used for showing information or what not back up to user
> space. This stuff wouldn't be necessary for the rt_mutex. We need to
> keep rt_mutex small since it is used all over the place.

I see--would the following fit your view?

This would be a kernel lock [from the fusyn patch, linux/fulock.h]:

	/** A fulock, mutex usable from the kernel. */
	struct fulock {
	        struct fuqueue fuqueue;
	        struct task_struct *owner;
	        unsigned flags;
	        struct plist olist_node;
	};

This has an in kernel API so you can use it from modules or kernel
code.

And this would be kernel representation of a user space lock [from
linux/fulock_kernel.h]:

	struct ufulock {
	        struct fulock fulock;
	        struct vlocator vlocator;
	        struct page *page;
	};

This is exposed via system calls with fast-path as an option.

This is basically the kernel lock that provides the functionality and
an structure to keep a tab to where the thing is in user space (hash
queues a la futex). The ops are hidden in fulock.fuqueue.ops [fuqueue
is the waitqueue--just for reference, from linux/fuqueue.h].

	/** A fuqueue, a prioritized wait queue usable from kernel space. */
	struct fuqueue {
	        spinlock_t lock;        
	        struct plist wlist;
	        struct fuqueue_ops *ops;
	};

-- 

Inaky

