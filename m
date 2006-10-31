Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946034AbWJaV2K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946034AbWJaV2K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 16:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946036AbWJaV2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 16:28:10 -0500
Received: from mx1.redhat.com ([66.187.233.31]:43675 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1946034AbWJaV2I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 16:28:08 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <16969.1161771256@redhat.com> 
References: <16969.1161771256@redhat.com> 
To: sds@tycho.nsa.gov, Karl MacMillan <kmacmill@redhat.com>
Cc: David Howells <dhowells@redhat.com>, jmorris@namei.org,
       chrisw@sous-sol.org, selinux@tycho.nsa.gov,
       linux-kernel@vger.kernel.org, aviro@redhat.com
Subject: Re: Security issues with local filesystem caching 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 31 Oct 2006 21:26:48 +0000
Message-ID: <31035.1162330008@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


David Howells <dhowells@redhat.com> wrote:

> Some issues have been raised by Christoph Hellwig over how I'm handling
> filesystem security in my CacheFiles module, and I'd like advice on how to
> deal with them.

Having discussed this with Stephen Smally and Karl MacMillan, this is, I think,
the security model for CacheFiles:

 (*) There will be four security labels per cache:

     (a) A security label attached to the caching directory and all the files
     	 and directories contained therein.  This identifies those files as
     	 being part of a particular cache's working set.

     (b) A security label that defines the context under which the daemon
     	 (cachefilesd) operates.  This permits cachefilesd to be restricted to
     	 only accessing files labelled in (a), and only to do things like stat,
     	 list and delete them - not read or write them.

     (c) A security label that defines the context under which the module
     	 operates when accessing the cache.  This allows the module, when
     	 accessing the cache, to only operate within the bounds of the cache.
     	 It also permits the module to set a common security label on all the
     	 files it creates in the cache.

     (d) A security label to attached to the cachefiles control character
     	 device.  This limits access to processes with label (b).

 (*) The module will obtain label (a) - the security label with which to label
     the files it creates (create_sid) - by reading the security label on the
     cache base directory (inode->i_security->sid).

 (*) The module will obtain label (c) by reading label (b) from the cachefilesd
     process when it opens the cachefiles control chardev and then passing it
     through security_change_sid() to ask the security policy to for label (c).

 (*) When accessing the cache to look up a cache object (equivalent to NFS read
     inode), the CacheFiles module will make temporary substitutions for the
     following process security attributes:

     (1) current->fsuid and current->fsgid will both become 0.

     (2) current->security->create_sid will be set to label (a) so that
         vfs_mkdir() and vfs_create() will set the correct labels.

     (3) current->security->sid will be set to label (c) so that vfs_mkdir(),
         vfs_create() and lookup ops will check for the correct labels.

     After the access, the old label will be restored.

     Point (3) shouldn't cause a cross-thread race as it would appear that the
     security label can only be changed on single-threaded processes.  Attempts
     to do so on multi-threaded processes are rejected.

David
