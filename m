Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752200AbWKAN3Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752200AbWKAN3Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 08:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752195AbWKAN3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 08:29:16 -0500
Received: from mummy.ncsc.mil ([144.51.88.129]:35971 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S1752180AbWKAN3P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 08:29:15 -0500
Subject: Re: Security issues with local filesystem caching
From: Stephen Smalley <sds@tycho.nsa.gov>
To: David Howells <dhowells@redhat.com>
Cc: Karl MacMillan <kmacmill@redhat.com>, jmorris@namei.org,
       chrisw@sous-sol.org, selinux@tycho.nsa.gov,
       linux-kernel@vger.kernel.org, aviro@redhat.com
In-Reply-To: <31035.1162330008@redhat.com>
References: <16969.1161771256@redhat.com>   <31035.1162330008@redhat.com>
Content-Type: text/plain
Organization: National Security Agency
Date: Wed, 01 Nov 2006 08:28:55 -0500
Message-Id: <1162387735.32614.184.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-31 at 21:26 +0000, David Howells wrote:
> David Howells <dhowells@redhat.com> wrote:
> 
> > Some issues have been raised by Christoph Hellwig over how I'm handling
> > filesystem security in my CacheFiles module, and I'd like advice on how to
> > deal with them.
> 
> Having discussed this with Stephen Smally and Karl MacMillan, this is, I think,
> the security model for CacheFiles:
> 
>  (*) There will be four security labels per cache:
> 
>      (a) A security label attached to the caching directory and all the files
>      	 and directories contained therein.  This identifies those files as
>      	 being part of a particular cache's working set.
> 
>      (b) A security label that defines the context under which the daemon
>      	 (cachefilesd) operates.  This permits cachefilesd to be restricted to
>      	 only accessing files labelled in (a), and only to do things like stat,
>      	 list and delete them - not read or write them.
> 
>      (c) A security label that defines the context under which the module
>      	 operates when accessing the cache.  This allows the module, when
>      	 accessing the cache, to only operate within the bounds of the cache.

Well, only if the module is well-behaved in the first place, since a
kernel module can naturally bypass SELinux at will.  What drives this
approach vs. exempting the module from SELinux checking via a task flag
that it raises and lowers around the access (vs. setting and resetting
the sid around the access to the per-cache module context)?

>      	 It also permits the module to set a common security label on all the
>      	 files it creates in the cache.
> 
>      (d) A security label to attached to the cachefiles control character
>      	 device.  This limits access to processes with label (b).
> 
>  (*) The module will obtain label (a) - the security label with which to label
>      the files it creates (create_sid) - by reading the security label on the
>      cache base directory (inode->i_security->sid).
> 
>  (*) The module will obtain label (c) by reading label (b) from the cachefilesd
>      process when it opens the cachefiles control chardev and then passing it
>      through security_change_sid() to ask the security policy to for label (c).

Do you mean security_transition_sid()?  security_change_sid() doesn't
seem suited to that purpose (relabeling vs. transition computations).
What would you use as the target SID and class?  What happens if there
is no transition/change rule in the policy?  It seems like the default
behavior would leave it operating in the context of the daemon itself,
in which case you might end up denying access to the module upon
creation?

>  (*) When accessing the cache to look up a cache object (equivalent to NFS read
>      inode), the CacheFiles module will make temporary substitutions for the
>      following process security attributes:
> 
>      (1) current->fsuid and current->fsgid will both become 0.
> 
>      (2) current->security->create_sid will be set to label (a) so that
>          vfs_mkdir() and vfs_create() will set the correct labels.
> 
>      (3) current->security->sid will be set to label (c) so that vfs_mkdir(),
>          vfs_create() and lookup ops will check for the correct labels.

I think you would want this to be a new ->fssid field instead, and
adjust SELinux to use it if set for permission checking (which could
also be leveraged by NFS later).  Or just use a task flag to disable
checking on the module internal accesses. 

>      After the access, the old label will be restored.
> 
>      Point (3) shouldn't cause a cross-thread race as it would appear that the
>      security label can only be changed on single-threaded processes.  Attempts
>      to do so on multi-threaded processes are rejected.

I don't quite follow this.  The cache module needs to be able to perform
cache access on behalf of any process, including multi-threaded ones,
and the security struct is per-task just like fsuid/fsgid.  But mutating
->sid could yield unfortunate behavior if e.g. another process happens
to be sending that task a signal at the same time, so if you go this
route, you want a ->fssid.

-- 
Stephen Smalley
National Security Agency

