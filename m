Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263416AbTEMU1I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 16:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263411AbTEMUZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 16:25:27 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:48139 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263396AbTEMUZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 16:25:15 -0400
Date: Tue, 13 May 2003 21:37:59 +0100
From: Christoph Hellwig <hch@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, openafs-devel@openafs.org
Subject: Re: [PATCH] PAG support only
Message-ID: <20030513213759.A9244@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	openafs-devel@openafs.org
References: <8943.1052843591@warthog.warthog>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <8943.1052843591@warthog.warthog>; from dhowells@redhat.com on Tue, May 13, 2003 at 05:33:11PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -166,6 +166,7 @@
>  	if (file->f_op && file->f_op->release)
>  		file->f_op->release(inode, file);
>  	security_file_free(file);
> +	if (file->f_token) vfs_token_put(file->f_token);

Please split this into 2 lines as per Documentation/CodingStyle.  Even better
make vfs_token_put handle a NULL argument.

> diff -uNr linux-2.5.69/fs/open.c linux-2.5.69-cred/fs/open.c
> --- linux-2.5.69/fs/open.c	2003-05-06 15:04:45.000000000 +0100
> +++ linux-2.5.69-cred/fs/open.c	2003-05-13 11:28:08.000000000 +0100
> @@ -46,7 +46,7 @@
>  	struct nameidata nd;
>  	int error;
>  
> -	error = user_path_walk(path, &nd);
> +	error = user_path_walk(path,&nd);

Random whitespace change - and even a wrong one..

> +static inline int is_vfs_token_valid(struct vfs_token *vtoken)
> +{
> +	return !list_empty(&vtoken->link);
> +}

This one is not used - and the name would imply it would be used without taking
a lock and thus racy..

> +static kmem_cache_t *vfs_token_cache;
> +static kmem_cache_t *vfs_pag_cache;

How many of those will be around for a typical AFS client?  I have the vague
feeling the slabs are overkill..

> +	if (pag>0) {
> +		/* join existing PAG */
> +		if (tsk->vfspag->pag &&
> +		    tsk->vfspag->pag==pag)
> +			return pag;

Please try to get your code in conformance with Documentation/CodingStyle.

> +} /* end vfs_pag_put() */

