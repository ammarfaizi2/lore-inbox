Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423813AbWKIOre@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423813AbWKIOre (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 09:47:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423819AbWKIOrd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 09:47:33 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:14528 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1423813AbWKIOrc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 09:47:32 -0500
Date: Thu, 9 Nov 2006 08:50:20 -0600
From: "Bill O'Donnell" <billodo@sgi.com>
To: Chris Friedhoff <chris@friedhoff.org>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-security-module@vger.kernel.org,
       Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
       Chris Wright <chrisw@sous-sol.org>, Andrew Morton <akpm@osdl.org>,
       KaiGai Kohei <kaigai@kaigai.gr.jp>,
       Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH 1/1] security: introduce fs caps
Message-ID: <20061109145020.GA20535@sgi.com>
References: <20061108222453.GA6408@sergelap.austin.ibm.com> <20061109061021.GA32696@sergelap.austin.ibm.com> <20061109103349.e58e8f51.chris@friedhoff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061109103349.e58e8f51.chris@friedhoff.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2006 at 10:33:49AM +0100, Chris Friedhoff wrote:
| Page http://www.friedhoff.org/fscaps.html updated ...
| Kernel 2.6.18.2 updated ...
| System keeps on humming ...
| Is anyone else using/testing the patch? Please give feedback ...
| Thanks ...
I am just starting to test it out.  I'll let you know how it goes.
Thanks!
Bill


| 
| Chris
| 
| 
| On Thu, 9 Nov 2006 00:10:21 -0600
| "Serge E. Hallyn" <serue@us.ibm.com> wrote:
| 
| > Sorry, I should have noticed and fixed this much sooner.  This
| > patch is against the latest full fscaps patch which I'm replying
| > to.
| > 
| > From: Serge E. Hallyn <serue@us.ibm.com>
| > Date: Thu, 9 Nov 2006 00:01:49 -0600
| > Subject: security: file caps: fix unused variable warnings
| > 
| > Address warnings of unused variables at cap_bprm_set_security
| > when file capabilities are disabled, and simultaneously clean
| > up the code a little, by pulling the new code into a helper
| > function.
| > 
| > Rename vfs_cap_data_struct to remove redundant '_struct'.
| > 
| > Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
| > ---
| >  security/commoncap.c |   73 ++++++++++++++++++++++++++++----------------------
| >  1 files changed, 41 insertions(+), 32 deletions(-)
| > 
| > diff --git a/security/commoncap.c b/security/commoncap.c
| > index 6f5e46c..4b50b4d 100644
| > --- a/security/commoncap.c
| > +++ b/security/commoncap.c
| > @@ -109,16 +109,17 @@ void cap_capset_set (struct task_struct 
| >  	target->cap_permitted = *permitted;
| >  }
| >  
| > +#ifdef CONFIG_SECURITY_FS_CAPABILITIES
| >  #define XATTR_CAPS_SUFFIX "capability"
| >  #define XATTR_NAME_CAPS XATTR_SECURITY_PREFIX XATTR_CAPS_SUFFIX
| > -struct vfs_cap_data_struct {
| > +struct vfs_cap_data {
| >  	__u32 version;
| >  	__u32 effective;
| >  	__u32 permitted;
| >  	__u32 inheritable;
| >  };
| >  
| > -static inline void convert_to_le(struct vfs_cap_data_struct *cap)
| > +static inline void convert_to_le(struct vfs_cap_data *cap)
| >  {
| >  	cap->version = le32_to_cpu(cap->version);
| >  	cap->effective = le32_to_cpu(cap->effective);
| > @@ -126,7 +127,7 @@ static inline void convert_to_le(struct 
| >  	cap->inheritable = le32_to_cpu(cap->inheritable);
| >  }
| >  
| > -static int check_cap_sanity(struct vfs_cap_data_struct *cap)
| > +static int check_cap_sanity(struct vfs_cap_data *cap)
| >  {
| >  	int i;
| >  
| > @@ -149,39 +150,14 @@ static int check_cap_sanity(struct vfs_c
| >  	return 0;
| >  }
| >  
| > -int cap_bprm_set_security (struct linux_binprm *bprm)
| > +/* Locate any VFS capabilities: */
| > +static int set_file_caps(struct linux_binprm *bprm)
| >  {
| >  	struct dentry *dentry;
| >  	ssize_t rc;
| > -	struct vfs_cap_data_struct cap_struct;
| > +	struct vfs_cap_data cap_struct;
| >  	struct inode *inode;
| >  
| > -	/* Copied from fs/exec.c:prepare_binprm. */
| > -
| > -	cap_clear (bprm->cap_inheritable);
| > -	cap_clear (bprm->cap_permitted);
| > -	cap_clear (bprm->cap_effective);
| > -
| > -	/*  To support inheritance of root-permissions and suid-root
| > -	 *  executables under compatibility mode, we raise all three
| > -	 *  capability sets for the file.
| > -	 *
| > -	 *  If only the real uid is 0, we only raise the inheritable
| > -	 *  and permitted sets of the executable file.
| > -	 */
| > -
| > -	if (!issecure (SECURE_NOROOT)) {
| > -		if (bprm->e_uid == 0 || current->uid == 0) {
| > -			cap_set_full (bprm->cap_inheritable);
| > -			cap_set_full (bprm->cap_permitted);
| > -		}
| > -		if (bprm->e_uid == 0)
| > -			cap_set_full (bprm->cap_effective);
| > -	}
| > -
| > -#ifdef CONFIG_SECURITY_FS_CAPABILITIES
| > -	/* Locate any VFS capabilities: */
| > -
| >  	dentry = dget(bprm->file->f_dentry);
| >  	inode = dentry->d_inode;
| >  	if (!inode->i_op || !inode->i_op->getxattr) {
| > @@ -216,9 +192,42 @@ #ifdef CONFIG_SECURITY_FS_CAPABILITIES
| >  	bprm->cap_permitted = cap_struct.permitted;
| >  	bprm->cap_inheritable = cap_struct.inheritable;
| >  
| > -#endif
| >  	return 0;
| >  }
| > +#else
| > +static int set_file_caps(struct linux_binprm *bprm)
| > +{
| > +	return 0;
| > +}
| > +#endif
| > +
| > +int cap_bprm_set_security (struct linux_binprm *bprm)
| > +{
| > +	/* Copied from fs/exec.c:prepare_binprm. */
| > +
| > +	cap_clear (bprm->cap_inheritable);
| > +	cap_clear (bprm->cap_permitted);
| > +	cap_clear (bprm->cap_effective);
| > +
| > +	/*  To support inheritance of root-permissions and suid-root
| > +	 *  executables under compatibility mode, we raise all three
| > +	 *  capability sets for the file.
| > +	 *
| > +	 *  If only the real uid is 0, we only raise the inheritable
| > +	 *  and permitted sets of the executable file.
| > +	 */
| > +
| > +	if (!issecure (SECURE_NOROOT)) {
| > +		if (bprm->e_uid == 0 || current->uid == 0) {
| > +			cap_set_full (bprm->cap_inheritable);
| > +			cap_set_full (bprm->cap_permitted);
| > +		}
| > +		if (bprm->e_uid == 0)
| > +			cap_set_full (bprm->cap_effective);
| > +	}
| > +
| > +	return set_file_caps(bprm);
| > +}
| >  
| >  void cap_bprm_apply_creds (struct linux_binprm *bprm, int unsafe)
| >  {
| > -- 
| > 1.4.1
| > 
| 
| 
| --------------------
| Chris Friedhoff
| chris@friedhoff.org
| -
| To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Bill O'Donnell
SGI
651.683.3079
billodo@sgi.com
