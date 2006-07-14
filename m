Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422725AbWGNTZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422725AbWGNTZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 15:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161294AbWGNTZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 15:25:57 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:57734 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161292AbWGNTZ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 15:25:56 -0400
Subject: Re: [RFC][PATCH 3/6] SLIM main patch
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>,
       Dave Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>,
       Serge Hallyn <sergeh@us.ibm.com>
In-Reply-To: <1152901664.314.35.camel@localhost.localdomain>
References: <1152897878.23584.6.camel@localhost.localdomain>
	 <1152901664.314.35.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 14 Jul 2006 12:25:57 -0700
Message-Id: <1152905158.23584.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Comments inline below.

On Fri, 2006-07-14 at 11:27 -0700, Dave Hansen wrote:
> On Fri, 2006-07-14 at 10:24 -0700, Kylene Jo Hall wrote:
> > +static int is_guard_integrity(struct slm_file_xattr *level)
> > +{
> > +	if ((level->guard.iac_r != SLM_IAC_NOTDEFINED)
> > +	    && (level->guard.iac_wx != SLM_IAC_NOTDEFINED))
> > +		return 1;
> > +	return 0;
> > +}
> > +
> > +static int is_guard_secrecy(struct slm_file_xattr *level)
> > +{
> > +	if ((level->guard.sac_rx != SLM_SAC_NOTDEFINED)
> > +	    && (level->guard.sac_w != SLM_SAC_NOTDEFINED))
> > +		return 1;
> > +	return 0;
> > +}
> 
> This is a nice helper function.  I think there are a couple of other
> places where nice helpers like this could really clean things up.
> 
I'll try to clean this up better in the next version.

> > +
> > +#define do_demote_thread_list(head, member) { \
> > +	struct task_struct *thread_tsk; \
> > +	list_for_each_entry(thread_tsk, head, member) \
> > +		do_demote_thread_entry(thread_tsk); \
> > +}
> 
> Can this be an inline function instead?
> 
I wanted to make it a static inline but how would I pass the member
field name that list_for_each_entry needs.  I presume this is why the
list_for_each_* functions are #defines themselves.

> > +static void demote_threads(void)
> > +{
> > +	do_demote_thread_list(&current->sibling, sibling);
> > +	do_demote_thread_list(&current->children, children);
> > +}
> > +
> > +/*
> > + * Revoke write permissions and demote threads using shared memory
> > + */
> > +static void revoke_permissions(struct slm_file_xattr *cur_level)
> > +{
> > +	if ((!is_kernel_thread(current)) && (current->pid != 1)) {
> > +		if (using_shmem())
> > +			demote_threads();
> > +
> > +		revoke_mmap_wperm(cur_level);
> > +		revoke_file_wperm(cur_level);
> > +	}
> > +}
> 
> Is that using_shmem() check really necessary?  IF you're not a threaded
> process and you get asked to demote your threads, I would imagine that
> the code would fall out of the loop immediately.  What does this protect
> against?

I'll test it out.
> 
> > +static enum slm_iac_level set_iac(char *token)
> > +{
> > +	int iac;
> > +
> > +	if (memcmp(token, EXEMPT_STR, strlen(EXEMPT_STR)) == 0)
> > +		return SLM_IAC_EXEMPT;
> > +	else {
> 
> Might as well add brackets here.  Or, just kill the else{} block and
> pull the code back to the lower indenting level.  The else is really
> unnecessary because of the return;

I'll fix next revision.
> 
> > +		for (iac = 0; iac < sizeof(slm_iac_str) / sizeof(char *); iac++) {
> > +			if (memcmp(token, slm_iac_str[iac],
> > +				   strlen(slm_iac_str[iac])) == 0)
> > +				return iac;
> 
> Why not use strcmp?
> 
> > +static enum slm_sac_level set_sac(char *token)
> > +{
> > +	int sac;
> > +
> > +	if (memcmp(token, EXEMPT_STR, strlen(EXEMPT_STR)) == 0)
> > +		return SLM_SAC_EXEMPT;
> > +	else {
> > +		for (sac = 0; sac < sizeof(slm_sac_str) / sizeof(char *); sac++) {
> > +			if (memcmp(token, slm_sac_str[sac],
> > +				   strlen(slm_sac_str[sac])) == 0)
> > +				return sac;
> > +		}
> > +	}
> > +	return SLM_SAC_ERROR;
> > +}
> 
> This function looks awfully similar :).  Can you just pass that array in
> as an argument, and get rid of one of the functions?

Sure that shouldn't be a problem.

> 
> > +static inline int set_bounds(char *token)
> > +{
> > +	if (memcmp(token, UNLIMITED_STR, strlen(UNLIMITED_STR)) == 0)
> > +		return 1;
> > +	return 0;
> > +}
> 
> strcmp?
> 
> > +/* 
> > + * Get the 7 access class levels from the extended attribute 
> > + * Format: TIMESTAMP INTEGRITY SECRECY [INTEGRITY_GUARD INTEGRITY_GUARD] [SECRECY_GUARD SECRECY_GUARD] [GUARD_ TYPE]
> > + */
> > +static int slm_parse_xattr(char *xattr_value, int xattr_len,
> > +			   struct slm_file_xattr *level)
> > +{
> > +	char *token;
> > +	int token_len;
> > +	char *buf, *buf_end;
> > +	int fieldno = 0;
> > +	int rc = -1;
> > +
> > +	buf = xattr_value + sizeof(time_t);
> > +	if (*buf == 0x20)
> > +		buf++;		/* skip blank after timestamp */
> > +	buf_end = xattr_value + xattr_len;
> > +
> > +	while ((token = get_token(buf, buf_end, ' ', &token_len)) != NULL) {
> > +		buf = token + token_len;
> > +		switch (++fieldno) {
> > +		case 1:
> > +			if ((level->iac_level =
> > +			     set_iac(token)) != SLM_IAC_ERROR)
> > +				rc = 0;
> > +			break;
> 
> How about:
> 
> 			level->iac_level = set_iac(token);
> 			if (level->iac_level != SLM_IAC_ERROR)
> 				rc = 0;
> 			break;

ok

> > +	isec->lock = SPIN_LOCK_UNLOCKED;
> > +	return isec;
> > +}
> 
> Is that safe, or is will the spin_lock_init() version make the lock
> debugging code happier?

Ok.

> > +/*
> > + * Exempt objects without extended attribute support 
> > + */
> > +static int is_exempt(struct inode *inode)
> > +{
> > +	if ((inode->i_sb->s_magic == PROC_SUPER_MAGIC)
> > +	    || S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode))
> > +		return 1;
> > +	return 0;
> > +}
> 
> This could probably be a much more generic function, no?  
> 
> inode_supports_xaddr()?  Seems like something that should check a
> superblock flag or something.

I don't know of any such flags.

Thanks,
Kylie

