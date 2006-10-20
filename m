Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964833AbWJTR6u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964833AbWJTR6u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 13:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964831AbWJTR6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 13:58:50 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:59115 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S964829AbWJTR6t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 13:58:49 -0400
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
Date: Fri, 20 Oct 2006 13:58:42 -0400
Message-Id: <1161367122.29755.209.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-19 at 13:48 -0700, Kylene Jo Hall wrote:
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
> +
> +	spin_lock(&tsec->lock);
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

Also, given your security model, why do you always have this hook deny
access rather than attempting to demote the task?

-- 
Stephen Smalley
National Security Agency

