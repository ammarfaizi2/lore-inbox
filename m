Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262424AbVEMQzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262424AbVEMQzF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 12:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbVEMQy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 12:54:59 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:9961 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262424AbVEMQyd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 12:54:33 -0400
Subject: Re: [RCF] [PATCH] unprivileged mount/umount
From: Ram <linuxram@us.ibm.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: jamie@shareable.org, ericvh@gmail.com, 7eggert@gmx.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       smfrench@austin.rr.com, hch@infradead.org
In-Reply-To: <E1DWWBo-00013Z-00@dorka.pomaz.szeredi.hu>
References: <20050511170700.GC2141@mail.shareable.org>
	 <E1DVwGn-0002BB-00@dorka.pomaz.szeredi.hu>
	 <1115840139.6248.181.camel@localhost>
	 <20050511212810.GD5093@mail.shareable.org>
	 <1115851333.6248.225.camel@localhost>
	 <a4e6962a0505111558337dd903@mail.gmail.com>
	 <20050512010215.GB8457@mail.shareable.org>
	 <a4e6962a05051119181e53634e@mail.gmail.com>
	 <20050512064514.GA12315@mail.shareable.org>
	 <a4e6962a0505120623645c0947@mail.gmail.com>
	 <20050512151631.GA16310@mail.shareable.org>
	 <E1DWIms-0005nC-00@dorka.pomaz.szeredi.hu>
	 <1115946620.6248.299.camel@localhost> <1115969123.6248.336.camel@localhost>
	 <1115974780.6248.346.camel@localhost>
	 <E1DWWBo-00013Z-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Organization: IBM 
Message-Id: <1116003238.6248.367.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 13 May 2005 09:53:58 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-05-13 at 02:10, Miklos Szeredi wrote:
> >  	dentry = file->f_dentry;
> >  	mnt = file->f_vfsmnt;
> >  	inode = dentry->d_inode;
> > +	if(mnt->mnt_namespace != current->namespace)
> > +		goto out_putf;
> >  
> >  	error = -ENOTDIR;
> >  	if (!S_ISDIR(inode->i_mode))
> > 
> 
> Does this actually fix the problem?  The open is done in the right
> namespace, and mount() doesn't call open().

Right but this fix disallows fchdir into a directory belonging to
a different namespace.  And hence would disallow the ability to
cross mount across namespaces.

RP

> 
> I think the right fix is something like this:
> 
> Index: linux/fs/namespace.c
> ===================================================================
> --- linux.orig/fs/namespace.c	2005-05-13 11:03:50.000000000 +0200
> +++ linux/fs/namespace.c	2005-05-13 11:05:06.000000000 +0200
> @@ -160,7 +160,7 @@ clone_mnt(struct vfsmount *old, struct d
>  		mnt->mnt_root = dget(root);
>  		mnt->mnt_mountpoint = mnt->mnt_root;
>  		mnt->mnt_parent = mnt;
> -		mnt->mnt_namespace = old->mnt_namespace;
> +		mnt->mnt_namespace = current->namespace;


>  
>  		/* stick the duplicate mount on the same expiry list
>  		 * as the original if that was on one */
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

