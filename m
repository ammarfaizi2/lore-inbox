Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267656AbTB1IwX>; Fri, 28 Feb 2003 03:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267677AbTB1IwX>; Fri, 28 Feb 2003 03:52:23 -0500
Received: from bi-01pt1.bluebird.ibm.com ([129.42.208.186]:54731 "EHLO
	bigbang.in.ibm.com") by vger.kernel.org with ESMTP
	id <S267656AbTB1IwV>; Fri, 28 Feb 2003 03:52:21 -0500
Date: Fri, 28 Feb 2003 14:45:35 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, zilvinas@gemtek.lt
Subject: Re: kernel Ooops (2.5.63 bk latest)
Message-ID: <20030228091535.GE11135@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20030226113718.GA3568@gemtek.lt> <20030228070905.GA11135@in.ibm.com> <20030227233434.7ed26b83.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030227233434.7ed26b83.akpm@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2003 at 11:34:34PM -0800, Andrew Morton wrote:
> Maneesh Soni <maneesh@in.ibm.com> wrote:
> >
> > Hi Linus,
> > 
> > The BUG was caught in d_validate() --> dget(). I think the 
> > dentry to be validated can be already on LRU list with d_count 
> > as zero. So, dget_locked should be used in place of dget(). 
> > dcache_rcu mistakingly used dget. This patch corrects it.
> > 
> > Please apply the following patch.
> > 
> > diff -urN linux-2.5.63-bk3/fs/dcache.c linux-2.5.63-bk3-d_validate/fs/dcache.c
> > --- linux-2.5.63-bk3/fs/dcache.c	2003-02-28 12:06:09.000000000 +0530
> > +++ linux-2.5.63-bk3-d_validate/fs/dcache.c	2003-02-28 12:16:30.000000000 +0530
> > @@ -1056,7 +1056,7 @@
> >  		 * as it is parsed under dcache_lock
> >  		 */
> >  		if (dentry == list_entry(lhp, struct dentry, d_hash)) {
> > -			dget(dentry);
> > +			__dget_locked(dentry);
> >  			spin_unlock(&dcache_lock);
> >  			return 1;
> 
> Is this correct?  If smbfs is playing around with dentries which are on
> dentry_unused and which have a zero refcount then these can be freed up at
> any time.  The filesystem should have taken a ref on the dentry to prevent it
> from being scavenged.
> Isn't the bug over in smb_fill_cache(), which does:
> 
> 	newdent = d_lookup(...);
> 	...
> 	ctl.cache->dentry[ctl.idx] = newdent;
> 	...
> 	dput(newdent);
> 
> I suspect we need to take an extra ref on the dentry when it is copied to the
> cache, and put that ref back when smb_readdir() has finished using the dentry
> (it looks like it's already doing that).
>
> If so, the same problem is present in 2.4, but nobody noticed because 2.4 is
> already using __dget_locked() and escapes the BUG check.
 
ref is taken in d_validate, which is called before using the smbfs cached 
dentry. It is this ref which is taken back in smb_readdir(). 

I am not sure when it is proper to take the extra ref that is either when 
dentry is introduced in the smbfs cache or when it is read from the cache.

Maneesh 

-- 
Maneesh Soni
IBM Linux Technology Center, 
IBM India Software Lab, Bangalore.
Phone: +91-80-5044999 email: maneesh@in.ibm.com
http://lse.sourceforge.net/
