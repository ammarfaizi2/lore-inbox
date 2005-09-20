Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964914AbVITH4T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964914AbVITH4T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 03:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964918AbVITH4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 03:56:18 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:48780 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S964914AbVITH4R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 03:56:17 -0400
Subject: Re: [RFC PATCH 5/10] vfs: shared subtree aware bind mounts
From: Ram Pai <linuxram@us.ibm.com>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Miklos Szeredi <miklos@szeredi.hu>,
       mike@waychison.com, bfields@fieldses.org, serue@us.ibm.com
In-Reply-To: <20050920071741.GI7992@ftp.linux.org.uk>
References: <20050916182619.GA28489@RAM>
	 <20050920071741.GI7992@ftp.linux.org.uk>
Content-Type: text/plain
Organization: IBM 
Message-Id: <1127202974.10061.27.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 20 Sep 2005 00:56:14 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-09-20 at 00:17, Al Viro wrote:
> On Fri, Sep 16, 2005 at 11:26:19AM -0700, Ram wrote:
> 
> This patch needs to be split *AND* accompanied by locking rules.  It's
> pretty much the core of the entire thing; if it's possible to offload
> chunks elsewhere, life would become easier.  Locking rules are badly
> needed, along with the comments re "why can't that mntput()/dput()
> block under a spinlock", etc.

Yes will do.

Also I realized that vfspnode_lock just added more complexity because
all it protected was already protected by vfsmount_lock. So I am
cleaning up that lock.



> 
> BTW, how are you dealing with MS_MOVE?
In the patch #6 MS_MOVE and pivot_root are handled.
> 
> > +void do_detach_prepare_mnt(struct vfsmount *mnt)
> > +{
> > +	mnt->mnt_mountpoint->d_mounted--;
> > +	mntput(mnt->mnt_parent);
> > +	dput(mnt->mnt_mountpoint);
> > +	mnt->mnt_parent = mnt;
> > +}
> 
> General note: mntput() should go _after_ dput() when we deal with pairs.
> Doesn't cost anything, trivially safe.

ok

> 
> >  	if (res) {
> >  		spin_lock(&vfsmount_lock);
> > +		clean_propagation_reference(res);
> 
> Uh-oh...  What makes that safe?  We do mntput() here; are we guaranteed
> that these pointers won't be the last references?

Yes it is safe and it is not releasing the last reference to the mount.
Will put in a comment there.

It is releasing a reference to source mount of the bind operation.

static void inline clean_propagation_reference(struct vfsmount *mnt)
+{
+	struct vfsmount *p;
+	for (p = mnt; p; p = next_mnt(p, mnt))
+		if (p->mnt_master)
+			mntput(p->mnt_master);
+}
+
 

> > +		spin_lock(&vfspnode_lock);
> > +		propagate_abort_mount(m);
> 
> Calls do_detach_prepare() -> dput(), mntput().  At the very least such
> cases need comments...
> 

ok will add a comment. 
but propagate_abort_mount() is not holding vfsmount_lock,  
it is holding vfspnode_lock. So there should be a problem. But as
mentioned earlier, even the need for vfspnode_lock is not needed.



> > +static void __do_make_private(struct vfsmount *mnt)
> > +{
> > +	__do_make_slave(mnt);
> > +	list_del_init(&mnt->mnt_slave);
> > +	mnt->mnt_master = NULL;
> > +	set_mnt_private(mnt);
> > +}
> > +
> >  int do_make_private(struct vfsmount *mnt)
> >  {
> >  	/*
> >  	 * a private mount is nothing but a
> >  	 * slave mount with no incoming
> >  	 * propagations.
> >  	 */
> >  	spin_lock(&vfspnode_lock);
> > -	__do_make_slave(mnt);
> > -	list_del_init(&mnt->mnt_slave);
> > +	__do_make_private(mnt);
> >  	spin_unlock(&vfspnode_lock);
> > -	mnt->mnt_master = NULL;
> > -	set_mnt_private(mnt);
> >  	return 0;
> >  }
> 
> Why not do that from the very beginning, BTW?

can be done. will do.

> 
> >  	/*
> > -	 * a unclonable mount is nothing but a
> > +	 * a unclonable mount is a
> >  	 * private mount which is unclonnable.
> >  	 */
> >  	spin_lock(&vfspnode_lock);
> > -	__do_make_slave(mnt);
> > -	list_del_init(&mnt->mnt_slave);
> > +	__do_make_private(mnt);
> >  	spin_unlock(&vfspnode_lock);
> > -	mnt->mnt_master = NULL;
> >  	set_mnt_unclonable(mnt);
> >  	return 0;
> >  }
> -
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

