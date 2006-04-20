Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751345AbWDTVoS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbWDTVoS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 17:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbWDTVoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 17:44:18 -0400
Received: from mail.suse.de ([195.135.220.2]:62851 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751345AbWDTVoR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 17:44:17 -0400
Date: Thu, 20 Apr 2006 14:39:55 -0700
From: Tony Jones <tonyj@suse.de>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Al Viro <viro@ftp.linux.org.uk>, linux-kernel@vger.kernel.org,
       chrisw@sous-sol.org, linux-security-module@vger.kernel.org
Subject: Re: [RFC][PATCH 4/11] security: AppArmor - Core access controls
Message-ID: <20060420213955.GA5458@suse.de>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com> <20060419174937.29149.97733.sendpatchset@ermintrude.int.wirex.com> <20060420094036.GU27946@ftp.linux.org.uk> <20060420114010.GB18604@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060420114010.GB18604@sergelap.austin.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2006 at 06:40:10AM -0500, Serge E. Hallyn wrote:
> Quoting Al Viro (viro@ftp.linux.org.uk):
> > 
> > > +static int _aa_perm_dentry(struct aaprofile *active, struct dentry *dentry,
> > > +			   int mask, const char **pname)
> > > +{
> > > +	char *name = NULL, *failed_name = NULL;
> > > +	struct aa_path_data data;
> > > +	int error = 0, failed_error = 0, path_error,
> > > +	    complain = PROFILE_COMPLAIN(active);
> > > +
> > > +	/* search all paths to dentry */
> > > +
> > > +	aa_path_begin(dentry, &data);
> > > +	do {
> > > +		name = aa_path_getname(&data);
> > > +		if (name) {
> > > +			/* error here is 0 (success) or +ve (mask of perms) */
> > > +			error = aa_file_perm(active, name, mask);
> > > +
> > > +			/* access via any path is enough */
> > > +			if (complain || error == 0)
> > > +				break; /* Caller must free name */
> > > +
> > > +			/* Already have an path that failed? */
> > > +			if (failed_name) {
> > > +				aa_put_name(name);
> > > +			} else {
> > > +				failed_name = name;
> > > +				failed_error = error;
> > > +			}
> > > +		}
> > > +	} while (name);
> > 
> > Is that a joke?  Are you really proposing to do _that_ on anything resembling
> > a hot path?

Unfortunately Al, no it's not a joke. We've been asked to publish performance 
numbers by Serge as part of another thread. We plan to do so shortly. Of 
course results are likely going to be related to the complexity of the 
namespace the benchmark operates within. Suggestions of benchmarks that
significantly exercise namespaces are more than welcome.

We are no fan of this code either but the fact is that vfsmounts are passed
inconsistently to the LSM.  Of course this isn't an issue of LSM just not
taking available data, rather of the information not being available in the
VFS at the point the hook is invoked.   Going out on a limb here, to fully 
support read-only bind mounts would seem to require similar changes - but 
with a more limited scope - cases like security_inode_create and 
security_inode_link likely still wouldn't have the necessary information to 
fully eliminate the above fuglyness. Perhaps one hook cannot be made to provide
both useful inode and name information.

> > BTW, the problems here really have nothing to do with namespaces or
> > lazy umount, seeing that it's whitelisting.  Moderate amount of bindings
> > will kill you here.  So much that I suspect that one-time overhead of
> > creating a namespace and umounting / remounting noexec / etc. on
> > execve() will be cheaper than all this crap.
> 
> I guess this would require per-vfsmount flags (i.e. mount --bind -o ro)
> to be implemented, but IIUC the suggestion is
> 
> given a policy
> 
> /bin/stty {
> 	/bin/stty r
> }
> 
> during execve AA would unshare(CLONE_NEWNS), remount / readonly and
> noexec,  and mount /bin/stty into place with exec privs.  I guess
> getting /bin/stty into place shouldn't be much of a challenge (i.e.
> just do the operations in the order
> 	mkdir /.tmp123
> 	mount --bind -o ro,noexec / /.tmp123
> 	mount --bind /bin/stty /.tmp123/bin/stty
> 	mount --bind /.tmp123 /
> )
> but implementing the 'ux' exec permission which apparmor currently has
> (i.e. giving the ability for stty to then execute /bin/login without
> restrictions) could be more challenging.
> 
> This also might beg for sys_unshare() (and corresponding code in clone)
> to have it's own security_vfs_unshare() hook, rather than being globbed
> in with CAP_SYS_ADMIN.

Are we referring here to the idea of giving each confined task it's own
namespace upon exec?  An interesting idea for sure.  The exec portion you
mention above is pretty trivial.  How to handle directories, scratch space
(the ability of a confined task to write selected temp files) is less clear.
Also one of the most powerful aspects of AppArmor (at least if the users are
to be believed :-) is the ability for policy to contain path name expansion
(globbing). For instance, it is very useful to grant one web application 
access to /var/www/**.html and another access to /var/www/**.pl.

But I think passing vfsmounts fully into LSM and closing the cases where a
nameidata can be NULL is an alternative plan B.  Something we are willing to
put effort into helping achieve.

I believe what users want is a system which offers good practical security
together with ease of expressiveness in policy (so that it may be actually
maintained by other than distribution vendors). We strongly believe that 
AppArmor provides this and think it is important to persue changes to LSM 
(and the VFS) as necessary.  However there is clearly an undeniable elegance 
to the per-confined-task namespace idea. I have my concerns about whether it 
can achieve close to the same expressiveness as current AppArmor policy (one 
of AppArmor's clear advantages over SELinux) but it is clearly important that 
the namespace idea is explored. Just not to the exclusion of also exploring 
rework of the LSM/VFS.

Tony
