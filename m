Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751132AbVIUQfd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbVIUQfd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 12:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbVIUQfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 12:35:33 -0400
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:58723 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751132AbVIUQfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 12:35:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=EGi1Z32+MejXczp0aiKAK4RuV1S+VOIcPqvHQdbF8fb+SjpGVJLtjtncSbYH2gFxdaGD96QRAsoHwaZw2Rq/sdStMtdIT6KKh4jhkhuvVLiKRMX7bTdM/0r6n04bf6FPV4JG79hB/ZEU7+mum1aeGrTdUsOBjoVDbw9MS9NOpFQ=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: [PATCH 12/12] HPPFS: fix nameidata handling
Date: Wed, 21 Sep 2005 18:34:11 +0200
User-Agent: KMail/1.8.2
Cc: Al Viro <viro@ftp.linux.org.uk>, Antoine Martin <antoine@nagafix.co.uk>,
       Al Viro <viro@zeniv.linux.org.uk>, Jeff Dike <jdike@addtoit.com>,
       LKML <linux-kernel@vger.kernel.org>
References: <20050918141009.31461.43507.stgit@zion.home.lan> <20050921035455.GY7992@ftp.linux.org.uk>
In-Reply-To: <20050921035455.GY7992@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509211834.12345.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 21 September 2005 05:54, Al Viro wrote:
> On Sun, Sep 18, 2005 at 04:10:09PM +0200, Paolo 'Blaisorblade' Giarrusso 
wrote:
> > From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

> > In follow_link, we call the underlying method with the same nameidata we
> > got - it will then call path_release() and then dput()/mntput() on hppfs
> > dentries / vfsmount rather than his own, which could be problematic (I'm
> > not really sure, however).

> Don't bother with that, procfs doesn't and will not care anyway.  It _is_
> legal to pass NULL as nd,
Where? At least not in proc_follow_link, I don't know for the rest. 

I'm now seeing lookup_one_len doing exactly that. But still, could these 
conventions be documented, as they're surely untrivial to guess?

> so you've actually introduced breakage here. 
> Just pass NULL and be done with that.

> > @@ -213,11 +240,20 @@ static struct dentry *hppfs_lookup(struc
> >  	} else {
> >  		up(&parent->d_inode->i_sem);
> >  		if (proc_dentry->d_op && proc_dentry->d_op->d_revalidate) {
> > -			if (!proc_dentry->d_op->d_revalidate(proc_dentry, NULL) &&
> > +			sav_dentry = nd->dentry;
> > +			sav_mnt = nd->mnt;
> > +
> > +			nd->dentry = dget(proc_dentry);
> > +			nd->mnt = mntget(proc_submnt);
> > +			if (!proc_dentry->d_op->d_revalidate(proc_dentry, nd) &&
> >  					!d_invalidate(proc_dentry)) {
> >  				dput(proc_dentry);
> >  				proc_dentry = ERR_PTR(-ENOENT);
> >  			}
> > +			path_release(nd);
> > +
> > +			nd->dentry = sav_dentry;
> > +			nd->mnt = sav_mnt;
> >  		}
> >  	}

> Shouldn't be there at all (use lookup_one_len() instead of open-coding it)


> >  static struct inode_operations hppfs_file_iops = {
> > @@ -794,6 +846,9 @@ static int hppfs_readlink(struct dentry
> >
> >  static void* hppfs_follow_link(struct dentry *dentry, struct nameidata
> > *nd) {
> > +	struct dentry *sav_dentry;
> > +	struct vfsmount *sav_mnt;
> > +
[...]
> And this is absolutely bogus.  The whole point of ->follow_link() is to
> move where your nameidata points to.  So no, you do _not_ want to flip
> nameidata, you do not want to drop it and you certainly do not want
> to flip it back.  Just call the underlying one.
But wouldn't the callee expect that nd->dentry is the same thing which I pass?

Yes, nameidata has other fields too, but is ->dentry meant to be unused here?
Not surely.

And especially, how would proc_pid_follow_link()'s path_release() call handle 
that?

I've been suspicious that, indeed, recursive lookup holds a ref on each 
pathname component dentry, and that proc, in that case, knows it can do 
without.

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
