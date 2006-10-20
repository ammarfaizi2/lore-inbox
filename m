Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946221AbWJTPcm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946221AbWJTPcm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 11:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946198AbWJTPcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 11:32:42 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:1277 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S1946127AbWJTPck (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 11:32:40 -0400
Subject: Re: [PATCH 3/7] SLIM main patch
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Kylene Jo Hall <kjhall@us.ibm.com>
Cc: akpm@osdl.org, Serge Hallyn <sergeh@us.ibm.com>,
       Mimi Zohar <zohar@us.ibm.com>, Dave Safford <safford@us.ibm.com>,
       LSM ML <linux-security-module@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1161290893.5182.106.camel@localhost.localdomain>
References: <1158083865.18137.13.camel@localhost.localdomain>
	 <1159296281.25493.31.camel@moss-spartans.epoch.ncsc.mil>
	 <1161290893.5182.106.camel@localhost.localdomain>
Content-Type: text/plain
Organization: National Security Agency
Date: Fri, 20 Oct 2006 11:32:35 -0400
Message-Id: <1161358356.29755.175.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-19 at 13:48 -0700, Kylene Jo Hall wrote:
> On Tue, 2006-09-26 at 14:44 -0400, Stephen Smalley wrote: 
> > Neither the above text nor your Documentation nor your code comments
> > seems to have been fully updated to reflect the changes to SLIM in this
> > submission, e.g. the removal of the secrecy MAC model and the change in
> > how you deal with "revocation".  Thus they are misleading and confusing
> > to potential users and to subsequent maintenance of the code.
> I'll provide a patch that fixes the comments and in-tree documentation.

That won't fix the actual patch descriptions, so I'd suggest just making
up a new patch set with all fixes folded into it targeted at replacing
the current patch set in -mm.  That would also facilitate full review of
the updated code as a whole, which I think is needed.

> > I think you would do better to just drop out the so-called "revocation"
> > code altogether and acknowledge this limitation in your Documentation.
> > Meanwhile, you could do a better job of using the permission checking
> > hooks that do exist to apply checks on subsequent operations after
> > demotion, like implementing file_receive, file_mmap, etc. 
> > 
> You are right in your AF_LOCAL socket concern.  We have been working
> on that and have implemented the file_receive hook, however, once we
> have this hook we cannot imagine the case where file_mmap is also
> needed.  If you still feel it is necessary can you please explain
> further.

I suppose that depends on the resolution of how you handle the
revocation issue and what you want to enforce and measure.

> --- linux-2.6.19-rc2/security/slim/slm_main.c	2006-10-19 12:05:58.000000000 -0700
> +++ linux-2.6.19-rc2/security/slim/slm_main.c	2006-10-19 12:11:37.000000000 -0700
> @@ -1130,6 +1103,34 @@ static int slm_socket_post_create(struct
>  	return 0;
>  }
>  
> +static int slm_file_receive(struct file *file)
> +{
> +	struct slm_isec_data *isec = file->f_dentry->d_inode->i_security;
> +	struct slm_tsec_data *tsec = current->security;
> +	struct slm_file_xattr level;
> +	int rc = 0;
> +
> +	spin_lock(&isec->lock);
> +	memcpy(&level, &isec->level, sizeof(struct slm_file_xattr));
> +	spin_unlock(&isec->lock);

What are you achieving with your lock?
Suppose that you just did the following here without any locking:
	enum slm_iac_level iac = isec->level.iac_level;
using that iac value in your subsequent checks, and suppose that in
post_setxattr you did the following likewise without any locking:
	isec->level.iac_level = level->iac_level;
What difference does it make to your checks?  Under both forms, it is
possible that the checks could be applied against the old value or the
new value when another thread is performing setxattr.

> +	spin_lock(&tsec->lock);

Keeping in mind that tsec is per-task (thread) and that you no longer
try to demote other threads, what purpose does this lock serve?

> +	if (file->f_mode & FMODE_READ) { /* IRAC(process) <= IAC(object) */
> +		if (!is_iac_less_than_or_exempt(&level, tsec->iac_r))
> +			rc = -EPERM;
> +	}
> +	if (file->f_mode & FMODE_WRITE) { /* IWXAC(process) >= IAC(object) */
> +		if (!is_iac_greater_than_or_exempt(&level, tsec->iac_wx))
> +			rc = -EPERM;
> +	}
> +	if (file->f_mode & FMODE_EXEC) { /* IWXAC(process) <= IAC(object) */
> +		if (!is_iac_less_than_or_exempt(&level, tsec->iac_wx))
> +			rc = -EPERM;
> +	}
> +	spin_unlock(&tsec->lock);
> +	return rc;
> +}
> +

> As for removing revocation altogether (and keeping demotion) we are
> concerned that checking every read and write for example in the
> file_permission hook would be a signifcant performance hit over the
> revocation way.

A file_permission hook implementation for SLIM should be quite simple
and fast in the common case, so I think performance is not the issue
here.

>   Additionally, Alan Cox brought up that demoting with an
> writeable open file really isnt' safe (http://marc.theaimsgroup.com/?
> l=linux-kernel&m=115643804205202&w=2) and revocation would still be
> necessary for mmaps as I don't know of a security hook that can be used
> to double check reads and writes to mmaps.

I believe Alan's point was that you need the core revoke() functionality
if you want to do this right.  Instead, you chose to back off from real
revocation, yielding a change in your security model (an application can
now get a denial upon a read attempt if demotion cannot be performed
safely), different handling for open files vs. memory mappings
(confusing semantics), and code that is still neither simple nor safe.

> Is it really not possible to enumerate all the possible cases and
> mediate them?

It can be done, but you didn't seem interested in doing it the right
way.  So if you aren't willing to do that, at least document the
limitations of your implementation.

> You were right about all the issues with this function.  It is no longer
> needed thus negating the issue with the locking.  Removing this and the
> reason it had been around (explanation below) also negates the need for
> the other is_isec_defined checks.  I looked and the rest of the locking
> looks sane to me.  Please point out any other particular instances you
> aren't sure about.

See my comments about the isec and tsec locking above - they apply
throughout.

> > This only checks for users of the mm (not necessarily other forms of
> > sharing), and it can yield "false" positives due to transient references
> > (also noted by Hugh).  If you look at the SELinux code, you'll see a
> > more complex test applied in selinux_setprocattr after this test, and
> > that is only checking for mm sharing.  For sharing of the file table,
> > there is the unsafe_exec checking that happens, with the corresponding
> > LSM_UNSAFE_SHARE check applied by SELinux (since we are only flushing
> > the table on context-changing exec).
> 
> Yes the mm_users check as is will cause us to fail things that might not
> necessarily need to fail but at least we are failing closed.

...which makes it prone to easy denial of service by another process
(just accessing the /proc/pid nodes of the target).

> It seems that all the checks in sys_unshare should be done and those
> that can be unshared should be and if any sharing exists that can't be
> undone (such as unshare_vm) then the demotion would need to be
> prevented.  We would implement this similar to how we split sys_mprotect
> and do_mprotect creating an exported do_unshare.

I don't think you want to automatically unshare state without
application awareness.

> > > +static int is_untrusted_blk_access(struct inode *inode)
> > > +{
> > > +	struct slm_tsec_data *cur_tsec = current->security;
> > > +	int rc = 0;
> > > +
> > > +	spin_lock(&cur_tsec->lock);
> > > +	if (cur_tsec && (cur_tsec->iac_wx == SLM_IAC_UNTRUSTED)
> > > +	    && S_ISBLK(inode->i_mode))
> > > +		rc = 1;
> > > +	spin_unlock(&cur_tsec->lock);
> > > +	return rc;
> > > +}
> > 
> > This kind of special case logic is troubling, and shouldn't be necessary.
> 
> Unfortunately, this does seem necessary.  Block devices don't have
> xattrs and thus are treated as EXEMPT.

Um, what?  They certainly can have xattrs, and SELinux assigns an
attribute to them.

>   However, they shouldn't be
> written to except by SYSTEM (logic updated to enforce this rather than !
> UNTRUSTED).  We thought about special casing them to be SYSTEM
> instead of EXEMPT or that might be able to do something like SELinux and
> provide a daemon to label these files at boot, however, then special
> casing would be necessary to avoid measuring these devices.  You don't
> really want /dev/hda1 rehashed everytime you write to the filesystem.

I don't follow.  Device nodes can certainly support xattrs, and SELinux
has always labeled them.  When udev came along, it was instrumented to
likewise handle labeling of the device nodes it creates.  If someone
actually does write to the raw device, then ignoring that for
measurement makes your measurements rather meaningless.  If someone
writes to a file within a mounted filesystem, there is no check against
the device node.

> The SLIM measure policy is to measure all system files and anything executable.
> Things opened writable are not measured.  Executables are caught in the
> bprm_check_security hook. Measurement cannot be moved to d_instantiate for
> example because you don't know what flags the file will be opened with.
> The measure hook is really only using the dentry to get the inode I will
> provide a patch to change the hook to accept an inode instead, though the
> filename will sometimes not be available without a dentry.

So how does this differ from digsig (aside from the distinction between
measurement and signature verification, and aside from dealing with more
than just executables)?  Why aren't you checking on
file_mmap/mprotect()?  What good does it do to measure from
inode_permission() if the actual content that is subsequently read
doesn't match what you measured?  etc.  Seems like all the prior
discussions of digsig and IMA apply here.  

-- 
Stephen Smalley
National Security Agency

