Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964878AbWHRLjk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964878AbWHRLjk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 07:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964881AbWHRLjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 07:39:40 -0400
Received: from mailer.campus.mipt.ru ([194.85.82.4]:16822 "EHLO
	mailer.campus.mipt.ru") by vger.kernel.org with ESMTP
	id S964878AbWHRLji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 07:39:38 -0400
Date: Fri, 18 Aug 2006 15:23:36 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Christoph Hellwig <hch@infradead.org>
Cc: lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>
Subject: Re: [take9 1/2] kevent: Core files.
Message-ID: <20060818112336.GB11034@2ka.mipt.ru>
References: <11555364962921@2ka.mipt.ru> <1155536496588@2ka.mipt.ru> <20060816134550.GA12345@infradead.org> <20060816135642.GD4314@2ka.mipt.ru> <20060818104607.GB20816@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060818104607.GB20816@infradead.org>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (mailer.campus.mipt.ru [194.85.82.4]); Fri, 18 Aug 2006 15:39:36 +0400 (MSD)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Fri, 18 Aug 2006 15:26:57 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2006 at 11:46:07AM +0100, Christoph Hellwig (hch@infradead.org) wrote:
> > > > +#define KEVENT_READY		0x1
> > > > +#define KEVENT_STORAGE		0x2
> > > > +#define KEVENT_USER		0x4
> > > 
> > > Please use enums here.
> > 
> > I used, but I was sugested to use define in some previous releases :)
> 
> defines make some sense for userspace-visible ABIs because then people
> can test for features with ifdef.  It doesn't make any sense for constants
> that are used purely in-kernel.  For those enums make more sense because
> you can for example looks at the symbolic names with a debugger.

Enums are only usefull when value is increased with each new member by
one.

> > > We were rather against these kind of odd multiplexers in the past.  For
> > > these three we at least have a common type beeing passed down so there's
> > > not compat handling problem, but I'm still not very happy with it..
> > 
> > I use one syscall for add/remove/modify, so it requires multiplexer.
> 
> I noticed that you do it, but it's not exactly considered a nice design.

There will be either several syscalls or multiplexer...
I prefer to have one syscall and a lot of multiplexers inside.

> > > > +asmlinkage long sys_kevent_ctl(int fd, unsigned int cmd, unsigned int num, void __user *arg)
> > > > +{
> > > > +	int err = -EINVAL;
> > > > +	struct file *file;
> > > > +
> > > > +	if (cmd == KEVENT_CTL_INIT)
> > > > +		return kevent_ctl_init();
> > > 
> > > This one on the other hand is plain wrong. At least it should be a separate
> > > syscall.  But looking at the code I don't quite understand why you need
> > > a syscall at all, why can't kevent be implemented as a cloning chardevice
> > > (on where every open allocates a new structure and stores it into
> > > file->private_data?)
> > 
> > That requires separate syscall.
> 
> Yes, it requires a separate syscall.
> 
> > I created a char device in first releases and was forced to not use it
> > at all.
> 
> Do you have a reference to it?  In this case a char devices makes a lot of
> sense because you get a filedescriptor and have operations only defined on
> it.  In fact given that you have a multiplexer anyway there's really no
> point in adding a syscall for that aswell, you could rather use the existing
> and debugged ioctl() multiplexer.  Sure, it's still not what we consider
> nice, but better than adding even more odd multiplexer syscalls.

Somewhere in february.
Here is link to initial anounce which used ioctl and raw char device and
enums for all constants.

http://marc.theaimsgroup.com/?l=linux-netdev&m=113949344414464&w=2

-- 
	Evgeniy Polyakov
