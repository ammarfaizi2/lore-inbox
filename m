Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261251AbVCRAve@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbVCRAve (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 19:51:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261254AbVCRAve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 19:51:34 -0500
Received: from zeus.kernel.org ([204.152.189.113]:65517 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261251AbVCRAva (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 19:51:30 -0500
Date: Fri, 18 Mar 2005 00:38:57 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Jay Lan <jlan@engr.sgi.com>, Erich Focht <efocht@hpce.nec.com>,
       Ram <linuxram@us.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>,
       elsa-devel <elsa-devel@lists.sourceforge.net>, Greg KH <greg@kroah.com>
Subject: Re: [patch 1/2] fork_connector: add a fork connector
Message-ID: <20050318003857.4600af78@zanzibar.2ka.mipt.ru>
In-Reply-To: <200503170856.57893.jbarnes@engr.sgi.com>
References: <1111050243.306.107.camel@frecb000711.frec.bull.fr>
	<200503170856.57893.jbarnes@engr.sgi.com>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (mailer.campus.mipt.ru [194.85.82.4]); Fri, 18 Mar 2005 02:44:34 +0300 (MSK)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [194.85.82.65]); Fri, 18 Mar 2005 00:11:57 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Mar 2005 08:56:57 -0800
Jesse Barnes <jbarnes@engr.sgi.com> wrote:

> On Thursday, March 17, 2005 1:04 am, Guillaume Thouvenin wrote:
> > +static inline void fork_connector(pid_t parent, pid_t child)
> > +{
> > + static DEFINE_SPINLOCK(cn_fork_lock);
> > + static __u32 seq;   /* used to test if message is lost */
> > +
> > + if (cn_fork_enable) {
> > +  struct cn_msg *msg;
> > +
> > +  __u8 buffer[CN_FORK_MSG_SIZE];
> > +
> > +  msg = (struct cn_msg *)buffer;
> > +
> > +  memcpy(&msg->id, &cb_fork_id, sizeof(msg->id));
> > +  spin_lock(&cn_fork_lock);
> > +  msg->seq = seq++;
> > +  spin_unlock(&cn_fork_lock);
> 
> As I mentioned before, this won't work very well on a large CPU count system.  
> cn_fork_lock will be taken by each CPU everytime it does a fork, meaning that 
> forks will be very slow if lots of CPUs are doing them at the same time.  Is 

Maybe... But..., concider ppc system, 
each lock is about 10 instructions(or even less), 
increment with return is about 3-5 instructions, unlock - 
barrier() and setting.
The whole fork syscall contains too bigger number
of instruction(do_fork() itself is more than 500, 
and it is not counting number of instructions in 
functions that are called from do_fork()) 
to care about 20 idle on each CPU, 
even if there are 512 of them.

The most significant part there - is requirement to store
u32 seq in each CPU's cache and thus flush cacheline + 
invalidate/get from mem on each other cpus
each time it is accessed, which is a big price.

> there a more scalable way to ensure message delivery?

It is totally Guillaume's work - so he decides, 
I would recomend per cpu counters and processor's 
id in each message.
And of course userspace should take care of misordered
messages.
I personally prefer such mechanism.

Guillaume?
 
> Jesse


	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt
