Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262032AbVELT4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262032AbVELT4S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 15:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbVELT4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 15:56:17 -0400
Received: from mail.shareable.org ([81.29.64.88]:61649 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262032AbVELT4N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 15:56:13 -0400
Date: Thu, 12 May 2005 20:56:01 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: ericvh@gmail.com, linuxram@us.ibm.com, 7eggert@gmx.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       smfrench@austin.rr.com, hch@infradead.org
Subject: Re: [RCF] [PATCH] unprivileged mount/umount
Message-ID: <20050512195601.GA21295@mail.shareable.org>
References: <1115840139.6248.181.camel@localhost> <20050511212810.GD5093@mail.shareable.org> <1115851333.6248.225.camel@localhost> <a4e6962a0505111558337dd903@mail.gmail.com> <20050512010215.GB8457@mail.shareable.org> <a4e6962a05051119181e53634e@mail.gmail.com> <20050512064514.GA12315@mail.shareable.org> <a4e6962a0505120623645c0947@mail.gmail.com> <20050512151631.GA16310@mail.shareable.org> <E1DWIms-0005nC-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DWIms-0005nC-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi wrote:
> I also tried bind mounting from the child's namespace to the parent's,
> and that works too.  But the new mount's mnt_namespace is copied from
> the old, which makes the mount un-removable.  This is most likely not
> intentional, IOW a bug.

I agree about the bug (and it's why I think the current->namespace
checks in fs/namespace.c should be killed - the _only_ effect is to
make un-removable mounts like the above, and the checks are completely
redundant for "normal" namespace operations).

I think the best thing to do for "jails" and such is to think of a
private namespace as a collection of bind mounts in a private tree
that (normally) cannot be reached from elsewhere, not can it reach
elsewhere.

And leave it to adminstration to ensure that a tree isn't visible from
another tree if you don't want it to be for security purposes.  That
basically amounts to making sure processes that shouldn't communicate
or ptrace each other can't.

With that view, the kernel's notion of "namespace" is redundant.  It
doesn't add anything to the security model, and it doesn't add any
useful functionality.

It's an abstract idea which does not need to be supported by kernel
code, except for the CLONE_NEWNS operation which actually means "copy
all mounts found recursively starting from the current root) to a new
tree of mounts, and chroot to the new tree".

In other words, is ->mnt_namespace required at all, except to contain
namespace->sem (which could be changed)?  I don't think it adds
anything realistic to security.  The way to make secure jails is to
isolated their trees so they are unreachable.  ->mnt_namespace doesn't
make any difference to that.

-- Jamie
