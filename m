Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261538AbVDZOHp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261538AbVDZOHp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 10:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261532AbVDZOHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 10:07:45 -0400
Received: from mail.shareable.org ([81.29.64.88]:4777 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S261527AbVDZOHe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 10:07:34 -0400
Date: Tue, 26 Apr 2005 15:07:15 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Miklos Szeredi <miklos@szeredi.hu>, hch@infradead.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] private mounts
Message-ID: <20050426140715.GA10833@mail.shareable.org>
References: <E1DPnOn-0000T0-00@localhost> <20050424201820.GA28428@infradead.org> <E1DPo3I-0000V0-00@localhost> <20050424205422.GK13052@parcelfarce.linux.theplanet.co.uk> <E1DPoCg-0000W0-00@localhost> <20050424210616.GM13052@parcelfarce.linux.theplanet.co.uk> <20050424213822.GB9304@mail.shareable.org> <20050425152049.GB2508@elf.ucw.cz> <20050425190734.GB28294@mail.shareable.org> <20050426092924.GA4175@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050426092924.GA4175@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> > > Actually, after you add right mount xyzzy /foo lines into .profile,
> > > you can just . ~/.profile ;-).
> > 
> > Is there a mount command that can do that?  We're talking about
> > private mounts - invisible to other namespaces, which includes the
> > other shells.
> > 
> > If there was a /proc/NNN/namespace, that would do the trick :)
> 
> Sounds like the solution, then. I do not think Al Viro is going to
> kill you for /proc/NNN/namespace...

Looking closer, I think we already have it.

It's called /proc/NNN/root.

Does chroot into /proc/NNN/root cause the chroot'ing process to adopt
the namespace of NNN?  Looking at the code, I think it does.

Furthermore, I think a daemon can acquire file descriptors for
multiple namespaces already, by open("/") and passing descriptors
between processes.  And the chroot can be done using /proc/self/fd/N
after receiving a descriptor.

This is because file descriptors, and current->fs->pwd and
current->fs->root, record the vfsmnt as well as the dentry that they
opened.

So no new system calls are needed.  A daemon to hand out per-user
namespaces (or any other policy) can be written using existing
kernels, and those namespaces can be joined using chroot.

That's the theory anyway.  It's always possible I misread the code (as
I don't use namespaces and don't have tools handy to try them).

-- Jamie
