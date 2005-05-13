Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262311AbVEMIzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262311AbVEMIzq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 04:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262310AbVEMIzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 04:55:46 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:26120 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262306AbVEMIzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 04:55:35 -0400
To: jamie@shareable.org
CC: miklos@szeredi.hu, ericvh@gmail.com, linuxram@us.ibm.com, 7eggert@gmx.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       smfrench@austin.rr.com, hch@infradead.org
In-reply-to: <20050512195601.GA21295@mail.shareable.org> (message from Jamie
	Lokier on Thu, 12 May 2005 20:56:01 +0100)
Subject: Re: [RCF] [PATCH] unprivileged mount/umount
References: <1115840139.6248.181.camel@localhost> <20050511212810.GD5093@mail.shareable.org> <1115851333.6248.225.camel@localhost> <a4e6962a0505111558337dd903@mail.gmail.com> <20050512010215.GB8457@mail.shareable.org> <a4e6962a05051119181e53634e@mail.gmail.com> <20050512064514.GA12315@mail.shareable.org> <a4e6962a0505120623645c0947@mail.gmail.com> <20050512151631.GA16310@mail.shareable.org> <E1DWIms-0005nC-00@dorka.pomaz.szeredi.hu> <20050512195601.GA21295@mail.shareable.org>
Message-Id: <E1DWVwo-000125-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 13 May 2005 10:55:06 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think the best thing to do for "jails" and such is to think of a
> private namespace as a collection of bind mounts in a private tree
> that (normally) cannot be reached from elsewhere, not can it reach
> elsewhere.
> 
> And leave it to adminstration to ensure that a tree isn't visible from
> another tree if you don't want it to be for security purposes.  That
> basically amounts to making sure processes that shouldn't communicate
> or ptrace each other can't.
> 
> With that view, the kernel's notion of "namespace" is redundant.

I'm not sure. 

> It doesn't add anything to the security model, and it doesn't add
> any useful functionality.

Struct namespace is pretty small, so let's see:

  1) count:  reference count for the "tree"

     if you remove this, how will you know when to "unmount" the tree?

  2) root: the root of the tree

     needed for the unmount, when the namespace has no more references

  3) list: flat list of mounts in the tree

     used by /proc/PID/mounts, but probably not strictly needed

  4) sem:  protects the mount list and the tree from modification

     could be removed in favor of a global lock, but that would
     increase contention

> In other words, is ->mnt_namespace required at all, except to contain
> namespace->sem (which could be changed)?  I don't think it adds
> anything realistic to security.  The way to make secure jails is to
> isolated their trees so they are unreachable.  ->mnt_namespace doesn't
> make any difference to that.

Probably true.  check_mnt() is there to make sure only trees protected
by namespace->sem are modified, and is not a security check.  That is
why the recursive bind mount from foreign namespace is not allowed,
while the simple bind mount is.

Miklos
