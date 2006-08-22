Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750995AbWHVT7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbWHVT7q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 15:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751069AbWHVT7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 15:59:45 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:45710 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750995AbWHVT7o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 15:59:44 -0400
Subject: Re: [RFC][PATCH 4/8] SLIM main patch
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: Seth Arnold <seth.arnold@suse.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>,
       Dave Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>,
       Serge Hallyn <sergeh@us.ibm.com>
In-Reply-To: <20060818182510.GS2584@suse.de>
References: <1155844402.6788.58.camel@localhost.localdomain>
	 <20060818011549.GO2584@suse.de>
	 <1155921842.6788.103.camel@localhost.localdomain>
	 <20060818182510.GS2584@suse.de>
Content-Type: text/plain
Date: Tue, 22 Aug 2006 12:59:28 -0700
Message-Id: <1156276769.6720.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-18 at 11:25 -0700, Seth Arnold wrote:
> On Fri, Aug 18, 2006 at 10:24:02AM -0700, Kylene Jo Hall wrote:
> > Thanks for your detailed review.  Responses inline below.
> 
> My pleasure; thanks for considering my comments.
> 
> > throughout (iac vs. sac).  However, on closer look I think you mean the
> > ones which are actually defined with "#define" and those will not be a
> > problem to move.
> 
> Yes, sorry for the confusion; I meant the #defines. :)
> 
> > > All of these booleans could be re-written to simply return the value of
> > > the boolean check. I don't know if those are actually easier to read,
> > > but someone should see them once and decide. :)
> > > 
> > Let me make sure I understand.  You think "return (isec && isec-
> > >level.iacl_level != SLM_IAC_NOTDEFINED);" would be easier?
> 
> Yeah, I'm not a fan of if (foo) return 1 else return 0; perhaps I'm in
> the minority, but I'd feel better if the choice of these two styles were
> made consciously:
> 
> static int is_isec_defined(struct slm_isec_data *isec)
> {
> 	if (isec && isec->level.iac_level != SLM_IAC_NOTDEFINED)
> 		return 1;
> 	return 0;
> }
> 
> static int is_isec_defined(struct slm_isec_data *isec)
> {
> 	return isec && (isec->level.iac_level != SLM_IAC_NOTDEFINED);
> }
> 
> If you find the first easier to work with, then feel free to keep it.
> 
> > > > +static void revoke_mmap_wperm(struct slm_file_xattr *cur_level)
> > > > +{
> > > > +	struct vm_area_struct *mpnt;
> > > > +	struct file *file;
> > > > +	struct dentry *dentry;
> > > > +	struct slm_isec_data *isec;
> > > > +
> > > > +	flush_cache_mm(current->mm);
> > > 
> > > Is it a good idea to flush the cache before making the modifications?
> > > Feels like the wrong order to me.
> > 
> > Our thought was that we are going to revoke write access to the file at
> > this point, bu all pending writes are still valid. So we flush to make
> > sure they can still be written (since we are revoking permission to that
> > operation).
> 
> Is there any danger of another task sharing the mm structure to
> repopulate the cache before your changes are incorporated?

This isn't a problem since we are only revoking the current processes
ability to write to the mmap so we don't care if another process
continues to write.  The flush is there to make sure any previous writes
by the current process (who's write access is being revoked) do actually
get written.
> 
> > > slm_get_xattr() seems remarkably subtle given its name: *status can be
> > > updated at two points in the function, a positive 'rc' from
> > > integrity_verify_data() is left to return at the end, but negative 'rc'
> > > values (that aren't -EOPNOTSUPP) get returned immediately, and if an
> > > error variable is negative, a specific value is returned..
> > > 
> > Yes that does look fishy.  I'll try to straighten it out better.
> 
> > > The complicated set of decision making in get_level() (which sets
> > > levels, heh) might be simplified if slm_get_xattr() internals were
> > > less complicated.
> > 
> > Yes I'll try to straighten out too.  The last review it was requested
> > that INTEGRITY status be returned from the hooks in a *int and regular
> > kernel errors returned from the function to get error propogation
> > correct but seems like we still have it over complicated.
> 
> Ah, yes, separating integrity status from error returns makes sense; I
> hope the functions can be made to read as clearly as your description.
> 
get_level couldn't really be changed other than the name but
slm_get_xattr has been cleaned up.

> > > > +	/* Derived from include/linux/sched.h:capable. */
> > > > +	if (cap_raised(tsk->cap_effective, cap)) {
> > > > +		spin_lock(&tsec->lock);
> > > > +		if (tsec->iac_wx == SLM_IAC_UNTRUSTED &&
> > > > +		    cap == CAP_SYS_ADMIN)
> > > > +			rc = -EACCES;
> > > 
> > > Why is CAP_SYS_ADMIN handled specially?
> > This function is here to add the ability to remove capabilities.
> > CAP_SYS_ADMIN should definitely be removed even if you are running as
> > root but have been demoted to UNTRUSTED.  We are testing others but some
> > tend to break existing applications.
> 
> CAP_SYS_MODULE, CAP_SYS_PTRACE, CAP_SYS_RAWIO, come to mind immediately. :)
> 
All others seemed to cause problems.  We'll continue testing this and
try to add to the list.

> > > > +static int slm_ptrace(struct task_struct *parent, struct task_struct *child)
> > > > +{
> > > > +	struct slm_tsec_data *parent_tsec = parent->security,
> > > > +	    *child_tsec = child->security;
> > > > +	int rc = 0;
> > > > +
> > > > +	if (is_kernel_thread(parent) || is_kernel_thread(child))
> > > > +		return 0;
> > > 
> > > Why was this added?
> > > 
> > Kernel threads are never demoted or restricted by SLIM
> 
> Makes sense; but should an UNTRUSTED process really have the ability to
> ptrace a kernel thread? (Ok, on my tests I wasn't able to strace attach
> to kernel threads, but I'm not positive that it can't be done.)

Good catch only the first half of the if should be there. So that the
kernel thread can ptrace but can't be ptraced by just anyone.
> 
> 
> Thanks Kylene

