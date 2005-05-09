Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261298AbVEILuH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbVEILuH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 07:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261289AbVEILuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 07:50:05 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:18347 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S261285AbVEILtD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 07:49:03 -0400
Date: Mon, 9 May 2005 15:48:09 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Cc: Alexander Nyberg <alexn@dsv.su.se>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, Jay Lan <jlan@engr.sgi.com>,
       aq <aquynh@gmail.com>, elsa-devel <elsa-devel@lists.sourceforge.net>
Subject: Re: [PATCH 2.6.12-rc3-mm3] connector: add a fork connector
Message-ID: <20050509154809.19076fe0@zanzibar.2ka.mipt.ru>
In-Reply-To: <1115638724.8540.59.camel@frecb000711.frec.bull.fr>
References: <1115626029.8548.24.camel@frecb000711.frec.bull.fr>
	<1115631107.936.25.camel@localhost.localdomain>
	<1115638724.8540.59.camel@frecb000711.frec.bull.fr>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed-Claws 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [194.85.82.65]); Mon, 09 May 2005 15:48:15 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 May 2005 13:38:44 +0200
Guillaume Thouvenin <guillaume.thouvenin@bull.net> wrote:

> On Mon, 2005-05-09 at 11:31 +0200, Alexander Nyberg wrote:
> > > +static inline void fork_connector(pid_t parent, pid_t child)
> > > +{
> > > +	if (cn_fork_enable) {
> > > +		struct cn_msg *msg;
> > > +		struct cn_fork_msg *forkmsg;
> > > +		__u8 buffer[CN_FORK_MSG_SIZE];	
> > > +
> > > +		msg = (struct cn_msg *)buffer;
> > > +			
> > > +		memcpy(&msg->id, &cb_fork_id, sizeof(msg->id));
> > > +		
> > > +		msg->ack = 0; /* not used */
> > > +		msg->seq = get_cpu_var(fork_counts)++;
> > > +
> > > +		msg->len = CN_FORK_INFO_SIZE;
> > > +		forkmsg = (struct cn_fork_msg *)msg->data;
> > > +		forkmsg->cpu = smp_processor_id();
> > > +		forkmsg->ppid = parent;
> > > +		forkmsg->cpid = child;
> > > +
> > > +		put_cpu_var(fork_counts);
> > > +
> > > +		cn_netlink_send(msg, CN_IDX_FORK, GFP_ATOMIC);
> > 
> > Why is this GFP_ATOMIC?
> 
> In the previous connector, cn_netlink_send(struct cn_msg *msg, u32
> __groups) called alloc_skb(size, GFP_ATOMIC). Now a third parameter is
> used with cn_netlink_send() in order to call alloc_skb(size, gfp_mask)
> with a specific gfp_mask. So, I'm using GFP_ATOMIC as the third argument
> to keep the same behavior.

It was atomic there to allow non process context usage.
Since do_fork() is executed in process context you can use GFP_KERNEL with 
__GFP_NOFAIL  - it will guarantee memory allocation.

> > > +	}
> > > +}
> > > +#else
> > > +static inline void fork_connector(pid_t parent, pid_t child) 
> > > +{
> > > +	return; 
> > > +}
> > > +#endif /* CONFIG_FORK_CONNECTOR */
> > > +#endif /* __KERNEL__ */
> > > +
> > > +#endif /* CN_FORK_H */
> > > Index: linux-2.6.12-rc3-mm3/include/linux/connector.h
> > > ===================================================================
> > > --- linux-2.6.12-rc3-mm3.orig/include/linux/connector.h	2005-05-09 07:45:56.000000000 +0200
> > > +++ linux-2.6.12-rc3-mm3/include/linux/connector.h	2005-05-09 09:50:01.000000000 +0200
> > > @@ -26,6 +26,8 @@
> > >  
> > >  #define CN_IDX_CONNECTOR		0xffffffff
> > >  #define CN_VAL_CONNECTOR		0xffffffff
> > > +#define CN_IDX_FORK			0xfeed  /* fork events */
> > > +#define CN_VAL_FORK			0xbeef
> > >  
> > >  /*
> > >   * Maximum connector's message size.
> > > Index: linux-2.6.12-rc3-mm3/kernel/fork.c
> > > ===================================================================
> > > --- linux-2.6.12-rc3-mm3.orig/kernel/fork.c	2005-05-09 07:45:56.000000000 +0200
> > > +++ linux-2.6.12-rc3-mm3/kernel/fork.c	2005-05-09 08:03:15.000000000 +0200
> > > @@ -41,6 +41,7 @@
> > >  #include <linux/profile.h>
> > >  #include <linux/rmap.h>
> > >  #include <linux/acct.h>
> > > +#include <linux/cn_fork.h>
> > >  
> > >  #include <asm/pgtable.h>
> > >  #include <asm/pgalloc.h>
> > > @@ -63,6 +64,14 @@ DEFINE_PER_CPU(unsigned long, process_co
> > >  
> > >  EXPORT_SYMBOL(tasklist_lock);
> > >  
> > > +#ifdef CONFIG_FORK_CONNECTOR
> > > +/* 
> > > + * fork_counts is used by the fork_connector() inline routine as 
> > > + * the sequence number of the netlink message.
> > > + */
> > > +static DEFINE_PER_CPU(unsigned long, fork_counts); 
> > > +#endif /* CONFIG_FORK_CONNECTOR */
> > > +
> > 
> > The above should go into cn_fork.c
> 
> I don't see why. It's used by fork_connector which is an inline routine
> so, IMHO, 'fork_counts' must be defined here and declared in
> include/linux/cn_fork.h
> 
> > >  int nr_processes(void)
> > >  {
> > >  	int cpu;
> > > @@ -1252,6 +1261,8 @@ long do_fork(unsigned long clone_flags,
> > >  			if (unlikely (current->ptrace & PT_TRACE_VFORK_DONE))
> > >  				ptrace_notify ((PTRACE_EVENT_VFORK_DONE << 8) | SIGTRAP);
> > >  		}
> > > +		
> > > +		fork_connector(current->pid, p->pid);
> > 
> > Are you sure this is what you want? ->pid has a special meaning to the
> > kernel and doesn't necessarily mean the same to user-space, so I think
> > you want ->tgid here. If you look at sys_getpid() and sys_gettid()
> > you'll see what I mean.
> 
> Yes, I think you're right. If I look the code of the BSD process
> accounting they're using the field ->tgid to get the process ID. I fix
> that.
> 
> Thank you very much for your comments,
> Best regards,
> 
> Guillaume


	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt
