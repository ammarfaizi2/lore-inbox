Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751108AbWJ0QKX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbWJ0QKX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 12:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752298AbWJ0QKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 12:10:23 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:42882 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S1752207AbWJ0QKW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 12:10:22 -0400
Subject: Re: Security issues with local filesystem caching
From: Stephen Smalley <sds@tycho.nsa.gov>
To: David Howells <dhowells@redhat.com>
Cc: aviro@redhat.com, linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
       chrisw@sous-sol.org, jmorris@namei.org
In-Reply-To: <4786.1161963766@redhat.com>
References: <1161960520.16681.380.camel@moss-spartans.epoch.ncsc.mil>
	 <1161884706.16681.270.camel@moss-spartans.epoch.ncsc.mil>
	 <1161880487.16681.232.camel@moss-spartans.epoch.ncsc.mil>
	 <1161867101.16681.115.camel@moss-spartans.epoch.ncsc.mil>
	 <1161810725.16681.45.camel@moss-spartans.epoch.ncsc.mil>
	 <16969.1161771256@redhat.com> <8567.1161859255@redhat.com>
	 <22702.1161878644@redhat.com> <24017.1161882574@redhat.com>
	 <2340.1161903200@redhat.com>   <4786.1161963766@redhat.com>
Content-Type: text/plain
Organization: National Security Agency
Date: Fri, 27 Oct 2006 12:10:10 -0400
Message-Id: <1161965410.1306.47.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-10-27 at 16:42 +0100, David Howells wrote:
> Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
> > We might want more information passed into the hook, like the cache
> > directory itself,
> 
> I can do that.  I have the cache directory path and the cache tag name both
> available as strings.
> 
> > 	int security_cache_set_context(struct vfsmount *mnt, struct dentry *dentry, u32 secid)
> > 	{
> 
> Where are you envisioning this going?  In SELinux, in the LSM core or in
> cachefiles?

Sorry, that should have been named selinux_cache_set_context(), a
SELinux-specific implementation of a security_cache_set_context() LSM
hook.  The hook would be called after the cache directory pathname has
been looked up by your module, yielding a (mnt, dentry) pair and after
the security context string has been mapped to a secid.  

>   I was also wondering if I could generalise it to handle all cache
> types, but the permissions checks are probably going to be quite different for
> each type.  For instance, CacheFiles uses files on a mounted fs, whilst CacheFS
> uses a block device.

So in the latter case, the daemon supplies the path of a block device
node?  I suppose the hook could internally check the type of inode to
decide what checks to apply, using the checks I previously sketched when
it is a directory and using a different set of checks for the block
device (substituting a write check against the block device for the
directory-specific checks).  The hook interface itself would look the
same IIUC, i.e. providing the (mnt, dentry) pair to which the path
resolved and the secid to which the context resolved.

> Also, with your multiple cache example, how would I bring each cachefilesd
> daemon up in a different context so that it could handle a different cache with
> a different context?

runcon will run a program in a specified context, so if you defined
cachesfilesd_internal_t and aachesfilesd_external_t domains in policy,
you could then do:
	runcon -t cachefilesd_internal_t -- /path/to/cachefilesd args...

-- 
Stephen Smalley
National Security Agency

