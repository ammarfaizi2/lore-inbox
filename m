Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261380AbVCKU3t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbVCKU3t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 15:29:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261353AbVCKU2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 15:28:24 -0500
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:8833 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261571AbVCKTTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 14:19:25 -0500
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net, tglx@linutronix.de
Subject: Re: [uml-devel] Re: [patch 1/1] unified spinlock initialization arch/um/drivers/port_kern.c
Date: Fri, 11 Mar 2005 20:18:42 +0100
User-Agent: KMail/1.7.2
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, domen@coderock.org,
       amitg@calsoftinc.com, gud@eth.net
References: <20050309094234.8FC0C6477@zion> <200503092052.24803.blaisorblade@yahoo.it> <1110442320.29330.196.camel@tglx.tec.linutronix.de>
In-Reply-To: <1110442320.29330.196.camel@tglx.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503112018.42662.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 March 2005 09:12, Thomas Gleixner wrote:
> On Wed, 2005-03-09 at 20:52 +0100, Blaisorblade wrote:
> > > Are you sure this is really the best option in this instance?
> > > Sometimes, static data initialisation is more efficient than
> > > code-based manual initialisation, especially when the memory
> > > is written to anyway.
> >
> > Agreed, theoretically, but this was done for multiple reasons globally,
> > for instance as a preparation to Ingo Molnar's preemption patches. There
> > was mention of this on lwn.net about this:
> >
> > http://lwn.net/Articles/108719/
>
> Those patches did only the conversion of
>
> static spinlock_t lock = SPIN_LOCK_UNLOCKED;
>        lock = SPIN_LOCK_UNLOCKED;
> to
> static DEFINE_SPINLOCK(lock);
>        spin_lock_init(lock);
First: I didn't write the patch, only forwarded it, so I just guessed why it 
was done.

The latter is spin_lock_init(&lock); (since someone got confused about this).

However, this is a .lock = SPIN_LOCK_UNLOCKED  -> 
spin_lock_init(&struct.lock),

so I don't understand what changes... the structure is initialized inside a 
function, so there's no change.

> If you want to do static initialization inside of structures, then you
> have to define a seperate MACRO similar to the static initialization of
> list_head's inside of structures:

> static struct sysfs_dirent sysfs_root = {
>         .s_sibling      = LIST_HEAD_INIT(sysfs_root.s_sibling),

I don't see the need here... and the initialization is not in static code; it 
changes this code snippet:

void *port_data(int port_num)
{
//...
        *port = ((struct port_list)
                { .list                 = LIST_HEAD_INIT(port->list),
                  .has_connection       = 0,
                  .sem                  = __SEMAPHORE_INITIALIZER(port->sem,
                                                                  0),
                  .lock                 = SPIN_LOCK_UNLOCKED,
                  .port                 = port_num,
                  .fd                   = fd,
                  .pending              = LIST_HEAD_INIT(port->pending),
                  .connections          = 
LIST_HEAD_INIT(port->connections) });

So you are all doing some confusion (in fact I guess Andrew realized this when 
he merged this anyway).

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

