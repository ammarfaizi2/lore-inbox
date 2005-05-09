Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261327AbVEIMWq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261327AbVEIMWq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 08:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbVEIMWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 08:22:46 -0400
Received: from mailfe07.swip.net ([212.247.154.193]:41195 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261327AbVEIMWl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 08:22:41 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: [PATCH 2.6.12-rc3-mm3] connector: add a fork connector
From: Alexander Nyberg <alexn@dsv.su.se>
To: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Jay Lan <jlan@engr.sgi.com>, aq <aquynh@gmail.com>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       elsa-devel <elsa-devel@lists.sourceforge.net>
In-Reply-To: <1115638724.8540.59.camel@frecb000711.frec.bull.fr>
References: <1115626029.8548.24.camel@frecb000711.frec.bull.fr>
	 <1115631107.936.25.camel@localhost.localdomain>
	 <1115638724.8540.59.camel@frecb000711.frec.bull.fr>
Content-Type: text/plain
Date: Mon, 09 May 2005 14:22:32 +0200
Message-Id: <1115641352.936.45.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

You said it yourself, it's used by the fork connector not fork.c. You've
already have DECLARE_PER_CPU(unsigned long, fork_counts); in cn_fork.h
so just put

/*
 * fork_counts is used by the fork_connector() inline routine as
 * the sequence number of the netlink message.
 */
DEFINE_PER_CPU(unsigned long, fork_counts);

in cn_fork.c and remove that chunk from kernel/fork.c

And I don't like putting code like fork_connector() in a header file
even if it is used once only, it's just a simple call/ret...

And before any abi sets itself I think you might want to consider
including both thread & process id of parent & child. This way the
user-space client can distinguish what is a thread and a group leader
although I admittedly don't know all your goals with this, just a
thought.

