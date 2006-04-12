Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932287AbWDLRil@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbWDLRil (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 13:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbWDLRil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 13:38:41 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:447 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S932262AbWDLRik (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 13:38:40 -0400
Subject: Re: [RFC][PATCH 2/7] implementation of LSM hooks
From: Stephen Smalley <sds@tycho.nsa.gov>
To: =?ISO-8859-1?Q?T=F6r=F6k?= Edwin <edwin@gurde.com>
Cc: linux-security-module@vger.kernel.org, James Morris <jmorris@namei.org>,
       linux-kernel@vger.kernel.org, fireflier-devel@lists.sourceforge.net
In-Reply-To: <200604072138.35201.edwin@gurde.com>
References: <200604021240.21290.edwin@gurde.com>
	 <200604072034.20972.edwin@gurde.com> <200604072124.24000.edwin@gurde.com>
	 <200604072138.35201.edwin@gurde.com>
Content-Type: text/plain; charset=utf-8
Organization: National Security Agency
Date: Wed, 12 Apr 2006 13:42:48 -0400
Message-Id: <1144863768.32059.67.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-07 at 21:38 +0300, Török Edwin wrote:
> Implementation of the LSM hooks. It is based on hooks.c from SELinux. 
> I replaced the avc with calls to functions from autolabel.c
> 
> Also, one important difference:
> - when open files are checked during an execve, they are NOT closed when a 
> domain transition occurs to a different sid. A group SID is created, and both 
> the old sid, and new sids can be retrieved later.
> 
> How could I write an SELinux policy that does this?

I don't think you can without further changes to SELinux, as you are
mutating object labels in response to events (aka floating labels).  But
the real question is why do you want to, i.e. what is actual functional
requirement, not just how you have chosen to implement it.

> diff -uprN null/hooks.c fireflier_lsm/hooks.c
> --- null/hooks.c	1970-01-01 02:00:00.000000000 +0200
> +++ fireflier_lsm/hooks.c	2006-04-07 17:43:37.000000000 +0300
> + * This function might sleep.
> + */
> +static int task_alloc_security(struct task_struct *task)
> +{
> +	struct fireflier_task_security_struct *tsec;
> +	
> +	tsec = kzalloc(sizeof(*tsec), GFP_ATOMIC);

Why GFP_ATOMIC?

> +	if (!tsec)
> +		return -ENOMEM;
> +	
> +	tsec->magic = FIREFLIER_MAGIC;

Drop the magic fields and tests; they are a relic of early LSM
development and have been dropped from SELinux.  Also you should
naturally drop any fields you aren't using.

> +static int fireflier_task_alloc_security(struct task_struct *tsk)
> +{
> +	struct fireflier_task_security_struct *tsec_current, *tsec_tsk;
> +
> +
> +	int rc;
> +	rc = task_alloc_security(tsk);
> +	if (rc)
> +		return rc;
> +	tsec_current = current->security;
> +	if(tsec_current) {

Better if you can guarantee that all tasks have a security structure,
either via early initialization or by processing them all during your
own initialization.

> +	return secondary_ops->task_alloc_security(tsk);

Don't call a secondary module hook unless you truly need it and know
that it can work.  In particular, alloc_security hooks can't work
properly without some mechanism for sharing the security field, so no
point in doing this here.

> +static int fireflier_bprm_set_security(struct linux_binprm *bprm)
> +{
> +	struct fireflier_bprm_security_struct *bsec;
> +
> +	bsec = bprm->security;
> +	if(unlikely(!bsec)) {
> +		printk(KERN_DEBUG "Fireflier: bprm->security not set\n");

Shouldn't be possible since you are allocating one in the other hook,
right, so don't test for such conditions.  You don't gain anything, and
you may hide or lose useful info that you would have gotten from the
Oops if it did occur.  Naturally the printks have to go for real use.

> +/**
> + * fireflier_bprm_free_security - free the binbprm's security structure
> + * @bprm: linux_binprm structure, who's security structure is to be freed
> + */
> +static void fireflier_bprm_free_security(struct linux_binprm *bprm)
> +{
> +	BUG_ON(!bprm->security);

Again, it doesn't serve any real purpose to have this kind of test.

> +	kfree(bprm->security);
> +	bprm->security = NULL;
> +	return secondary_ops->bprm_free_security(bprm);

And calling a secondary module here isn't likely to work anyway.

> +static void fireflier_bprm_apply_creds(struct linux_binprm *bprm, int unsafe)
> +{
> +	struct fireflier_task_security_struct *tsec;
> +	struct fireflier_bprm_security_struct *bsec;
> +	u32 sid;
> +
> +
> +	secondary_ops->bprm_apply_creds(bprm, unsafe);
> +
> +	tsec = current->security;
> +	bsec = bprm->security;
> +	if(unlikely(!bsec)) {
> +		printk(KERN_DEBUG "No bprm security structure allocated\n");
> +		dump_stack();
> +		return;
> +	}

Again, drop the test and let it Oops if it happens.

> +	sid = bsec->sid;
> +
> +
> +	bsec->unsafe = 0;
> +	if(unlikely(!tsec)) {
> +		printk(KERN_DEBUG "No security structure allocated\n");
> +		dump_stack();
> +		return;
> +	}

Ditto.

> +/**
> + * inode_update_perm - update the group SID of this inode
> + * @tsk - the task that has accesses the inode
> + * @inode - the inode who's SID has to be updated
> + * A task has accessed this file, add the task's SID to the group SID of 
> tasks
> + * accessing the file
> + * based on inode_has_perm 
> + */
> +static void inode_update_perm(struct task_struct *tsk,struct inode *inode)
> +{
> +	struct fireflier_task_security_struct *tsec;
> +	struct fireflier_inode_security_struct *isec;
> +
> +     	tsec = tsk->security;
> +   	isec = inode->i_security;
> +   	if(!isec) 
> +     		return;
> +   
> +     	if(unlikely(!tsec))
> +       		isec->sid = compute_inode_sid(isec->sid,FIREFLIER_SID_UNLABELED);
> +   	else
> +     		isec->sid = compute_inode_sid(isec->sid,tsec->sid);
> +   	printk(KERN_DEBUG "computed inode 
> sid: %ld->%d\n",inode->i_ino,isec->sid);   
> +}

Locking?  You are mutating the inode's SID, but many different tasks may
be accessing (in this case, inheriting/receiving a descriptor to) the
inode simultaneously.  Not clear that SIDs are even the right primitive
for what you are doing here, essentially aggregating a list of all
subjects that have gained a descriptor to the socket.  

> +static  inline void file_update_perm(struct task_struct *tsk, struct file 
> *file)    
> +{
> +   
> +	struct fireflier_task_security_struct *tsec = tsk->security;
> +	struct fireflier_file_security_struct *fsec = file->f_security;
> +	struct dentry *dentry = file->f_dentry;
> +	struct inode *inode = dentry->d_inode;
> +   
> +	inode_update_perm(tsk, inode);
> +   
> +	if(!fsec)
> +		return;
> +	if(unlikely(!tsec))
> +		fsec->sid=compute_inode_sid(fsec->sid,FIREFLIER_SID_UNLABELED);
> +	else
> +		fsec->sid=compute_inode_sid(fsec->sid,tsec->sid);

As before, locking required for safety.  But also - where do you use
this fsec->sid for anything (vs. the isec->sid)?

> +static int fireflier_inode_getsecurity(struct inode *inode, const char *name, 
> void *buffer, size_t size, int err)
> +{
<snip>
> +	if (err > 0) {
> +		if ((len == err) && !(memcmp(context, buffer, len))) {
> +			/* Don't need to canonicalize value */
> +			rc = err;
> +			goto out_free;
> +		}
> +		memset(buffer, 0, size);

IIUC, since you are dealing with sockets, this case is extraneous for
you.  In SELinux, it only exists for the case where you have an on-disk
xattr that already matches the incore representation, and is actually
eliminated in recent patches altogether.

> +	}
> +	memcpy(buffer, context, len);
> +	rc = len;
> + out_free:
> +	kfree(context);
> + out:
> +	return secondary_ops->inode_getsecurity(inode,name,buffer,size,err);
> +}

If there is a secondary module that implements that hook, won't it end
up clobbering what you just put into the buffer (and you lose the rc
value here)?  Again, drop any secondary hooks that you don't need and
that can't work in the absence of a real stacking solution.

> +
> +static int fireflier_inode_listsecurity(struct inode *inode, char *buffer, 
> size_t buffer_size)
> +{
> +	if(inode->i_security) 
> +	{
> +	
> +		const int len = sizeof(XATTR_NAME_FIREFLIER);
> +		if (buffer && len <= buffer_size)
> +			memcpy(buffer, XATTR_NAME_FIREFLIER, len);
> +		return len+
> +			secondary_ops->inode_listsecurity(inode,buffer+len,buffer_size-len);

What if len > buffer_size?  But as before, don't bother calling
secondary here unless you can actually make it work and have a need for
it.

-- 
Stephen Smalley
National Security Agency

