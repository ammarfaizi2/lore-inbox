Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314288AbSEIUII>; Thu, 9 May 2002 16:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314289AbSEIUIH>; Thu, 9 May 2002 16:08:07 -0400
Received: from moist227.drizzle.com ([216.162.216.227]:60406 "EHLO
	cac.seattle.wa.us") by vger.kernel.org with ESMTP
	id <S314288AbSEIUIF>; Thu, 9 May 2002 16:08:05 -0400
Date: Thu, 9 May 2002 13:08:07 -0700 (PDT)
From: "Charles A. Clinton" <cac@cac.seattle.wa.us>
To: Johnny Mnemonic <johnny@themnemonic.org>
cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.14.19-pre8 bug in tmpfs
In-Reply-To: <20020508170024.RTDY6993.fep23-svc.tin.it@there>
Message-ID: <Pine.LNX.4.33.0205091258460.21368-100000@cac.seattle.wa.us>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 May 2002, Johnny Mnemonic wrote:

> From: Christoph Rohland <cr@sap.com>
> To: Johnny Mnemonic <johnny@themnemonic.org>
>
> > I've noticed the following wrong behaviour on tmpfs:
> >
> > (running kernel 2.4.18)
> >
> > [johnny@revenge johnny]$ cd /mnt/shm
> > [johnny@revenge shm]$ rm -rf W
> > [johnny@revenge shm]$ mkdir W
> > [johnny@revenge shm]$ cd W
> > [johnny@revenge W]$ touch MYFILE
> > [johnny@revenge W]$ ln -s X Y
> > [johnny@revenge W]$ ls -l
> > total 0
> > -rw-rw-r--    1 johnny   johnny          0 May  7 19:37 MYFILE
> > -rw-rw-r--    1 johnny   johnny          0 May  7 19:37 MYFILE
> > lrwxrwxrwx    1 johnny   johnny          1 May  7 19:37 Y -> X
> > [johnny@revenge W]$ ls -l
> > total 0
> > -rw-rw-r--    1 johnny   johnny          0 May  7 19:37 MYFILE
> > lrwxrwxrwx    1 johnny   johnny          1 May  7 19:37 Y -> X
> > [johnny@revenge W]$
> >
> > This bug is reproducible in most ways, when you create a
> > non-existent symlink, the first ls will always show up two "MYFILE",
> > while the second and further one won't.
>
> This is probably a misbehaviour of the general cfs layer on which the
> tmpfs directory handling relies. Further on my time nowaday is totally
> sucked up by my job. So I can't look into this myself.
>
> Anyone would like to track this bug before 2.4.19 release?

dcache_readdir inconsistantly counts entries in the d_subdirs list. The code
to handle a starting f_pos > 2 counts every entry, but the code that actually
calls fill_dir only counts usable entries. This patch provides a consistent
counting behavior.

-- Charles

--- linux-2.4.19-pre8.orig/fs/readdir.c	Sun Aug 12 14:59:08 2001
+++ linux/fs/readdir.c	Thu May  9 12:56:18 2002
@@ -70,9 +70,14 @@
 					spin_unlock(&dcache_lock);
 					return 0;
 				}
-				if (!j)
-					break;
-				j--;
+				{
+					struct dentry *de = list_entry(list, struct dentry, d_child);
+					if (!list_empty(&de->d_hash) && de->d_inode) {
+						if (!j)
+							break;
+						j--;
+					}
+				}
 				list = list->next;
 			}

@@ -84,8 +89,8 @@
 					if (filldir(dirent, de->d_name.name, de->d_name.len, filp->f_pos, de->d_inode->i_ino, DT_UNKNOWN) < 0)
 						break;
 					spin_lock(&dcache_lock);
+				    filp->f_pos++;
 				}
-				filp->f_pos++;
 				list = list->next;
 				if (list != &dentry->d_subdirs)
 					continue;

