Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262649AbRFBSRD>; Sat, 2 Jun 2001 14:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262651AbRFBSQx>; Sat, 2 Jun 2001 14:16:53 -0400
Received: from mout0.freenet.de ([194.97.50.131]:34236 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id <S262649AbRFBSQo>;
	Sat, 2 Jun 2001 14:16:44 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andreas Hartmann <andihartmann@freenet.de>
Organization: Privat
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [2.4.5 and all ac-Patches] massive file corruption with reiser or NFS
Date: Sat, 2 Jun 2001 20:08:49 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <E156E7j-0001su-00@the-village.bc.nu>
In-Reply-To: <E156E7j-0001su-00@the-village.bc.nu>
Cc: "Kernel-Mailingliste" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <01060220084900.04097@athlon>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag,  2. Juni 2001 18:19 schrieben Sie:
> > I got massive file corruptions with the kernels mentioned in the subject.
> > I can reproduce it every time.
>
> Which other 2.4 trees have you tried ?

I had the following situations:

NFS server:
linux 2.2.19

NFS Client:
linux 2.4.[32]ac[...],
linux 2.4.4ac[1-...]
[1-10] have been working fine. Beginning with ac11, I got the problems I 
wrote. During this time, I never used any knfsd-patch.



The following is the combination, which seems to be working fine:

NFS Server:
linux 2.2.19 with knfsd-patch or linux 2.4.5 with the following knfsd-Patch 
from Gergely Tamas <dice@mfa.kfki.hu> (I got it from the mailinglist of 
reiser) (there is no patch for ac6):

--------------------------------------------------------------------------------------
--- linux-2.4.5/fs/inode.c.orig Fri May 25 14:15:38 2001
+++ linux-2.4.5/fs/inode.c      Wed May 30 12:17:29 2001
@@ -1044,6 +1044,8 @@
                                inode->i_state|=I_FREEING;
                                inodes_stat.nr_inodes--;
                                spin_unlock(&inode_lock);
+                               if (inode->i_data.nrpages)
+                                       truncate_inode_pages(&inode->i_data, 
0);
                                clear_inode(inode);
                        }
                }

--- linux-2.4.5-pre6/fs/nfs/dir.c.orig  Fri May 25 14:15:38 2001
+++ linux-2.4.5-pre6/fs/nfs/dir.c       Thu May 31 14:53:32 2001
@@ -753,6 +753,8 @@

        nfs_zap_caches(dir);
        error = NFS_PROTO(dir)->rmdir(dir, &dentry->d_name);
+       if (!error)
+               dentry->d_inode->i_nlink -= 2;

        return error;
 }
@@ -870,6 +872,8 @@
        error = NFS_PROTO(dir)->remove(dir, &dentry->d_name);
        if (error < 0)
                goto out;
+       if (inode)
+               inode->i_nlink--;

  out_delete:
        /*
------------------------------------------------------------------------

I patched the original 2.4.5-sources.

NFS Client:
linux 2.4.5 with knfsd-patch.

I need the patch on both the server and the client to get it working.

>
> Does booting with ide=nodma help ? [only in -ac]

I tested the following combination:

Server
2.2.19 without knfsd-Patch

Client
2.4.5ac6 without knfsd-Patch but ide=nodma

Result:
IO-Errors as I wrote in my initial posting.


Regards
Adnreas Hartmann
