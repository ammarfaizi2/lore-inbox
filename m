Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751263AbVK1MOv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbVK1MOv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 07:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbVK1MOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 07:14:50 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:55763 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751255AbVK1MOu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 07:14:50 -0500
Subject: Re: [PATCH 2/2] shared mounts: save mount flag space
From: Ram Pai <linuxram@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Al Viro <viro@ftp.linux.org.uk>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <20051126215509.073cb957.akpm@osdl.org>
References: <E1EfJfC-00016e-00@dorka.pomaz.szeredi.hu>
	 <E1EfJnm-00017H-00@dorka.pomaz.szeredi.hu>
	 <E1EfK2o-0001AK-00@dorka.pomaz.szeredi.hu>
	 <20051126215509.073cb957.akpm@osdl.org>
Content-Type: text/plain
Organization: IBM 
Message-Id: <1133180090.3811.95.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 28 Nov 2005 04:14:50 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-11-26 at 21:55, Andrew Morton wrote:
> Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > Remaining mount flags are becoming scarce (just 11 bits)
> > and shared mount code uses 4 though one would suffice.
> > 
> > I think this should go into 2.6.15, fixing it later would be breaking
> > userspace ABI.
> 
> These seem sane objectives.
> 
> > -static int do_change_type(struct nameidata *nd, int flag)
> > +static int do_change_type(struct nameidata *nd, int recurse, char *name)
> >  {
> >  	struct vfsmount *m, *mnt = nd->mnt;
> > -	int recurse = flag & MS_REC;
> > -	int type = flag & ~MS_REC;
> > +	enum propagation_type type;
> >  
> >  	if (nd->dentry != nd->mnt->mnt_root)
> >  		return -EINVAL;
> >  
> > +	if (!name)
> > +		return -EINVAL;
> > +
> > +	if (strcmp(name, "unbindable") == 0)
> > +		type = PT_UNBINDABLE;
> > +	else if (strcmp(name, "private") == 0)
> > +		type = PT_PRIVATE;
> > +	else if (strcmp(name, "slave") == 0)
> > +		type = PT_SLAVE;
> > +	else if (strcmp(name, "shared") == 0)
> > +		type = PT_SHARED;
> > +	else
> > +		return -EINVAL;
> > +
> >  	down_write(&namespace_sem);
> >  	spin_lock(&vfsmount_lock);
> >  	for (m = mnt; m; m = (recurse ? next_mnt(m, mnt) : NULL))
> > @@ -1302,8 +1315,8 @@ long do_mount(char *dev_name, char *dir_
> >  				    data_page);
> >  	else if (flags & MS_BIND)
> >  		retval = do_loopback(&nd, dev_name, flags & MS_REC);
> > -	else if (flags & (MS_SHARED | MS_PRIVATE | MS_SLAVE | MS_UNBINDABLE))
> > -		retval = do_change_type(&nd, flags);
> > +	else if (flags & MS_PROPAGATION)
> > +		retval = do_change_type(&nd, flags & MS_REC, data_page);
> >  	else if (flags & MS_MOVE)
> >  		retval = do_move_mount(&nd, dev_name);
> >  	else
> 
> But I don't know how much trauma this would cause.  Hasn't util-linux
> already been patched with the new mount flags?

Andrew,
    No. The new mount flags have not yet been picked up by 
    util-linux AFAIK.

    and again with shared subtree semantics mount/umount command
    can no way handle all the implicit mounts/unmounts that take
    place without its knowledge.  Dependence on /etc/mnttab is already
    broken with namespaces. Shared-subtree adds some more misery.

I will work on that once I am back from vacation, 
RP



> 
> If it has, and if it uses the same names for these options, the patched
> mount(8) just won't work.
> 
> The proposed new mount options should be documented somewhere.
> 
> Anyway, I'll let Ram&Al decide on this proposal.

