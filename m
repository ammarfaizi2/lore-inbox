Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269967AbTHFQLO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 12:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269978AbTHFQLO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 12:11:14 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:32379 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S269967AbTHFQLK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 12:11:10 -0400
Message-ID: <3F3128A4.8030305@RedHat.com>
Date: Wed, 06 Aug 2003 12:11:16 -0400
From: Steve Dickson <SteveD@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030507
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
CC: nfs@lists.sourceforge.net, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [NFS] [PATCH] kNFSd: Fixes a problem with inode clean up for vxfs
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This a patch I've received from Veritas. Supposedly they have
already submitted this but I can't seem to find it in any 2.4 trees..

Does anybody recognize this and are there any known issues with it?

The Problem: The nfsd_findparent creates a dentry using d_alloc_root. 
The d_op
vector pointer in this dentry is not initialized. Hence filesystems that 
supply
the vector have a problem. nfs exports of such filesystems do not work
correctly under memory pressure.  vxfs, vfat, ntfs are amongst the 
filesystems
affected by the bug.  Need redhat to fix nfsd code in their kernels. 
Ideally
a kernel needs to ask a filesystem to setup a d_op vector.  An entry point
into a filesystem for doing this job doesn't exist. We can work around the
problem by copying d_op vector pointer from the child of the dentry, whose
d_op vector is correct.


The Patch:

--- ./fs/nfsd/nfsfh.c.diff      Wed Jul  2 13:17:35 2003
+++ ./fs/nfsd/nfsfh.c   Tue Jul 29 04:45:43 2003
@@ -303,6 +303,7 @@ struct dentry *nfsd_findparent(struct de
                       if (pdentry) {
                               igrab(tdentry->d_inode);
                               pdentry->d_flags |= 
DCACHE_NFSD_DISCONNECTED;
+                              pdentry->d_op = child->d_op;
                       }
               }
               if (pdentry == NULL)

SteveD.


