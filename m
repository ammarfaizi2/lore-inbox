Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946954AbWKARbK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946954AbWKARbK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 12:31:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946955AbWKARbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 12:31:10 -0500
Received: from zombie.ncsc.mil ([144.51.88.131]:22172 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S1946954AbWKARbG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 12:31:06 -0500
Subject: Re: Security issues with local filesystem caching
From: Stephen Smalley <sds@tycho.nsa.gov>
To: David Howells <dhowells@redhat.com>
Cc: Karl MacMillan <kmacmill@redhat.com>, jmorris@namei.org,
       chrisw@sous-sol.org, selinux@tycho.nsa.gov,
       linux-kernel@vger.kernel.org, aviro@redhat.com
In-Reply-To: <4417.1162395294@redhat.com>
References: <1162387735.32614.184.camel@moss-spartans.epoch.ncsc.mil>
	 <16969.1161771256@redhat.com> <31035.1162330008@redhat.com>
	 <4417.1162395294@redhat.com>
Content-Type: text/plain
Organization: National Security Agency
Date: Wed, 01 Nov 2006 12:30:18 -0500
Message-Id: <1162402218.32614.230.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-01 at 15:34 +0000, David Howells wrote:
> Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > Well, only if the module is well-behaved in the first place, since a
> > kernel module can naturally bypass SELinux at will.  What drives this
> > approach vs. exempting the module from SELinux checking via a task flag
> > that it raises and lowers around the access (vs. setting and resetting
> > the sid around the access to the per-cache module context)?
> 
> Christoph objected very strongly to my bypassing of vfs_mkdir() and co, and Al
> wasn't to happy about it either.  This should allow me, for example, to call
> vfs_mkdir() rather than calling the inode op directly as the reason I wasn't
> was that I was having to avoid the security checks it made.

I wasn't suggesting bypassing the vfs helpers; I was only asking what
motivated the approach of substituting a different SID for the
permission checks vs. using a task flag to disable the permission
checking entirely when the module performs an internal access.  The task
flag approach is simpler and avoids the need to set up a label and
policy for the module's internal accesses, which should always succeed
if the module is operating correctly.  The only reason to apply a check
on the module's internal accesses is if you want policy to help
safeguard the module against unintentional access attempts to e.g. the
wrong cache or a file outside of the cache.  And even that is only a
discretionary safeguard wrt the module - it still relies on the module
to not bypass the security hooks and to set the SID correctly for the
cache it wants to access.  

> Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > Do you mean security_transition_sid()?  security_change_sid() doesn't
> > seem suited to that purpose
> 
> That's what Karl said to use.

I think security_transition_sid() is more appropriate if you use this
approach.

> > What would you use as the target SID and class?
> 
> I've no idea.  I tried to find out how to use this function from Karl, but he
> said I should ask on the list.

In normal practice, one passes the task SID as the first argument, the
SID of a related object as the second argument, and the class of object
for which you are computing a SID as the third argument.  For program
execution, this takes the form of the current task SID, the executable
file SID, and the process class, and computes the new task SID of the
transformed process.

> > I think you would want this to be a new ->fssid field instead, and
> > adjust SELinux to use it if set for permission checking (which could
> > also be leveraged by NFS later).
> 
> I could do that.  Does it actually gain anything?  Or are there good reasons
> for not altering current->security->sid?  For instance, does that affect the
> label seen on /proc/pid/ files?

Yes, upon the next d_revalidate, and it also would affect signal
permission checking and any other permission check against that task.

> > Or just use a task flag to disable checking on the module internal accesses.
> 
> I could do that too.

Unless there is some benefit to setting a ->fssid and checking against
it (e.g. safeguarding the module against unintentional internal access),
I think the task flag approach is preferable.

> > But mutating ->sid could yield unfortunate behavior if e.g. another process
> > happens to be sending that task a signal at the same time, so if you go this
> > route, you want a ->fssid.
> 
> Okay... that seems like a good reason to do use the ->fssid approach.  How do I
> tell if ->fssid is set?  Is zero usable as 'unset'?  Alternatively, would it be
> reasonable to have ->fssid track ->sid when the latter changes?

Zero aka SECSID_NULL is unset.  But a task flag may be sufficient here.

-- 
Stephen Smalley
National Security Agency

