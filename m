Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965149AbWHWT1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965149AbWHWT1t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 15:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965146AbWHWT1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 15:27:49 -0400
Received: from kanga.kvack.org ([66.96.29.28]:58826 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S965014AbWHWT1s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 15:27:48 -0400
Date: Wed, 23 Aug 2006 15:27:33 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: Kylene Jo Hall <kjhall@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>,
       Dave Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>,
       Serge Hallyn <sergeh@us.ibm.com>
Subject: Re: [PATCH 3/7] SLIM main patch
Message-ID: <20060823192733.GG28594@kvack.org>
References: <1156359937.6720.66.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156359937.6720.66.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2006 at 12:05:37PM -0700, Kylene Jo Hall wrote:
> +/* 
> + * Called with current->files->file_lock. There is not a great lock to grab
> + * for demotion of this type.  The only place f_mode is changed after install
> + * is in mark_files_ro in the filesystem code.  That function is also changing
> + * taking away write rights so even if we race the outcome is the same.
> + */
> +static inline void do_revoke_file_wperm(struct file *file,
> +					struct slm_file_xattr *cur_level)
> +{
> +	struct inode *inode;
> +	struct slm_isec_data *isec;
> +
> +	inode = file->f_dentry->d_inode;
> +	if (!S_ISREG(inode->i_mode) || !(file->f_mode && FMODE_WRITE))
> +		return;
> +
> +	isec = inode->i_security;
> +	spin_lock(&isec->lock);
> +	if (is_lower_integrity(cur_level, &isec->level))
> +		file->f_mode &= ~FMODE_WRITE;
> +	spin_unlock(&isec->lock);
> +}

This function does not do what you claim or hope it is supposed to do.  
Looking at the races (you do nothing to shoot down writes that are in 
progress) present, this does not instill confidence in the rest of the 
code (as always seems to be the case with new security frameworks or 
patches).  Cheers,

		-ben
