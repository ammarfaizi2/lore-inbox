Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263174AbTCLN0k>; Wed, 12 Mar 2003 08:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263175AbTCLN0k>; Wed, 12 Mar 2003 08:26:40 -0500
Received: from mail.gmx.net ([213.165.64.20]:57171 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S263174AbTCLN0j> convert rfc822-to-8bit;
	Wed, 12 Mar 2003 08:26:39 -0500
Content-Type: text/plain; charset=US-ASCII
From: Torsten Foertsch <torsten.foertsch@gmx.net>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [2.4.19] How to get the path name of a struct dentry
Date: Wed, 12 Mar 2003 14:32:47 +0100
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <200303121033.08560.torsten.foertsch@gmx.net> <20030312104741.A9625@infradead.org> <200303121404.04979.torsten.foertsch@gmx.net>
In-Reply-To: <200303121404.04979.torsten.foertsch@gmx.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200303121432.51329.torsten.foertsch@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wednesday 12 March 2003 14:04, Torsten Foertsch wrote:
> On Wednesday 12 March 2003 11:47, Christoph Hellwig wrote:
> > On Wed, Mar 12, 2003 at 11:38:27AM +0100, Torsten Foertsch wrote:
> > > Next question, is there a way to get the dentry and vfsmount of /? I
> > > mean not current->fs->root and current->fs->rootmnt. They can be
> > > chrooted. I mean the real /.
> >
> > No.  Esecially as there is not single "real" root.
>
> How about that slightly modified d_path()?
>
> char*
> full_d_path( struct dentry *dentry,
> 	     struct vfsmount *vfsmnt,
> 	     char *buf, int buflen ) {
...
> }

or even simpler

char*
full_d_path( struct dentry *dentry,
	     struct vfsmount *vfsmnt,
	     char *buf, int buflen ) {
  char *res;
  struct vfsmount *rootmnt;
  struct dentry *root;
  struct namespace *ns;

  ns=current->namespace;
/*   get_namespace( ns ); */
  rootmnt=mntget( ns->root );
/*   put_namespace( ns ); */

  root = dget(rootmnt->mnt_root);

  spin_lock(&dcache_lock);
  res = __d_path(dentry, vfsmnt, root, rootmnt, buf, buflen);
  spin_unlock(&dcache_lock);

  dput(root);
  mntput(rootmnt);
  return res;
}

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE+bzcDwicyCTir8T4RAju7AJ4lP23Mzp+GVJHQP7XqHhNNLV9qIACdF2cO
GZVG8UuSq4UwOLxA2za4W8g=
=wCJb
-----END PGP SIGNATURE-----
