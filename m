Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750947AbWHRKq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750947AbWHRKq0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 06:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbWHRKq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 06:46:26 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:65453 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750942AbWHRKqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 06:46:25 -0400
Date: Fri, 18 Aug 2006 11:46:07 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Christoph Hellwig <hch@infradead.org>, lkml <linux-kernel@vger.kernel.org>,
       David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>
Subject: Re: [take9 1/2] kevent: Core files.
Message-ID: <20060818104607.GB20816@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
	lkml <linux-kernel@vger.kernel.org>,
	David Miller <davem@davemloft.net>,
	Ulrich Drepper <drepper@redhat.com>, Andrew Morton <akpm@osdl.org>,
	netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>
References: <11555364962921@2ka.mipt.ru> <1155536496588@2ka.mipt.ru> <20060816134550.GA12345@infradead.org> <20060816135642.GD4314@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060816135642.GD4314@2ka.mipt.ru>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > +#define KEVENT_READY		0x1
> > > +#define KEVENT_STORAGE		0x2
> > > +#define KEVENT_USER		0x4
> > 
> > Please use enums here.
> 
> I used, but I was sugested to use define in some previous releases :)

defines make some sense for userspace-visible ABIs because then people
can test for features with ifdef.  It doesn't make any sense for constants
that are used purely in-kernel.  For those enums make more sense because
you can for example looks at the symbolic names with a debugger.

> > We were rather against these kind of odd multiplexers in the past.  For
> > these three we at least have a common type beeing passed down so there's
> > not compat handling problem, but I'm still not very happy with it..
> 
> I use one syscall for add/remove/modify, so it requires multiplexer.

I noticed that you do it, but it's not exactly considered a nice design.

> > > +asmlinkage long sys_kevent_ctl(int fd, unsigned int cmd, unsigned int num, void __user *arg)
> > > +{
> > > +	int err = -EINVAL;
> > > +	struct file *file;
> > > +
> > > +	if (cmd == KEVENT_CTL_INIT)
> > > +		return kevent_ctl_init();
> > 
> > This one on the other hand is plain wrong. At least it should be a separate
> > syscall.  But looking at the code I don't quite understand why you need
> > a syscall at all, why can't kevent be implemented as a cloning chardevice
> > (on where every open allocates a new structure and stores it into
> > file->private_data?)
> 
> That requires separate syscall.

Yes, it requires a separate syscall.

> I created a char device in first releases and was forced to not use it
> at all.

Do you have a reference to it?  In this case a char devices makes a lot of
sense because you get a filedescriptor and have operations only defined on
it.  In fact given that you have a multiplexer anyway there's really no
point in adding a syscall for that aswell, you could rather use the existing
and debugged ioctl() multiplexer.  Sure, it's still not what we consider
nice, but better than adding even more odd multiplexer syscalls.
