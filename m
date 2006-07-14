Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422735AbWGNTxc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422735AbWGNTxc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 15:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422739AbWGNTxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 15:53:31 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:53226 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1422735AbWGNTxa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 15:53:30 -0400
Date: Fri, 14 Jul 2006 14:52:30 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Kylene Jo Hall <kjhall@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>,
       Dave Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>,
       Serge Hallyn <sergeh@us.ibm.com>
Subject: Re: [RFC][PATCH 3/6] SLIM main patch
Message-ID: <20060714195230.GB6846@sergelap.austin.ibm.com>
References: <1152897878.23584.6.camel@localhost.localdomain> <1152901664.314.35.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152901664.314.35.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dave Hansen (haveblue@us.ibm.com):
> > +static void revoke_file_wperm(struct slm_file_xattr *cur_level)
> > +{
> > +	int i, j = 0;
> > +	struct files_struct *files = current->files;
> > +	unsigned long fd = 0;
> > +	struct fdtable *fdt;
> > +	struct file *file;
> > +
> > +	if (!files || !cur_level)
> > +		return;
> > +
> > +	spin_lock(&files->file_lock);
> > +	fdt = files_fdtable(files);
> > +
> > +	for (;;) {
> > +		i =j * __NFDBITS;
> > +		if ( i>= fdt->max_fdset || i >= fdt->max_fds)
> > +			break;
> > +		fd = fdt->open_fds->fds_bits[j++];
> > +		while(fd) {
> > +			if (fd & 1) {
> > +				file = fdt->fd[i++];
> > +				if (file && file->f_dentry)
> > +					do_revoke_file_wperm(file, cur_level);
> > +			}
> > +			fd >>= 1;
> > +		}
> > +	}
> > +	spin_unlock(&files->file_lock);
> > +}
> 
> This is an awfully ugly function ;)
> 
> Instead of actually walking the fd table and revoking permissions, would
> doing a hook in generic_write_permission() help?  It might be easier to
> switch back and forth.

Or, would using security_file_permission(), which is called on each read
and write to an open file, suffice?  Would it perform as well as this
way?

-serge
