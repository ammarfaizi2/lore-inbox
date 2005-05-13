Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262251AbVEMFro@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262251AbVEMFro (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 01:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262253AbVEMFro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 01:47:44 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:49419 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262251AbVEMFrj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 01:47:39 -0400
To: hbryan@us.ibm.com
CC: ericvh@gmail.com, hch@infradead.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, smfrench@austin.rr.com
In-reply-to: <OF1BD633A3.AED1499B-ON88256FFF.006E4A76-88256FFF.00742B3D@us.ibm.com>
	(message from Bryan Henderson on Thu, 12 May 2005 14:08:21 -0700)
Subject: Re: [RCF] [PATCH] unprivileged mount/umount
References: <OF1BD633A3.AED1499B-ON88256FFF.006E4A76-88256FFF.00742B3D@us.ibm.com>
Message-Id: <E1DWT0t-0000of-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 13 May 2005 07:47:07 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > So if a user creates a private namespace, it should have the choice of:
> > 
> >    1) Giving up all suid rights (i.e. all mounts are cloned and
> >       propagated with nosuid)
> > 
> >    2) Not giving up suid for cloned and propagated mounts, but having
> >       extra limitations (suid/sgid programs cannot access unprivileged
> >       "synthetic" mounts)
> 
> (2) isn't realistic.  There's no such thing as a suid program.  Suid is a 
> characteristic of a _file_.  There's no way to know whether a given 
> executing program is running with privileges that came from a suid file 
> getting exec'ed.  Bear in mind that that exec could be pretty remote -- 
> done by a now-dead ancestor with three more execs in between.
> 
> Many user space programs contain hacks to try to discern this information, 
> and they often cause me headaches and I have to fix them.  The usual hacks 
> are euid==uid, euid==suid, and/or euid==0.  It would be an order of 
> magnitude worse for the kernel to contain such a hack.

Guess what?  It's already there.  Look in ptrace_attach() in
kernel/ptrace.c

You could argue about the usefulness of ptrace.  The point is, that
suid/sgid programs _can_ be discerned, and ptrace _needs_ to discern
them.

And for the same reason, user controlled filesystems also need to do
this check.  See Documentation/filesystems/fuse.txt in -mm and later
discussion in this thread for more information.

The strange thing is that people argue so vehemently about this on
theoretical grounds.  But practice shows, that there's in fact no
problem with it whatsoever.  This check (or something similar), has
been in FUSE for more than 3 years, used by thousands of people, and
it didn't cause _any_ problems, except various sub-mount related
things, which we are trying to solve properly, by making mount
unprivileged.

Miklos
