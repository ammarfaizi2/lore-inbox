Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270212AbRHGXU3>; Tue, 7 Aug 2001 19:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270218AbRHGXUT>; Tue, 7 Aug 2001 19:20:19 -0400
Received: from fungus.teststation.com ([212.32.186.211]:30468 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S270212AbRHGXUJ>; Tue, 7 Aug 2001 19:20:09 -0400
Date: Wed, 8 Aug 2001 01:20:18 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
To: Dan Podeanu <pdan@spiral.extreme.ro>
cc: <linux-kernel@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: netfs allows multiple identical mounts (was: smb/mount bug.)
In-Reply-To: <Pine.LNX.4.33L2.0108060511330.25283-100000@spiral.extreme.ro>
Message-ID: <Pine.LNX.4.30.0108071655260.20090-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Aug 2001, Dan Podeanu wrote:

> This should be self explanatory. My guess is, its probably the smb
> filesystem reporting as mounting again a share after network failure.

A very simple way to reproduce this (on 2.4.7):

$ mount -t smbfs -o username=puw //srv/share /mnt/smb
$ mount -t smbfs -o username=puw //srv/share /mnt/smb
$ cat /proc/mounts | grep smbfs
//srv/share /mnt/smb smbfs rw 0 0
//srv/share /mnt/smb smbfs rw 0 0


But smbfs isn't alone in allowing this, nfs does it too (hej Trond):

$ mount -t nfs srv:/mnt/something /mnt/x1
$ mount -t nfs srv:/mnt/something /mnt/x1
$ cat /proc/mounts | grep x1
srv:/mnt/store /mnt/x1 nfs rw,v2,rsize=8192,...
srv:/mnt/store /mnt/x1 nfs rw,v2,rsize=8192,...


This is probably something that smbmount could check before mounting.
But I'm not sure if that is the best fix.

fs/super.c:do_add_mount has this (2.4.7)

        /* Refuse the same filesystem on the same mount point */
        if (nd->mnt->mnt_sb == sb && nd->mnt->mnt_root == nd->dentry)
                retval = -EBUSY;
        else
                retval = graft_tree(mnt, nd);

As I read the rest of the code, 'nd->mnt->mnt_sb == sb' will be true if
the block device is the same. And trying to mount a local fs multiple
times on the same place fails. However, networked fs' get a new superblock
(and device) each time they are mounted so that condition will never be
true.

It could compare the server string ("//srv/share") but what if that server
listens to more than one name?

/Urban

