Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262265AbVEMGnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262265AbVEMGnZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 02:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262263AbVEMGnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 02:43:24 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:34963 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262262AbVEMGmp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 02:42:45 -0400
Subject: Re: [RCF] [PATCH] unprivileged mount/umount
From: Ram <linuxram@us.ibm.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 7eggert@gmx.de, ericvh@gmail.com,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       smfrench@austin.rr.com, hch@infradead.org
In-Reply-To: <20050512005906.GA8457@mail.shareable.org>
References: <40rNB-6p8-3@gated-at.bofh.it> <40t37-7ol-5@gated-at.bofh.it>
	 <42VeB-8hG-3@gated-at.bofh.it> <42WNo-1eJ-17@gated-at.bofh.it>
	 <E1DVuHG-0006YJ-Q7@be1.7eggert.dyndns.org>
	 <20050511170700.GC2141@mail.shareable.org>
	 <E1DVwGn-0002BB-00@dorka.pomaz.szeredi.hu>
	 <1115840139.6248.181.camel@localhost>
	 <20050511212810.GD5093@mail.shareable.org>
	 <1115851333.6248.225.camel@localhost>
	 <20050512005906.GA8457@mail.shareable.org>
Content-Type: text/plain
Organization: IBM 
Message-Id: <1115966508.6248.331.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 12 May 2005 23:41:48 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-05-11 at 17:59, Jamie Lokier wrote:
> Ram wrote:
> > > Can you give a reason why sys_chdir() shouldn't have that behaviour?
> > 
> > Do you mean to say you want to change the namespace when a process
> > changes to a directory which belongs to that namespace?
> > 
> > Well it makes it totally confusing. A user would start seeing different
> > set of mounts suddenly as he changes directories beloning to different
> > namespaces. I am not sure, if changing namespace implicitly is a good
> > idea. Not saying its a bad idea, but seems to change my notion of
> > namespaces completely. 
> 
> That happens _already_.  I'm not suggesting it, it's been there in the
> kernel for ages.
> 
> Let me explain how namespaces _really_ work in Linux.
> 
> For path lookup, mounts are just mappings from (dentry,vfsmnt) to
> (dentry,vfsmnt).  There's a unique vfsmnt for each
> (filesystem,namespace) pair, by the way.
> 
> During path lookup, each path component moves from one (dentry,vfsmnt)
> pair to the next.  vfsmnt doesn't change from one dentry to the next
> while following a path component.  But then, if there's a mount whose
> key is the current (dentry,vfsmnt) pair, the current pair is replaced
> by the value of the mount.
> 
> Notice how namespaces aren't involved in path lookup at all.
> 
> That's nothing new: it's what Linux does already.
> 
> If that seems confusing, it's because _bind mounts_ are confusing.
> 
> Namespaces don't really exist.  When you create a new namespace with
> CLONE_NEWNS, all that really happens is a lot of bind mounts, to
> create a copy of the current directory tree, and then chrooting into
> that tree (in effect).
> 
> > having the ability to access two namespaces simultaneously can allow
> > cross contamination. Which essentially makes namespaces as a concept
> > irrelevent.
> 
> Cross contamination is already possible, using file descriptor passing
> or ptrace().

I am yet to convince myself that this is possible. Maybe possible and if
its possible we should close those holes.

> 
> Also, your suggested new syscall for accessing another namespace would
> have exactly the same effect, wouldn't it? :)

No it wont. a process can contaminate namespaces if the process has
access to both the namespace simultaneously.  With the proposed syscall,
the process would have access to one namespace at any given point in
time. There cannot be a instance where a process will have access
to vfsmounts belonging to two different namespaces. 

So I dont' think contamination is possible. By contamination I mean
'ability for a process to bind mount from one namespace to other'


RP



> 
> -- Jamie

