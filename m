Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263447AbTLCA06 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 19:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264439AbTLCA06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 19:26:58 -0500
Received: from c06284a.rny.bostream.se ([217.215.27.171]:41989 "EHLO
	pc2.dolda2000.com") by vger.kernel.org with ESMTP id S263447AbTLCA0t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 19:26:49 -0500
From: Fredrik Tolf <fredrik@dolda2000.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="HY9PDQzdLw"
Content-Transfer-Encoding: 7bit
Message-ID: <16333.11722.151279.490037@pc7.dolda2000.com>
Date: Wed, 3 Dec 2003 01:26:50 +0100
To: Fredrik Tolf <fredrik@dolda2000.com>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.6 nfsd troubles - stale filehandles
In-Reply-To: <16326.253.163939.9953@pc7.dolda2000.com>
References: <16325.11418.646482.223946@pc7.dolda2000.com>
	<16325.14967.248703.483363@notabene.cse.unsw.edu.au>
	<16326.253.163939.9953@pc7.dolda2000.com>
X-Mailer: VM 7.17 under Emacs 21.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HY9PDQzdLw
Content-Type: text/plain; charset=us-ascii
Content-Description: message body text
Content-Transfer-Encoding: 7bit

Fredrik Tolf writes:
 > Neil Brown writes:
 >  > On Wednesday November 26, fredrik@dolda2000.com wrote:
 >  > > Hi!
 >  > > 
 >  > > I'm running my NFSv3 server at home on a 2.6 kernel, and it seems to
 >  > > have some issues, to say the least. The clients sporadically get stale
 >  > > handle errors, and I don't really know how to debug it.
 >  > 
 >  > I'll see if I can help.
 >  > 
 >  > I suspect that if you add the "no_subtree_check" export option the
 >  > problem will go away.  If you could confirm that, and then set it back
 >  > to "subtree_check" so we can keep hunting, that would be good.
 > 
 > That actually does seem to have done the job. I thought subtree_check
 > only affected exports that aren't entire filesystems, but I guess it
 > does something to the filehandles anyway. Thank you, at least now I
 > have something to fall back upon if no other solution presents itself.
 > 
 >  > Next, some better tracing.
 >  > The Linux NFS client will never re-try a filehandle that it thinks is
 >  > stale, so the tracing you did doesn't actually show any access of the stale
 >  > filehandle. 
 > 
 > I see... I thought it would try to get a new filehandle to the same
 > file somehow.
 > 
 >  > So you need to have tracing on when the filehandle goes stale.
 >  > 
 >  > If you could:
 >  > 
 >  >   echo 2 >  /proc/sys/sunrpc/nfsd_debug 
 >  > 
 >  > and then try to create a stale file/directory, then the trace produced
 >  > by that could well be helpful.
 >  > 
 >  > Finally, when you have create a stale filehandle and got a good trace,
 >  > could you send it to me and include an
 >  >    ls -l
 >  > for the bad file/directory and every parent up to the export point.
 > 
 > I'll do my best, but I don't know how long it will take me. It is
 > extremely hard to predict when it will happen, so tracing the actual
 > fault won't be easy.
 > 
 > I'll post again when (and if) I manage to get a good trace.

So, I managed to do it now. The strange thing is, I had created an
extra share of the home dirs for this test (I had "mount --bind"'ed it
on /var/lib/nfs/nfstest), and only set subtree_check back on the test
export, in an attempt to keep the normal parts of the system reliable
while testing, but just doing that made the real export behave bad as
well. It seems to run amok as soon as I have subtree_checking on only
one export.

Anyway, the traces got rather long, and therefore I have only made the
entire logs available as attachments to this mail. I hope that's
OK. Anyway, here follows what seems to be the interesting parts.

I used the same directory to make it fail again. From the filesystem's
point of view, it is /hannes/dc, inode 146244 (23b44 hex). On the
failed attempt (once again, I ran ls with the failing dir as the cwd),
the server says this:

nfsd_dispatch: vers 3 proc 1 
nfsd: GETATTR(3)  36: 06000001 0000fe00 00000002 00023b44 00023957 00000000 
nfsd: fh_verify(36: 06000001 0000fe00 00000002 00023b44 00023957 00000000) 
nfsd_acceptable failed at c669a5c0 dc 

The working attempts all looked a bit different, so I will have to
refer you to the log excerpt, if you don't mind. In case you wonder
about the inodes, 145751 (23957 hex) is /hannes, 146273 (23b61 hex) is
a regular file inside /hannes/dc, and 2 is (surprisingly) the root dir
of that filesystem. Again, 146244 (23b44 hex) is the failing
directory, /hannes/dc.

On the client, the failed call (an attemp is rather long on the
client) looks like this:

NFS: revalidating (0:d/146244)
NFS call  getattr
NFS reply getattr
nfs_revalidate_inode: (0:d/146244) getattr failed, error=-116

Some more info: I was root while causing this error, and the dir arch
looks like this (from this filesystem's point of view, it is really my
home dirs):

rwxr-xr-x  root   root  /
rwx--x---+ hannes users /hannes
rwxr-xr-x  hannes users /hannes/dc

I have an ACL which allows x perm for apache on /hannes, but that is
not the cause of the fault; it was like this before I had even applied
the ACL patches. The real mode on /hannes is 700; the 010 is added by
the ACL code. In short, getfacl returns the following when querying
/hannes:

# owner: hannes
# group: users
user::rwx
user:apache:--x
group::---
mask::--x
other::---

That is all I have found out; I hope it's helpful.

Fredrik Tolf


--HY9PDQzdLw
Content-Type: text/plain
Content-Description: Client log
Content-Disposition: inline;
	filename="nfslog.client"
Content-Transfer-Encoding: 7bit

Dec  3 00:41:22 pc7 kernel: NFS: dentry_delete(vfolders/applications.vfolder-info, 0)
Dec  3 00:41:22 pc7 kernel: NFS: dentry_delete(vfolders/applications, 0)
Dec  3 00:41:22 pc7 last message repeated 2 times
Dec  3 00:41:28 pc7 kernel: NFS: dentry_delete(vfolders/applications.vfolder-info, 0)
Dec  3 00:41:28 pc7 kernel: NFS: dentry_delete(vfolders/applications, 0)
Dec  3 00:41:28 pc7 last message repeated 2 times
Dec  3 00:41:28 pc7 kernel: NFS call  access
Dec  3 00:41:28 pc7 kernel: NFS: refresh_inode(0:d/2 ct=1 info=0x6)
Dec  3 00:41:28 pc7 kernel: NFS reply access
Dec  3 00:41:28 pc7 kernel: NFS: revalidating (0:d/145751)
Dec  3 00:41:28 pc7 kernel: NFS call  getattr
Dec  3 00:41:28 pc7 kernel: NFS reply getattr
Dec  3 00:41:28 pc7 kernel: NFS: refresh_inode(0:d/145751 ct=1 info=0x6)
Dec  3 00:41:28 pc7 kernel: NFS: (0:d/145751) revalidation complete
Dec  3 00:41:28 pc7 kernel: NFS call  access
Dec  3 00:41:28 pc7 kernel: NFS: refresh_inode(0:d/145751 ct=1 info=0x6)
Dec  3 00:41:28 pc7 kernel: NFS reply access
Dec  3 00:41:28 pc7 kernel: NFS: revalidating (0:d/146244)
Dec  3 00:41:28 pc7 kernel: NFS call  getattr
Dec  3 00:41:28 pc7 kernel: NFS reply getattr
Dec  3 00:41:28 pc7 kernel: NFS: refresh_inode(0:d/146244 ct=1 info=0x6)
Dec  3 00:41:28 pc7 kernel: NFS: (0:d/146244) revalidation complete
Dec  3 00:41:28 pc7 kernel: NFS call  access
Dec  3 00:41:28 pc7 kernel: NFS: refresh_inode(0:d/146244 ct=1 info=0x6)
Dec  3 00:41:28 pc7 kernel: NFS reply access
Dec  3 00:41:30 pc7 kernel: NFS: revalidating (0:d/146244)
Dec  3 00:41:30 pc7 kernel: NFS call  getattr
Dec  3 00:41:30 pc7 kernel: NFS reply getattr
Dec  3 00:41:30 pc7 kernel: NFS: refresh_inode(0:d/146244 ct=1 info=0x6)
Dec  3 00:41:30 pc7 kernel: NFS: (0:d/146244) revalidation complete
Dec  3 00:41:30 pc7 kernel: NFS call  access
Dec  3 00:41:30 pc7 kernel: NFS: refresh_inode(0:d/146244 ct=1 info=0x6)
Dec  3 00:41:30 pc7 kernel: NFS reply access
Dec  3 00:41:30 pc7 kernel: NFS: readdir_search_pagecache() searching for cookie 0
Dec  3 00:41:30 pc7 kernel: NFS: find_dirent_page() searching directory page 0
Dec  3 00:41:30 pc7 kernel: NFS: found cookie 2
Dec  3 00:41:30 pc7 kernel: NFS: find_dirent() returns 0
Dec  3 00:41:30 pc7 kernel: NFS: find_dirent_page() returns 0
Dec  3 00:41:30 pc7 kernel: NFS: readdir_search_pagecache() returned 0
Dec  3 00:41:31 pc7 kernel: NFS: nfs_do_filldir() filling starting @ cookie 0
Dec  3 00:41:31 pc7 kernel: NFS: nfs_do_filldir() filling ended @ cookie 1387241729; returning = 0
Dec  3 00:41:31 pc7 kernel: NFS call  access
Dec  3 00:41:31 pc7 kernel: NFS: refresh_inode(0:d/146244 ct=1 info=0x6)
Dec  3 00:41:31 pc7 kernel: NFS reply access
Dec  3 00:41:31 pc7 kernel: NFS: revalidating (0:d/146273)
Dec  3 00:41:31 pc7 kernel: NFS call  getattr
Dec  3 00:41:31 pc7 kernel: NFS reply getattr
Dec  3 00:41:31 pc7 kernel: NFS: refresh_inode(0:d/146273 ct=1 info=0x6)
Dec  3 00:41:31 pc7 kernel: NFS: (0:d/146273) revalidation complete
Dec  3 00:41:31 pc7 kernel: NFS: dentry_delete(dc/filter.log, 0)
Dec  3 00:41:31 pc7 kernel: NFS: readdir_search_pagecache() searching for cookie 1387241729
Dec  3 00:41:31 pc7 kernel: NFS: find_dirent_page() searching directory page 0
Dec  3 00:41:31 pc7 kernel: NFS: found cookie 2
Dec  3 00:41:31 pc7 kernel: NFS: found cookie 2711168
Dec  3 00:41:31 pc7 kernel: NFS: found cookie 26116736
Dec  3 00:41:31 pc7 kernel: NFS: found cookie 945084544
Dec  3 00:41:31 pc7 kernel: NFS: found cookie 1207804544
Dec  3 00:41:31 pc7 kernel: NFS: found cookie 1387241728
Dec  3 00:41:31 pc7 kernel: NFS: found cookie 1387241729
Dec  3 00:41:31 pc7 kernel: NFS: find_dirent() returns -523
Dec  3 00:41:31 pc7 kernel: NFS: find_dirent_page() returns -523
Dec  3 00:41:31 pc7 kernel: NFS: readdir_search_pagecache() returned -523
Dec  3 00:41:33 pc7 kernel: NFS: revalidating (0:d/146244)
Dec  3 00:41:33 pc7 kernel: NFS call  getattr
Dec  3 00:41:33 pc7 kernel: NFS reply getattr
Dec  3 00:41:33 pc7 kernel: NFS: refresh_inode(0:d/146244 ct=1 info=0x6)
Dec  3 00:41:33 pc7 kernel: NFS: (0:d/146244) revalidation complete
Dec  3 00:41:33 pc7 kernel: NFS call  access
Dec  3 00:41:33 pc7 kernel: NFS: refresh_inode(0:d/146244 ct=1 info=0x6)
Dec  3 00:41:33 pc7 kernel: NFS reply access
Dec  3 00:41:33 pc7 kernel: NFS: readdir_search_pagecache() searching for cookie 0
Dec  3 00:41:33 pc7 kernel: NFS: find_dirent_page() searching directory page 0
Dec  3 00:41:33 pc7 kernel: NFS: found cookie 2
Dec  3 00:41:33 pc7 kernel: NFS: find_dirent() returns 0
Dec  3 00:41:33 pc7 kernel: NFS: find_dirent_page() returns 0
Dec  3 00:41:33 pc7 kernel: NFS: readdir_search_pagecache() returned 0
Dec  3 00:41:33 pc7 kernel: NFS: nfs_do_filldir() filling starting @ cookie 0
Dec  3 00:41:33 pc7 kernel: NFS: nfs_do_filldir() filling ended @ cookie 1387241729; returning = 0
Dec  3 00:41:33 pc7 kernel: NFS call  access
Dec  3 00:41:33 pc7 kernel: NFS: refresh_inode(0:d/146244 ct=1 info=0x6)
Dec  3 00:41:33 pc7 kernel: NFS reply access
Dec  3 00:41:33 pc7 kernel: NFS: dentry_delete(dc/filter.log, 0)
Dec  3 00:41:34 pc7 kernel: NFS: readdir_search_pagecache() searching for cookie 1387241729
Dec  3 00:41:34 pc7 kernel: NFS: find_dirent_page() searching directory page 0
Dec  3 00:41:34 pc7 kernel: NFS: found cookie 2
Dec  3 00:41:34 pc7 kernel: NFS: found cookie 2711168
Dec  3 00:41:34 pc7 kernel: NFS: found cookie 26116736
Dec  3 00:41:34 pc7 kernel: NFS: found cookie 945084544
Dec  3 00:41:34 pc7 kernel: NFS: found cookie 1207804544
Dec  3 00:41:34 pc7 kernel: NFS: found cookie 1387241728
Dec  3 00:41:34 pc7 kernel: NFS: found cookie 1387241729
Dec  3 00:41:34 pc7 kernel: NFS: find_dirent() returns -523
Dec  3 00:41:34 pc7 kernel: NFS: find_dirent_page() returns -523
Dec  3 00:41:34 pc7 kernel: NFS: readdir_search_pagecache() returned -523
Dec  3 00:41:34 pc7 kernel: NFS call  access
Dec  3 00:41:34 pc7 kernel: NFS: refresh_inode(0:d/2 ct=1 info=0x6)
Dec  3 00:41:34 pc7 kernel: NFS reply access
Dec  3 00:41:34 pc7 kernel: NFS: revalidating (0:d/5216)
Dec  3 00:41:34 pc7 kernel: NFS call  getattr
Dec  3 00:41:34 pc7 kernel: NFS reply getattr
Dec  3 00:41:34 pc7 kernel: NFS: refresh_inode(0:d/5216 ct=1 info=0x6)
Dec  3 00:41:34 pc7 kernel: NFS: (0:d/5216) revalidation complete
Dec  3 00:41:34 pc7 kernel: NFS: dentry_delete(vfolders/applications.vfolder-info, 0)
Dec  3 00:41:34 pc7 kernel: NFS: dentry_delete(vfolders/applications, 0)
Dec  3 00:41:34 pc7 last message repeated 2 times
Dec  3 00:41:36 pc7 kernel: NFS: revalidating (0:d/146244)
Dec  3 00:41:36 pc7 kernel: NFS call  getattr
Dec  3 00:41:36 pc7 kernel: NFS reply getattr
Dec  3 00:41:36 pc7 kernel: nfs_revalidate_inode: (0:d/146244) getattr failed, error=-116
Dec  3 00:41:39 pc7 kernel: NFS: dentry_delete(hannes/dc, 0)
Dec  3 00:41:40 pc7 kernel: NFS: revalidating (0:d/8333)
Dec  3 00:41:40 pc7 kernel: NFS call  getattr
Dec  3 00:41:40 pc7 kernel: NFS reply getattr
Dec  3 00:41:40 pc7 kernel: NFS: refresh_inode(0:d/8333 ct=1 info=0x6)
Dec  3 00:41:40 pc7 kernel: NFS: (0:d/8333) revalidation complete
Dec  3 00:41:40 pc7 kernel: NFS: dentry_delete(vfolders/applications.vfolder-info, 0)
Dec  3 00:41:40 pc7 kernel: NFS: dentry_delete(vfolders/applications, 0)
Dec  3 00:41:40 pc7 last message repeated 2 times
Dec  3 00:41:42 pc7 kernel: NFS call  access
Dec  3 00:41:42 pc7 kernel: NFS: refresh_inode(0:d/2 ct=1 info=0x6)
Dec  3 00:41:42 pc7 kernel: NFS reply access
Dec  3 00:41:42 pc7 kernel: NFS call  access
Dec  3 00:41:42 pc7 kernel: NFS: refresh_inode(0:d/5216 ct=1 info=0x6)
Dec  3 00:41:42 pc7 kernel: NFS reply access
Dec  3 00:41:42 pc7 kernel: NFS call  lookup .emacs.d
Dec  3 00:41:42 pc7 kernel: NFS reply lookup: 0
Dec  3 00:41:42 pc7 kernel: NFS: refresh_inode(0:d/5216 ct=1 info=0x6)
Dec  3 00:41:42 pc7 kernel: NFS: refresh_inode(0:d/120801 ct=1 info=0x6)
Dec  3 00:41:42 pc7 kernel: NFS call  access
Dec  3 00:41:42 pc7 kernel: NFS: refresh_inode(0:d/120801 ct=1 info=0x6)
Dec  3 00:41:42 pc7 kernel: NFS reply access
Dec  3 00:41:42 pc7 kernel: NFS: revalidating (0:d/120802)
Dec  3 00:41:42 pc7 kernel: NFS call  getattr
Dec  3 00:41:42 pc7 kernel: NFS reply getattr
Dec  3 00:41:42 pc7 kernel: NFS: refresh_inode(0:d/120802 ct=1 info=0x6)
Dec  3 00:41:42 pc7 kernel: NFS: (0:d/120802) revalidation complete
Dec  3 00:41:42 pc7 kernel: NFS call  access
Dec  3 00:41:42 pc7 kernel: NFS: refresh_inode(0:d/120802 ct=1 info=0x6)
Dec  3 00:41:42 pc7 kernel: NFS reply access
Dec  3 00:41:42 pc7 kernel: NFS: revalidating (0:d/9802)
Dec  3 00:41:42 pc7 kernel: NFS call  getattr
Dec  3 00:41:42 pc7 kernel: NFS reply getattr
Dec  3 00:41:42 pc7 kernel: NFS: refresh_inode(0:d/9802 ct=1 info=0x6)
Dec  3 00:41:42 pc7 kernel: NFS: (0:d/9802) revalidation complete
Dec  3 00:41:42 pc7 kernel: NFS call  access
Dec  3 00:41:42 pc7 kernel: NFS: refresh_inode(0:d/9802 ct=1 info=0x6)
Dec  3 00:41:42 pc7 kernel: NFS reply access
Dec  3 00:41:42 pc7 kernel: NFS call  setattr
Dec  3 00:41:42 pc7 kernel: NFS reply setattr
Dec  3 00:41:42 pc7 kernel: NFS: refresh_inode(0:d/9802 ct=1 info=0x7)
Dec  3 00:41:42 pc7 kernel: nfs: write(auto-save-list/.saves-6006-pc7.dolda2000.com~(9802), 1197@0)
Dec  3 00:41:42 pc7 kernel: NFS:      nfs_updatepage(auto-save-list/.saves-6006-pc7.dolda2000.com~ 1197@0)
Dec  3 00:41:42 pc7 kernel: NFS:      nfs_updatepage returns 0 (isize 1197)
Dec  3 00:41:42 pc7 kernel: nfs: flush(0:d/9802)
Dec  3 00:41:42 pc7 kernel: NFS: 37826 initiated write call (req 0:d/9802, 1197 bytes @ offset 0)
Dec  3 00:41:42 pc7 kernel: NFS: refresh_inode(0:d/9802 ct=2 info=0x7)
Dec  3 00:41:42 pc7 kernel: NFS: 37826 nfs_writeback_done (status 1197)
Dec  3 00:41:42 pc7 kernel: NFS: write (0:d/9802 1197@0) marked for commit
Dec  3 00:41:42 pc7 kernel: NFS: 37827 initiated commit call
Dec  3 00:41:43 pc7 kernel: NFS: refresh_inode(0:d/9802 ct=2 info=0x7)
Dec  3 00:41:43 pc7 kernel: NFS: 37827 nfs_commit_done (status 0)
Dec  3 00:41:43 pc7 kernel: NFS: commit (0:d/9802 1197@0) OK
Dec  3 00:41:43 pc7 kernel: NFS: dentry_delete(auto-save-list/.saves-6006-pc7.dolda2000.com~, 0)

--HY9PDQzdLw
Content-Type: text/plain
Content-Description: Server log
Content-Disposition: inline;
	filename="nfslog.server"
Content-Transfer-Encoding: 7bit

Dec  3 00:36:17 pc5 kernel: nfsd_dispatch: vers 3 proc 4 
Dec  3 00:36:17 pc5 kernel: nfsd: ACCESS(3)   12: 00000001 0000fe00 00000002 00000000 00000000 00000000 0x2 
Dec  3 00:36:17 pc5 kernel: nfsd: fh_verify(12: 00000001 0000fe00 00000002 00000000 00000000 00000000) 
Dec  3 00:36:17 pc5 kernel: nfsd_dispatch: vers 3 proc 1 
Dec  3 00:36:17 pc5 kernel: nfsd: GETATTR(3)  24: 03000001 0000fe00 00000002 00023957 00000002 00000000 
Dec  3 00:36:17 pc5 kernel: nfsd: fh_verify(24: 03000001 0000fe00 00000002 00023957 00000002 00000000) 
Dec  3 00:36:17 pc5 kernel: nfsd_dispatch: vers 3 proc 4 
Dec  3 00:36:17 pc5 kernel: nfsd: ACCESS(3)   24: 03000001 0000fe00 00000002 00023957 00000002 00000000 0x2 
Dec  3 00:36:17 pc5 kernel: nfsd: fh_verify(24: 03000001 0000fe00 00000002 00023957 00000002 00000000) 
Dec  3 00:36:18 pc5 kernel: nfsd_dispatch: vers 3 proc 1 
Dec  3 00:36:18 pc5 kernel: nfsd: GETATTR(3)  36: 06000001 0000fe00 00000002 00023b44 00023957 00000000 
Dec  3 00:36:18 pc5 kernel: nfsd: fh_verify(36: 06000001 0000fe00 00000002 00023b44 00023957 00000000) 
Dec  3 00:36:18 pc5 kernel: nfsd_dispatch: vers 3 proc 4 
Dec  3 00:36:18 pc5 kernel: nfsd: ACCESS(3)   36: 06000001 0000fe00 00000002 00023b44 00023957 00000000 0x2 
Dec  3 00:36:18 pc5 kernel: nfsd: fh_verify(36: 06000001 0000fe00 00000002 00023b44 00023957 00000000) 
Dec  3 00:36:21 pc5 kernel: nfsd_dispatch: vers 3 proc 1 
Dec  3 00:36:21 pc5 kernel: nfsd: GETATTR(3)  36: 06000001 0000fe00 00000002 00023b44 00023957 00000000 
Dec  3 00:36:21 pc5 kernel: nfsd: fh_verify(36: 06000001 0000fe00 00000002 00023b44 00023957 00000000) 
Dec  3 00:36:21 pc5 kernel: nfsd_dispatch: vers 3 proc 4 
Dec  3 00:36:21 pc5 kernel: nfsd: ACCESS(3)   36: 06000001 0000fe00 00000002 00023b44 00023957 00000000 0x1 
Dec  3 00:36:21 pc5 kernel: nfsd: fh_verify(36: 06000001 0000fe00 00000002 00023b44 00023957 00000000) 
Dec  3 00:36:21 pc5 kernel: nfsd_dispatch: vers 3 proc 4 
Dec  3 00:36:21 pc5 kernel: nfsd: ACCESS(3)   36: 06000001 0000fe00 00000002 00023b44 00023957 00000000 0x2 
Dec  3 00:36:21 pc5 kernel: nfsd: fh_verify(36: 06000001 0000fe00 00000002 00023b44 00023957 00000000) 
Dec  3 00:36:21 pc5 kernel: nfsd_dispatch: vers 3 proc 1 
Dec  3 00:36:21 pc5 kernel: nfsd: GETATTR(3)  36: 06000001 0000fe00 00000002 00023b61 00023b44 00000000 
Dec  3 00:36:21 pc5 kernel: nfsd: fh_verify(36: 06000001 0000fe00 00000002 00023b61 00023b44 00000000) 
Dec  3 00:36:21 pc5 kernel: nfsd_dispatch: vers 3 proc 4 
Dec  3 00:36:21 pc5 kernel: nfsd: ACCESS(3)   12: 00000001 0000fe00 00000002 00000000 00000000 00000000 0x2 
Dec  3 00:36:22 pc5 kernel: nfsd: fh_verify(12: 00000001 0000fe00 00000002 00000000 00000000 00000000) 
Dec  3 00:36:22 pc5 kernel: nfsd_dispatch: vers 3 proc 1 
Dec  3 00:36:22 pc5 kernel: nfsd: GETATTR(3)  36: 06000001 0000fe00 00000002 0000208d 00001460 00000000 
Dec  3 00:36:22 pc5 kernel: nfsd: fh_verify(36: 06000001 0000fe00 00000002 0000208d 00001460 00000000) 
Dec  3 00:36:23 pc5 kernel: nfsd_dispatch: vers 3 proc 1 
Dec  3 00:36:23 pc5 kernel: nfsd: GETATTR(3)  36: 06000001 0000fe00 00000002 00023b44 00023957 00000000 
Dec  3 00:36:23 pc5 kernel: nfsd: fh_verify(36: 06000001 0000fe00 00000002 00023b44 00023957 00000000) 
Dec  3 00:36:23 pc5 kernel: nfsd_acceptable failed at c669a5c0 dc 
Dec  3 00:36:24 pc5 kernel: nfsd_dispatch: vers 3 proc 1 
Dec  3 00:36:24 pc5 kernel: nfsd: GETATTR(3)  24: 03000001 0000fe00 00000002 00023957 00000002 00000000 
Dec  3 00:36:24 pc5 kernel: nfsd: fh_verify(24: 03000001 0000fe00 00000002 00023957 00000002 00000000) 
Dec  3 00:36:29 pc5 kernel: nfsd_dispatch: vers 3 proc 1 
Dec  3 00:36:29 pc5 kernel: nfsd: GETATTR(3)  24: 03000001 0000fe00 00000002 00023957 00000002 00000000 
Dec  3 00:36:29 pc5 kernel: nfsd: fh_verify(24: 03000001 0000fe00 00000002 00023957 00000002 00000000) 

--HY9PDQzdLw--

