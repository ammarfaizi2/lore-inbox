Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293580AbSCEDlg>; Mon, 4 Mar 2002 22:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293566AbSCEDl3>; Mon, 4 Mar 2002 22:41:29 -0500
Received: from office.mandrakesoft.com ([195.68.114.34]:5619 "EHLO
	office.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S293563AbSCEDlU>; Mon, 4 Mar 2002 22:41:20 -0500
To: Hanna Linder <hannal@us.ibm.com>
Cc: davej@suse.de, torvalds@transmeta.com, viro@math.psu.edu,
        linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] [PATCH] 2.5.5-dj2 - Fast Walk Dcache to Decrease Cacheline Bouncing
In-Reply-To: <33110000.1015293677@w-hlinder.des>
X-Url: http://www.lfcia.org/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <33110000.1015293677@w-hlinder.des>
Date: 05 Mar 2002 04:30:00 +0100
Message-ID: <m2sn7f8zev.fsf@localhost.mandrakesoft.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "hanna" == Hanna Linder <hannal@us.ibm.com> writes:

Hi
hanna> --- linux-2.5.5-dj2/fs/dcache.c	Mon Mar  4 15:56:20 2002
hanna> +++ linux-2.5.5-fastwalk/fs/dcache.c	Fri Mar  1 16:21:40 2002
hanna> @@ -705,13 +705,23 @@
  
hanna> struct dentry * d_lookup(struct dentry * parent, struct qstr * name)
hanna> {
hanna> +	struct dentry *dentry = NULL;

Not needed.


hanna> +int path_lookup(const char *name, unsigned int flags, struct nameidata *nd)
hanna> +{
hanna> +	nd->last_type = LAST_ROOT; /* if there are only slashes... */
hanna> +	nd->flags = flags;
hanna> +	if (*name=='/'){
hanna> +		read_lock(&current->fs->lock);
hanna> +		if (current->fs->altroot && !(nd->flags & LOOKUP_NOALT)) {
hanna> +			nd->mnt = mntget(current->fs->altrootmnt);
hanna> +			nd->dentry = dget(current->fs->altroot);
hanna> +			read_unlock(&current->fs->lock);
hanna> +			if (__emul_lookup_dentry(name,nd))
hanna> +				return 0;
hanna> +			read_lock(&current->fs->lock);
hanna> +		}
hanna> +		spin_lock(&dcache_lock); /*to avoid cacheline bouncing with d_count*/
hanna> +		nd->mnt = current->fs->rootmnt;
hanna> +		nd->dentry = current->fs->root;
hanna> +		read_unlock(&current->fs->lock);
hanna> +	}
hanna> +	else{
hanna> +		read_lock(&current->fs->lock);
hanna> +		spin_lock(&dcache_lock);
hanna> +		nd->mnt = current->fs->pwdmnt;
hanna> +		nd->dentry = current->fs->pwd;
hanna> +		read_unlock(&current->fs->lock);
hanna> +	}
hanna> +	nd->flags |= LOOKUP_LOCKED;
hanna> +	return (path_walk(name, nd));
hanna> +}
hanna> +

Would you mean retest if the speed is the same using lik the old code

(already static inline)
/* SMP-safe */
static inline int
walk_init_root(const char *name, struct nameidata *nd)
{
	read_lock(&current->fs->lock);
	if (current->fs->altroot && !(nd->flags & LOOKUP_NOALT)) {
		nd->mnt = mntget(current->fs->altrootmnt);
		nd->dentry = dget(current->fs->altroot);
		read_unlock(&current->fs->lock);
		if (__emul_lookup_dentry(name,nd))
			return 0;
		read_lock(&current->fs->lock);
	}
	nd->mnt = mntget(current->fs->rootmnt);
	nd->dentry = dget(current->fs->root);
	read_unlock(&current->fs->lock);
	return 1;
}

/* SMP-safe */
int path_lookup(const char *name, unsigned int flags, struct nameidata *nd)
{
	nd->last_type = LAST_ROOT; /* if there are only slashes... */
	nd->flags = flags;
	if (*name=='/')
		walk_init_root(name,nd);
        else {
        	read_lock(&current->fs->lock);
                nd->mnt = mntget(current->fs->pwdmnt);
                nd->dentry = dget(current->fs->pwd);
                read_unlock(&current->fs->lock);
        }
	nd->flags |= LOOKUP_LOCKED;
	return (path_walk(name, nd));
}

I think that it should not made difference, and code is IMHO, more
readadble (and you don't duplicate walk_init_root).

Later, Juan.

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
