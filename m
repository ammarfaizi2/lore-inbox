Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261458AbVAXNtp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261458AbVAXNtp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 08:49:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261495AbVAXNtp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 08:49:45 -0500
Received: from odin2.bull.net ([192.90.70.84]:30680 "EHLO odin2.bull.net")
	by vger.kernel.org with ESMTP id S261458AbVAXNrR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 08:47:17 -0500
Message-ID: <41F4FD26.2050307@evidian.com>
Date: Mon, 24 Jan 2005 14:50:30 +0100
From: Pascal Dameme <pascal.dameme@evidian.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [nfsd-bug ?] ESTALE returned after a while when using nfsdfs (2.6.10
 kernel)
X-MIMETrack: Itemize by SMTP Server on FRN-001/EVIDIAN(Release 5.0.8 |June 18, 2001) at
 24/01/2005 14:47:09,
	Serialize by Router on FRN-001/EVIDIAN(Release 5.0.8 |June 18, 2001) at 24/01/2005
 14:47:10,
	Serialize complete at 24/01/2005 14:47:10
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When a locally exported directory is mounted other itself using nfs V3, 
after
a few minutes, the nfs servers starts issueing "ESTALE" on previously 
perfectly accessible files ...

This behavior has been observed on redhat Fedora core 2, Suse SLES 9 
*and* 2.6.10 (from kernel.org) kernels.
The less activity there is, the fastest the problem appears ...

For some reason, it manifests *only if the nfsdfs filesystem is mounted*
(in "legacy" mode, where the filesystem is not mounted, the system behaves
 normally for at least a week, whereas with the filesystem mounted, ESTALE
is returned after at  most 30 minutes)

Herafter, you will find a test scenario to reproduce the problem,
 as well as all information I have dug so far .

Anyone ?

Best regards,
-- 
Pascal Dameme.


----------------------------------------------------------------------------------------------------------------
The test scenario to reproduce the problem is as follow (the test machine is
 a SuSE distribution running a freshly compiled 2.6.10 kernel):

#start nfsd
/etc/rc.d/nfsserver start
#export test directory
exportfs -o rw,insecure,no_root_squash,no_subtree_check 127.0.0.1:/test/dir
#mount
mount -o hard,nolock,vers=3,proto=udp 127.0.0.1:/test/dir /test/dir

The following is a trace of what happens :

atchoum:~ # while true; do date;ls -ld /test/dir; sleep 60;done
Thu Jan  6 14:33:41 CET 2005
drwxr-xr-x  8 root root 360 Dec  7 13:46 /test/dir
Thu Jan  6 14:34:41 CET 2005
drwxr-xr-x  8 root root 360 Dec  7 13:46 /test/dir
Thu Jan  6 14:35:41 CET 2005
drwxr-xr-x  8 root root 360 Dec  7 13:46 /test/dir
Thu Jan  6 14:36:41 CET 2005
drwxr-xr-x  8 root root 360 Dec  7 13:46 /test/dir
Thu Jan  6 14:37:41 CET 2005
drwxr-xr-x  8 root root 360 Dec  7 13:46 /test/dir
Thu Jan  6 14:38:41 CET 2005
drwxr-xr-x  8 root root 360 Dec  7 13:46 /test/dir
Thu Jan  6 14:39:41 CET 2005
drwxr-xr-x  8 root root 360 Dec  7 13:46 /test/dir
Thu Jan  6 14:40:41 CET 2005
drwxr-xr-x  8 root root 360 Dec  7 13:46 /test/dir
Thu Jan  6 14:41:41 CET 2005
drwxr-xr-x  8 root root 360 Dec  7 13:46 /test/dir
Thu Jan  6 14:42:41 CET 2005
/bin/ls: /test/dir: Stale NFS file handle
Thu Jan  6 14:43:41 CET 2005
/bin/ls: /test/dir: Stale NFS file handle
Thu Jan  6 14:44:41 CET 2005
/bin/ls: /test/dir: Stale NFS file handle
Thu Jan  6 14:45:42 CET 2005
/bin/ls: /test/dir: Stale NFS file handle
Thu Jan  6 14:46:42 CET 2005
/bin/ls: /test/dir: Stale NFS file handle
Thu Jan  6 14:47:42 CET 2005
/bin/ls: /test/dir: Stale NFS file handle
Thu Jan  6 14:48:42 CET 2005
/bin/ls: /test/dir: Stale NFS file handle
Thu Jan  6 14:49:42 CET 2005
/bin/ls: /test/dir: Stale NFS file handle
Thu Jan  6 14:50:42 CET 2005
/bin/ls: /test/dir: Stale NFS file handle

I enabled the NFS debug messages, this is what is seen in the syslog file
around the problem:

Jan  6 14:40:41 atchoum kernel: NFS: revalidating (0:f/113840)
Jan  6 14:40:41 atchoum kernel: NFS call  getattr
Jan  6 14:40:41 atchoum kernel: nfsd_dispatch: vers 3 proc 1
Jan  6 14:40:41 atchoum kernel: nfsd: GETATTR(3)  12: 00000001 02000800 
0001bcb0 00000000 00000000 00000000
Jan  6 14:40:41 atchoum kernel: nfsd: fh_verify(12: 00000001 02000800 
0001bcb0 00000000 00000000 00000000)
Jan  6 14:40:41 atchoum kernel: NFS reply getattr
Jan  6 14:40:41 atchoum kernel: NFS: nfs_update_inode(0:f/113840 ct=1 
info=0x6)
Jan  6 14:40:41 atchoum kernel: NFS: (0:f/113840) revalidation complete
Jan  6 14:41:41 atchoum kernel: NFS: revalidating (0:f/113840)
Jan  6 14:41:41 atchoum kernel: NFS call  getattr
Jan  6 14:41:41 atchoum kernel: nfsd_dispatch: vers 3 proc 1
Jan  6 14:41:41 atchoum kernel: nfsd: GETATTR(3)  12: 00000001 02000800 
0001bcb0 00000000 00000000 00000000
Jan  6 14:41:41 atchoum kernel: nfsd: fh_verify(12: 00000001 02000800 
0001bcb0 00000000 00000000 00000000)
Jan  6 14:41:41 atchoum kernel: NFS reply getattr
Jan  6 14:41:41 atchoum kernel: NFS: nfs_update_inode(0:f/113840 ct=1 
info=0x6)
Jan  6 14:41:41 atchoum kernel: NFS: (0:f/113840) revalidation complete
Jan  6 14:41:42 atchoum kernel: exp_export: export of non-dev fs without 
fsidfound domain localhost
Jan  6 14:41:42 atchoum kernel: found fsidtype 0
Jan  6 14:41:42 atchoum kernel: found fsid length 8
Jan  6 14:41:42 atchoum kernel: Path seems to be <>
Jan  6 14:42:41 atchoum kernel: NFS: revalidating (0:f/113840)
Jan  6 14:42:41 atchoum kernel: NFS call  getattr
Jan  6 14:42:41 atchoum kernel: nfsd_dispatch: vers 3 proc 1
Jan  6 14:42:41 atchoum kernel: nfsd: GETATTR(3)  12: 00000001 02000800 
0001bcb0 00000000 00000000 00000000
Jan  6 14:42:41 atchoum kernel: nfsd: fh_verify(12: 00000001 02000800 
0001bcb0 00000000 00000000 00000000)
Jan  6 14:42:41 atchoum kernel: NFS reply getattr
Jan  6 14:42:41 atchoum kernel: nfs_revalidate_inode: (0:f/113840) 
getattr failed, error=-116
Jan  6 14:43:41 atchoum kernel: NFS: revalidating (0:f/113840)
Jan  6 14:43:41 atchoum kernel: NFS call  getattr
Jan  6 14:43:41 atchoum kernel: nfsd_dispatch: vers 3 proc 1
Jan  6 14:43:41 atchoum kernel: nfsd: GETATTR(3)  12: 00000001 02000800 
0001bcb0 00000000 00000000 00000000
Jan  6 14:43:41 atchoum kernel: nfsd: fh_verify(12: 00000001 02000800 
0001bcb0 00000000 00000000 00000000)
Jan  6 14:43:41 atchoum kernel: NFS reply getattr
Jan  6 14:43:41 atchoum kernel: nfs_revalidate_inode: (0:f/113840) 
getattr failed, error=-116

Somehow, it seems that check_export gets confused ...

I tried to mount the directory using the fsid= option, this seems to help a
 little, but after some time, the following message appears in the syslog:

Jan  6 18:35:41 atchoum kernel: NFS: nfs_update_inode(0:f/113904 ct=1 
info=0x6)
Jan  6 18:35:41 atchoum kernel: NFS: (0:f/113904) revalidation complete
Jan  6 18:36:41 atchoum kernel: NFS: revalidating (0:f/113904)
Jan  6 18:36:41 atchoum kernel: NFS call  getattr
Jan  6 18:36:41 atchoum kernel: nfsd_dispatch: vers 3 proc 1
Jan  6 18:36:41 atchoum kernel: nfsd: GETATTR(3)  8: 00010001 00000309 
00000000 00000000 00000000 00000000
Jan  6 18:36:41 atchoum kernel: nfsd: fh_verify(8: 00010001 00000309 
00000000 00000000 00000000 00000000)
Jan  6 18:36:41 atchoum kernel: NFS reply getattr
Jan  6 18:36:41 atchoum kernel: NFS: nfs_update_inode(0:f/113904 ct=1 
info=0x6)
Jan  6 18:36:41 atchoum kernel: NFS: (0:f/113904) revalidation complete
Jan  6 18:37:41 atchoum kernel: NFS: revalidating (0:f/113904)
Jan  6 18:37:41 atchoum kernel: NFS call  getattr
Jan  6 18:37:41 atchoum kernel: nfsd_dispatch: vers 3 proc 1
Jan  6 18:37:41 atchoum kernel: nfsd: GETATTR(3)  8: 00010001 00000309 
00000000 00000000 00000000 00000000
Jan  6 18:37:41 atchoum kernel: nfsd: fh_verify(8: 00010001 00000309 
00000000 00000000 00000000 00000000)
Jan  6 18:37:41 atchoum kernel: nfsd: Dropping request due to malloc 
failure!
Jan  6 18:37:41 atchoum kernel: nfsd_dispatch: vers 3 proc 1
Jan  6 18:37:41 atchoum kernel: nfsd: GETATTR(3)  8: 00010001 00000309 
00000000 00000000 00000000 00000000
Jan  6 18:37:41 atchoum kernel: nfsd: fh_verify(8: 00010001 00000309 
00000000 00000000 00000000 00000000)
Jan  6 18:37:41 atchoum kernel: nfsd: Dropping request due to malloc 
failure!
Jan  6 18:37:41 atchoum kernel: nfsd_dispatch: vers 3 proc 1
Jan  6 18:37:41 atchoum kernel: nfsd: GETATTR(3)  8: 00010001 00000309 
00000000 00000000 00000000 00000000
Jan  6 18:37:41 atchoum kernel: nfsd: fh_verify(8: 00010001 00000309 
00000000 00000000 00000000 00000000)
Jan  6 18:37:41 atchoum kernel: nfsd: Dropping request due to malloc 
failure!
Jan  6 18:37:41 atchoum kernel: nfsd_dispatch: vers 3 proc 1
Jan  6 18:37:41 atchoum kernel: nfsd: GETATTR(3)  8: 00010001 00000309 
00000000 00000000 00000000 00000000
Jan  6 18:37:41 atchoum kernel: nfsd: fh_verify(8: 00010001 00000309 
00000000 00000000 00000000 00000000)
Jan  6 18:37:41 atchoum kernel: nfsd: Dropping request due to malloc 
failure!

Looks like a  memory leak ...

