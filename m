Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312235AbSCRIPq>; Mon, 18 Mar 2002 03:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312237AbSCRIPh>; Mon, 18 Mar 2002 03:15:37 -0500
Received: from pat.uio.no ([129.240.130.16]:31174 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S312235AbSCRIPX>;
	Mon, 18 Mar 2002 03:15:23 -0500
To: NIIBE Yutaka <gniibe@m17n.org>
Cc: Stephan von Krawczynski <skraw@ithnet.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: BUG REPORT: kernel nfs between 2.4.19-pre2 (server) and 2.2.21-pre3 (client)
In-Reply-To: <shswuwkujx5.fsf@charged.uio.no>
	<200203110018.BAA11921@webserver.ithnet.com>
	<15499.64058.442959.241470@charged.uio.no>
	<200203180707.g2I771Z00657@mule.m17n.org>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 18 Mar 2002 09:15:06 +0100
Message-ID: <shs8z8qb8c5.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == NIIBE Yutaka <gniibe@m17n.org> writes:

     > A problem is easily reproducible with user-space nfsd (on ext3,
     > in my case).  We see the message (say, when installing a
     > package with dpkg -i):
     > 	nfs_refresh_inode: inode XXXXXXX mode changed, OOOO to OOOO
     > Which means, same file handle but different type.

     > FWIW, I'm using the patch attached.  It works for me.

     > --- linux-2.4.18/fs/nfs/inode.c~ Wed Mar 13 17:56:48 2002
     > +++ linux-2.4.18.superh/fs/nfs/inode.c Mon Mar 18 13:27:39 2002
     > @@ -680,8 +680,10 @@ nfs_find_actor(struct inode *inode, unsi
     >  	if (is_bad_inode(inode))
     >  		return 0;
     >  	/* Force an attribute cache update if inode->i_count
     >  	== 0 */
     > - if (!atomic_read(&inode->i_count))
     > + if (!atomic_read(&inode->i_count)) {
     >  		NFS_CACHEINV(inode);
     > + inode->i_mode = 0;
     > +	}
     >  	return 1;
     >  }
 
Er... Why?

If you really want to change something in nfs_find_actor() then the
following works better w.r.t. init_special_inode() on character
devices:

        if ((inode->i_mode & S_IFMT) != (fattr->mode & S_IFMT))
                return 0;

That doesn't fix all the races w.r.t. unfsd though: if someone on the
server removes a file that you have open for writing and replaces it
with a new one, you can still corrupt the new file.

Cheers,
  Trond
