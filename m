Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315919AbSHaEIz>; Sat, 31 Aug 2002 00:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315923AbSHaEIz>; Sat, 31 Aug 2002 00:08:55 -0400
Received: from web10501.mail.yahoo.com ([216.136.130.151]:43292 "HELO
	web10501.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S315919AbSHaEIx>; Sat, 31 Aug 2002 00:08:53 -0400
Message-ID: <20020831041318.26193.qmail@web10501.mail.yahoo.com>
Date: Fri, 30 Aug 2002 21:13:18 -0700 (PDT)
From: Andy Tai <lichengtai@yahoo.com>
Reply-To: atai@atai.org
Subject: Re: file locking (fcntl) bug in 2.4.19
To: atai@atai.org, Matthew Wilcox <willy@debian.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020830205006.80088.qmail@web10501.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I just figured out the problem is not with the
locking code in the kernel, which works with your
patch, but in the user space application setting the
file permission in such a way as to use mandatory
locks, that surely fails on a NFS volume...

The user space application in this case is Samba
2.2.5.

Thanks for your help.

Andy

--- Andy Tai <lichengtai@yahoo.com> wrote:
> Mr. Wilcox, thanks for the reply.  I checked the
> source of the stock 2.4.19 kernel and it seems to
> have
> part of the patch incorporated.  I checked to make
> sure the patch is fully applied and recompiled the
> kernel, and the bug still shows up (less frequently,
> but the test program lockbug.c can still trigger the
> bug). It seems the problem is not totally gone yet.
> 
> Thanks for any help.
> 
> Andy  
> --- Matthew Wilcox <willy@debian.org> wrote:
> > 
> > Yep, 2.4 & 2.5 are broken.  Here's a patch which
> > both marcelo and alan
> > refuse to apply, but fixes the problem.
> > 
> > diff -urNX dontdiff linux-2418/fs/locks.c
> > linux-2418-acct/fs/locks.c
> > --- linux-2418/fs/locks.c	Thu Oct 11 08:52:18 2001
> > +++ linux-2418-acct/fs/locks.c	Mon Jul  1 16:23:36
> > 2002
> > @@ -134,15 +134,9 @@
> >  static kmem_cache_t *filelock_cache;
> >  
> >  /* Allocate an empty lock structure. */
> > -static struct file_lock *locks_alloc_lock(int
> > account)
> > +static struct file_lock *locks_alloc_lock(void)
> >  {
> > -	struct file_lock *fl;
> > -	if (account && current->locks >=
> > current->rlim[RLIMIT_LOCKS].rlim_cur)
> > -		return NULL;
> > -	fl = kmem_cache_alloc(filelock_cache,
> > SLAB_KERNEL);
> > -	if (fl)
> > -		current->locks++;
> > -	return fl;
> > +	return kmem_cache_alloc(filelock_cache,
> > SLAB_KERNEL);
> >  }
> >  
> >  /* Free a lock which is not in use. */
> > @@ -152,7 +146,6 @@
> >  		BUG();
> >  		return;
> >  	}
> > -	current->locks--;
> >  	if (waitqueue_active(&fl->fl_wait))
> >  		panic("Attempting to free lock with active wait
> > queue");
> >  
> > @@ -219,7 +212,7 @@
> >  /* Fill in a file_lock structure with an
> > appropriate FLOCK lock. */
> >  static struct file_lock *flock_make_lock(struct
> > file *filp, unsigned int type)
> >  {
> > -	struct file_lock *fl = locks_alloc_lock(1);
> > +	struct file_lock *fl = locks_alloc_lock();
> >  	if (fl == NULL)
> >  		return NULL;
> >  
> > @@ -348,7 +341,7 @@
> >  /* Allocate a file_lock initialised to this type
> of
> > lease */
> >  static int lease_alloc(struct file *filp, int
> type,
> > struct file_lock **flp)
> >  {
> > -	struct file_lock *fl = locks_alloc_lock(1);
> > +	struct file_lock *fl = locks_alloc_lock();
> >  	if (fl == NULL)
> >  		return -ENOMEM;
> >  
> > @@ -712,7 +705,7 @@
> >  			 size_t count)
> >  {
> >  	struct file_lock *fl;
> > -	struct file_lock *new_fl = locks_alloc_lock(0);
> > +	struct file_lock *new_fl = locks_alloc_lock();
> >  	int error;
> >  
> >  	if (new_fl == NULL)
> > @@ -872,8 +865,8 @@
> >  	 * We may need two file_lock structures for this
> > operation,
> >  	 * so we get them in advance to avoid races.
> >  	 */
> > -	new_fl = locks_alloc_lock(0);
> > -	new_fl2 = locks_alloc_lock(0);
> > +	new_fl = locks_alloc_lock();
> > +	new_fl2 = locks_alloc_lock();
> >  	error = -ENOLCK; /* "no luck" */
> >  	if (!(new_fl && new_fl2))
> >  		goto out_nolock;
> > @@ -1426,7 +1419,7 @@
> >  int fcntl_setlk(unsigned int fd, unsigned int
> cmd,
> > struct flock *l)
> >  {
> >  	struct file *filp;
> > -	struct file_lock *file_lock =
> locks_alloc_lock(0);
> > +	struct file_lock *file_lock =
> locks_alloc_lock();
> >  	struct flock flock;
> >  	struct inode *inode;
> >  	int error;
> > @@ -1582,7 +1575,7 @@
> >  int fcntl_setlk64(unsigned int fd, unsigned int
> > cmd, struct flock64 *l)
> >  {
> >  	struct file *filp;
> > -	struct file_lock *file_lock =
> locks_alloc_lock(0);
> > +	struct file_lock *file_lock =
> locks_alloc_lock();
> >  	struct flock64 flock;
> >  	struct inode *inode;
> >  	int error;
> > 
> > -- 
> > Revolutions do not require corporate support.
> 
> 
> __________________________________________________
> Do You Yahoo!?
> Yahoo! Finance - Get real-time stock quotes
> http://finance.yahoo.com


__________________________________________________
Do You Yahoo!?
Yahoo! Finance - Get real-time stock quotes
http://finance.yahoo.com
