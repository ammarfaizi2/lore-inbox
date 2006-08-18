Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932188AbWHRArm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbWHRArm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 20:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbWHRArm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 20:47:42 -0400
Received: from ihug-mail.icp-qv1-irony4.iinet.net.au ([203.59.1.198]:17491
	"EHLO mail-ihug.icp-qv1-irony4.iinet.net.au") by vger.kernel.org
	with ESMTP id S932180AbWHRArl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 20:47:41 -0400
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.08,140,1154880000"; 
   d="scan'208"; a="857299643:sNHT134686810"
Subject: Re: [PATCH] NFS: Replace null dentries that appear in readdir's
	list
From: Ian Kent <raven@themaw.net>
To: David Howells <dhowells@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel@vger.kernel.org, aviro@redhat.com
In-Reply-To: <13319.1155744959@warthog.cambridge.redhat.com>
References: <1155743399.5683.13.camel@localhost>
	 <20060813133935.b0c728ec.akpm@osdl.org>
	 <20060813012454.f1d52189.akpm@osdl.org>
	 <5910.1155741329@warthog.cambridge.redhat.com>
	 <13319.1155744959@warthog.cambridge.redhat.com>
Content-Type: text/plain
Date: Fri, 18 Aug 2006 08:47:43 +0800
Message-Id: <1155862063.2997.6.camel@raven.themaw.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-16 at 17:15 +0100, David Howells wrote:

>  fs/nfs/dir.c |    9 +++++++--
>  1 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index e746ed1..bb8b5f0 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -1105,8 +1105,13 @@ static struct dentry *nfs_readdir_lookup
>  	}
>  	name.hash = full_name_hash(name.name, name.len);
>  	dentry = d_lookup(parent, &name);
> -	if (dentry != NULL)
> -		return dentry;
> +	if (dentry != NULL) {
> +		/* negative dentries must be reconsidered */
> +		if (!IS_ERR(dentry) && !dentry->d_inode)
> +			d_drop(dentry);

Don't we need to return something like NULL here also?

> +		else
> +			return dentry;
> +	}
>  	if (!desc->plus || !(entry->fattr->valid & NFS_ATTR_FATTR))
>  		return NULL;
>  	/* Note: caller is already holding the dir->i_mutex! */
