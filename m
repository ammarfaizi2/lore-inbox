Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030223AbWI0M3c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030223AbWI0M3c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 08:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030222AbWI0M3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 08:29:31 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:45286 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S1030220AbWI0M3a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 08:29:30 -0400
Subject: Re: [PATCH 4/7] SLIM: secfs patch
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Kylene Jo Hall <kjhall@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>,
       Dave Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>,
       Serge Hallyn <sergeh@us.ibm.com>, akpm@osdl.org
In-Reply-To: <1158612642.16727.53.camel@localhost.localdomain>
References: <1158083873.18137.14.camel@localhost.localdomain>
	 <1158611418.14194.70.camel@moss-spartans.epoch.ncsc.mil>
	 <1158612642.16727.53.camel@localhost.localdomain>
Content-Type: text/plain
Organization: National Security Agency
Date: Wed, 27 Sep 2006 08:30:14 -0400
Message-Id: <1159360214.32075.29.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-09-18 at 13:50 -0700, Kylene Jo Hall wrote:
> On Mon, 2006-09-18 at 16:30 -0400, Stephen Smalley wrote:
> > On Tue, 2006-09-12 at 10:57 -0700, Kylene Jo Hall wrote:
> > > This patch provides the securityfs used by SLIM.
> > > 
> > > Signed-off-by: Mimi Zohar <zohar@us.ibm.com>
> > > Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
> > > --- 
> > >  security/slim/slm_secfs.c |   73 ++++++++++++++++++++++++++++++++++++
> > >  1 files changed, 73 insertions(+)
> > > 
> > > --- linux-2.6.18/security/slim/slm_secfs.c	1969-12-31 16:00:00.000000000 -0800
> > > +++ linux-2.6.17-working/security/slim/slm_secfs.c	2006-09-06 11:49:09.000000000 -0700
> > > @@ -0,0 +1,73 @@
> > > +/*
> > > + * SLIM securityfs support: debugging control files
> > > + *
> > > + * Copyright (C) 2005, 2006 IBM Corporation
> > > + * Author: Mimi Zohar <zohar@us.ibm.com>
> > > + *	   Kylene Hall <kjhall@us.ibm.com>
> > > + *
> > > + *      This program is free software; you can redistribute it and/or modify
> > > + *      it under the terms of the GNU General Public License as published by
> > > + *      the Free Software Foundation, version 2 of the License.
> > > + */
> > > +
> > > +#include <asm/uaccess.h>
> > > +#include <linux/config.h>
> > > +#include <linux/module.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/security.h>
> > > +#include <linux/debugfs.h>
> > > +#include "slim.h"
> > > +
> > > +static struct dentry *slim_sec_dir, *slim_level;
> > > +
> > > +static ssize_t slm_read_level(struct file *file, char __user *buf,
> > > +			      size_t buflen, loff_t *ppos)
> > > +{
> > > +	struct slm_tsec_data *cur_tsec = current->security;
> > > +	ssize_t len;
> > > +	char data[28]; 
> > > +	if (is_kernel_thread(current))
> > > +		len = snprintf(data, sizeof(data), "KERNEL\n");
> > > +	else if (!cur_tsec)
> > > +		len = snprintf(data, sizeof(data), "UNKNOWN\n");
> > > +	else {
> > > +		if (cur_tsec->iac_wx != cur_tsec->iac_r)
> > > +			len = snprintf(data, sizeof(data), "GUARD wx:%s r:%s\n",
> > > +				      slm_iac_str[cur_tsec->iac_wx],
> > > +				      slm_iac_str[cur_tsec->iac_r]);
> > > +		else
> > > +			len = snprintf(data, sizeof(data), "%s\n",
> > > +				      slm_iac_str[cur_tsec->iac_wx]);
> > > +	}
> > > +	return simple_read_from_buffer(buf, buflen, ppos, data, len);
> > > +}
> > 
> > Why do you need this when you implement getprocattr and return the same
> > data that way?
> > 
> True you can get the same info that way but we find it very useful to be
> able to cat this file and get the level of the current process.

It is duplicated code and interface for no obvious purpose - why cannot
you cat /proc/self/attr/current instead?

-- 
Stephen Smalley
National Security Agency

