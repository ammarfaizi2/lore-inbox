Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262072AbUK3N1e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262072AbUK3N1e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 08:27:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262086AbUK3N1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 08:27:33 -0500
Received: from gaz.sfgoth.com ([69.36.241.230]:14796 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S262072AbUK3NYw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 08:24:52 -0500
Date: Tue, 30 Nov 2004 05:27:44 -0800
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] relinquish_fs() syscall
Message-ID: <20041130132744.GB63669@gaz.sfgoth.com>
References: <20041129114331.GA33900@gaz.sfgoth.com> <1101729087.20223.14.camel@localhost.localdomain> <20041129135559.GC33900@gaz.sfgoth.com> <1101741440.20225.22.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101741440.20225.22.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.2.2 (gaz.sfgoth.com [127.0.0.1]); Tue, 30 Nov 2004 05:27:44 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> With CAP_SYS_RAWIO I can ask the IDE controller to DMA into the kernel
> as one example.

Can you really do that on normal file descriptors?  Weird.  I'd have thought
you'd need to open /dev/hd* to do that.

Oh, and you also need to revoke CAP_SYS_PTRACE to prevent a compromised
process from taking over a process inside the jail

> Without it should be sane. However if you take away all
> the capabilities then you don't need the other changes because mount
> works just fine.

True; for the root-user case you can build an equivalent jail as long as you
  * remove CAP_SYS_RAWIO
  * remove CAP_SYS_ADMIN to prevent mount/umount
  * make the root somehow immutable (make mountpoint r/o; ext2 attribute;
    whatever)

I probably shouldn't have even mentioned the jail-root case in my description;
my only point is that relinquish_fs() is at least as good as the currently
used chroot("/var/empty") in every way.  It's also stronger in some
ways.  Obviously a rogue process running with a full CAP_SYS_* set can
do all kinds of bad things even inside a jail (up to and including a
reboot)

The real point of the patch is to add a method giving this same power to
unprivileged processes, functionality which is currently lacking but
useful.  The existing namespace support makes it almost trivial to provide.

> Yes I realise that but you also need to realise that glibc has a lot of
> supporting baggage it likes to find if its going to function sanely.

And how is this different then people using chroot() currently?  The people
doing privsep designs understand the limits libc and can work within them.

> > > Imagine a jpeg decoder using an SELinux policy. 
> > 
> > SELinux is great but it's a pretty orthoginal issue.  There's no reason the
> > two can't coexist.
> 
> I don't see it as orthogonal except for the "done by user" aspect.

Yes and that's the point.  relinquish_fs() is a tool for defensive
programming.  SELinux is a tool for sysadmins and distribution vendors
to enforce policy.  Ideally they would both be used -- defense in depth
is a good thing.

> BTW: you also have to deal with fchdir() and potentially AF_UNIX
> sockets.

Is AF_UNIX in a separate namespace?  My understanding (from reading
unix_find_other()) is that unless you can create a UNIX socket in your
filesystem you're going to have trouble creating new UNIX sockets.
I think some *NIXes worked differently but linux seems sane in this
regard.  So you'd have to trick your privsep-peer outside the jail to
send you a directory fd over a unix-domain socket you already had open
before you jailed yourself.

-Mitch
