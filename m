Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132673AbRDMAY3>; Thu, 12 Apr 2001 20:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132666AbRDMAYT>; Thu, 12 Apr 2001 20:24:19 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:6152 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S132642AbRDMAYK>; Thu, 12 Apr 2001 20:24:10 -0400
Date: Thu, 12 Apr 2001 19:42:18 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Alexander Viro <viro@math.psu.edu>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: generic_osync_inode() broken?
In-Reply-To: <Pine.LNX.4.31.0104121228550.20191-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0104121937110.3305-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 12 Apr 2001, Linus Torvalds wrote:

> 
> 
> On Thu, 12 Apr 2001, Marcelo Tosatti wrote:
> >
> > Comments?
> >
> > --- fs/inode.c~	Thu Mar 22 16:04:13 2001
> > +++ fs/inode.c	Thu Apr 12 15:18:22 2001
> > @@ -347,6 +347,11 @@
> >  #endif
> >
> >  	spin_lock(&inode_lock);
> > +	while (inode->i_state & I_LOCK) {
> > +		spin_unlock(&inode_lock);
> > +		__wait_on_inode(inode);
> > +		spin_lock(&inode_lock);
> > +	}
> >  	if (!(inode->i_state & I_DIRTY))
> >  		goto out;
> >  	if (datasync && !(inode->i_state & I_DIRTY_DATASYNC))
> 
> Ehh.
> 
> Why not just lock the inode around the thing?
> 
> The above looks rather ugly.

Ok, me again.
 
The inode->i_state locking is rather nasty: there is no need to lock the
inode. We just have to wait for it to become unlocked, since its
guaranteed that who locked it wrote it to disk. (sync_one())

Aviro suggested the following, which is much cleaner than the previous
patch: 


--- fs/inode.c~	Thu Apr 12 21:15:23 2001
+++ fs/inode.c	Thu Apr 12 21:16:35 2001
@@ -301,6 +301,8 @@
 		while (inode->i_state & I_DIRTY)
 			sync_one(inode, sync);
 		spin_unlock(&inode_lock);
+		if (sync)
+			wait_on_inode(inode);
 	}
 	else
 		printk("write_inode_now: no super block\n");
@@ -357,6 +359,7 @@
 
  out:
 	spin_unlock(&inode_lock);
+	wait_on_inode(inode);
 	return err;
 }
 

