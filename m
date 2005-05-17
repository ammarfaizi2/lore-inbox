Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261251AbVEQSsz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbVEQSsz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 14:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbVEQSsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 14:48:55 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:1946 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261251AbVEQSsq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 14:48:46 -0400
Subject: Re: [PATCH] namespace.c: fix bind mount from foreign namespace
From: Ram <linuxram@us.ibm.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: jamie@shareable.org, viro@parcelfarce.linux.theplanet.co.uk,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <E1DXm08-0006XD-00@dorka.pomaz.szeredi.hu>
References: <E1DWXeF-00017l-00@dorka.pomaz.szeredi.hu>
	 <20050513170602.GI1150@parcelfarce.linux.theplanet.co.uk>
	 <E1DWdn9-0004O2-00@dorka.pomaz.szeredi.hu>
	 <1116005355.6248.372.camel@localhost>
	 <E1DWf54-0004Z8-00@dorka.pomaz.szeredi.hu>
	 <1116012287.6248.410.camel@localhost>
	 <E1DWfqJ-0004eP-00@dorka.pomaz.szeredi.hu>
	 <1116013840.6248.429.camel@localhost>
	 <E1DWprs-0005D1-00@dorka.pomaz.szeredi.hu>
	 <1116256279.4154.41.camel@localhost>
	 <20050516111408.GA21145@mail.shareable.org>
	 <1116301843.4154.88.camel@localhost>
	 <E1DXm08-0006XD-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Organization: IBM 
Message-Id: <1116355699.24560.79.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 17 May 2005 11:48:24 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-05-16 at 13:15, Miklos Szeredi wrote:
> > Ok. less restriction without compromising security is a good idea.
> > 
> > Under the premise that bind mounts across namespace should be allowed;
> > any insight why the "founding fathers" :) allowed only bind
> > and not recursive bind?  What issue would that create? One can
> > easily workaround that restriction by manually binding recursively.
> > So does the recursive bind restriction serve any purpose?
> > 
> > I remember Miklos saying its not a security issue but a
> > implementation/locking issue. That can be fixed aswell.
> 
> Yes, as pointed out by Jamie, both namespaces need to be locked for
> this to work.  Something like the attached should do it.
> 
> Miklos
> 
> 
> Index: linux/fs/namespace.c
> ===================================================================
> --- linux.orig/fs/namespace.c	2005-05-16 22:02:36.000000000 +0200
> +++ linux/fs/namespace.c	2005-05-16 22:13:30.000000000 +0200
> @@ -622,6 +622,8 @@ out_unlock:
>  static int do_loopback(struct nameidata *nd, char *old_name, int recurse)
>  {
>  	struct nameidata old_nd;
> +	struct namespace *ns1 = current->namespace;
> +	struct namespace *ns2 = NULL;
>  	struct vfsmount *mnt = NULL;
>  	int err = mount_is_safe(nd);
>  	if (err)
> @@ -632,15 +634,30 @@ static int do_loopback(struct nameidata 
>  	if (err)
>  		return err;
>  
> -	down_write(&current->namespace->sem);
>  	err = -EINVAL;
> -	if (check_mnt(nd->mnt) && (!recurse || check_mnt(old_nd.mnt))) {
> -		err = -ENOMEM;
> -		if (recurse)
> -			mnt = copy_tree(old_nd.mnt, old_nd.dentry);
> -		else
> -			mnt = clone_mnt(old_nd.mnt, old_nd.dentry);
> -	}
> +	if (!check_mnt(nd->mnt))
> +		goto out_path_release;

This disallows bind mounts in foreign namespace. 
But allows bind mounts in current namespace from foreign namespace. Any
reason? 
Both should be allowed. Infact both the namespaces  operated
on could be foriegn namespaces.

This is based on the premise that the process has gained rights 
to operate on the namespaces in question.

RP


