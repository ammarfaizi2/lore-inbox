Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751034AbWDLTHm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbWDLTHm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 15:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751068AbWDLTHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 15:07:42 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:32750 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S1750918AbWDLTHl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 15:07:41 -0400
Subject: Re: [RFC][PATCH 1/7] fireflier LSM for labeling sockets based on
	its creator (owner)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: =?ISO-8859-1?Q?T=F6r=F6k?= Edwin <edwin@gurde.com>
Cc: linux-security-module@vger.kernel.org, James Morris <jmorris@namei.org>,
       linux-kernel@vger.kernel.org, fireflier-devel@lists.sourceforge.net
In-Reply-To: <200604072127.30925.edwin@gurde.com>
References: <200604021240.21290.edwin@gurde.com>
	 <200604072034.20972.edwin@gurde.com> <200604072124.24000.edwin@gurde.com>
	 <200604072127.30925.edwin@gurde.com>
Content-Type: text/plain; charset=utf-8
Organization: National Security Agency
Date: Wed, 12 Apr 2006 15:11:52 -0400
Message-Id: <1144869112.1083.27.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-07 at 21:27 +0300, Török Edwin wrote:
> Auto-labeling logic. This is where the (individual&group) SIDs are generated, 
> and maintained.

> diff -uprN null/autolabel.c fireflier_lsm/autolabel.c
> --- /dev/null	1970-01-01 02:00:00.000000000 +0200
> +++ fireflier_lsm/autolabel.c	2006-04-07 17:43:48.000000000 +0300
> +/**
> + * internal_get_or_generate_sid - returns a SID that uniqueuly identifies 
> this devname+inode combination
> + * @devname - name of the mountpoint(device) the process's executable is on
> + * @inode - inode of the process's executable
> + * @unsafe - reason this process might be unsafe (ptrace,etc.)
> + */
> +static inline u32 internal_get_or_generate_sid(const char* devname,const 
> unsigned long inode,const char unsafe)
> +{
> +	u32 sid = FIREFLIER_SID_UNLABELED;
> +	const struct context context=
> +		{
> +			.inode = inode,
> +			.mnt_devname = unlikely(devname==NULL) ? empty_dev : devname,
> +			.groupmembers = 0,
> +			.unsafe = unsafe
> +		};
> +	sidtab_context_to_sid(&fireflier_sidtab,&context,&sid);
<snip>
> +u32 get_or_generate_sid(const struct file* execfile,const char unsafe)
> +{
> +	return 
> internal_get_or_generate_sid(execfile->f_vfsmnt->mnt_devname,execfile->f_dentry->d_inode->i_ino,unsafe);
> +}

(mnt_devname, ino) pair is not a suitable basis here.  If you truly
cannot use inode extended attributes, then you might want to consider
using file handles.  It would help to understand how the userspace
component intends to use the supplied information, e.g. given some kind
of identifier or attribute for the subjects that have access to the
socket, what does the userspace component do with that identifier or
attribute?

-- 
Stephen Smalley
National Security Agency

