Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261393AbVEXHRd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbVEXHRd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 03:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261401AbVEXHRB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 03:17:01 -0400
Received: from dsl081-242-086.sfo1.dsl.speakeasy.net ([64.81.242.86]:32665
	"EHLO lapdance.christiehouse.net") by vger.kernel.org with ESMTP
	id S261393AbVEXHPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 03:15:01 -0400
Message-ID: <4292D416.5070001@waychison.com>
Date: Tue, 24 May 2005 03:13:26 -0400
From: Mike Waychison <mike@waychison.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
Newsgroups: gmane.linux.file-systems,gmane.linux.kernel
To: Miklos Szeredi <miklos@szeredi.hu>
CC: jamie@shareable.org, linuxram@us.ibm.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [RFC][PATCH] rbind across namespaces
References: <1116627099.4397.43.camel@localhost> <E1DZNSN-0006cU-00@dorka.pomaz.szeredi.hu> <1116660380.4397.66.camel@localhost> <E1DZP37-0006hH-00@dorka.pomaz.szeredi.hu> <20050521134615.GB4274@mail.shareable.org> <E1DZlVn-0007a6-00@dorka.pomaz.szeredi.hu> <429277CA.9050300@google.com> <E1DaSCb-0003Tw-00@dorka.pomaz.szeredi.hu>
In-Reply-To: <E1DaSCb-0003Tw-00@dorka.pomaz.szeredi.hu>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi wrote:
>>FWIW, all this stuff has already been done and posted here.
>>
>>Detachable chunks of vfsmounts:
>>http://marc.theaimsgroup.com/?l=linux-fsdevel&m=109872862003192&w=2
>>
>>'Soft' reference counts for manipulating vfsmounts without pinning them 
>>down:
>>http://marc.theaimsgroup.com/?l=linux-kernel&m=109872797030644&w=2
> 
> 
> I think this might just interest Jamie Lokier.  He had a very similar
> poposal recently, but without reference to this patch, so I guess he
> wasn't aware of it.
> 

Interesting.  I haven't been following LKML/fsdevel lately due to lack
of time.

> 
>>Referencing vfsmounts in userspace using a file descriptor:
>>http://marc.theaimsgroup.com/?l=linux-kernel&m=109871948812782&w=2
> 
> 
> Why not just use /proc/PID/fd/FD?

In what sense?  readlink of /proc/PID/fd/* will provide a pathname
relative to current's root: useless for any paths not in current's
namespace.

Also, if we were to hijack /proc/PID/fd/* for cross namespace
manipulation, then we'd be enabling any root user on the system to
modify anyone's namespace.  Any security *cough* provided by namespaces
is lost.  A more secure way is to have root in namespace A allow root in
namespace B do the mounts.  If you further restrict how this hand-off
happens, such as the walking constraints in the patch mentioned below,
we can restrict modification of a namespace to a given sub-tree of
vfsmounts.

This interface also has the huge advantage that you gain all the goodies
of using file descriptors, such as SCM_RIGHTS.  You can hand of entire
trees of mountpoints between applications without ever even binding them
to any namespace whatsoever.

Tie this in with some userspace code that can mount devices for users
with restrictions and appropriate policy, you can create some API+daemon
for regular user apps to get things mounted in a way that guarantees
hiding from other users.

> 
> 
>>walking mountpoints in userspace: 
>>http://marc.theaimsgroup.com/?l=linux-kernel&m=109875012510262&w=2
> 
> 
> Is this needed?  Userspace can find out mountpoints from /proc/mounts
> (or something similar for detached trees).
> 

With detached mountpoints (and especially with detached mountpoint
_trees_) it can become very difficult to assess which trees are which.

Also, just like /proc/PID/fd/*, /proc/mounts is built according to
_current_'s root.  This only gives a skewed view of what is going on.

> 
>>attaching mountpoints in userspace:
>>http://marc.theaimsgroup.com/?l=linux-fsdevel&m=109875063100111&w=2
> 
> 
> Again, bind from/to /proc/PID/fd/FD should work without any new
> interfaces.

No..  It wouldn't.  Pathname resolution is doing everything according to
the ->readlink information provided by this magic proc files, again in
current's namespace.  If you care to hijack ->follow_link, prepare
yourself for a slew of corner cases.

> 
> 
>>detaching mountpoints in userspace:
>>http://marc.theaimsgroup.com/?l=linux-kernel&m=109880051800963&w=2
> 
> 
> What's wrong with sys_umount()?

sys_umount only works with paths in current's namespace. It doesn't
allow you to handle vfsmounts as primaries in userspace.

> 
> 
>>getting info from a vfsmount:
>>http://marc.theaimsgroup.com/?l=linux-kernel&m=109875135030473&w=2
> 
> 
> /proc or /sys should do fine for this purpose I think.
> 

Sure, if you can look it up somehow.  Even if you could currently walk
around in another namespace using fchdir+chdir, you couldn't pull out
kernel-knowledge of mountpoints, you have to fall back to /etc/mtab,
which is completely broken when you mix in namespaces anyway..

> I agree, that having "floating trees" could be useful, but I don't see
> the point of adding new interfaces to support it.
> 

I'm not hugely tied to the idea at the moment.  I implemented it as part
of this interface cause it was a simple extension to what was being done.

> Miklos
> -
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

