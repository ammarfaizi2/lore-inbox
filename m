Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965191AbWHWUf4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965191AbWHWUf4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 16:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965192AbWHWUf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 16:35:56 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:39115 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965189AbWHWUfz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 16:35:55 -0400
Subject: Re: [PATCH 3/7] SLIM main patch
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>,
       Dave Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>,
       Serge Hallyn <sergeh@us.ibm.com>
In-Reply-To: <20060823192733.GG28594@kvack.org>
References: <1156359937.6720.66.camel@localhost.localdomain>
	 <20060823192733.GG28594@kvack.org>
Content-Type: text/plain
Date: Wed, 23 Aug 2006 13:35:56 -0700
Message-Id: <1156365357.6720.87.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-23 at 15:27 -0400, Benjamin LaHaise wrote:
> On Wed, Aug 23, 2006 at 12:05:37PM -0700, Kylene Jo Hall wrote:
> > +/* 
> > + * Called with current->files->file_lock. There is not a great lock to grab
> > + * for demotion of this type.  The only place f_mode is changed after install
> > + * is in mark_files_ro in the filesystem code.  That function is also changing
> > + * taking away write rights so even if we race the outcome is the same.
> > + */
> > +static inline void do_revoke_file_wperm(struct file *file,
> > +					struct slm_file_xattr *cur_level)
> > +{
> > +	struct inode *inode;
> > +	struct slm_isec_data *isec;
> > +
> > +	inode = file->f_dentry->d_inode;
> > +	if (!S_ISREG(inode->i_mode) || !(file->f_mode && FMODE_WRITE))
> > +		return;
> > +
> > +	isec = inode->i_security;
> > +	spin_lock(&isec->lock);
> > +	if (is_lower_integrity(cur_level, &isec->level))
> > +		file->f_mode &= ~FMODE_WRITE;
> > +	spin_unlock(&isec->lock);
> > +}
> 
> This function does not do what you claim or hope it is supposed to do.  
> Looking at the races (you do nothing to shoot down writes that are in 
> progress) present, this does not instill confidence in the rest of the 
> code (as always seems to be the case with new security frameworks or 
> patches).  Cheers,
> 
This function is called in the process of authorizing the current
process to do something which would remove its right to write to the
given file. So it hasn't done anything at the lower integrity level yet
and therefore if a write gets through it can't possibly be of low
integrity data.

Example: The current process is running at the USER level and writing to
a USER file in /home/user/.  The process then attempts to read an
UNTRUSTED file.  The current process will become UNTRUSTED and the read
allowed to proceed but first write access to all USER files is revoked
including the ones it has open.

Thanks,
Kylie 

> 		-ben

