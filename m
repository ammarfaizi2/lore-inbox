Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313991AbSDKFl1>; Thu, 11 Apr 2002 01:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313992AbSDKFl0>; Thu, 11 Apr 2002 01:41:26 -0400
Received: from rj.SGI.COM ([204.94.215.100]:23967 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S313991AbSDKFlZ>;
	Thu, 11 Apr 2002 01:41:25 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: NFS access to loopback mounts
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 11 Apr 2002 15:41:12 +1000
Message-ID: <2576.1018503672@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is accessing a loopback mount via NFS supposed to work or not?  If not,
how do you export iso contents without duplicating the entire iso?

Machine A.
  mount -t iso9660 -o ro,loop /foo/iso /mnt/iso
  /etc/exports contains /mnt *(rw,no_root_squash,no_all_squash)

Machine B.
  mount -t nfs A:/mnt/iso /local/iso

B says 
  mount: A:/mnt/iso failed, reason given by server: Permission denied
A says
  rpc.mountd: authenticated mount request from ... for /mnt/iso(/mnt) 
  rpc.mountd: getfh failed: Operation not permitted 

strace rpc.mountd on A
  stat64("/mnt/iso", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
  nfsservctl(0x8, 0xbfffda80, 0x80553a0)  = -1 EPERM (Operation not permitted)

If A does not have the loopback mounted then B can mount A:/mnt/iso
over NFGS, getting an empty directrory.  Not a permission problem.

A and B are running 2.4.18-XFS, nfs-utils-0.3.1-13, mount-2.11g-5.
A is built with

CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
# CONFIG_ROOT_NFS is not set
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y

I have a note from April 2000 where NFS access to a loopback mount used
to work.  Before I dig through two years of kernels to find out where
it stopped working, is it valid to access loopback via NFS?

AFAIK doing NFS first then loopback on the local NFS directory has
never worked.

