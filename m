Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263169AbTCLM5g>; Wed, 12 Mar 2003 07:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263170AbTCLM5g>; Wed, 12 Mar 2003 07:57:36 -0500
Received: from mail.gmx.net ([213.165.64.20]:49394 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S263169AbTCLM5f> convert rfc822-to-8bit;
	Wed, 12 Mar 2003 07:57:35 -0500
Content-Type: text/plain; charset=US-ASCII
From: Torsten Foertsch <torsten.foertsch@gmx.net>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [2.4.19] How to get the path name of a struct dentry
Date: Wed, 12 Mar 2003 14:04:01 +0100
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <200303121033.08560.torsten.foertsch@gmx.net> <200303121138.31387.torsten.foertsch@gmx.net> <20030312104741.A9625@infradead.org>
In-Reply-To: <20030312104741.A9625@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200303121404.04979.torsten.foertsch@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wednesday 12 March 2003 11:47, Christoph Hellwig wrote:
> On Wed, Mar 12, 2003 at 11:38:27AM +0100, Torsten Foertsch wrote:
> > Next question, is there a way to get the dentry and vfsmount of /? I mean
> > not current->fs->root and current->fs->rootmnt. They can be chrooted. I
> > mean the real /.
>
> No.  Esecially as there is not single "real" root.


How about that slightly modified d_path()?

char*
full_d_path( struct dentry *dentry,
	     struct vfsmount *vfsmnt,
	     char *buf, int buflen ) {
  char *res;
  struct vfsmount *rootmnt;
  struct dentry *root;
  read_lock(&current->fs->lock);
  rootmnt = mntget(current->fs->rootmnt);
  read_unlock(&current->fs->lock);

  while( rootmnt!=rootmnt->mnt_parent ) {
    struct vfsmount *h=mntget( rootmnt->mnt_parent );
    mntput( rootmnt );
    rootmnt=h;
  }

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

iD8DBQE+bzBEwicyCTir8T4RAnDGAJ9A0/e2Qz1U6ewbAZWDi5s9Xe1dYwCfUShA
MWs6OWH+PXurHALosXxMdEU=
=/MHy
-----END PGP SIGNATURE-----
