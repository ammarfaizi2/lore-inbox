Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262403AbVC3WD3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262403AbVC3WD3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 17:03:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262362AbVC3WD3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 17:03:29 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:19345
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S262438AbVC3WDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 17:03:22 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: blaisorblade@yahoo.it
Subject: Re: [patch 6/8] uml: fix hostfs special perm handling [for 2.6.12]
Date: Wed, 30 Mar 2005 15:59:34 -0500
User-Agent: KMail/1.6.2
Cc: torvalds@osdl.org, akpm@osdl.org, jdike@addtoit.com,
       linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
References: <20050330173400.36A5FEFEFF@zion>
In-Reply-To: <20050330173400.36A5FEFEFF@zion>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200503301559.34350.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 March 2005 12:34 pm, blaisorblade@yahoo.it wrote:
> From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> CC: Rob Landley <rob@landley.net>
> When opening devices nodes on hostfs, it does not make sense to call
> access(), since we are not going to open the file on the host.
>
> If the device node is owned by root, the root user in UML should succeed in
> opening it, even if UML won't be able to open the file.
>
> As reported by Rob Landley, UML currently does not follow this, so here's
> an (untested) fix.
>
> Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Not untested, it Worked For Me (tm).

Signed-off-by: Rob Landley <rob@landley.net>

> ---
>
>  linux-2.6.11-paolo/fs/hostfs/hostfs_kern.c |   20 +++++++++++++-------
>  1 files changed, 13 insertions(+), 7 deletions(-)
>
> diff -puN fs/hostfs/hostfs_kern.c~uml-fix-hostfs-special-perm-handling
> fs/hostfs/hostfs_kern.c ---
> linux-2.6.11/fs/hostfs/hostfs_kern.c~uml-fix-hostfs-special-perm-handling	2
>005-03-22 20:10:07.000000000 +0100 +++
> linux-2.6.11-paolo/fs/hostfs/hostfs_kern.c	2005-03-22 20:12:45.000000000
> +0100 @@ -806,15 +806,21 @@ int hostfs_permission(struct inode *ino,
>  	char *name;
>  	int r = 0, w = 0, x = 0, err;
>
> -	if(desired & MAY_READ) r = 1;
> -	if(desired & MAY_WRITE) w = 1;
> -	if(desired & MAY_EXEC) x = 1;
> +	if (desired & MAY_READ) r = 1;
> +	if (desired & MAY_WRITE) w = 1;
> +	if (desired & MAY_EXEC) x = 1;
>  	name = inode_name(ino, 0);
> -	if(name == NULL) return(-ENOMEM);
> -	err = access_file(name, r, w, x);
> +	if (name == NULL) return(-ENOMEM);
> +
> +	if (S_ISCHR(ino->i_mode) || S_ISBLK(ino->i_mode) ||
> +			S_ISFIFO(ino->i_mode) || S_ISSOCK(ino->i_mode))
> +		err = 0;
> +	else
> +		err = access_file(name, r, w, x);
>  	kfree(name);
> -	if(!err) err = generic_permission(ino, desired, NULL);
> -	return(err);
> +	if(!err)
> +		err = generic_permission(ino, desired, NULL);
> +	return err;
>  }
>
>  int hostfs_setattr(struct dentry *dentry, struct iattr *attr)
> _
