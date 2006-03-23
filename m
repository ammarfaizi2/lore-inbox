Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932477AbWCWIxJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932477AbWCWIxJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 03:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932573AbWCWIxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 03:53:09 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:39848 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S932477AbWCWIxI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 03:53:08 -0500
Date: Thu, 23 Mar 2006 11:52:44 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Matt Helsley <matthltc@us.ibm.com>
Cc: Yi Yang <yang.y.yi@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Michael Kerrisk <michael.kerrisk@gmx.net>
Subject: Re: [2.6.16 PATCH] Connector: Filesystem Events Connector
Message-ID: <20060323085244.GA23750@2ka.mipt.ru>
References: <44216612.3060406@gmail.com> <1143099809.29668.89.camel@stark>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143099809.29668.89.camel@stark>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Thu, 23 Mar 2006 11:52:45 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2006 at 11:43:28PM -0800, Matt Helsley (matthltc@us.ibm.com) wrote:
> On Wed, 2006-03-22 at 22:58 +0800, Yi Yang wrote:
> > This patch implements a new connector, Filesystem Event Connector,
> >  the user can monitor filesystem activities via it, currently, it
> >  can monitor access, attribute change, open, create, modify, delete,
> >  move and close of any file or directory.
> > 
> > Every filesystem event will include tgid, uid and gid of the process
> >  which triggered this event, process name, file or directory name 
> > operated by it.
> > 
> > Filesystem events connector is never a duplicate of inotify, inotify
> >  just concerns change on file or directory, Beagle uses it to watch
> >  file changes in order to regenerate index for it, inotify can't tell
> >  us who did that change and what is its process name, but filesystem
> >  events connector can do these, moreover inotify's overhead is greater
> >  than filesystem events connector, inotify needs compare inode with 
> > watched file or directories list to decide whether it should generate an
> >  inotify_event, some locks also increase overhead, filesystem event 
> > connector hasn't these overhead, it just generates a fsevent and send.
> > 
> > To be important, filesystem event connector doesn't add any new system 
> > call, the user space application can make use of it by netlink socket, 
> > but inotify added several system calls, many events mechanism in kernel
> >  have used netlink as communication way with user space, for example, 
> > KOBJECT_UEVENT, PROC_EVENTS, to use netlink will make it more possible
> >  to unify events interface to netlink, the user space application can use 
> > it very easy.
> > 
> > Signed-off-by: Yi Yang <yang.y.yi@gmail.com>

Ugh, I like the idea!

> > --- a/include/linux/connector.h.orig	2006-03-15 23:21:37.000000000 +0800
> > +++ b/include/linux/connector.h	2006-03-15 23:23:09.000000000 +0800
> > @@ -34,6 +34,8 @@
> >  #define CN_VAL_PROC			0x1
> >  #define CN_IDX_CIFS			0x2
> >  #define CN_VAL_CIFS                     0x1
> > +#define CN_IDX_FS			0x3
> > +#define CN_VAL_FS			0x1


Please add some on-line comment about what it is here.

> >  #define CN_NETLINK_USERS		1


This must be increased each time new id is added.
Although connector code does allocation with reserve, better to not
exhaust it.
Please increase it to 3.

...

> > +/*
> > + * Userspace sends this enum to register with the kernel that it is listening
> > + * for events on the connector.
> > + */
> > +enum fsevent_mode {
> > +	FSEVENT_LISTEN = 1,
> > +	FSEVENT_IGNORE = 2
> > +};
> > +
> 
> 	Process Events Connector uses this mechanism to avoid most of the event
> generation code if there are no listeners. 
> 
> 	Michael Kerrisk has privately suggested to me that this mechanism gives
> userspace too much rope with which to hang itself. I think it just gives
> userspace more rope.
> 
> 	That said, perhaps we can shorten the rope by adding a connector
> function to quickly return a value indicating if a process in userspace
> is listening to messages sent by the kernel. Then connectors could use
> that function rather that reinvent the same mechanism.

Btw, current connector code performs check for listeners before it
allocates any skbs.
If there are no listenres -ESRCH is returned from cn_netlink_send().

...

> Pull the assignment out of the condition. You're not saving any space by
> putting it into the if () and it's harder to read. I don't think the
> __u8 cast is necessary..
> 
> > +		printk("cn_fs: out of memory\n");
> 
> missing printk tag

Do not print such info at all.

> > +void raise_fsevent(struct dentry * dentryp, u32 mask)
> > +{
> > +	__raise_fsevent(dentryp->d_name.name, NULL, mask);
> > +}
> > +EXPORT_SYMBOL_GPL(raise_fsevent);
> > +
> > +void raise_fsevent_create(struct inode * inode, const char * name, u32 mask)
> > +{
> > +	__raise_fsevent(name, NULL, mask);
> > +}
> > +EXPORT_SYMBOL_GPL(raise_fsevent_create);
> > +
> > +void raise_fsevent_move(struct inode * olddir, const char * oldname, 
> > +		struct inode * newdir, const char * newname, u32 mask)
> > +{
> > +	__raise_fsevent(oldname, newname, mask);
> > +}
> > +EXPORT_SYMBOL_GPL(raise_fsevent_move);

Are there external modules which might use it?

-- 
	Evgeniy Polyakov
