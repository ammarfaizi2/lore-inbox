Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261275AbVELBAC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261275AbVELBAC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 21:00:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261283AbVELA72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 20:59:28 -0400
Received: from mail.shareable.org ([81.29.64.88]:9169 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S261274AbVELA7S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 20:59:18 -0400
Date: Thu, 12 May 2005 01:59:06 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Ram <linuxram@us.ibm.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 7eggert@gmx.de, ericvh@gmail.com,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       smfrench@austin.rr.com, hch@infradead.org
Subject: Re: [RCF] [PATCH] unprivileged mount/umount
Message-ID: <20050512005906.GA8457@mail.shareable.org>
References: <40rNB-6p8-3@gated-at.bofh.it> <40t37-7ol-5@gated-at.bofh.it> <42VeB-8hG-3@gated-at.bofh.it> <42WNo-1eJ-17@gated-at.bofh.it> <E1DVuHG-0006YJ-Q7@be1.7eggert.dyndns.org> <20050511170700.GC2141@mail.shareable.org> <E1DVwGn-0002BB-00@dorka.pomaz.szeredi.hu> <1115840139.6248.181.camel@localhost> <20050511212810.GD5093@mail.shareable.org> <1115851333.6248.225.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1115851333.6248.225.camel@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ram wrote:
> > Can you give a reason why sys_chdir() shouldn't have that behaviour?
> 
> Do you mean to say you want to change the namespace when a process
> changes to a directory which belongs to that namespace?
> 
> Well it makes it totally confusing. A user would start seeing different
> set of mounts suddenly as he changes directories beloning to different
> namespaces. I am not sure, if changing namespace implicitly is a good
> idea. Not saying its a bad idea, but seems to change my notion of
> namespaces completely. 

That happens _already_.  I'm not suggesting it, it's been there in the
kernel for ages.

Let me explain how namespaces _really_ work in Linux.

For path lookup, mounts are just mappings from (dentry,vfsmnt) to
(dentry,vfsmnt).  There's a unique vfsmnt for each
(filesystem,namespace) pair, by the way.

During path lookup, each path component moves from one (dentry,vfsmnt)
pair to the next.  vfsmnt doesn't change from one dentry to the next
while following a path component.  But then, if there's a mount whose
key is the current (dentry,vfsmnt) pair, the current pair is replaced
by the value of the mount.

Notice how namespaces aren't involved in path lookup at all.

That's nothing new: it's what Linux does already.

If that seems confusing, it's because _bind mounts_ are confusing.

Namespaces don't really exist.  When you create a new namespace with
CLONE_NEWNS, all that really happens is a lot of bind mounts, to
create a copy of the current directory tree, and then chrooting into
that tree (in effect).

> having the ability to access two namespaces simultaneously can allow
> cross contamination. Which essentially makes namespaces as a concept
> irrelevent.

Cross contamination is already possible, using file descriptor passing
or ptrace().

Also, your suggested new syscall for accessing another namespace would
have exactly the same effect, wouldn't it? :)

-- Jamie
