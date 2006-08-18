Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932132AbWHRBAQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbWHRBAQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 21:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbWHRBAQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 21:00:16 -0400
Received: from ihug-mail.icp-qv1-irony2.iinet.net.au ([203.59.1.196]:11873
	"EHLO mail-ihug.icp-qv1-irony2.iinet.net.au") by vger.kernel.org
	with ESMTP id S932132AbWHRBAP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 21:00:15 -0400
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.08,140,1154880000"; 
   d="scan'208"; a="594599677:sNHT618413862"
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
Date: Fri, 18 Aug 2006 08:58:45 +0800
Message-Id: <1155862725.2997.17.camel@raven.themaw.net>
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

And there's no dput for this gotten dentry.

> -	if (dentry != NULL)
> -		return dentry;
> +	if (dentry != NULL) {
> +		/* negative dentries must be reconsidered */
> +		if (!IS_ERR(dentry) && !dentry->d_inode)
> +			d_drop(dentry);
> +		else
> +			return dentry;
> +	}
>  	if (!desc->plus || !(entry->fattr->valid & NFS_ATTR_FATTR))
>  		return NULL;
>  	/* Note: caller is already holding the dir->i_mutex! */

Sorry I didn't look at this more closely earlier.

Just looking at this function alone it looks to me like it is
essentially part of a dentry instantiation which would mean a negative
dentry is perfectly valid at the point above.

Ian

