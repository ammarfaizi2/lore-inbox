Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261864AbVEXRcn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261864AbVEXRcn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 13:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261904AbVEXRcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 13:32:35 -0400
Received: from rev.193.226.233.9.euroweb.hu ([193.226.233.9]:6159 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261864AbVEXRcS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 13:32:18 -0400
To: mikew@google.com
CC: jamie@shareable.org, linuxram@us.ibm.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
In-reply-to: <42935FCB.1010809@google.com> (message from Mike Waychison on
	Tue, 24 May 2005 10:09:31 -0700)
Subject: Re: [RFC][PATCH] rbind across namespaces
References: <1116627099.4397.43.camel@localhost> <E1DZNSN-0006cU-00@dorka.pomaz.szeredi.hu> <1116660380.4397.66.camel@localhost> <E1DZP37-0006hH-00@dorka.pomaz.szeredi.hu> <20050521134615.GB4274@mail.shareable.org> <E1DZlVn-0007a6-00@dorka.pomaz.szeredi.hu> <429277CA.9050300@google.com> <E1DaSCb-0003Tw-00@dorka.pomaz.szeredi.hu> <4292D416.5070001@waychison.com> <E1DaUj1-0003eq-00@dorka.pomaz.szeredi.hu> <42935FCB.1010809@google.com>
Message-Id: <E1DadFv-0004Te-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 24 May 2005 19:31:51 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >>In what sense?  readlink of /proc/PID/fd/* will provide a pathname
> >>relative to current's root: useless for any paths not in current's
> >>namespace.
> > 
> > 
> > Not readlink, but actual dereference of link will give you exactly the
> > vfsmount/dentry the file was opened on.  If you want to bind/move
> > whatever on that mount, that's possible, even if it's a "detached
> > tree".
> 
> Removing proc_check_root essentially removes any protection that 
> namespaces provided in the first place.
> 
> Think of it like virtual memory.  You can fork off and create your own 
> COW instance, and no one can see what you are doing unless they ptrace 
> you or explicitly ask you.  The mountfd model allows for explicit 
> handing off of vfsmounts between namespaces without allowing arbitrary 
> access.

Note: I didn't say we should remove proc_check_root().  I said _if_
you remove it, _then_ mounting on foreign namespace will work, which
has actually been confirmed experimentally.

So your follow_link argument doesn't hold.  The proc code does the
follow_link in some clever way, that the looked up object will end up
with the same vfsmount/dentry pair as the file.

> Yet even this doesn't allow userspace to define it's own policy for 
> inter-namespace manipulation.

OK.  Let's keep the kernel policy simple: just allow a process to
access it's _own_ file descriptors in proc.  I.e. allow access to
/proc/self/fd/* even if it comes from a foreign namespace.

Then the policy (who passes whom the file descriptors) is entirely up
to userspace (just as with your scheme).

/proc/self/fd/FD doesn't give any extra rights to the process, it just
makes mounting from/to detached mounts, and foreign namespaces
possible without new interfaces.

> Beware that due to the detached-subtrees bit, the locking became a bit 
> ugly, requiring a global rw_lock for mntget/mntput.  I still haven't 
> figured out a better way to keep per-vfsmounts counts and per-subtree 
> counts in sync.

Did you measure the effect on performace?  Maybe it isn't so bad.

Miklos
