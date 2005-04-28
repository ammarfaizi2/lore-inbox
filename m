Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262287AbVD1WJT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262287AbVD1WJT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 18:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262286AbVD1WJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 18:09:19 -0400
Received: from mail.shareable.org ([81.29.64.88]:48298 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262285AbVD1WJJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 18:09:09 -0400
Date: Thu, 28 Apr 2005 23:08:39 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Ram <linuxram@us.ibm.com>
Cc: Eric Van Hensbergen <ericvh@gmail.com>, Pavel Machek <pavel@ucw.cz>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Miklos Szeredi <miklos@szeredi.hu>, hch@infradead.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] private mounts
Message-ID: <20050428220839.GA5183@mail.shareable.org>
References: <E1DPoCg-0000W0-00@localhost> <20050424210616.GM13052@parcelfarce.linux.theplanet.co.uk> <20050424213822.GB9304@mail.shareable.org> <20050425152049.GB2508@elf.ucw.cz> <20050425190734.GB28294@mail.shareable.org> <20050426092924.GA4175@elf.ucw.cz> <20050426140715.GA10833@mail.shareable.org> <a4e6962a050428064774e88f4a@mail.gmail.com> <20050428192048.GA2895@mail.shareable.org> <1114717183.4180.718.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1114717183.4180.718.camel@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ram wrote:
> > I've looked at the code.  Look in fs/proc/base.c (Linux 2.6.10),
> > proc_root_link().
> > 
> > I don't see anything there to prevent you from traversing to the
> > mounts in the other namespace.
> > 
> > So why is it failing?  Any idea?
> 
> Since you are traversing a symlink, you will be traversing the symlink
> in the context of traversing process's namespace. 
> 
> If process 'x' is traversing /proc/y/root , the lookup for the root
> dentry will happen in the context of process x's  namespace, and not
> process y's namespace. Hence process 'x' wont really get into
> the namespace of the process y.

Lookups don't happen in the context of a namespace.

They happen in the context of a vfsmnt.  And the switch to a new
vfsmnt is done by matching against (dentry,parent-vfsmnt) pairs.
current->namespace is only checked for mount & unmount operations, not
for path lookups.

Which means proc_root_link, when it switches to the vfsmnt at the root
of the other process, should traverse into the tree of vfsmnts which
make up the other namespace.

-- Jamie
